From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/3] cpufreq: pmac64: re-estimate G5 cpufreq transition latency
Date: Wed, 24 Jul 2013 16:15:46 +0530
Message-ID: <CAKohpony71fjY580Nk-35P9WmR-WaXVb7+2Xv9do1taByK+ELA@mail.gmail.com>
References: <1374611079-28091-1-git-send-email-aaro.koskinen@iki.fi>
	<1374611079-28091-2-git-send-email-aaro.koskinen@iki.fi>
	<CAKohpo=t0C63m_WuZA-dGiLDtBu8FbdM8tgJLNh_NSAALnf+fw@mail.gmail.com>
	<20130724101832.GA26943@blackmetal.musicnaut.iki.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-oa0-f43.google.com ([209.85.219.43]:44354 "EHLO
	mail-oa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750878Ab3GXKpq (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jul 2013 06:45:46 -0400
Received: by mail-oa0-f43.google.com with SMTP id i7so542797oag.2
        for <linux-pm@vger.kernel.org>; Wed, 24 Jul 2013 03:45:46 -0700 (PDT)
In-Reply-To: <20130724101832.GA26943@blackmetal.musicnaut.iki.fi>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Aaro Koskinen <aaro.koskinen@iki.fi>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Nick Piggin <npiggin@suse.de>, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org

On 24 July 2013 15:48, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
> Hi,
>
> On Wed, Jul 24, 2013 at 11:04:50AM +0530, Viresh Kumar wrote:
>> On 24 July 2013 01:54, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
>> > The patch also enables to use ondemand governor on the latter.
>>
>> How? I can't see anything obvious here. :(
>
> It replaces CPUFREQ_ETERNAL with a proper value on older PowerMacs.
> ondemand does not accept CPUFREQ_ETERNAL transition latency.

Ahh.. In case you are sending it again, just add this info in log as people
might miss it.
