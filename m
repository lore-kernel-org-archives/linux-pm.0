From: Chanwoo Choi <cw00.choi@samsung.com>
Subject: [PATCH v2 0/2] MAINTAINERS: Update the DEVFREQ and DEVFREQ-EVENT entry
Date: Thu, 05 Nov 2015 13:30:16 +0900
Message-ID: <1446697818-20534-1-git-send-email-cw00.choi@samsung.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: myungjoo.ham@samsung.com, joe@perches.com
Cc: kyungmin.park@samsung.com, rafael.j.wysocki@intel.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Chanwoo Choi <cw00.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch updates the DEVFREQ entry including missing information and add the
new DEVFREQ-EVENT[1] entry.
[1] https://lkml.org/lkml/2015/1/25/573

Changes from v1:
- Add patch1 which add the missing git repository and directory of devfreq
- Add devfreq git repository info to DEVFREQ-EVENT entry in MAINTAINERS

Chanwoo Choi (2):
  MAINTAINERS: Add missing git repository and directory for devfreq
  MAINTAINERS: Add devfreq-event entry

 MAINTAINERS | 13 +++++++++++++
 1 file changed, 13 insertions(+)

-- 
1.9.1
