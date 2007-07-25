From: Oleg Nesterov <oleg@tv-sign.ru>
Subject: Re: [RFC][PATCH -mm 2/2] Freezer: Use wait queue instead
	of busy looping
Date: Wed, 25 Jul 2007 17:29:17 +0400
Message-ID: <20070725132917.GA242@tv-sign.ru>
References: <200707251401.48340.rjw@sisk.pl> <200707251409.40592.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707251409.40592.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Nigel Cunningham <nigel@nigel.suspend2.net>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On 07/25, Rafael J. Wysocki wrote:
>
>  void refrigerator(void)
>  {
> @@ -50,6 +73,9 @@ void refrigerator(void)
>  	   processes around? */
>  	long save;
>
> +	refrigerator_called = 1;
> +	wake_up(&refrigerator_waitq);
> +

This is a bit racy. Unless I missed something, the task should not set
refrigerator_called == 1 until it has PF_FROZEN.

Otherwise, try_to_freeze_tasks() can set refrigerator_called == 0 after
refrigerator() sets it == 1, the the main loop notices this unfrozen task,
and goes to sleep.

(I must admit, I agree with Pavel on that patch).

Oleg.
