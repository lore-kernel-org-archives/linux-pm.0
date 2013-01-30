From: "AnilKumar, Chimata" <anilkumar@ti.com>
Subject: RE: [PATCH v2] cpufreq: instantiate cpufreq-cpu0 as a
 platform_driver
Date: Wed, 30 Jan 2013 07:10:20 +0000
Message-ID: <331ABD5ECB02734CA317220B2BBEABC13EAF880F@DBDE01.ent.ti.com>
References: <1359428020-21068-1-git-send-email-shawn.guo@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bear.ext.ti.com ([192.94.94.41]:50975 "EHLO bear.ext.ti.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753292Ab3A3HKb convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 30 Jan 2013 02:10:31 -0500
In-Reply-To: <1359428020-21068-1-git-send-email-shawn.guo@linaro.org>
Content-Language: en-US
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: 'Shawn Guo' <shawn.guo@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Langsdorf <mark.langsdorf@calxeda.com>, Tony Lindgren <tony@atomide.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

On Tue, Jan 29, 2013 at 08:23:40, Shawn Guo wrote:
> As multiplatform build is being adopted by more and more ARM platforms,
> initcall function should be used very carefully.  For example, when
> GENERIC_CPUFREQ_CPU0 is built in the kernel, cpu0_cpufreq_driver_init()
> will be called on all the platforms to initialize cpufreq-cpu0 driver.
> 
> To eliminate this undesired the effect, the patch changes cpufreq-cpu0
> driver to have it instantiated as a platform_driver.  Then it will only
> run on platforms that create the platform_device "cpufreq-cpu0".
> 
> Along with the change, it also changes cpu_dev to be &pdev->dev,
> so that managed functions can start working, and module build gets
> supported too.
> 
> The existing users of cpufreq-cpu0 driver highbank and am33xx are also
> updated accordingly to adapt the changes.
> 
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> Cc: Mark Langsdorf <mark.langsdorf@calxeda.com>
> Cc: AnilKumar Ch <anilkumar@ti.com>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> Changes since v1:
>  * Migrate cpufreq-cpu0 users in the same patch
> 
> Rafael,
> 
> The patch is based on Mark's highbank-cpufreq series and Nishanth's
> "PM / OPP : export symbol consolidation" sereis.
> 
> Mark, AnilKumar,
> 
> I only compile-tested it on highbank and omap2.  Please give it a test
> no hardware to make sure cpufreq-cpu0 still works for you.  Thanks.

Hi Shawn,

I hope this is based on linux-omap/master, to test the driver I have
to add some patches on top of this patch, because of recent changes.
I will provide the test details once I am done.

Thanks
AnilKumar
