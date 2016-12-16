From: Javier Martinez Canillas <javier@osg.samsung.com>
Subject: Re: [PATCH v2] ARM: dts: Add missing CPU frequencies for
 Exynos5422/5800
Date: Fri, 16 Dec 2016 16:18:53 -0300
Message-ID: <65cc16b3-4252-6933-96c8-621e3b694707@osg.samsung.com>
References: <10512254.nyUcL0zgTP@amdc3058>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from ec2-52-27-115-49.us-west-2.compute.amazonaws.com ([52.27.115.49]:44246
        "EHLO osg.samsung.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756255AbcLPTTE (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 16 Dec 2016 14:19:04 -0500
In-Reply-To: <10512254.nyUcL0zgTP@amdc3058>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Krzysztof Kozlowski <krzk@kernel.org>
Cc: Kukjin Kim <kgene@kernel.org>, Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>, Russell King <linux@armlinux.org.uk>, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>, Thomas Abraham <thomas.ab@samsung.com>, Ben Gamari <ben@smart-cactus.org>, Arjun K V <arjun.kv@samsung.com>, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org

Hello Bartlomiej,

On 12/15/2016 08:55 AM, Bartlomiej Zolnierkiewicz wrote:
> Add missing 2000MHz & 1900MHz OPPs (for A15 cores) and 1400MHz OPP
> (for A7 cores).  Also update common Odroid-XU3 Lite/XU3/XU4 thermal
> cooling maps to account for new OPPs.
> 
> Since new OPPs are not available on all Exynos5422/5800 boards modify
> dts files for Odroid-XU3 Lite (limited to 1.8 GHz / 1.3 GHz) & Peach
> Pi (limited to 2.0 GHz / 1.3 GHz) accordingly.
> 
> Tested on Odroid-XU3 and XU3 Lite.
> 
> Cc: Doug Anderson <dianders@chromium.org>
> Cc: Javier Martinez Canillas <javier@osg.samsung.com>
> Cc: Andreas Faerber <afaerber@suse.de>
> Cc: Thomas Abraham <thomas.ab@samsung.com>
> Cc: Ben Gamari <ben@smart-cactus.org>
> Cc: Arjun K V <arjun.kv@samsung.com>
> Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
> ---
> v2:
> - added comments about limitations of SoC revisions used by Odroid-XU3 Lite and
>   Peach Pi boards (suggested by Javier)
> - removed redundant opp_a7_14 label
> - added Arjun to Cc:
> 
> Javier, could you test it on Peach Pi board?
> 

I've tested this patch on my Peach Pi by setting the CPUFreq governor to
performance and checking that the current scaling frequency was 2.0 GHz:

$ cat /sys/devices/system/cpu/cpu*/cpufreq/scaling_cur_freq 
2000000
2000000
2000000
2000000
1400000
1400000
1400000
1400000

I ran the machine for hours and it didn't became unstable. Also installed
the stress [0] tool and setting the governor to ondemand, I executed:

$ stress --cpu 8

For about 30 minutes, the current frequencies were again the maximum and
had no issues.

Finally, I tested some devices that are under the INT rail (MFC and GSC)
by using the following GStreamer pipeline:

$ gst-launch-1.0 filesrc location=test-1080p.mp4 ! qtdemux ! h264parse ! \
  v4l2video5dec ! v4l2video7convert capture-io-mode=dmabuf ! kmssink

Again, the system keeps working correctly. So I think it's safe to say:

Tested-by: Javier Martinez Canillas <javier@osg.samsung.com>

I can't provide a Reviewed-by since is still not clear to me if these OPP
values are correct or not due the ChromiumOS tree using higher voltages.

FWIW, the chip ID block information on my Exynos5800 Peach Pi is:

Exynos: CPU[EXYNOS5800] CPU_REV[0x1] PKG_ID[0x350c82f8] AUX_INFO[0x4d]

[0]: http://people.seas.harvard.edu/~apw/stress/

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
