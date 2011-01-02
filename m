From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] Power Hibernate: (bugfix) when failed,
	"in_suspend"	should be reset.
Date: Sun, 2 Jan 2011 10:10:47 +0100
Message-ID: <20110102091047.GX32469@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
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
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Len Brown <len.brown@intel.com>, kyungmin.park@samsung.com, myungjoo.ham@gmail.com, linux-pm@lists.linux-foundation.org, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


> When hibernation failed due to an error in swsusp_write() called by
> hibernate(), it skips calling "power_down()" and returns. When
> hibernate() is called again (probably after fixing up so that
> swsusp_write() wouldn't fail again), before "in_suspend = 1" of
> create_image is called, in_suspend should be 0. However, because
> hibernate() did not reset "in_suspend" after a failure, it's already 1.
> 
> This patch fixes such inconsistency of "in_suspend" value.

Ack.

> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> ---
>  kernel/power/hibernate.c |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index e6c498d..e27bf22 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -643,6 +643,7 @@ int hibernate(void)
>  		swsusp_free();
>  		if (!error)
>  			power_down();
> +		in_suspend = 0;
>  	} else {
>  		pr_debug("PM: Image restored successfully.\n");
>  	}

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
