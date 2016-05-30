From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] cpufreq: stats: Make the stats code non-modular
Date: Mon, 30 May 2016 15:43:12 +0200
Message-ID: <CAJZ5v0jq10Sza7H3659U9c4aja8qc3pwbEk4=NxhPfAO3fYCqA@mail.gmail.com>
References: <1482863.aVJEuqdboc@vostro.rjw.lan>
	<20160526045945.GO17585@vireshk-i7>
	<5665576.VhylybbIm6@vostro.rjw.lan>
	<20160530045348.GA26787@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:35810 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754249AbcE3NnO (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 30 May 2016 09:43:14 -0400
In-Reply-To: <20160530045348.GA26787@vireshk-i7>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

On Mon, May 30, 2016 at 6:53 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 28-05-16, 15:15, Rafael J. Wysocki wrote:
>> It does, but there's a problem.
>>
>> If fast frequency switching is in use, the stats attributes just sit there
>> full of zeros (because the stats are not updated then) which is confusing.
>>
>> Of course, the ultimate solution here would be to make the stats actually
>> work with fast frequency switching, but that requires some major surgery of
>> the stats code, so for now I'd like to simply make those attributes return
>> nothing if fast frequency switching is enabled for the policy (returning
>> -EBUSY from there, which would have been cleaner, unfortunately breaks
>> powertop).
>
> What's stopping us from doing that? Sorry I don't remember that well :(
>
> I mean, why can't we call cpufreq_stats_record_transition() somehow via that
> code ?

Because it does things that aren't allowed to be done from the
scheduler paths (using the non-raw spinlock in the first place).

It also isn't efficient enough.  For example, the fast switch path in
schedutil for non-shared policies is lockless and it would be a shame
to add a lock to it just for the stats.
