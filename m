From: Krzysztof Kozlowski <k.kozlowski@samsung.com>
Subject: Re: [PATCH v5 3/7] ARM: dts: Exynos542x/5800: add CPU OPP properties
Date: Fri, 11 Dec 2015 13:53:26 +0900
Message-ID: <566A56C6.2000503@samsung.com>
References: <1449766729-435-1-git-send-email-b.zolnierkie@samsung.com>
 <1449766729-435-4-git-send-email-b.zolnierkie@samsung.com>
 <20151211031646.GL3612@ubuntu> <566A4231.9050608@osg.samsung.com>
 <20151211033253.GN3612@ubuntu> <566A4A60.8060402@samsung.com>
 <20151211041349.GO3612@ubuntu> <566A4E82.3040203@samsung.com>
 <20151211043802.GP3612@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout2.w1.samsung.com ([210.118.77.12]:23035 "EHLO
	mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751598AbbLKExh (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 10 Dec 2015 23:53:37 -0500
In-reply-to: <20151211043802.GP3612@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>, Rob Herring <robh+dt@kernel.org>
Cc: Javier Martinez Canillas <javier@osg.samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Thomas Abraham <thomas.ab@samsung.com>, Sylwester Nawrocki <s.nawrocki@samsung.com>, Mike Turquette <mturquette@baylibre.com>, Kukjin Kim <kgene.kim@samsung.com>, Kukjin Kim <kgene@kernel.org>, Ben Gamari <ben@smart-cactus.org>, Tomasz Figa <tomasz.figa@gmail.com>, Lukasz Majewski <l.majewski@samsung.com>, Heiko Stuebner <heiko@sntech.de>, Chanwoo Choi <cw00.choi@samsung.com>, Kevin Hilman <khilman@linaro.org>, Tobias Jakobi <tjakobi@math.uni-bielefeld.de>, Anand Moon <linux.amoon@gmail.com>, linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, Doug Anderson <dianders@chromium.org>, Andreas Faerber <afaerber@suse.de>

On 11.12.2015 13:38, Viresh Kumar wrote:
> On 11-12-15, 13:18, Krzysztof Kozlowski wrote:
>> We had such configuration before (before df09df6f9ac3). I don't see any
>> benefit in what you described. Where is the "thing" to be fixed? It is
>> mixed up. The contiguous ordering is easier to read and more natural.
> 
> This is what you are doing today (keeping on one CPU per cluster to
> simplify it):
> 
> 		cpu0: cpu@0 {
> 			device_type = "cpu";
> 			compatible = "arm,cortex-a15";
> 			reg = <0x0>;
> 			clock-frequency = <1800000000>;
> 			cci-control-port = <&cci_control1>;
> 		};
> 
> 		cpu4: cpu@100 {
> 			device_type = "cpu";
> 			compatible = "arm,cortex-a7";
> 			reg = <0x100>;
> 			clock-frequency = <1000000000>;
> 			cci-control-port = <&cci_control0>;
> 		};
> 
> 
> Then you overwrite it with:
> 
>                 &cpu0 {
>                 	device_type = "cpu";
>                 	compatible = "arm,cortex-a7";
>                 	reg = <0x100>;
>                 	clock-frequency = <1000000000>;
>                 	cci-control-port = <&cci_control0>;
>                 };
>                 
>                 &cpu4 {
>                 	device_type = "cpu";
>                 	compatible = "arm,cortex-a15";
>                 	reg = <0x0>;
>                 	clock-frequency = <1800000000>;
>                 	cci-control-port = <&cci_control1>;
>                 };
> 
> 
> Don't you think this isn't the right way of solving problems?
> 
> The DT overwrite feature isn't there to do such kind of stuff, though
> it doesn't stop you from doing that.

This is quite ugly, indeed, and it is getting uglier :)... but it does
not violate the idea of DT to describe the hardware. Both hardware
descriptions - the 5420 and overridden - are entirely correct... because
the CPU ordering comes from booting sequence (actually code in IROM
decides according to pulled up GPIO gpg2-1).


> Either you should keep separate paths for both the SoCs,

I like that idea. That makes it much more readable. Thanks for feedback!
I will send a patch for that.


> or can solve
> it the way I suggested earlier.
> 
> This came up because in the current series you are doing this:
> 
> 		cpu0: cpu@0 {
> 			compatible = "arm,cortex-a15";
>                         operating-points-v2 = <&cpu0_opp_table>;
> 		};
> 
> 		cpu4: cpu@100 {
> 			device_type = "cpu";
> 			compatible = "arm,cortex-a7";
>                         operating-points-v2 = <&cpu1_opp_table>;
> 		};
> 
> 
> Then you overwrite it with:
> 
>                 &cpu0 {
>                 	compatible = "arm,cortex-a7";
>                         operating-points-v2 = <&cpu1_opp_table>;
>                 };
>                 
>                 &cpu4 {
>                 	compatible = "arm,cortex-a15";
>                         operating-points-v2 = <&cpu0_opp_table>;
>                 };

Yes, it is getting uglier with each change...

Best regards,
Krzysztof


