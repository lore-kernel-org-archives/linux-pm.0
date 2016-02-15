From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/9] cpufreq governor improvements
Date: Mon, 15 Feb 2016 02:08:32 +0100
Message-ID: <3329748.lhJgppdTt9@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Juri Lelli <juri.lelli@arm.com>
List-Id: linux-pm@vger.kernel.org

Hi All,

Here's a buch of patches that slightly improve the ondemand/conservative code
on top of the current linux-next branch of my tree (linux-pm.git).

They don't change the way things work fundamentally, but some minor differences
may be noticeable.

[1/9] Do not do atomic_inc() in gov_cancel_work() as there's no reason to do it
      (new version).

[2/9] Avoid atomic ops in scheduler paths if not absolutely necessary (new version).

[3/9] Fix computation of the contribution from nice in dbs_check_cpu().

[4/9] Clean up load-related computations in the common governor code.

[5/9] Get rid of the ->gov_check_cpu callback.

[6/9] Make store_sampling_rate() reset the sample delay to 0 (instead of setting
      it to the new sampling rate) to avoid weird interactions with the ondemand
      governor.

[7/9] Move rate_mult to struct policy_dbs_info.

[8/9] Simplify conditionals in od_dbs_timer().

[9/9] Use microseconds in computations related to sample delay.

The series have been (lightly) tested on Toshiba Portege R500.

Thanks,
Rafael
