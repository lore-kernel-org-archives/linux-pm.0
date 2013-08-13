From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: add frequency table to at32ap driver
Date: Tue, 13 Aug 2013 19:00:22 +0530
Message-ID: <CAKohpomya5EcqRabz7k=eT_vMdb5yuMCbk0vJuY7fLwpCZbc-A@mail.gmail.com>
References: <1376334657-23578-1-git-send-email-egtvedt@samfundet.no>
	<CAKohpokCsCLS=8FNZpUBgEVi7YropyR4UoLC9XNN+rs5xuigMw@mail.gmail.com>
	<CAKohponh4tW8j3qk7eP9YnfXufutNkK-+iCQRvqSUC2=GwvqeA@mail.gmail.com>
	<20130813065208.GB7055@samfundet.no>
	<CAKohponXSvxQwyx7YJYbcQHD8X2F=EuFpFd31DR5HY3JjvS+rQ@mail.gmail.com>
	<20130813090613.GA1850@samfundet.no>
	<CAKohpokqMt2L_r3WR=vTPyW0kUS5wZ8FxS3ii=B=H=Yizuu=ig@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohpokqMt2L_r3WR=vTPyW0kUS5wZ8FxS3ii=B=H=Yizuu=ig@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Hans-Christian Egtvedt <egtvedt@samfundet.no>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Lists linaro-kernel <linaro-kernel@lists.linaro.org>
List-Id: linux-pm@vger.kernel.org

On 13 August 2013 14:39, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Yes, that's what.. That generic routine can be used instead of your .verify()..

So here is a patch for that which I will include in my original series. It uses
functions from this patch:

http://www.kernelhub.org/?msg=309940&p=2

-----------x-------------------x---------------------

commit e02892f73f8f669b265310e51a677c7253e32389
Author: Viresh Kumar <viresh.kumar@linaro.org>
Date:   Fri Aug 9 12:05:56 2013 +0530

    cpufreq: at32ap: Use generic cpufreq routines

    Most of the CPUFreq drivers do similar things in .exit() and
.verify() routines
    and .attr. So its better if we have generic routines for them
which can be used
    by cpufreq drivers then.

    This patch uses these generic routines for this driver.

    Cc: Hans-Christian Egtvedt <egtvedt@samfundet.no>
    Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
---
 drivers/cpufreq/at32ap-cpufreq.c | 12 +-----------
 1 file changed, 1 insertion(+), 11 deletions(-)

diff --git a/drivers/cpufreq/at32ap-cpufreq.c b/drivers/cpufreq/at32ap-cpufreq.c
index 1d19fa5..788f7e7 100644
--- a/drivers/cpufreq/at32ap-cpufreq.c
+++ b/drivers/cpufreq/at32ap-cpufreq.c
@@ -24,16 +24,6 @@
 static struct clk *cpuclk;
 static struct cpufreq_frequency_table *freq_table;

-static int at32_verify_speed(struct cpufreq_policy *policy)
-{
-       if (policy->cpu != 0)
-               return -EINVAL;
-
-       cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
-                       policy->cpuinfo.max_freq);
-       return 0;
-}
-
 static unsigned int at32_get_speed(unsigned int cpu)
 {
        /* No SMP support */
@@ -152,7 +142,7 @@ out_err:
 static struct cpufreq_driver at32_driver = {
        .name           = "at32ap",
        .init           = at32_cpufreq_driver_init,
-       .verify         = at32_verify_speed,
+       .verify         = cpufreq_generic_frequency_table_verify,
        .target         = at32_set_target,
        .get            = at32_get_speed,
        .flags          = CPUFREQ_STICKY,
