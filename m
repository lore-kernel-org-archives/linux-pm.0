From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: PROBLEM: Kernel OOPS and possible system freeze after concurrent writing to cpufreq/scaling_governor (Resend)
Date: Mon, 08 Sep 2014 23:14:32 +0200
Message-ID: <3737419.nVAGuIilZz@vostro.rjw.lan>
References: <1405522398.2348.42.camel@x200t> <1410164208.6159.18.camel@x200t> <CAKohpo=DeQQq505U_EDsJ+5dPGPuSOypx_YbTYW5owj4FDYLpA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:54156 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1753416AbaIHUzF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 8 Sep 2014 16:55:05 -0400
In-Reply-To: <CAKohpo=DeQQq505U_EDsJ+5dPGPuSOypx_YbTYW5owj4FDYLpA@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Robert =?ISO-8859-1?Q?Sch=F6ne?= <robert.schoene@tu-dresden.de>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Srivatsa S. Bhat" <srivatsa@mit.edu>, Prarit Bhargava <prarit@redhat.com>, Saravana Kannan <skannan@codeaurora.org>, Stephen Boyd <sboyd@codeaurora.org>

On Monday, September 08, 2014 04:26:42 PM Viresh Kumar wrote:
> 
> --001a11c2eb5293ba1305028bac8b
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: quoted-printable
> 
> On 8 September 2014 13:46, Robert Sch=C3=B6ne <robert.schoene@tu-dresden.de=
> > wrote:
> > (Sorry for the resend, I forgot to disable my S/MIME signature)
> >
> > The patch you suggested did not work, so I introduced a new mutex in the
> > patch below.
> 
> Okay, let me apologize first. This thread has taken much longer than I
> expected, to some level due to me. I have changed my job recently
> and have been running busy with new assignments, etc..
> 
> > I am not happy with adding just another mutex, but it fixes my problem
> > of changing governors concurrently.
> 
> So, yeah back to the problem.
> 
> Can you please try attached patch with the revert earlier suggested?
> To make it clear again, cherry-pick: 19c7630 and then apply  this
> patch.
> 
> Let me know if it still doesn't work for you..
> 
> I don't have a local setup to test this and so its just compile tested.
> 
> Cc'd few more people who also reported similar issues.

Some mailer (mine or yours) mangled the attachment.  I can see it in patchwork,
though.

It looks reasonable to me.

Am I supposed to pick it up?  If so, do we need it in -stable?  If so, which
-stable (or what commit does it fix)?

Rafael

