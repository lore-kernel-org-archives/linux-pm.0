From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH 0/2] tracing: drivers: devfreq: add basic trace mechanism
Date: Thu, 14 Feb 2019 19:57:54 +0100
Message-ID: <1550170676-14173-1-git-send-email-l.luba@partner.samsung.com>
References: <CGME20190214185807eucas1p10432f753eeb3ce7c3e9ce8245a3aee20@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, mka@chromium.org, rostedt@goodmis.org, mingo@redhat.com, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

Hi all,

This patch set adds support for tracing in devfreq framework. It is related
to the discussion regarding devfreq workqueue mechanism and wake-ups.
These two tracing patches have been submitted in larger patch set, which
needs more discussion. For the further discussion and development there
is a need of measurements/testing, though. It was agreed that trace events
would help. The whole discussion is here [1].

With these patches it is possible to capture current behaviour for the 
devfreq subsystem and devices such as when and which workqueue is used,
on which CPU, what is the load and frequency of the device.

A few comments for the first version has been addressed here:
- moved long '/' operation to post-processing phase, according to Seven's
  comments [2] 
- re-ordered fields in the structure to avoid holes, according to Seven's
  comments [3] 
- removed unneeded variable, according to Chanwoo's comment [4]

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
 drivers/devfreq/devfreq.c      |  8 ++++++++
 include/trace/events/devfreq.h | 42 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 51 insertions(+)
 create mode 100644 include/trace/events/devfreq.h

-- 
2.7.4
