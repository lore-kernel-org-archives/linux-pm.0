From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [RESEND 2] cpufreq: dt: disable unsupported OPPs
Date: Thu, 23 Oct 2014 16:43:54 +0200
Message-ID: <CAMuHMdXAYhAEFNLCcq91xctYwaCZnJt-V+U+vYy1iC5Kb=qqjw@mail.gmail.com>
References: <48734362.lRa73hezrZ@vostro.rjw.lan>
	<1413454100-23009-1-git-send-email-l.stach@pengutronix.de>
	<8590662.lsNXszcTd0@vostro.rjw.lan>
	<CAMuHMdV2gPOZoV62rSNjpD=dJ43EE+s0wtRW4ncLWU-J-eHLDg@mail.gmail.com>
	<1414073448.2764.1.camel@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f182.google.com ([209.85.217.182]:63979 "EHLO
	mail-lb0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752107AbaJWOn4 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 23 Oct 2014 10:43:56 -0400
In-Reply-To: <1414073448.2764.1.camel@pengutronix.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lucas Stach <l.stach@pengutronix.de>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Viresh Kumar <viresh.kumar@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>

Hi Lucas,

On Thu, Oct 23, 2014 at 4:10 PM, Lucas Stach <l.stach@pengutronix.de> wrote:
> Am Donnerstag, den 23.10.2014, 11:19 +0200 schrieb Geert Uytterhoeven:
>> On Tue, Oct 21, 2014 at 4:19 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> > On Thursday, October 16, 2014 12:08:20 PM Lucas Stach wrote:
>> >> If the regulator connected to the CPU voltage plane doesn't
>> >> support an OPP specified voltage with the acceptable tolerance
>> >> it's better to just disable the OPP instead of constantly
>> >> failing the voltage scaling later on.
>> >>
>> >> Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
>> >> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>> >
>> > Applied, thanks!
>>
>> This commit
>> (http://git.kernel.org/cgit/linux/kernel/git/rafael/linux-pm.git/commit/?h=linux-next&id=d7bbd4cd0359d781b67c9e621d4bbfd1bb2f3783)
>> causes a boot regression on r8a7791/koelsch. It hangs after:
>>
>>     TCP: cubic registered
>>     Initializing XFRM netlink socket
>>     NET: Registered protocol family 17
>>     NET: Registered protocol family 15
>>     ata1: link resume succeeded after 1 retries
>>     ata1: SATA link down (SStatus 0 SControl 300)
>>     random: nonblocking pool is initialized

>> Reverting this commit fixes the issue, and makes the boot continue with:
>>
>>     cpufreq: __cpufreq_add_dev: CPU0: Running at unlisted freq: 1300000 KHz
>>     cpufreq: __cpufreq_add_dev: CPU0: Unlisted initial frequency
>> changed to: 1312500 KHz
>>     cpu cpu1: failed to get cpu-2 clock: 1
>>     cpufreq_dt: cpufreq_init: Failed to allocate resources: -2
>>
>
> Urgh, thanks for the report. Am I right that for koelsch you do
> reference a regulator supply for the cpu, but don't actually have a
> driver for it, so a dummy regulator gets plugged in there?

arch/arm/boot/dts/r8a7791-koelsch.dts has:

&cpu0 {
        cpu0-supply = <&vdd_dvfs>;
};

&i2c6 {
        status = "okay";
        clock-frequency = <100000>;

        vdd_dvfs: regulator@68 {
                compatible = "dlg,da9210";
                reg = <0x68>;

                regulator-min-microvolt = <1000000>;
                regulator-max-microvolt = <1000000>;
                regulator-boot-on;
                regulator-always-on;
        };
};

CONFIG_REGULATOR_DA9210=y

and the driver does seem to run:

    DA9210: 1000 mV at 4600 mA

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
