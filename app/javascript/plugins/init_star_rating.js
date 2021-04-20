import "jquery-bar-rating";
import $ from 'jquery';

const rating = $('#review_rating');

const initStarRating = () => {
  if (rating) {
    rating.barrating({
      theme: 'css-stars'
    });
  }
};

export { initStarRating };
