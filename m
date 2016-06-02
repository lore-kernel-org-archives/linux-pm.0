From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 00/11] cpufreq: Keep policy->freq_table sorted
Date: Thu, 2 Jun 2016 22:35:21 +0200
Message-ID: <CAJZ5v0h23n7k66fRdmARXStOYFVTpVSQQVa1bN3YixehG=eD4w@mail.gmail.com>
References: <cover.1464876460.git.viresh.kumar@linaro.org>
	<CAJZ5v0hF5vk_KPCu0xrRA3mzRBGqW4wtPODkCRk47_n5h_y7jw@mail.gmail.com>
	<CAKohpokG3P4PmmGVD7PcEMramLUv5yrhPY4MkEif3QH0e7EySA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f67.google.com ([74.125.82.67]:35748 "EHLO
	mail-wm0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932593AbcFBUfX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 2 Jun 2016 16:35:23 -0400
In-Reply-To: <CAKohpokG3P4PmmGVD7PcEMramLUv5yrhPY4MkEif3QH0e7EySA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Kevin Hilman <khilman@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Kukjin Kim <kgene@kernel.org>, Sekhar Nori <nsekhar@ti.com>, Steven Miao <realmz6@gmail.com>

On Thu, Jun 2, 2016 at 5:42 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 2 June 2016 at 20:38, Rafael J. Wysocki <rafael@kernel.org> wrote:
>> On Thu, Jun 2, 2016 at 4:19 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>>> Hi Rafael,
>>>
>>> This series fixes all cpufreq drivers that provide a 'target_index'
>>> callback or in other words, which provide a freq-table to cpufreq core,
>>> to make sure they *only* use the 'index' argument to ->target_index()
>>> with the policy->freq_table.
>>>
>>> This change allows us to remove the (duplicate) sorted-freq-table, which
>>> was added by following series:
>>>
>>> [PATCH V2 0/2] cpufreq: Use sorted frequency tables
>>
>> Which I'm not going to apply.
>>
>> If this series depended on that one, please rework it.
>
> Hi Rafael,
>
> The first 9 patches can be applied without any dependency
> on the earlier series, but not the last two.
>
> The target of this series is to make freq-table lookup faster
> and so most of its patches would make sense only if we
> are trying to solve that problem. Otherwise they may not
> be required at all.

Well, in that case I'm not sure about them.

> I hope that you will be replying to the earlier series [1] as well,
> to convey the concerns you have with it.

Oh, that's very simple: I don't see a reason to apply that series.

Quoting from this very cover letter "This change allows us to remove
the (duplicate) sorted-freq-table, which
was added by following series:", so why to add it in the first place?

Besides, there already is a number of tables (per policy which in some
important cases pretty much means per CPU) in cpufreq that contain
more-or-less the same information.  For example, if acpi-cpufreq is in
use, the ACPI layer has a table coming from _PSS, the driver creates
freq_table to pass to the core and there is an additional one for the
stats.  And your series adds one more just so it is ordered.  Come on.

If you want to clean that up, fine, but please don't do that in a
hurry.  Let's talk about it a bit more without sending any more
patches in that area for the time being.

At this point, I'm lost in the patches you've been sending for the
last couple of days.  I don't know what depends on what, what will be
updated and so on and quite frankly I don't really have the time to
figure that out.  Overall, the most recent burst of activity regarding
the sorting of frequency tables hasn't been very helpful from my
perspective.

If you have cleanups that look obvious and don't interfere with
anything already posted by Steve, please send them *again* in one
ordered series and let everybody know whom you would like to apply
them etc.

And now I'm going to look at the Steve's patches again and start over
from there.

Thanks,
Rafael
