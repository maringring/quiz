function filterTable() {
    const filterValue = document.getElementById('filterInput').value.toLowerCase();
    const tableRows = document.querySelectorAll('table tr');
  
    tableRows.forEach(row => {
      const questionColumn = row.getElementsByTagName('td')[1]; // 컬럼 순서에 따라 조정
      if (questionColumn) {
        const questionText = questionColumn.textContent || questionColumn.innerText;
        if (questionText.toLowerCase().includes(filterValue)) {
          row.style.display = '';
        } else {
          row.style.display = 'none';
        }
      }
    });
  }
  