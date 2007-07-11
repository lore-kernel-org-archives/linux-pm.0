From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [RFC][PATCH -mm 4/7] Freezer: Introduce
	freezer-firendly waiting macros
Date: Thu, 12 Jul 2007 03:02:49 +0400
Message-ID: <20070711230249.GA310@tv-sign.ru>
References: <200707120006.50095.rjw@sisk.pl> <200707120013.32672.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707120013.32672.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, pm list <linux-pm@lists.linux-foundation.org>, Pavel Machek <pavel@ucw.cz>, Miklos Szeredi <miklos@szeredi.hu>
List-Id: linux-pm@vger.kernel.org

On 07/12, Rafael J. Wysocki wrote:
>
> +#define wait_event_freezable(wq, condition)				\
> +({									\
> +	int __ret;							\
> +	do {								\
> +		__ret = wait_event_interruptible(wq, 			\
> +				(condition) || freezing(current));	\
> +		try_to_freeze();					\
> +	} while (!(condition));					\
> +	__ret;								\
> +})

This is still not right in general, I believe.

It will spin if the caller is signalled. You changed the freezer, but
kthread can use signals anyway.

It returns only when "condition" is true, so the "__ret" is meaningless.

Oleg.
