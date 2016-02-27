From: Li Yang <leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org>
Subject: Re: [PATCH V3] cpufreq: qoriq: Register cooling device based on
 device tree
Date: Fri, 26 Feb 2016 18:41:06 -0600
Message-ID: <CADRPPNQhmb3bET9fV072ad5FEHAPrjuXSze1HwnRnKMRmFi8cg@mail.gmail.com>
References: <1448529671-48216-1-git-send-email-hongtao.jia@freescale.com>
	<2396230.MApG9VTrxr@wuerfel>
	<CADRPPNTeBXJBybGwm4jkS64nSyWg+oaod3KJbE_SqfdSuUCA_Q@mail.gmail.com>
	<3593471.QAyZdAuTcW@wuerfel>
	<CADRPPNSASmfxS=BWKvOxGKyCiqno9YvOuAfBaHwKL-Y=jQ2Dzw@mail.gmail.com>
	<CADRPPNQPOUE-2_UnHbfMvGXCuuKYkX4a2Pp3Sb9Uc3vgMr-HuQ@mail.gmail.com>
	<1456531704.5360.53.camel@buserror.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1456531704.5360.53.camel-fOR+EgIDQEHk1uMJSBkQmQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Scott Wood <oss-fOR+EgIDQEHk1uMJSBkQmQ@public.gmane.org>
Cc: Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, linuxppc-dev <linuxppc-dev-uLR06cmDAlY/bJ5BZ2RsiQ@public.gmane.org>, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Jia Hongtao <hongtao.jia-KZfg59tc24xl57MIdRCFDg@public.gmane.org>, Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 26, 2016 at 6:08 PM, Scott Wood <oss-fOR+EgIDQEHk1uMJSBkQmQ@public.gmane.org> wrote:
> On Fri, 2016-02-26 at 18:04 -0600, Li Yang wrote:
>> On Fri, Feb 26, 2016 at 5:31 PM, Li Yang <leoli-KZfg59tc24xl57MIdRCFDg@public.gmane.org> wrote:
>> > On Fri, Feb 26, 2016 at 5:16 PM, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org> wrote:
>> > > On Friday 26 February 2016 17:07:09 Li Yang wrote:
>> > > >
>> > > > I don't have a perfect solution either.  But I think this is still
>> > > > better than making cpufreq not usable.  The cpufreq driver will print
>> > > > out an error message if thermal is not reachable.  Maybe this can
>> > > > relief the confusion a little bit?
>> > >
>> > > With my patch, the configuration will just force the cpufreq
>> > > driver to be a loadable module as well if thermal is a module,
>> > > so the dependency can be resolved by loading the thermal module first.
>> >
>> > It would be perfect if this it true.  But I tried with the following
>> > change, it just makes QORIQ_CPUFREQ non-selectable if THERMAL=m.
>> >
>> > diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
>> > index dcb972a38fbc..ca05037dd565 100644
>> > --- a/drivers/cpufreq/Kconfig
>> > +++ b/drivers/cpufreq/Kconfig
>> > @@ -297,6 +297,7 @@ endif
>> >  config QORIQ_CPUFREQ
>> >         tristate "CPU frequency scaling driver for Freescale QorIQ SoCs"
>> >         depends on OF && COMMON_CLK && (PPC_E500MC || ARM)
>> > +       depends on !CPU_THERMAL || THERMAL=y
>> >         select CLK_QORIQ
>> >         help
>> >           This adds the CPUFreq driver support for Freescale QorIQ SoCs
>>
>>
>> I find we can achieve your desired result with the following change instead:
>>
>> +       depends on (THERMAL=m && m) || THERMAL=y || THERMAL=n
>
> "depends on THERMAL || !THERMAL" should also work.

Right.  And this is more simpler.

Regards,
Leo
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
