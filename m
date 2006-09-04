From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/3] PM: Make console suspending configureable
Date: Mon, 4 Sep 2006 13:03:25 +0200
Message-ID: <200609041303.25817.rjw@sisk.pl>
References: <200608151509.06087.rjw@sisk.pl> <200608161309.34370.rjw@sisk.pl> <20060904090820.GA4500@suse.de>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1751312AbWIDLA0@vger.kernel.org>
In-Reply-To: <20060904090820.GA4500@suse.de>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: Stefan Seyfried <seife@suse.de>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Monday, 4 September 2006 11:08, Stefan Seyfried wrote:
> Hi,
> 
> sorry, i am only slowly catching up after vacation.
> 
> On Wed, Aug 16, 2006 at 01:09:34PM +0200, Rafael J. Wysocki wrote:
> > Change suspend_console() so that it waits for all consoles to flush the
> > remaining messages and make it possible to switch the console suspending
> > off with the help of a Kconfig option.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> > +#ifndef CONFIG_DISABLE_CONSOLE_SUSPEND
> >  /**
> >   * suspend_console - suspend the console subsystem
> >   *
> > @@ -709,8 +710,14 @@ int __init add_preferred_console(char *n
> >   */
> >  void suspend_console(void)
> >  {
> > +	printk("Suspending console(s)\n");
> >  	acquire_console_sem();
> >  	console_suspended = 1;
> > +	/* This is needed so that all of the messages that have already been
> > +	 * written to all consoles can be actually transmitted (eg. over a
> > +	 * network) before we try to suspend the consoles' devices.
> > +	 */
> > +	ssleep(2);
> 
> Sorry, but no. Suspend and resume is already slow enough, no need to make
> both of them much slower.
> If we can condition this on the netconsole being used, ok, but not for the
> most common case of "console is on plain VGA".

Hm, it already is in -mm, but of course I can prepare a patch that removes
this ssleep().

Pavel, what do you think?

Rafael


-- 
You never change things by fighting the existing reality.
		R. Buckminster Fuller

-- 
VGER BF report: H 4.55007e-15
