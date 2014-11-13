From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Remove architecture specific menu entries
Date: Thu, 13 Nov 2014 10:56:53 +0530
Message-ID: <CAKohpokMgHNUWX8s9Vfow+JdRsnF3LDpS4Erqks5RznyXDDBFw@mail.gmail.com>
References: <92d6fb45a43b8d800cbcdf690bbf6f8e4713b95e.1415765396.git.viresh.kumar@linaro.org>
	<2888462.gyjhHfUy7m@vostro.rjw.lan>
	<1415843008.15957.45.camel@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:47947 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753635AbaKMF0y (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 13 Nov 2014 00:26:54 -0500
Received: by mail-qa0-f44.google.com with SMTP id v10so339821qac.3
        for <linux-pm@vger.kernel.org>; Wed, 12 Nov 2014 21:26:54 -0800 (PST)
In-Reply-To: <1415843008.15957.45.camel@freescale.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Scott Wood <scottwood@freescale.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Yuantian Tang <Yuantian.Tang@freescale.com>

On 13 November 2014 07:13, Scott Wood <scottwood@freescale.com> wrote:
> On Thu, 2014-11-13 at 02:47 +0100, Rafael J. Wysocki wrote:
>> On Wednesday, November 12, 2014 09:40:43 AM Viresh Kumar wrote:
>> > CPUFreq driver's Kconfig entries are added in Kconfig.<arch> files and they are
>> > all included from the main Kconfig file using a menu entry. This creates another
>> > level of (unnecessary) hierarchy within the menuconfig entries.
>> >
>> > The problem occurs when there are drivers usable across architectures. Either
>> > their config entry is duplicated in all the supported architectures or is put
>> > into the main Kconfig entry. With the later one, we have menuconfig entries for
>> > drivers at two levels then.
>> >
>> > Fix these issues by getting rid of another level of menuconfig entries and
>> > populate all drivers within the main cpufreq menu.
>>
>> Won't this be confusing?
>
> Why would it be confusing?  It's already in a not-too-large "CPU
> Frequency scaling" menu, the names of the individual options should be
> clear enough, and they'd all be grouped at the end of the menu.
>
> FWIW, there's already "Generic DT based cpufreq driver" under that menu.
>
>> Can we at least have a "CPU frequency scaling drivers" menu for drivers
>> the *contents* of which will depend on the architecture?
>
> That works too -- I just don't see the confusion aspect.

After thinking a bit about the concerns raised by both of you, I decided to look
at what others are doing about this. And this is the best I came around:

diff --git a/drivers/cpufreq/Kconfig b/drivers/cpufreq/Kconfig
index a24d678..230a912 100644
--- a/drivers/cpufreq/Kconfig
+++ b/drivers/cpufreq/Kconfig
@@ -183,6 +183,8 @@ config CPU_FREQ_GOV_CONSERVATIVE

          If in doubt, say N.

+comment "CPU frequency scaling drivers"
+
 config CPUFREQ_DT
        tristate "Generic DT based cpufreq driver"
        depends on HAVE_CLK && OF


And this is how it looks in menuconfig now:

        [*] CPU Frequency scaling
        <*>   CPU frequency translation statistics (NEW)
        [ ]     CPU frequency translation statistics details (NEW)
              Default CPUFreq governor (performance)  --->
        -*-   'performance' governor
        < >   'powersave' governor (NEW)
        < >   'userspace' governor for userspace frequency scaling
(NEW)
        < >   'ondemand' cpufreq policy governor (NEW)
        < >   'conservative' cpufreq governor (NEW)
              *** CPU frequency scaling drivers ***
        < >   Generic DT based cpufreq driver (NEW)
        < >   Generic ARM big LITTLE CPUfreq driver (NEW)
        [*]   SAMSUNG EXYNOS4210 (NEW)
        [*]   SAMSUNG EXYNOS4x12 (NEW)
        [*]   SAMSUNG EXYNOS5250 (NEW)
        [*]   SAMSUNG EXYNOS5440 (NEW)
        [ ]   EXYNOS Frequency Overclocking - Software (NEW)


Good enough ?
