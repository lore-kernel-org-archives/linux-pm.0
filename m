From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH v10 1/3] cpufreq: Add mechanism for registering
 utilization update callbacks
Date: Tue, 8 Mar 2016 23:43:26 +0100
Message-ID: <CAJZ5v0hkrDq4Fy-zqy3u4EbC1SeCZ4c6aymXYwqvcRgXHuGTYA@mail.gmail.com>
References: <3071836.JbNxX8hU6x@vostro.rjw.lan>
	<CAJZ5v0gs3bddvskseh58q+0d+KqXYt=4SYGuiR3vdhdOyhoKmA@mail.gmail.com>
	<20160223110118.GJ27380@e106622-lin>
	<5947930.P2W8Baqyau@vostro.rjw.lan>
	<20160308192400.4103.71868@quark.deferred.io>
	<CAJZ5v0io2D6CBCfmnaBq5rPRpJWPQbkszs_y30NAXnX0c0hZQg@mail.gmail.com>
	<20160308220632.4103.13377@quark.deferred.io>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-lb0-f194.google.com ([209.85.217.194]:36697 "EHLO
	mail-lb0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750937AbcCHWn2 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 8 Mar 2016 17:43:28 -0500
In-Reply-To: <20160308220632.4103.13377@quark.deferred.io>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Michael Turquette <mturquette@baylibre.com>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Juri Lelli <juri.lelli@arm.com>, Linux PM list <linux-pm@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, Viresh Kumar <viresh.kumar@linaro.org>, Steve Muckle <steve.muckle@linaro.org>, Thomas Gleixner <tglx@linutronix.de>

On Tue, Mar 8, 2016 at 11:06 PM, Michael Turquette
<mturquette@baylibre.com> wrote:
> Quoting Rafael J. Wysocki (2016-03-08 12:40:18)
>> On Tue, Mar 8, 2016 at 8:24 PM, Michael Turquette
>> <mturquette@baylibre.com> wrote:
>> > Quoting Rafael J. Wysocki (2016-02-23 18:01:06)
>> >> On Tuesday, February 23, 2016 11:01:18 AM Juri Lelli wrote:
>> >> > On 22/02/16 22:26, Rafael J. Wysocki wrote:
>> >> > > On Mon, Feb 22, 2016 at 10:32 AM, Juri Lelli <juri.lelli@arm.com> wrote:
>> >> > > > On 19/02/16 23:14, Rafael J. Wysocki wrote:
>> >> > > >> On Friday, February 19, 2016 08:09:17 AM Juri Lelli wrote:
>> >> > > >> > Hi Rafael,
>> >> > > >> >
>> >> > > >> > On 18/02/16 21:22, Rafael J. Wysocki wrote:
>> >> > > >> > > On Mon, Feb 15, 2016 at 10:47 PM, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
>> >> > > >> > > > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>> >> > > >> > > >
>> >> > >
>> >> > > [cut]
>> >> > >
>> >> > > >> That said, if the concern is that there are plans to change the way the
>> >> > > >> scheduler computes the utilization numbers and that may become difficult to
>> >> > > >> carry out if cpufreq starts to depend on them in their current form, then I
>> >> > > >> may agree that it is valid, but I'm not aware of those plans ATM.
>> >> > > >>
>> >> > > >
>> >> > > > No, I don't think there's any substantial discussion going on about the
>> >> > > > utilization numbers.
>> >> > >
>> >> > > OK, so the statement below applies.
>> >> > >
>> >> > > >> However, if the numbers are going to stay what they are, I don't see why
>> >> > > >> passing them to cpufreq may possibly become problematic at any point.
>> >> > > >
>> >> > > > My concern was mostly on the fact that there is already another RFC
>> >> > > > under discussion that uses the same numbers and has different hooks
>> >> > > > placed in scheduler code (Steve's sched-freq); so, additional hooks
>> >> > > > might generate confusion, IMHO.
>> >> > >
>> >> > > So this is about the hooks rather than about their arguments after
>> >> > > all, isn't it?
>> >> > >
>> >> > > I fail to see why it is better to drop the arguments and leave the hooks, then.
>> >> > >
>> >> >
>> >> > It's about where we place such hooks and what arguments they have.
>> >> > Without the schedutil governor as a consumer the current position makes
>> >> > sense, but some of the arguments are not used. With schedutil both
>> >> > position and arguments make sense, but a different implementation
>> >> > (sched-freq) might have different needs w.r.t. position and arguments.
>> >>
>> >> And that's fine.  If the current position and/or arguments are not suitable,
>> >> they'll need to be changed.  It's not like things introduced today are set
>> >> in stone forever.
>> >>
>> >> Peter has already shown how they may be changed to make everyone happy,
>> >> so I don't really see what the fuss is about.
>> >
>> > I see this patch in linux-next now. Did it ever get Peter's or Ingo's
>> > Ack?
>>
>> No, but none of them said "no" either.
>>
>> And the interface was suggested by Peter in the first place.
>>
>> > Also it seems weird to me that this patch touching sched code is going
>> > through the pm tree.
>>
>> That's for purely practical reasons.  There are lots of PM changes
>> depending on it that have nothing to do with the scheduler.  I've been
>> talking about that for several times now, last time in my yesterday
>> post (http://marc.info/?l=linux-pm&m=145740561402948&w=2).  I've been
>> talking openly about what I'm going to do with this all the time.
>>
>> No one is hiding things from anyone or trying to slip them through
>> past somebody here if that's what you're worried about.
>>
>> > When it comes times to experiment more with the interfaces and make the
>> > "future changes" that everyone keeps talking about, who is the
>> > maintainer? Who has the last word?
>>
>> As usual, it is about consensus.
>
> To be fair, that consensus should be recorded formally by Reviewed-by
> and Acked-by tags.

I would feel much more comfortable with ACKs on the commits touching
the scheduler code, no question about that. :-)

That said, if another maintainer makes PM-related or ACPI-related
changes and follows my suggestions all the way through, I may not feel
like I have to ACK all of that every time.  After all, it all boils
down to what happens to the pull request eventually and Acked-by tags
may or may not help there.

>>
>> This is on a boundary of two subsystems and I have good reasons to do
>> it.  One of the maintainers of the other subsystem involved is working
>> with me all the time and I'm following his suggestions.  Isn't that
>> really sufficient?
>>
>> But really please see
>> http://marc.info/?l=linux-pm&m=145740561402948&w=2 as it means I'm
>> actually going to do what Juri and Steve asked for unless I'm told
>> that this is a bad idea.
>
> I'll take a look. Note that Steve, Juri and Vincent are all at a
> conference this week so their responses may be slow.

That's fine.

I'm not going to send new versions of the patches any time soon
(unless somebody points out a problem to fix in them to me).

Thanks,
Rafael
