From: Tuomas Tynkkynen <ttynkkynen@nvidia.com>
Subject: Re: [PATCH v2 14/16] cpufreq: Add cpufreq driver for Tegra124
Date: Wed, 23 Jul 2014 22:17:27 +0300
Message-ID: <53D00A47.7050203@nvidia.com>
References: <1405957142-19416-1-git-send-email-ttynkkynen@nvidia.com>	<1405957142-19416-15-git-send-email-ttynkkynen@nvidia.com>	<CAKohpomQthJ_XE-HhzW07Q4aVtxQVy97iaL0Vy6Q4Lhw22A=VA@mail.gmail.com>	<53CFA33F.6030307@nvidia.com> <CAKohponLh66Ubr6=wY2OZCCrK11KZDj=DmXXqXsGGTHSG45wpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate16.nvidia.com ([216.228.121.65]:13507 "EHLO
	hqemgate16.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932514AbaGWTRc (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Jul 2014 15:17:32 -0400
In-Reply-To: <CAKohponLh66Ubr6=wY2OZCCrK11KZDj=DmXXqXsGGTHSG45wpA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-tegra@vger.kernel.org" <linux-tegra@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Stephen Warren <swarren@wwwdotorg.org>, Thierry Reding <thierry.reding@gmail.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Prashant Gaikwad <pgaikwad@nvidia.com>, Mike Turquette <mturquette@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Paul Walmsley <pwalmsley@nvidia.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>



On 23/07/14 19:50, Viresh Kumar wrote:
> On 23 July 2014 17:27, Tuomas Tynkkynen <ttynkkynen@nvidia.com> wrote:
>> The platform device is required for the deferred probe that can happen if the
>> DFLL driver hasn't initialized yet, and module_init() callbacks don't seem to
>> respect -EPROBE_DEFER.
> 
> Oh, which call in this file will return EPROBE_DEFER? I couldn't make out
> which one will depend on DFLL driver.
> 

It's this:

+static int tegra124_cpufreq_probe(struct platform_device *pdev)
+{
[...]
+
+	dfll_clk = of_clk_get_by_name(cpu_dev->of_node, "dfll");
+	if (IS_ERR(dfll_clk)) {
+		ret = PTR_ERR(dfll_clk);
+		goto out_put_cpu_clk;
+	}

-- 
nvpublic
