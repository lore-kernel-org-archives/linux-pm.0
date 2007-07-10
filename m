From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 2/6] Freezer: Do not send signals to
	kernel threads
Date: Tue, 10 Jul 2007 07:57:39 +0200
Message-ID: <200707100757.40668.rjw@sisk.pl>
References: <200707092229.08898.rjw@sisk.pl> <200707092232.01603.rjw@sisk.pl>
	<20070709234212.GJ1967@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070709234212.GJ1967@elf.ucw.cz>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Miklos Szeredi <miklos@szeredi.hu>, pm list <linux-pm@lists.linux-foundation.org>, Oleg Nesterov <oleg@tv-sign.ru>
List-Id: linux-pm@vger.kernel.org

Hi,

On Tuesday, 10 July 2007 01:42, Pavel Machek wrote:
> Hi!
> 
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > Commit b74d0deb968e1f85942f17080eace015ce3c332c has changed
> > recalc_sigpending_tsk() so that it doesn't clear TIF_SIGPENDING.  For this
> > reason, the freezer should not send fake signals to kernel threads any more,
> > since otherwise some of them may run with TIF_SIGPENDING set forever if the
> > freezing of kernel threads fails.
> 
> Is there some bigger plan why we want this?
> 
> I mean, it seems nicer w/o signals, but OTOH it is more lines of code
> and kernel/user freezing diverges. Can we just revert few lines,
> instead of inserting 100 lines?

I'm not sure what you mean.

AFAICS, commit b74d0deb968e1f85942f17080eace015ce3c332c is a bugfix and is not
reversible.

> > +/*
> > + * Freezer-friendly wrappers around wait_event_interruptible() and
> > + * wait_event_interruptible_timeout(), originally defined in <linux/wait.h>
> > + */
> > +
> > +#define wait_event_freezable(wq, condition)				\
> > +({									\
> > +	int __ret;							\
> > +	do {								\
> > +		__ret = wait_event_interruptible(wq, 			\
> > +				(condition) || freezing(current));	\
> > +	} while (try_to_freeze());					\
> > +	__ret;								\
> > +})
> > +
> > +
> > +#define wait_event_freezable_timeout(wq, condition, timeout)		\
> > +({									\
> > +	long __ret = timeout;						\
> > +	do {								\
> > +		__ret = wait_event_interruptible_timeout(wq,		\
> > +				(condition) || freezing(current),	\
> > +				__ret); 				\
> > +	} while (try_to_freeze());					\
> > +	__ret;								\
> > +})
> 
> Hohum, but yes, these are nice.

:-)

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
