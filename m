From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 2/6] Freezer: Do not send signals to
	kernel threads
Date: Tue, 10 Jul 2007 01:42:12 +0200
Message-ID: <20070709234212.GJ1967@elf.ucw.cz>
References: <200707092229.08898.rjw@sisk.pl> <200707092232.01603.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707092232.01603.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, pm list <linux-pm@lists.linux-foundation.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

Hi!

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Commit b74d0deb968e1f85942f17080eace015ce3c332c has changed
> recalc_sigpending_tsk() so that it doesn't clear TIF_SIGPENDING.  For this
> reason, the freezer should not send fake signals to kernel threads any more,
> since otherwise some of them may run with TIF_SIGPENDING set forever if the
> freezing of kernel threads fails.

Is there some bigger plan why we want this?

I mean, it seems nicer w/o signals, but OTOH it is more lines of code
and kernel/user freezing diverges. Can we just revert few lines,
instead of inserting 100 lines?

> +/*
> + * Freezer-friendly wrappers around wait_event_interruptible() and
> + * wait_event_interruptible_timeout(), originally defined in <linux/wait.h>
> + */
> +
> +#define wait_event_freezable(wq, condition)				\
> +({									\
> +	int __ret;							\
> +	do {								\
> +		__ret = wait_event_interruptible(wq, 			\
> +				(condition) || freezing(current));	\
> +	} while (try_to_freeze());					\
> +	__ret;								\
> +})
> +
> +
> +#define wait_event_freezable_timeout(wq, condition, timeout)		\
> +({									\
> +	long __ret = timeout;						\
> +	do {								\
> +		__ret = wait_event_interruptible_timeout(wq,		\
> +				(condition) || freezing(current),	\
> +				__ret); 				\
> +	} while (try_to_freeze());					\
> +	__ret;								\
> +})

Hohum, but yes, these are nice.

								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
