From: Jason Cooper <jason@lakedaemon.net>
Subject: Re: [PATCH v3 4/4] mvebu: Dove: Add clocks and DFS interrupt to
 cpu node in DT.
Date: Sat, 23 Nov 2013 21:51:00 -0500
Message-ID: <20131124025100.GO29241@titan.lakedaemon.net>
References: <1383247111-26834-1-git-send-email-andrew@lunn.ch>
 <1383247111-26834-4-git-send-email-andrew@lunn.ch>
 <1429743.Nz1AUEe5Hi@vostro.rjw.lan>
 <CAKohpokTWfBnhWj+bdA9zx-+hyXUdp4ir5BYkZNLe08mcwVwLg@mail.gmail.com>
 <20131101090737.GB26890@lunn.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mho-03-ewr.mailhop.org ([204.13.248.66]:37064 "EHLO
	mho-01-ewr.mailhop.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756226Ab3KXCvN (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 23 Nov 2013 21:51:13 -0500
Content-Disposition: inline
In-Reply-To: <20131101090737.GB26890@lunn.ch>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Andrew Lunn <andrew@lunn.ch>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, linux ARM <linux-arm-kernel@lists.infradead.org>

On Fri, Nov 01, 2013 at 10:07:37AM +0100, Andrew Lunn wrote:
> On Fri, Nov 01, 2013 at 05:21:03AM +0530, Viresh Kumar wrote:
> > On 1 November 2013 03:56, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > On Thursday, October 31, 2013 08:18:31 PM Andrew Lunn wrote:
> > >> The dove-cpufreq driver needs access to the DDR and CPU clock.  There
> > >> is also an interrupt generated when the DFS hardware completes a
> > >> change of frequencey. Add these to the cpu node in DT.
> > >>
> > >> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > >> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > >
> > > I need someone with DT bindings knowledge to ACK this for me.
> > 
> > I can do that
> 
> Thanks.
> 
> > , but this set has to be rebased over all the latest developments
> > in cpufreq core before getting posted again..
> 
> I will wait for -rc1 and rebase. 

ping.

thx,

Jason.
