From: Jacob Pan <jacob.jun.pan@linux.intel.com>
Subject: [PATCH v1] TMON thermal monitoring/tuning tool
Date: Mon, 14 Oct 2013 16:02:26 -0700
Message-ID: <1381791747-7458-1-git-send-email-jacob.jun.pan@linux.intel.com>
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([143.182.124.37]:52064 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932083Ab3JNXCb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 14 Oct 2013 19:02:31 -0400
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Zhang Rui <rui.zhang@intel.com>, Linux PM <linux-pm@vger.kernel.org>, Eduardo Valentin <eduardo.valentin@ti.com>, LKML <linux-kernel@vger.kernel.org>, acme@redhat.com, dhowells@redhat.com, bp@suse.de, gthelen@google.com
Cc: Rafael Wysocki <rafael.j.wysocki@intel.com>, Jacob Pan <jacob.jun.pan@linux.intel.com>

Changes since v0
	- fix seg fault on arm mvprintw() call
	- give out warning to console instead of syslog when
	  no thermal zones are detected
	- draw sub window title on top of border line
	- add entry to tools/Makefile
	- change linking order to put libpanel before ncurses

Jacob Pan (1):
  tools/thermal: Introduce tmon, a tool for thermal subsystem

 tools/Makefile              |   15 +-
 tools/thermal/tmon/Makefile |   47 ++++
 tools/thermal/tmon/README   |   50 ++++
 tools/thermal/tmon/pid.c    |  131 +++++++++
 tools/thermal/tmon/sysfs.c  |  596 ++++++++++++++++++++++++++++++++++++++++
 tools/thermal/tmon/tmon.8   |  142 ++++++++++
 tools/thermal/tmon/tmon.c   |  352 ++++++++++++++++++++++++
 tools/thermal/tmon/tmon.h   |  204 ++++++++++++++
 tools/thermal/tmon/tui.c    |  638 +++++++++++++++++++++++++++++++++++++++++++
 9 files changed, 2173 insertions(+), 2 deletions(-)
 create mode 100644 tools/thermal/tmon/Makefile
 create mode 100644 tools/thermal/tmon/README
 create mode 100644 tools/thermal/tmon/pid.c
 create mode 100644 tools/thermal/tmon/sysfs.c
 create mode 100644 tools/thermal/tmon/tmon.8
 create mode 100644 tools/thermal/tmon/tmon.c
 create mode 100644 tools/thermal/tmon/tmon.h
 create mode 100644 tools/thermal/tmon/tui.c

-- 
1.7.9.5

