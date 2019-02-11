From: Lukasz Luba <l.luba@partner.samsung.com>
Subject: [PATCH v2 0/2] drivers: devfreq: fix and optimize workqueue
 mechanism
Date: Mon, 11 Feb 2019 16:30:03 +0100
Message-ID: <1549899005-7760-1-git-send-email-l.luba@partner.samsung.com>
References: <CGME20190211153030eucas1p19bd9a7eca565ca066ab00dc2243cfb46@eucas1p1.samsung.com>
Content-Type: text/plain; charset="utf-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Cc: b.zolnierkie@samsung.com, myungjoo.ham@samsung.com, cw00.choi@samsung.com, kyungmin.park@samsung.com, m.szyprowski@samsung.com, s.nawrocki@samsung.com, tkjos@google.com, joel@joelfernandes.org, chris.diamand@arm.com, mka@chromium.org, Lukasz Luba <l.luba@partner.samsung.com>
List-Id: linux-pm@vger.kernel.org

This patch set changes workqueue related features in devfreq framework.
First patch switches to delayed work instead of deferred.
The second switches to regular system work and deletes custom 'devfreq'.

Using deferred work in this context might harm the system performance.
When the CPU enters idle, deferred work is not fired. The devfreq device's
utilization does not have to be connected with a particular CPU.
The drivers for GPUs, Network on Chip, cache L3 rely on devfreq governor.
They all are missing opportunity to check the HW state and react when
the deferred work is not fired.
A corner test case, when Dynamic Memory Controller is utilized by CPUs running
on full speed, might show x5 worse performance if the crucial CPU is in idle.

Changes:
v2:
- single patch split into two
- added cover letter

link for the previous version and discussion:
https://marc.info/?l=linux-pm&m=154904631226997&w=2

Regards,
Lukasz Luba

Lukasz Luba (2):
  drivers: devfreq: change devfreq workqueue mechanism
  drivers: devfreq: change deferred work into delayed

 drivers/devfreq/devfreq.c | 27 +++++++--------------------
 1 file changed, 7 insertions(+), 20 deletions(-)

-- 
2.7.4
