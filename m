From: Michael Wang <wangyun@linux.vnet.ibm.com>
Subject: Re: [v3.10 regression] deadlock on cpu hotplug
Date: Wed, 10 Jul 2013 14:04:50 +0800
Message-ID: <51DCF982.4070707@linux.vnet.ibm.com>
References: <1443144.WnBWEpaopK@amdc1032> <51DB724F.9050708@linux.vnet.ibm.com>	<1754044.EVIH1UZj6p@amdc1032> <51DC0B0D.9070201@linux.vnet.ibm.com>	<51DCDF1C.1000208@linux.vnet.ibm.com> <CAKohpokbo+X5bEYweBuSqr5bkdRsb-XHT7SrMWybwAvkfDsGBQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from e28smtp03.in.ibm.com ([122.248.162.3]:35695 "EHLO
	e28smtp03.in.ibm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750894Ab3GJGFD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 10 Jul 2013 02:05:03 -0400
Received: from /spool/local
	by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
	for <linux-pm@vger.kernel.org> from <wangyun@linux.vnet.ibm.com>;
	Wed, 10 Jul 2013 11:28:33 +0530
In-Reply-To: <CAKohpokbo+X5bEYweBuSqr5bkdRsb-XHT7SrMWybwAvkfDsGBQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Borislav Petkov <bp@alien8.de>, Jiri Kosina <jkosina@suse.cz>, Tomasz Figa <t.figa@samsung.com>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 07/10/2013 01:39 PM, Viresh Kumar wrote:
> On 10 July 2013 09:42, Michael Wang <wangyun@linux.vnet.ibm.com> wrote:
>> I'm not sure what is supposed after notify CPUFREQ_GOV_STOP event, if it
>> is in order to stop queued work and prevent follow work happen again,
>> then it failed to, and we need some method to stop queue work again when
>> CPUFREQ_GOV_STOP notified, like some flag in policy which will be
>> checked before re-queue work in work.
>>
>> But if the event is just to sync the queued work but not prevent follow
>> work happen, then things will become tough...we need confirm.
> 
> After GOV_STOP, until the time GOV_START is called, we shouldn't be
> queuing any work.

Thanks for the confirm :) seems like the root cause is very likely
related with the problem Srivatsa discovered.

I think the fix in his mail worth a try, but I need more investigations
to confirm that's the right way...

Regards,
Michael Wang

> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

