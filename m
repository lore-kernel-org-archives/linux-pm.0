From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2] cpufreq: Avoid attempts to create duplicate symbolic links
Date: Mon, 27 Jul 2015 15:45:10 +0200
Message-ID: <4080510.IQ60sVQvbL@vostro.rjw.lan>
References: <1660815.CyKx9SEI9c@vostro.rjw.lan> <CAJZ5v0i6t36Nr7nFOKjGY5fBjzR=h+rNHcHWYd=eEdapMWQEGQ@mail.gmail.com> <20150727022718.GE19944@linux>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63180 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1752533AbbG0NSQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 27 Jul 2015 09:18:16 -0400
In-Reply-To: <20150727022718.GE19944@linux>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Russell King <linux@arm.linux.org.uk>

On Monday, July 27, 2015 07:57:18 AM Viresh Kumar wrote:
> On 26-07-15, 00:46, Rafael J. Wysocki wrote:
> > OK, I'll prepare a new version of that patch then, but as I said this
> > choice means that we'll be creating the links to the policy at the
> > policy creation time going forward.
> 
> Atleast for the rc fix, we should do exactly this. Right.
> 
> But we can rethink about getting both my earlier patches merged for
> 4.3, which did this:
> 
> - Keep adding CPUs to a global mask, which didn't had a existing
>   policy and were offline when subsys-callback for called for them.
> - And then create the links only when the subsys callback is called
>   for CPUs, for which policy already exist, as Russell suggested.

Say the subsys add callback runs for a CPU and it doesn't have a policy.
If it is offline, we ignore it and the add callback won't be executed
for it again.

In turn, if it is online, we create a policy for it and we should (right
away) link the policy to all of the CPUs that were offline when the subsys add
callback was called for them.  That's what we do today.

Is there anything missing in that?

Thanks,
Rafael

