From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH] Revert "cpufreq: pcc-cpufreq: update default value of cpuinfo_transition_latency"
Date: Sat, 23 Jul 2016 01:47:26 +0200
Message-ID: <CAJZ5v0g3_QrVD3rwjdcWKcDb5SpA11n9C_2Jpk6qMsXg3pxfOg@mail.gmail.com>
References: <20160722151411.GB11711@suselix.suse.de> <3431802.ZZWypmTthK@vostro.rjw.lan>
 <20160722212852.GE3122@ubuntu> <3860863.MLaNBM27lJ@vostro.rjw.lan> <20160722233042.GI3122@ubuntu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f42.google.com ([74.125.82.42]:35931 "EHLO
	mail-wm0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288AbcGVXr3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 22 Jul 2016 19:47:29 -0400
In-Reply-To: <20160722233042.GI3122@ubuntu>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andreas Herrmann <aherrmann@suse.com>, Jacob Tanenbaum <jtanenba@redhat.com>, Stable <stable@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

On Sat, Jul 23, 2016 at 1:30 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> On 22-07-16, 23:46, Rafael J. Wysocki wrote:
>> On Friday, July 22, 2016 02:28:52 PM Viresh Kumar wrote:
>> > On 22-07-16, 23:31, Rafael J. Wysocki wrote:
>> > > > cpufreq.c
>> > > >
>> > > >         if (policy->governor->max_transition_latency &&
>> > > >             policy->cpuinfo.transition_latency >
>> > > >             policy->governor->max_transition_latency) {
>> > > >
>> > > > - And this check will always fail, unless max_transition_latency is zero.
>> > >
>> > > Why would it fail?  If governor->max_transition_latency is non-zero, but less
>> > > than UNIT_MAX, the condition checked will be true to my eyes.
>> >
>> > Bad wording. Sorry.
>> >
>> > I meant, this 'if' check will always succeed (as you also noted), and
>> > so we will always get the error message reported in this patch.
>>
>> Not always, but for drivers setting cpuinfo.transition_latency to CPUFREQ_ETERNAL.
>
> So the drivers which have set their transition_latency to
> CPUFREQ_ETERNAL, can't use ondemand governor unless
> governor->max_transition_latency is set to 0 from userspace.
>
> What should be done about this patch then ? It broke in late 2015.

I'll apply the revert with a "Cc: stable" tag.

Question is what to do about the other drivers setting
cpuinfo.transition_latency to CPUFREQ_ETERNAL.

Thanks,
Rafael
