From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 00/31] CPUFreq: Implement light weight ->target(): for 3.13
Date: Tue, 13 Aug 2013 10:19:18 +0530
Message-ID: <CAKohpokOkWMo4UAcpXYzUMBz4rUn3253GFkdi+YtqRbmqFOm3Q@mail.gmail.com>
References: <cover.1376329128.git.viresh.kumar@linaro.org>
	<1391342.M2Jbj3t5qy@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f49.google.com ([209.85.219.49]:45111 "EHLO
	mail-oa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751370Ab3HMEtT (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 13 Aug 2013 00:49:19 -0400
Received: by mail-oa0-f49.google.com with SMTP id n10so8271731oag.8
        for <linux-pm@vger.kernel.org>; Mon, 12 Aug 2013 21:49:18 -0700 (PDT)
In-Reply-To: <1391342.M2Jbj3t5qy@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, John Crispin <blogic@openwrt.org>, Kukjin Kim <kgene.kim@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-cris-kernel@axis.com, Mikael Starvik <starvik@axis.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sekhar Nori <nsekhar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, sparclinux@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Steven Miao <realmz6@gmail.com>, Tony Luck <tony.luck@intel.com>

On 13 August 2013 04:17, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday, August 12, 2013 11:18:36 PM Viresh Kumar wrote:
>> Currently prototype of cpufreq_drivers target routines is:
>>
>> int target(struct cpufreq_policy *policy, unsigned int target_freq,
>>       unsigned int relation);
>>
>> And most of the drivers call cpufreq_frequency_table_target() to get a valid
>> index of their frequency table which is closest to the target_freq. And they
>> don't use target_freq and relation after it.
>>
>> So, it makes sense to just do this work in cpufreq core before calling
>> cpufreq_frequency_table_target() and simply pass index instead. But this can be
>> done only with drivers which expose their frequency table with cpufreq core. For
>> others we need to stick with the old prototype of target() until those drivers
>> are converted to expose frequency tables.
>>
>> So, in order not to break those special drivers first patch renames ->target() to
>> ->target_old() and the following patches will define the new prototype and
>> convert existing drivers one by one.
>
> Super-ugly.

Thanks. I expected something similar.. :)

> Please just keep the old .target() as is, add a new callback and switch the
> suitable drivers to using it.  You may call the new one .target_index() or
> something along these lines.

I thought of implementing with this name but then thought maybe earlier name
is good enough and can be kept and so went for the *Super-ugly* solution..

Will be fixed :)
