From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 07/15] cpufreq: spear needs cpufreq table
Date: Sat, 1 Jun 2013 15:15:26 +0530
Message-ID: <CAKohponkPNBA2kWnpPyNmmJw2t03x63uUSbZkiDfUZzpqqxSKw@mail.gmail.com>
References: <1370038972-2318779-1-git-send-email-arnd@arndb.de>
	<1370038972-2318779-8-git-send-email-arnd@arndb.de>
	<CAKohpomzoGsOoQ__fd0V651bjWt2=JTC10wGSQzX2yyTcWZmvA@mail.gmail.com>
	<2104181.OHBofkq3lH@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qa0-f52.google.com ([209.85.216.52]:56071 "EHLO
	mail-qa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758720Ab3FAJp1 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 1 Jun 2013 05:45:27 -0400
Received: by mail-qa0-f52.google.com with SMTP id cr7so951384qab.4
        for <linux-pm@vger.kernel.org>; Sat, 01 Jun 2013 02:45:26 -0700 (PDT)
In-Reply-To: <2104181.OHBofkq3lH@wuerfel>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: linux-kernel@vger.kernel.org, patches@lists.linaro.org, linux-arm-kernel@lists.infradead.org, "Rafael J. Wysocki" <rjw@sisk.pl>, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On 1 June 2013 14:33, Arnd Bergmann <arnd@arndb.de> wrote:
> On Saturday 01 June 2013 07:28:01 Viresh Kumar wrote:
>> On 1 June 2013 03:52, Arnd Bergmann <arnd@arndb.de> wrote:
>> > Like a lot of the other cpufreq drivers, this one needs to
>> > select CONFIG_CPU_FREQ_TABLE to avoid a build error like
>> >
>> > drivers/built-in.o: In function `spear_cpufreq_exit':
>> > spear-cpufreq.c:198: undefined reference to `cpufreq_frequency_table_put_attr'
>> > drivers/built-in.o: In function `spear_cpufreq_verify':
>> > spear-cpufreq.c:35: undefined reference to `cpufreq_frequency_table_verify'
>> > drivers/built-in.o: In function `spear_cpufreq_init':
>> > spear-cpufreq.c:181: undefined reference to `cpufreq_frequency_table_cpuinfo'
>> > spear-cpufreq.c:187: undefined reference to `cpufreq_frequency_table_get_attr'
>> > drivers/built-in.o: In function `spear_cpufreq_target':
>> > spear-cpufreq.c:120: undefined reference to `cpufreq_frequency_table_target'
>> > drivers/built-in.o:(.data+0x5e63c): undefined reference to `cpufreq_freq_attr_scaling_available_freqs'
>> >
>> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> > Cc: Rafael J. Wysocki <rjw@sisk.pl>
>> > Cc: Viresh Kumar <viresh.kumar@linaro.org>
>> > Cc: cpufreq@vger.kernel.org
>> > Cc: linux-pm@vger.kernel.org
>> > ---
>> >  drivers/cpufreq/Kconfig.arm | 1 +
>> >  1 file changed, 1 insertion(+)
>>
>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>
>> BTW, you want me to apply this one or take it through arm-soc tree?
>
> As I said in the introductory mail, I would prefer it if you
> can pick it up. Thanks!

I saw that mail later :(

Applied to cpufreq-next. Thanks.
