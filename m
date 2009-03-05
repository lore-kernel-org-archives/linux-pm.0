From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH 1/2] PM: Split up
	sysdev_[suspend|resume] from	device_power_[down|up]
Date: Thu, 5 Mar 2009 17:54:30 +0100
Message-ID: <20090305165430.GC1379__26926.0206645869$1236272452$gmane$org@ucw.cz>
References: <200902221837.49396.rjw@sisk.pl> <200902221838.51548.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902221838.51548.rjw@sisk.pl>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Move the sysdev_suspend/resume from the callee to the callers, with
> no real change in semantics, so that we can rework the disabling of
> interrupts during suspend/hibernation.
> 
> This is based on an earlier patch from Linus.

> Index: linux-2.6/drivers/base/power/main.c
> ===================================================================
> --- linux-2.6.orig/drivers/base/power/main.c
> +++ linux-2.6/drivers/base/power/main.c
> @@ -333,7 +333,6 @@ static void dpm_power_up(pm_message_t st
>   */
>  void device_power_up(pm_message_t state)
>  {
> -	sysdev_resume();
>  	dpm_power_up(state);
>  }

And at this point we can rename dpm_power_up -> device_power_up. Good.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
