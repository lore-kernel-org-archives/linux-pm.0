From: Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v3 4/4] mvebu: Dove: Add clocks and DFS interrupt to cpu
 node in DT.
Date: Fri, 1 Nov 2013 14:14:52 +0100
Message-ID: <20131101131452.GJ26890@lunn.ch>
References: <1383247111-26834-1-git-send-email-andrew@lunn.ch>
 <CAKohpokTWfBnhWj+bdA9zx-+hyXUdp4ir5BYkZNLe08mcwVwLg@mail.gmail.com>
 <20131101090737.GB26890@lunn.ch>
 <1436787.LWqDTIBNS8@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from vps0.lunn.ch ([178.209.37.122]:47070 "EHLO vps0.lunn.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753193Ab3KANTr (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 1 Nov 2013 09:19:47 -0400
Content-Disposition: inline
In-Reply-To: <1436787.LWqDTIBNS8@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Andrew Lunn <andrew@lunn.ch>, Viresh Kumar <viresh.kumar@linaro.org>, Sebastian Hesselbarth <sebastian.hesselbarth@googlemail.com>, Jason Cooper <jason@lakedaemon.net>, linux ARM <linux-arm-kernel@lists.infradead.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Fri, Nov 01, 2013 at 02:16:37PM +0100, Rafael J. Wysocki wrote:
> On Friday, November 01, 2013 10:07:37 AM Andrew Lunn wrote:
> > On Fri, Nov 01, 2013 at 05:21:03AM +0530, Viresh Kumar wrote:
> > > On 1 November 2013 03:56, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> > > > On Thursday, October 31, 2013 08:18:31 PM Andrew Lunn wrote:
> > > >> The dove-cpufreq driver needs access to the DDR and CPU clock.  There
> > > >> is also an interrupt generated when the DFS hardware completes a
> > > >> change of frequencey. Add these to the cpu node in DT.
> > > >>
> > > >> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> > > >> Tested-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> > > >
> > > > I need someone with DT bindings knowledge to ACK this for me.
> > > 
> > > I can do that
> > 
> > Thanks.
> > 
> > , but this set has to be rebased over all the latest developments
> > > in cpufreq core before getting posted again..
> > 
> > I will wait for -rc1 and rebase.
> 
> Actually, it is possible that 3.12-rc8 will be released this weekend.  If that
> happens, please rebase your patchset on top of the current linux-next and
> resubmit it next week.

Hi Rafael

Just be to sure, since we have had problems with terminology before.
Do you mean the The linux-next, or your linux next branch?

Thanks
	Andrew
