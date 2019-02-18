From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v3 0/2] tracing: drivers: devfreq: add basic trace mechanism
Date: Mon, 18 Feb 2019 19:21:07 +0100
Message-ID: <1550514069-9237-1-git-send-email-l.luba@partner.samsung.com>
References: <CGME20190218182128eucas1p1bac39e9f11572143697b5cb854b2eb87@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi all,

This is v3 which addresses suggestions from reviews.

This patch set adds support for tracing in devfreq framework. It is related
to the discussion regarding devfreq workqueue mechanism and wake-ups.
These two tracing patches have been submitted in larger patch set, which
needs more discussion. For the further discussion and development there
is a need of measurements/testing, though. It was agreed that trace events
would help. The whole discussion is here [1].

With these patches it is possible to capture current behaviour for the 
devfreq subsystem and devices such as when and which workqueue is used,
on which CPU, what is the load and frequency of the device.

v3:
- change 'load' value to 0 when 'total_time' is equal to 0,
- re-base on top of v5.0-rc7
v2:
- simplified arguments list, according to Steven's comments, with only
  one arg: 'devfreq' and the rest fields taken from there,
v1:
- moved long '/' operation to post-processing phase, according to Seven's
  comments [2] 
- re-ordered fields in the structure to avoid holes, according to Seven's
  comments [3] 
- removed unneeded variable, according to Chanwoo's comment [4]
basic in larget patch set:
- added support for trace events

I did not dare to add 'Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>'
for the 1st patch, which was in [5], since the code slightly changed.
The 2nd patch has it. 

Regards,
Lukasz Luba

[1] https://lkml.org/lkml/2019/2/12/1179
[2] https://lkml.org/lkml/2019/2/12/1201
[3] https://lkml.org/lkml/2019/2/13/532
[4] https://lkml.org/lkml/2019/2/13/1587
[5] https://lkml.org/lkml/2019/2/14/2

Lukasz Luba (2):
  trace: events: add devfreq trace event file
  drivers: devfreq: add tracing for scheduling work

 MAINTAINERS                    |  1 +
 drivers/devfreq/devfreq.c      |  5 +++++
 include/trace/events/devfreq.h | 40 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)
 create mode 100644 include/trace/events/devfreq.h

-- 
2.7.4
