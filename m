From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Remove code duplication between
	main.c and user.c
Date: Thu, 21 Jun 2007 17:07:12 +0200
Message-ID: <200706211707.13331.rjw@sisk.pl>
References: <200706182231.04203.rjw@sisk.pl>
	<20070621132815.GF18392@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070621132815.GF18392@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thursday, 21 June 2007 15:28, Pavel Machek wrote:
> Hi!
> 
> > The SNAPSHOT_S2RAM ioctl code is outdated and it should not duplicate the
> > suspend code in kernel/power/main.c.  Fix that.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Mostly works ok, but
> 
> > +/**
> > + *	suspend_suspend - suspend devices and enter the desired system sleep
> > + *			  state.
> > + *	@state:		  state to enter
> > + */
> > +int suspend_suspend(suspend_state_t state)
> 
> This is really horrible name.

Yes, I just couldn't invent anything else.

> Maybe this should be suspend_enter, and suspend_enter should become
> __suspend_enter, or something?

Well, suspend_enter() is called from a couple of places and I wouldn't like
to change that.

I would like to call it pm_suspend(), but that one is already used.

I have two candidates: __suspend() and suspend_devices_and_enter().

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
