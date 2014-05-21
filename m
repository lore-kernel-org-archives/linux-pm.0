From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 3/7] driver/core: cpu: initialize opp table
Date: Wed, 21 May 2014 19:31:01 +0530
Message-ID: <CAKohpo=-kmfH9Z+m8E9HQXs4AvRoUCDzcrns6-HHLH=AqeJ-DQ@mail.gmail.com>
References: <cover.1400670427.git.viresh.kumar@linaro.org>
	<b59df199b373191791afcccd627d900ce07afa71.1400670427.git.viresh.kumar@linaro.org>
	<537CADFB.1090305@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f173.google.com ([209.85.214.173]:48050 "EHLO
	mail-ob0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751018AbaEUOBF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 21 May 2014 10:01:05 -0400
Received: by mail-ob0-f173.google.com with SMTP id wm4so2183275obc.18
        for <linux-pm@vger.kernel.org>; Wed, 21 May 2014 07:01:04 -0700 (PDT)
In-Reply-To: <537CADFB.1090305@arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Sudeep Holla <sudeep.holla@arm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Arvind Chauhan <Arvind.Chauhan@arm.com>, "inderpal.s@samsung.com" <inderpal.s@samsung.com>, "nm@ti.com" <nm@ti.com>, "chander.kashyap@linaro.org" <chander.kashyap@linaro.org>, "pavel@ucw.cz" <pavel@ucw.cz>, "len.brown@intel.com" <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Amit Daniel Kachhap <amit.daniel@samsung.com>, Kukjin Kim <kgene.kim@samsung.com>, Shawn Guo <shawn.guo@linaro.org>

On 21 May 2014 19:15, Sudeep Holla <sudeep.holla@arm.com> wrote:
> [Nit] Not sure if we need this logging on each cpu, may be dev_dbg if you
> still
> fancy one ? :)

It wouldn't happen on each CPU, but one CPU per policy as others
would return -ENODEV.

I added dev_dbg earlier but then I thought dev_info is better as we may
better show this to everybody as it about the most important device,
i.e. CPU :)

>> +       /* Print error only if there is an issue with OPP table */
>> +       else if (error != -ENOSYS && error != -ENODEV)
>> +               dev_err(&cpu->dev, "%s: failed to init OPP table for
>> cpu%d, err: %d\n",
>> +                       __func__, cpu->dev.id, error);
>> +}
>> +#else
>> +static inline void of_init_cpu_opp_table(struct cpu *cpu) {}
>> +#endif
>> +
>
>
> IMO this could be more generic and applicable for any device if you replace
> "struct cpu" with "struct device". I know this is currently used by cpu but
> we can extend it's use for any device if needed in future. You can then move
> this to pm_opp.h as of_init_dev_opp_table may be.

Probably we will call of_init_opp_table() directly for other devices, as this
function doesn't do anything else, apart from some prints.. So, probably
leave is as is for now, unless a real need arises ?
