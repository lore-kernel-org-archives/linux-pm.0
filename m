From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V5 0/7] cpufreq: suspend early/resume late: dpm_{suspend|resume}()
Date: Mon, 17 Feb 2014 11:32:55 +0530
Message-ID: <CAKohpo=JVUPV81hFmwpuweWrfoEGZ0S_pkb9Fd+-SCXy+O+QCQ@mail.gmail.com>
References: <cover.1392273722.git.viresh.kumar@linaro.org>
	<52FE71BD.3020103@wwwdotorg.org>
	<52FE7AFD.2040203@wwwdotorg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <52FE7AFD.2040203@wwwdotorg.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Warren <swarren@wwwdotorg.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Nishanth Menon <nm@ti.com>, Kgene Kim <kgene.kim@samsung.com>, jinchoi@broadcom.com, Lan Tianyu <tianyu.lan@intel.com>, Sebastian Capella <sebastian.capella@linaro.org>, Jonghwan Choi <jhbird.choi@samsung.com>
List-Id: linux-pm@vger.kernel.org

On 15 February 2014 01:52, Stephen Warren <swarren@wwwdotorg.org> wrote:
> BTW, I also happened to test these on a Tegra114 system, on which there
> is no cpufreq driver, and this series (applied on top of commit
> 9398a10cd964 Merge tag 'regulator-v3.14-rc2') causes the following
> during suspend:

Ahh, that's a obvious bug. Following would fix it, thanks:

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index c13c100..2dfbb7e 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -1617,6 +1617,9 @@ void cpufreq_suspend(void)
 {
        struct cpufreq_policy *policy;

+       if (!cpufreq_driver)
+               return;
+
        if (!has_target())
                return;

@@ -1645,6 +1648,9 @@ void cpufreq_resume(void)
 {
        struct cpufreq_policy *policy;

+       if (!cpufreq_driver)
+               return;
+
        if (!has_target())
                return;
