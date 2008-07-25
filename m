From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [patch 2.6.26-git] pm selftest:  rtc paranoia
Date: Fri, 25 Jul 2008 14:49:46 -0700
Message-ID: <20080725144946.5e1b78c8.akpm__22796.2759942331$1217022768$gmane$org@linux-foundation.org>
References: <200807251326.51987.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807251326.51987.david-b@pacbell.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Fri, 25 Jul 2008 13:26:51 -0700
David Brownell <david-b@pacbell.net> wrote:

> From: David Brownell <dbrownell@users.sourceforge.net>
> 
> Cope with a quirk of some RTCs (notably ACPI ones) which
> aren't guaranteed to implement oneshot behavior when they
> woke the system from sleeep:  forcibly disable the alarm,
> just in case.
> 
> Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
> ---
>  kernel/power/main.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> --- a/kernel/power/main.c	2008-07-22 16:38:32.000000000 -0700
> +++ b/kernel/power/main.c	2008-07-22 16:39:15.000000000 -0700
> @@ -635,6 +635,13 @@ static void __init test_wakealarm(struct
>  	}
>  	if (status < 0)
>  		printk(err_suspend, status);
> +
> +	/* Some platforms can't detect that the alarm triggered the
> +	 * wakeup, or (accordingly) disable it after it afterwards.
> +	 * It's supposed to give oneshot behavior; cope.
> +	 */
> +	alm.enabled = false;
> +	rtc_set_alarm(rtc, &alm);
>  }
>  
>  static int __init has_wakealarm(struct device *dev, void *name_ptr)

I assume this fixes some reported bug?  Any references?

Is this needed in 2.6.26.x?  2.6.25.x?
