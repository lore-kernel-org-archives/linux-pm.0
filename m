From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-pm] [patch, rft] amd74xx: implement suspend-to-ram
Date: Wed, 26 Jul 2006 17:29:33 -0700
Message-ID: <200607261729.35098.david-b@pacbell.net>
References: <20060715210518.GA3263@opus.vpn-dev.reflex> <200607251727.12678.david-b@pacbell.net> <20060726090204.GC1905@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20060726090204.GC1905@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
To: Pavel Machek <pavel@suse.cz>
Cc: linux-pm@lists.osdl.org, Jason Lunz <lunz@falooley.org>, linux-ide@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Wednesday 26 July 2006 2:02 am, Pavel Machek wrote:
> Hi!
> 
> > > and please don't do this. Suspend-to-disk will call 
> > > amd74xx_resume when it needs to talk to the disk.
> > 
> > I don't understand the rest of this comment.  That code looks
> > correct (other than calling the goofy/broken pci_choose_state thing);
> > PM_EVENT_FREEZE and PM_EVENT_PRETHAW should not disable the device.
> 
> Well, I'd prefer PM_EVENT_FREEZE and PM_EVENT_SUSPEND to be the same
> code (i.e. remove the if() and just do 
> 
> > > > +		pci_disable_device(dev);
> > > > +		pci_set_power_state(dev, pci_choose_state(dev, state));
> 
> unconditionaly). It should also work, and not really be slower.

Oh, I see.  But wouldn't that cause FREEZE to spin down the drives?

