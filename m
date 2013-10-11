From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2 Resend 00/92] CPUFreq Cleanup Series: Part II
Date: Sat, 12 Oct 2013 00:17:30 +0200
Message-ID: <4804152.VMEEXS0eqL@vostro.rjw.lan>
References: <cover.1380783079.git.viresh.kumar@linaro.org> <4259753.v7BpD2vKia@vostro.rjw.lan> <CAKohponVmnQr-QuPAW-aHyVJYpWX9ODdF5x-RbTdtjrVjn807A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:53332 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754792Ab3JKWFp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 11 Oct 2013 18:05:45 -0400
In-Reply-To: <CAKohponVmnQr-QuPAW-aHyVJYpWX9ODdF5x-RbTdtjrVjn807A@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org

On Friday, October 11, 2013 07:27:44 PM Viresh Kumar wrote:
> On 11/10/2013, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > So I've just added this to bleeding-edge, but I have a couple complaints.
> 
> Thanks..
> 
> > First off, this is three patch sets in one.  The first part is the generic
> > .attr(), exit() and .verify() one, the second part is the duplicated
> > initialization and the third one is about cpufreq_generic_init().  They
> > really should have been posted and reviewed separately.
> 
> They were posted and reviewed separately earlier.. Only this time
> I have merged them together for applying..
> 
> > And while I'm basically OK with the first and the third part, I'm concerned
> > about the second one, because it has potential to introduce some subtle
> > initialization issues (initializing something twice is not a bug per se,
> > although it is inefficient, but failing to initialize that or initializing
> > it
> > with an incorrect value *is* a bug).
> 
> I agree.. Lets see if it breaks anything... I will get it fixed as soon as
> possible.. (BTW, there was a fixup for the last series that you missed
> to apply: fixup! cpufreq: sa11x0: Expose frequency table)

Any links?

