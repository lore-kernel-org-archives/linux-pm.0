From: Pavel Machek <pavel@suse.cz>
Subject: Re: [linux-pm] [patch, rft] amd74xx: implement suspend-to-ram
Date: Fri, 28 Jul 2006 00:51:53 +0200
Message-ID: <20060727225153.GG3797@elf.ucw.cz>
References: <20060715210518.GA3263@opus.vpn-dev.reflex> <200607251727.12678.david-b@pacbell.net> <20060726090204.GC1905@elf.ucw.cz> <200607261729.35098.david-b@pacbell.net> <20060727204939.GA3797@elf.ucw.cz> <20060727224311.GA4104@knob.reflex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-ide-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060727224311.GA4104@knob.reflex>
Sender: linux-ide-owner@vger.kernel.org
To: Jason Lunz <lunz@falooley.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, linux-ide@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Thu 2006-07-27 18:43:12, Jason Lunz wrote:
> On Thu, Jul 27, 2006 at 10:49:39PM +0200, Pavel Machek wrote:
> > > Oh, I see.  But wouldn't that cause FREEZE to spin down the drives?
> > 
> > I do not think so. If it will, I'm obviously wrong and original
> > version is okay.
> 
> I think it's the ide bus shutdown methods that do power management on
> the drives. But here we're talking about the pci ide controller.
> 
> At any rate, not having the if() means my machine freezes during the
> suspend phase of STD.

I'd still like to understand why it freezes (it should not), but I
guess you have my ACK on that patch.
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
