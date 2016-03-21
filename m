From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH 0/3] cpufreq: Governor start handling unification and cpufreq_resume() cleanup
Date: Mon, 21 Mar 2016 15:44:17 +0100
Message-ID: <1780622.pJaGsuQWcI@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Linux PM list <linux-pm@vger.kernel.org>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>
List-Id: linux-pm@vger.kernel.org

Hi,

As per the subject, the following patches unify the handling of governor
start throughout the cpufreq core and clean up the way cpufreq_resume()
deals with policy->cur being out of sync with the real frequency.

[1/3] introduces cpufreq_start_governor() to implement the repeating
      governor start code pattern.
[2/3] moves the frequency update code from cpufreq_update_policy() to
      a separate function, cpufreq_update_current_freq().
[3/3] makes cpufreq_start_governor() call cpufreq_update_current_freq()
      and drops the (super-ugly and racy) piece of code to synchrnonize
      the frequency of the boot CPU with its policy->cur.

Thanks,
Rafael
