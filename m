From: Nicolas Pitre <nicolas.pitre@linaro.org>
Subject: Re: [RFC PATCHC 1/3] cpuidle: encapsulate power info in a separate
 structure
Date: Fri, 28 Mar 2014 20:00:13 -0400 (EDT)
Message-ID: <alpine.LFD.2.11.1403281950450.1571@knanqh.ubzr>
References: <1396009796-31598-1-git-send-email-daniel.lezcano@linaro.org> <1396009796-31598-2-git-send-email-daniel.lezcano@linaro.org> <alpine.LFD.2.11.1403281356220.1571@knanqh.ubzr> <CAKnoXLz13V-xd7Vi9ahF02tT86jshGmzPAL5C0_mvcnpZB=ExQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-qg0-f43.google.com ([209.85.192.43]:42466 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751274AbaC2AAS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 28 Mar 2014 20:00:18 -0400
Received: by mail-qg0-f43.google.com with SMTP id f51so5093299qge.16
        for <linux-pm@vger.kernel.org>; Fri, 28 Mar 2014 17:00:18 -0700 (PDT)
In-Reply-To: <CAKnoXLz13V-xd7Vi9ahF02tT86jshGmzPAL5C0_mvcnpZB=ExQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: LKML <linux-kernel@vger.kernel.org>, mingo@elte.hu, Peter Zijlstra <peterz@infradead.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alex Shi <alex.shi@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Morten Rasmussen <morten.rasmussen@arm.com>

On Fri, 28 Mar 2014, Daniel Lezcano wrote:

> Hi Nicolas,
> 
> thanks for reviewing the patchset.
> 
> On 03/28/2014 07:17 PM, Nicolas Pitre wrote:
> > On Fri, 28 Mar 2014, Daniel Lezcano wrote:
> >
> >> The scheduler needs some information from cpuidle to know the timing for a
> >> specific idle state a cpu is.
> >>
> >> This patch creates a separate structure to group the cpuidle power info in
> >> order to share it with the scheduler. It improves the encapsulation of the
> >> code.
> >
> > Having cpuidle_power as a structure name, or worse, 'power' as a struct
> > member, is a really bad choice.
> 
> Yes, I was asking myself if this name was a good choice or not. I
> assumed 'power' could have been a good name because 'target_residency'
> is a time conversion of the power needed to enter this state.

Still, that's something the casual reviewer might not know.

And we ought to be careful when talking about power as well.  By 
definition, power means energy transferred per unit of time.  Sometimes 
we tend to say 'power' when we actually mean 'energy'.  With more "power 
aware" work going into the scheduler, it is better to disambiguate those 
terms.

> > Amongst the fields this struct
> > contains, only 1 out of 3 is about power.  The word "power" is already
> > abused quite significantly to mean too many different things already.
> >
> > I'd suggest something inspired by your own patch log message i.e.
> > 'struct cpuidle_info' instead, and use 'info' as a field name within
> > struct cpuidle_state.  Having 'params" instead of "info" could be a good
> > alternative too, although slightly longer.
> 
> Hmm 'info' or 'param' sound too vague. What about:
> 
> cpuidle_attr
> or
> cpuidle_property

As you wish.  As long as it isn't 'power'.


Nicolas
