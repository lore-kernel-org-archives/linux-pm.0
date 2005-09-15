From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [linux-pm] swsusp3: push image reading/writing into userspace
Date: Thu, 15 Sep 2005 09:37:44 +0200
Message-ID: <20050915073744.GA2725@elf.ucw.cz>
References: <20050914223206.GA2376@elf.ucw.cz> <1126749596.3987.5.camel@localhost> <20050915063753.GA2691@elf.ucw.cz> <1126768581.3987.31.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1030470AbVIOHh5@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1126768581.3987.31.camel@localhost>
Sender: linux-kernel-owner@vger.kernel.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > > Here's prototype code for swsusp3. It seems to work for me, but don't
> > > > try it... yet. Code is very ugly at places, sorry, I know and will fix
> > > > it. This is just proof that it can be done, and that it can be done
> > > > without excessive ammount of code.
> > > 
> > > No comments on the code sorry. Instead I want to ask, could you please
> > > find a different name? swsusp3 is going to make people think that it's
> > > Suspend2 redesigned. Since there hasn't been a swsusp2 (so far as I
> > > know), how about using that name instead? At least then we'll clearly
> > > differentiate the two implementations and you won't confuse/irritate
> > > users.
> > 
> > swsusp2 can't be used, it is already "taken" by suspend2 (25000 hits
> > on google). I was actually hoping that you would release suspend4
> > (using swsusp3 infrastructure) :-).
> 
> You could reclaim it. There are 10 times as many hits (239,000) for
> suspend2, and I've never wanted it to be called swsusp2 anyway :). As
> for suspend4, at the moment, I'm not planning on ever progressing beyond
> 2.x.

Sorry, have to ask...

"not planning on progressing" == version number stays "2" no matter
what changes, or "not planning on progressing" == not plan to use
swsusp3/uswsusp infrastructure?

> > I guess I could call it "uswsusp".
> 
> u as in micro?

Originaly I thought about it as "userland-swsusp", but micro-swsusp
sounds nice, too.
								Pavel

-- 
if you have sharp zaurus hardware you don't need... you know my address
