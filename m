From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [linux-pm] [patch, rft] amd74xx: implement suspend-to-ram
Date: Fri, 28 Jul 2006 11:15:01 +0200
Message-ID: <200607281115.01362.rjw@sisk.pl>
References: <20060715210518.GA3263@opus.vpn-dev.reflex> <20060727224311.GA4104@knob.reflex> <20060727225153.GG3797@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-ide-owner@vger.kernel.org>
In-Reply-To: <20060727225153.GG3797@elf.ucw.cz>
Content-Disposition: inline
Sender: linux-ide-owner@vger.kernel.org
To: linux-pm@lists.osdl.org
Cc: Pavel Machek <pavel@suse.cz>, Jason Lunz <lunz@falooley.org>, David Brownell <david-b@pacbell.net>, linux-ide@vger.kernel.org, Vojtech Pavlik <vojtech@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Friday 28 July 2006 00:51, Pavel Machek wrote:
> On Thu 2006-07-27 18:43:12, Jason Lunz wrote:
> > On Thu, Jul 27, 2006 at 10:49:39PM +0200, Pavel Machek wrote:
> > > > Oh, I see.  But wouldn't that cause FREEZE to spin down the drives?
> > > 
> > > I do not think so. If it will, I'm obviously wrong and original
> > > version is okay.
> > 
> > I think it's the ide bus shutdown methods that do power management on
> > the drives. But here we're talking about the pci ide controller.
> > 
> > At any rate, not having the if() means my machine freezes during the
> > suspend phase of STD.
> 
> I'd still like to understand why it freezes (it should not), but I
> guess you have my ACK on that patch.

So I guess it needs to be forwarded to Andrew.  Should I?

It helps to resume my box from RAM, btw.  Now only the graphics doesn't
wake up.

Rafael
