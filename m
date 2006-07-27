From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [patch, rft] amd74xx: implement suspend-to-ram
Date: Thu, 27 Jul 2006 22:49:39 +0200
Message-ID: <20060727204939.GA3797@elf.ucw.cz>
References: <20060715210518.GA3263@opus.vpn-dev.reflex> <200607251727.12678.david-b@pacbell.net> <20060726090204.GC1905@elf.ucw.cz> <200607261729.35098.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200607261729.35098.david-b@pacbell.net>
Sender: linux-ide-owner@vger.kernel.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.osdl.org, Jason Lunz <lunz@falooley.org>, linux-ide@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Wed 2006-07-26 17:29:33, David Brownell wrote:
> On Wednesday 26 July 2006 2:02 am, Pavel Machek wrote:
> > Hi!
> > 
> > > > and please don't do this. Suspend-to-disk will call 
> > > > amd74xx_resume when it needs to talk to the disk.
> > > 
> > > I don't understand the rest of this comment.  That code looks
> > > correct (other than calling the goofy/broken pci_choose_state thing);
> > > PM_EVENT_FREEZE and PM_EVENT_PRETHAW should not disable the device.
> > 
> > Well, I'd prefer PM_EVENT_FREEZE and PM_EVENT_SUSPEND to be the same
> > code (i.e. remove the if() and just do 
> > 
> > > > > +		pci_disable_device(dev);
> > > > > +		pci_set_power_state(dev, pci_choose_state(dev, state));
> > 
> > unconditionaly). It should also work, and not really be slower.
> 
> Oh, I see.  But wouldn't that cause FREEZE to spin down the drives?

I do not think so. If it will, I'm obviously wrong and original
version is okay.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
