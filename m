From: Greg KH <greg@kroah.com>
Subject: Re: [linux-pm] [RFC][PATCH 3/3] PM: Remove PM_TRACE from Kconfig
Date: Thu, 17 Aug 2006 04:52:50 -0700
Message-ID: <20060817115250.GA6843@kroah.com>
References: <200608151509.06087.rjw@sisk.pl> <20060816104143.GC9497@elf.ucw.cz> <200608161304.51758.rjw@sisk.pl> <200608161314.11128.rjw@sisk.pl> <20060817044011.GB14127@kroah.com> <20060817091238.GA17899@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S964833AbWHQL5u@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20060817091238.GA17899@elf.ucw.cz>
Sender: linux-kernel-owner@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: "Rafael J. Wysocki" <rjw@sisk.pl>, Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 17, 2006 at 11:12:38AM +0200, Pavel Machek wrote:
> Hi!
> 
> > > Remove the CONFIG_PM_TRACE option, which is dangerous and should only be used
> > > by people who know exactly what they are doing, from Kconfig.
> > 
> > No, don't remove this, that's not acceptable at all.  This is useful for
> > others (and one specifically who will be pissed to see this removed...)
> 
> Yep, while it breaks suspend for every pool soul that enables it by
> mistake. (And in hard-to-debug way, too).
> 
> This option has EXACTLY ONE USER... or more precisely used to have one
> user when he was debugging his mac mini...

I tried it out for a bit when having problems with resume, which I have
yet to resolve properly, so I'll need it again when I get the chance.

And you go tell that "ONE USER" that you disabled his feature :)

thanks,

greg k-h
