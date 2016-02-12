From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/2] cpufreq: governor: Optimize work queuing in ondemand/conservative
Date: Fri, 12 Feb 2016 14:26:59 +0100
Message-ID: <5225538.XnBMjjCp2q@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>, Shilpasri G Bhat <shilpabhatppc@gmail.com>
List-Id: linux-pm@vger.kernel.org

Hi,

This is rather extreme, but I think that we should make the scheduler paths as
lightweight as reasonably possible.

[1/2] removes the atomic work counter incrementation from gov_cancel_work() as
      it is not necessary any more.

[2/2] changes the way work items are handled by dbs_update_util_handler() and
      dbs_work_handler() to avoid extra atomic operations in cases when they
      aren't really necessary (policy objects serving one CPU only).

On top of the pm-cpufreq-test branch of linux-pm.git.  Lightly tested, but
I don't have systems where policy objects are shared.

Thanks,
Rafael
