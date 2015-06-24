From: Pi-Cheng Chen <pi-cheng.chen@linaro.org>
Subject: Re: [PATCH 2/2] cpufreq: mediatek: Add MT8173 cpufreq driver
Date: Wed, 24 Jun 2015 17:09:49 +0800
Message-ID: <CALx668Ug6Ox_2jf3Ad7zvW1Q=L61oE-P-yXdadG_eJ20W2qN9A@mail.gmail.com>
References: <1433766561-1330-1-git-send-email-pi-cheng.chen@linaro.org>
	<1433766561-1330-3-git-send-email-pi-cheng.chen@linaro.org>
	<20150622114511.GA28340@linux>
	<CALx668VmT+90y712QO4JQCh-nTCxStWYY+ygJ_1KiVN7VnmmpQ@mail.gmail.com>
	<20150624005759.GA6424@linux>
	<CALx668UUUCzswiXyM9e4v9fhu6PTXq5DLu_O3swTPhJUjJPBFg@mail.gmail.com>
	<20150624085658.GF27188@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-yh0-f51.google.com ([209.85.213.51]:34402 "EHLO
	mail-yh0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750787AbbFXJJt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 24 Jun 2015 05:09:49 -0400
Received: by yhnv31 with SMTP id v31so14185092yhn.1
        for <linux-pm@vger.kernel.org>; Wed, 24 Jun 2015 02:09:49 -0700 (PDT)
In-Reply-To: <20150624085658.GF27188@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Mike Turquette <mturquette@linaro.org>, Matthias Brugger <matthias.bgg@gmail.com>, Mark Rutland <mark.rutland@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linaro Kernel Mailman List <linaro-kernel@lists.linaro.org>, linux-mediatek@lists.infradead.org

On Wed, Jun 24, 2015 at 4:56 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 24-06-15, 16:44, Pi-Cheng Chen wrote:
>> One reason to put those initialization and resource allocation in probe is
>> that it's easier to handle the return value -PROBE_DEFER from clock
>> and regulator framework when trying to get clocks and regulators
>> consumed by cpufreq driver.
>
> This is the sequence of events if you move these things to ->init().
>
> - your driver's probe()
>   -> cpufreq_register_driver()
>     -> init()
>       -> clk/reg get, failed, return -EPROBE_DEFER
>
> And the failure here will be propagated to probe(). So, it should
> work IMHO.

I will try it.

>
>> The other reason is when the whole system is resuming from suspend,
>> the other subsystem e.g. i2c on which cpufreq driver depends might not
>> ready yet during cpufreq driver initialization. In this case, the cpufreq
>> driver will be blocked when trying to get resources e.g. regulator on i2c
>> bus, and the whole system will stuck for seconds.
>
> That's something else you must investigate on. This dependency should
> be resolved in some other way, I thought DT might have taken care of
> such dependencies.

I will check if it could be solved in some other way.
Thanks.

Pi-Cheng

>
> --
> viresh
