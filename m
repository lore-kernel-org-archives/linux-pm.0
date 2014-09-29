From: Prarit Bhargava <prarit@redhat.com>
Subject: Re: [PATCH 1/2] cpufreq: serialize calls to __cpufreq_governor()
Date: Mon, 29 Sep 2014 07:50:23 -0400
Message-ID: <5429477F.3050008@redhat.com>
References: <efa1d8ae3e7b227b73a951d6072fa211d3cfe593.1410235439.git.viresh.kumar@linaro.org> <54294299.1060208@redhat.com> <CAKohpo=WumLcZAH1ezwBV1yCYO_q9mzSMb+2ZnQOf_r+50ToGQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:47171 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753228AbaI2Luj (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 29 Sep 2014 07:50:39 -0400
In-Reply-To: <CAKohpo=WumLcZAH1ezwBV1yCYO_q9mzSMb+2ZnQOf_r+50ToGQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, =?UTF-8?B?Um9iZXJ0?= =?UTF-8?B?IFNjaMO2bmU=?= <robert.schoene@tu-dresden.de>, Saravana Kannan <skannan@codeaurora.org>



On 09/29/2014 07:38 AM, Viresh Kumar wrote:
> On 29 September 2014 16:59, Prarit Bhargava <prarit@redhat.com> wrote:
> 
>> This is exactly the same issue I mentioned a few weeks ago and traced back to
>> 955ef4833574636819cd269cfbae12f79cbde63a which drops the lock around the
>> CPUFREQ_GOV_POLICY_EXIT __cpufreq_governor() call.
>>
>> Just my two cents -- I don't think that adding a new lock/locking scheme is the
>> way to fix this.
> 
> Me and Robert are just inches away from fixing it. Just that the
> remote testing by
> Robert and patches from me aren't working well together.. I need to do
> this myself
> and have a board to reproduce it now.. But would take some time to get going...
> 
> And yes, I am also against another lock here :)

Send me what you have in mind -- I can always take a look and put it through
tests as well.

P.

> 
