From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Tue, 07 Jul 2015 14:22:07 +0200
Message-ID: <1632426.Ho6HuulePs@vostro.rjw.lan>
References: <Pine.LNX.4.44L0.1507041011510.19175-100000@netrider.rowland.org> <4932758.cYVny4lmZN@vostro.rjw.lan> <20150707102507.GA13811@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20150707102507.GA13811@amd>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Alan Stern <stern@rowland.harvard.edu>, Dave Chinner <david@fromorbit.com>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 07, 2015 12:25:07 PM Pavel Machek wrote:
> On Mon 2015-07-06 15:59:15, Rafael J. Wysocki wrote:
> > On Monday, July 06, 2015 01:06:45 PM Pavel Machek wrote:
> > > On Mon 2015-07-06 01:28:20, Rafael J. Wysocki wrote:
> > > > On Saturday, July 04, 2015 10:19:55 AM Alan Stern wrote:
> > > > > On Sat, 4 Jul 2015, Rafael J. Wysocki wrote:
> > > > > 
> > > > > > The only argument against dropping sys_sync() from the suspend code path
> > > > > > I've seen in this thread that I entirely agree with is that it may lead to
> > > > > > regressions, because we've done it practically forever and it may hide latent
> > > > > > bugs somewhere in block drivers etc.  Dropping it, though, is the only way
> > > > > > to see those bugs, if any, and if we want to ever fix them, we need to see
> > > > > > them.  That's why I think that it may be a good idea to allow people to
> > > > > > drop it if they are willing to accept some extra risk (via the kernel
> > > > > > command line, for example).
> > > > > 
> > > > > I'd be perfectly happy to have the sync selectable at runtime, one way 
> > > > > or another.  The three most reasonable options seem to be:
> > > > > 
> > > > > 	kernel command line
> > > > > 
> > > > > 	sysfs file
> > > > > 
> > > > > 	sysctl setting
> > > > > 
> > > > > The command line is less flexible (it can't be changed after booting).  
> > > > > Either of the other two would be fine with me.
> > > > 
> > > > We'll probably use a sysfs file (possibly plus a Kconfig option to set the
> > > > boot time default).
> > > 
> > > Android people can already do sync-less s2ram using existing
> > > interface. IMO they should just do it.
> > > 
> > > In any case, sysfs file + Kconfig is an overkill. We already have too
> > > many Kconfig options.
> > 
> > I don't think we can reach a general agreement on what's the *right* approach
> > with respect to the sys_sync() in the suspend code path, so the only way out
> > of this situation I can see is to make it configurable.
> 
> So first: not having general agreement does not mean we should
> introduce Kconfig + sysfs file. Second: your proposal of "lets sync if
> runtime was shorter than xxx" is over complex, but at least should not
> need Kconfig support...

The Kconfig part is only about setting the default at compile time, so I'm
not sure why you have any problems with it.


> Third: we have ioctl() based interface, and I guess android should use that
> one; it already has "s2ram without sync" method.

And that is tied to hibernation and therefore useless to people who don't
build that in.


> > > There's not a single Android phone supported by mainline
> > > kernel. I'm sure they have bigger problems than Android setting
> > > default sysfs values...
> > 
> > But perhaps we'd like to change that?
> 
> We'd like to, but lets start with the real hard stuff (merging support
> for Qualcomm chipsets) that is 1000000 LoC+, not with trivial tweaks
> that would be 1-line change, but we pollute code with Kconfig+sysfs
> making it 100..

It is suboptimal, but this is the only way I can see allowing us to make
any forward progress here.

Evidently, some people are not happy with the status quo and they also should
be able to cover their use cases with the mainline kernel, shouldn't they?

Rafael
