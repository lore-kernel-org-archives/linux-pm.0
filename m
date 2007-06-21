From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH] PM: Remove code duplication between
	main.c and user.c
Date: Thu, 21 Jun 2007 15:28:15 +0200
Message-ID: <20070621132815.GF18392@elf.ucw.cz>
References: <200706182231.04203.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706182231.04203.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> The SNAPSHOT_S2RAM ioctl code is outdated and it should not duplicate the
> suspend code in kernel/power/main.c.  Fix that.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Mostly works ok, but

> +/**
> + *	suspend_suspend - suspend devices and enter the desired system sleep
> + *			  state.
> + *	@state:		  state to enter
> + */
> +int suspend_suspend(suspend_state_t state)

This is really horrible name. Maybe this should be suspend_enter, and
suspend_enter should become __suspend_enter, or something?
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
