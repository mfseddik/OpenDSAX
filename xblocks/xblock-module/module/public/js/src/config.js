"use strict";
(function () {
  var settings = {};
  //@efouh: added this variable back because it is needed by gradebook.html
  settings.BOOK_NAME = "testX";
  settings.BOOK_LANG = "en";
  settings.EXERCISE_SERVER = "";
  settings.LOGGING_SERVER = "";
  settings.SCORE_SERVER = "";
  settings.MODULE_ORIGIN = "http://opendsax.local";
  settings.EXERCISE_ORIGIN = "http://opendsax.local";
  settings.AV_ORIGIN = "http://opendsax.local";
  // Flag controlling whether or not the system will assign credit (scores) obtained by anonymous users to the next user to log in
  settings.ALLOW_ANON_CREDIT = true;
  settings.REQ_FULL_SS = true;
  settings.BUILD_TO_ODSA = "../../../";
  settings.BOOK_URL = "/resource/module/public/";

  settings.DISP_MOD_COMP = "{{displayModule}}";
  settings.MODULE_NAME = "{{shortName}}";
  settings.MODULE_LONG_NAME = "{{longName}}";
  settings.MODULE_CHAPTER = "{{chapter}}";
  settings.BUILD_DATE = "2014-12-29 14:18:41";
  settings.BUILD_CMAP = true;

  window.ODSA = {};
  window.ODSA.SETTINGS = settings;
}());