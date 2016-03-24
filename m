From: Feng Xiao <xf@rock-chips.com>
Subject: Re: [PATCH v2] cpufreq: rockchip: add driver
Date: Thu, 24 Mar 2016 11:01:40 +0800
Message-ID: <56F35894.3020106@rock-chips.com>
References: <1458647848-48999-1-git-send-email-xf@rock-chips.com>
 <1458699487-58470-1-git-send-email-xf@rock-chips.com>
 <20160323044033.GQ5272@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.131]:34610 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752843AbcCXDBJ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 23 Mar 2016 23:01:09 -0400
In-Reply-To: <20160323044033.GQ5272@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linux@arm.linux.org.uk, heiko@sntech.de, rjw@rjwysocki.net, linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, wxt@rock-chips.com, zyw@rock-chips.com, jay.xu@rock-chips.com, tim.chen@rock-chips.com, xxx@rock-chips.com, huangtao@rock-chips.comrjw@rjwysocki.net

hi all,
      I found that it could match the cpufreq-dt driver succesfully onl=
y=20
with the following changes.
--- a/arch/arm64/boot/dts/rockchip/rk3366.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3366.dtsi
@@ -139,6 +139,10 @@
                 };
         };

+       cpufreq-dt {   //the node name must be cpufreq-dt
+               compatible =3D "rockchip,cpufreq";  //  the compatible=20
name is insignificant
+       };
+

This was supported by the commit 07e461cd7e73a84f0e3757932b93cc80976fd7=
49

commit 07e461cd7e73a84f0e3757932b93cc80976fd749
Author: Grant Likely <grant.likely@linaro.org>
Date:   Wed May 21 15:40:31 2014 +0900

     of: Ensure unique names without sacrificing determinism

     The way the driver core is implemented, every device using the sam=
e bus
     type is required to have a unique name because a symlink to each d=
evice
     is created in the appropriate /sys/bus/*/devices directory, and tw=
o
     identical names causes a collision.

     The current code handles the requirement by using an globally
     incremented counter that is appended to the device name. It works,=
 but
     it means any change to device registration will change the assigne=
d
     numbers. Instead, if we build up the name by using information fro=
m the
     parent nodes, then it can be guaranteed to be unique without addin=
g a
     random number to the end of it.

     Signed-off-by: Grant Likely <grant.likely@linaro.org>
     Cc: Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
     Cc: Rob Herring <robh@kernel.org>

If so, do I need to continue to add the new cpufreq driver ?

=E5=9C=A8 2016/3/23 12:40, Viresh Kumar =E5=86=99=E9=81=93:
> On 23-03-16, 10:18, Feng Xiao wrote:
>> diff --git a/drivers/cpufreq/Kconfig.arm b/drivers/cpufreq/Kconfig.a=
rm
>> index 14b1f93..1786315 100644
>> --- a/drivers/cpufreq/Kconfig.arm
>> +++ b/drivers/cpufreq/Kconfig.arm
>> @@ -97,6 +97,16 @@ config ARM_OMAP2PLUS_CPUFREQ
>>   	depends on ARCH_OMAP2PLUS
>>   	default ARCH_OMAP2PLUS
>>  =20
>> +config ARM_ROCKCHIP_CPUFREQ
>> +	tristate "Rockchip CPUfreq driver"
> Since you are allowing it to be built as a module ...
>
>> +	depends on ARCH_ROCKCHIP && CPUFREQ_DT
>> +	select PM_OPP
>> +	help
>> +	  This adds the CPUFreq driver support for Rockchip SoCs.
>> +	  The driver will directly use cpufreq-dt driver as backend.
>> +
>> +	  If in doubt, say N.
>> +++ b/drivers/cpufreq/rockchip-cpufreq.c
>> +static int __init rockchip_cpufreq_driver_init(void)
>> +{
>> +	struct platform_device *pdev;
>> +	int i;
>> +
>> +	for (i =3D 0; i < ARRAY_SIZE(rockchip_compat); i++) {
>> +		if (of_machine_is_compatible(rockchip_compat[i])) {
>> +			pdev =3D platform_device_register_simple("cpufreq-dt",
>> +							       -1, NULL, 0);
>> +			return PTR_ERR_OR_ZERO(pdev);
>> +		}
>> +	}
>> +
>> +	return -ENODEV;
>> +}
>> +module_init(rockchip_cpufreq_driver_init);
> You need a module exit as well to remove the device. Otherwise follow=
ing
> sequence will give you errors:
>
> insmod rockchip-cpufreq.ko
> rmmod rockchip-cpufreq.ko
> insmod rockchip-cpufreq.ko //Errors on this..
>
> So, either don't allow it to be built as a module or fix the module-e=
xit path.
>


