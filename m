From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: governor: Drop gov_cancel_work()
Date: Thu, 9 Jun 2016 14:21:33 +0200
Message-ID: <CAJZ5v0i5Tf+KsLRSO7A0PanPjG1XenzLpZopfOAYH-3cLbjTbg@mail.gmail.com>
References: <31871585.32WEDJA5Kj@vostro.rjw.lan> <20160609032100.GB9356@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f65.google.com ([74.125.82.65]:36560 "EHLO
	mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750836AbcFIMVf (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 9 Jun 2016 08:21:35 -0400
In-Reply-To: <20160609032100.GB9356@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Thu, Jun 9, 2016 at 5:21 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 09-06-16, 01:45, Rafael J. Wysocki wrote:
>> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>>
>> There's no reason for gov_cancel_work() to exist at all, as it only
>> has one caller and the only thing done by that caller is to invoke
>> gov_cancel_work().
>>
>> Accordingly, drop gov_cancel_work() and move its contents to the
>> caller.
>>
>> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> ---
>>  drivers/cpufreq/cpufreq_governor.c |   19 +++++++------------
>>  1 file changed, 7 insertions(+), 12 deletions(-)
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Thanks!

> I am wondering what happened to your other patches around the governor callbacks
> and why weren't they applied yet :)

They are in linux-next now, aren't they?
