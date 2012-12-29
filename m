From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] Fix problem with cpufreq_pndemand or cpufreq_conservative
Date: Fri, 28 Dec 2012 18:53:20 -0600
Message-ID: <50DE3F00.70800@lwfinger.net>
References: <50DE1A74.4040607@lwfinger.net> <3226192.H2BxHSuKio@vostro.rjw.lan> <50DE2F32.1010207@lwfinger.net> <20121229003341.GA30982@balto.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f53.google.com ([209.85.220.53]:59974 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755105Ab2L2AxY (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Dec 2012 19:53:24 -0500
In-Reply-To: <20121229003341.GA30982@balto.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Fabio Baltieri <fabio.baltieri@linaro.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, viresh kumar <viresh.kumar@linaro.org>, cpufreq@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 12/28/2012 06:33 PM, Fabio Baltieri wrote:
> On Fri, Dec 28, 2012 at 05:45:54PM -0600, Larry Finger wrote:
>>> I wonder if that's avoidable?  The intention is not to create an additional
>>> module, clearly.
>>
>> It appears not to be possible. I don't know enough about to kmake to
>> understand why it is forcing a new module. Perhaps some expert knows
>> what Kconfig or Makefile magic will prevent that.
>
> kbuild is building an additional module just because the makefile is
> adding the new objects in the obj-m list directly, as in:
>
> obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)     += cpufreq_ondemand.o cpufreq_governor.o
> obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE) += cpufreq_conservative.o cpufreq_governor.o
>
> To build just two modules the Makefile would have to be modified [1]
> into something into something like:
>
> obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)     += cpufreq_ondemand_mod.o
> cpufreq_ondemand_mod-y                  := cpufreq_ondemand.o cpufreq_governor.o
> obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE) += cpufreq_conservative_mod.o
> cpufreq_conservative_mod-y              := cpufreq_conservative.o cpufreq_governor.o
>
> so that only two .o are added to obj-m, but that's not correct either as
> you end up with cpufreq_governor symbols exported twice.
>
> I think the only way would be to force cpufreq_governor as builtin with
> an automatic Kconfig option.
>
> Fabio
>
> 1. http://lxr.linux.no/#linux+v3.7.1/Documentation/kbuild/makefiles.txt#L191

Fabio,

Thanks for the explanation. Now I think I know how to do it.

V3 follows.

Larry


