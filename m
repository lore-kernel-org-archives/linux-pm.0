From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: cpufreq-next opps with cpufreq-bench
Date: Thu, 17 Oct 2013 16:06:36 +0200
Message-ID: <2877026.HBynBTHMf8@vostro.rjw.lan>
References: <20131013090159.GB24566@lunn.ch> <2640083.dKj7t8UqiF@vostro.rjw.lan> <CAKohpomiFqgSz3=C0_XyG8wqA8puPqxbkNo+rvYbUypcfrsukQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:50124 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1755500Ab3JQNyp (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 17 Oct 2013 09:54:45 -0400
In-Reply-To: <CAKohpomiFqgSz3=C0_XyG8wqA8puPqxbkNo+rvYbUypcfrsukQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, linux-pm@vger.kernel.org

On Thursday, October 17, 2013 10:34:03 AM Viresh Kumar wrote:
> On 16/10/2013, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > On Wednesday, October 16, 2013 09:49:02 AM Viresh Kumar wrote:
> 
> >> @Andrew: Can you give this a try please? (Use attached commit)..
> >
> > No.
> >
> > Please resumbit the original commit *with* the fix folded into it.
> >
> > Since I have dropped the broken one from linux-next, this "fixup" doesn't
> > apply to it any more.
> 
> I thought of adding following lines to my last email and then dropped it
> for some reason:
> 
> "After you have tested it, I will resend a single patch for both these for
> Rafael to include as he has already dropped this offending commit"
> 
> :)

That really isn't helpful, because even if the fixup is tested, you can still
make a mistake when folding it into the original patch (while I believe that
that is unlikely, things like that have happened in the kernel history).  So,
it is always better to test the final patch altogether.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
