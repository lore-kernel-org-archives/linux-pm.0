From: "Woodruff, Richard" <r-woodruff2@ti.com>
Subject: Re: [RFD] Automatic suspend
Date: Mon, 16 Feb 2009 15:32:06 -0600
Message-ID: <13B9B4C6EF24D648824FF11BE896716203771DCF1E__16674.6330367916$1234820142$gmane$org@dlee02.ent.ti.com>
References: <f73f7ab80902161208h12837d4ex1d28d55d031d5d71@mail.gmail.com>
	<Pine.LNX.4.44L0.0902161537080.19732-100000@netrider.rowland.org>
	<20090216124520.315320dc@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090216124520.315320dc@infradead.org>
Content-Language: en-US
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>, Alan Stern <stern@rowland.harvard.edu>
Cc: Kyle Moffett <kyle@moffetthome.net>, Nigel Cunningham <nigel@nigel.suspend2.net>, LKML <linux-kernel@vger.kernel.org>, Uli Luckas <u.luckas@road.de>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> From: Arjan van de Ven [mailto:arjan@infradead.org]
> Sent: Monday, February 16, 2009 2:45 PM

> On Mon, 16 Feb 2009 15:39:15 -0500 (EST)
> Alan Stern <stern@rowland.harvard.edu> wrote:
>
> > On Mon, 16 Feb 2009, Kyle Moffett wrote:
> >
> > > Userspace may not have a useful decision-making capability regarding
> > > functionality versus power-saving, but the user it's talking to
> > > might!
> > >
> > > I think it would be very useful to have a mechanism for userspace to
> > > find out "Link detection on this NIC costs ~50mW" and "No link has
> > > been detected for the last 15 minutes", so that it can compile all
> > > that sort of information and prompt the user what devices they would
> > > like to disable.  Perhaps an "airline mode" sort of thing?
> >
> > Even if drivers don't know how much power their devices consume (and
> > generally I wouldn't expect them to), it still makes sense to offer
> > userspace the discretionary power to force devices into a low-power
> > mode.  USB does this.
>
> "stop using it" isn't this discretionary power ?
> (for NICs this is "ifconfig .. down")

Allowing a trusted user space process some hook in kernel PM has turned out useful for us.

- It gives a way for frame works which load codecs into DSPs a way to specify needs before loading. The DSP has its own internal dynamic predictor but it is not always good enough. Feeding this info in from user space is easy as it knows everything about the DSP algorithm it is loading. There isn't a reason to re-export all of that back into the kernel and might hurt DSP performance if it ran on it natively.

- It provides a way to handle overdrive/turbo operating points out of band from the generically tuned cpufreq governors like ondemand.  The way we characterize overdrive is stricter then what Intel has talked about for x86.

In TI-reference code we effectively export sysfs knobs which influence system p-state and c-state choices (we borrowed Intel terms here as they are useful). This was done before pmqos was available. We would have considered extending pmqos but a couple things stopped this. One being it wasn't in kernel at the time and two being any change picks up a year of disagreements. As such we put some front end wrappers on the calls which use it to some degree.

There is a community-reference targeting kernel merging but I think it is only now reaching the point of the user space interface. People working there have expressed interest in a direct pmqos interface and removing our wrapping calls.

What we have done more follows what happens when you have a complex driver/subsystem which has pieces in both users and kernel space.  It works ok for this.

This is ok for making sure the complex driver works well. It doesn't address all the other user space things going on which also need some kind of management so they don't sink system power. This is where wakelocks start to do something more generically useful.

Right now it seems no one is willing to own the whole system. It is easier to just say user space sucks and someone else should fix it...or my driver is fine it is someone else's problem. However, by not giving some kind of useful constraints interface to help control bad (or uncontrollable) elements the end result are non-competitive Linux systems or ugly out of tree vendor hacks. This is where wakelocks actually stand out.  They actually try and do something useful generically.

It seems the perfect is often the enemy of the good when it comes to Linux PM discussions.

Regards,
Richard W.
