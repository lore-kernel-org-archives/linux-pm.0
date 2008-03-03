From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH RFC] introduce pm_call() macro to get rid of
	most	#ifdef CONFIG_PM
Date: Mon, 3 Mar 2008 15:18:18 +0100
Message-ID: <20080303141818.GE12606__1273.48085302419$1204555750$gmane$org@elf.ucw.cz>
References: <20080302234308.GA10116@zarina>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080302234308.GA10116@zarina>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi!

> diff --git a/include/linux/pm.h b/include/linux/pm.h
> index 015b735..6e0b9c2 100644
> --- a/include/linux/pm.h
> +++ b/include/linux/pm.h
> @@ -114,6 +114,13 @@ typedef struct pm_message {
>  	int event;
>  } pm_message_t;
>  
> +#ifdef CONFIG_PM
> +#define pm_call(x) (x)
> +#else
> +/* avoid `defined but not used' warning */
> +#define pm_call(x) ((x) - 1 ? NULL : NULL)
> +#endif /* CONFIG_PM */
> +

This is evil. Maybe your gcc is smart enough to optimize this away,
but I'm not sure mine is.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
