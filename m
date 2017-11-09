From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] bq2415x_charger: Use common error handling code in
 bq2415x_timer_work()
Date: Thu, 9 Nov 2017 13:08:42 +0100
Message-ID: <20171109120842.GA28552@atrey.karlin.mff.cuni.cz>
References: <48b34d35-8c41-d25b-0cb7-6257b37c5a44@users.sourceforge.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <48b34d35-8c41-d25b-0cb7-6257b37c5a44@users.sourceforge.net>
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-pm@vger.kernel.org, Pali Roh?r <pali.rohar@gmail.com>, Sebastian Reichel <sre@kernel.org>, LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Mon, 30 Oct 2017 21:45:09 +0100
> 
> Add a jump target so that a bit of exception handling can be better reused
> at the end of this function.
> 
> This issue was detected by using the Coccinelle software.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Better fix would be to display separate messages; user is probably
interested in what failed...
								Pavel

> ---
>  drivers/power/supply/bq2415x_charger.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/power/supply/bq2415x_charger.c b/drivers/power/supply/bq2415x_charger.c
> index c4770a94cc8e..8385e02e1634 100644
> --- a/drivers/power/supply/bq2415x_charger.c
> +++ b/drivers/power/supply/bq2415x_charger.c
> @@ -914,16 +914,12 @@ static void bq2415x_timer_work(struct work_struct *work)
>  	}
>  
>  	boost = bq2415x_exec_command(bq, BQ2415X_BOOST_MODE_STATUS);
> -	if (boost < 0) {
> -		bq2415x_timer_error(bq, "Unknown error");
> -		return;
> -	}
> +	if (boost < 0)
> +		goto report_timer_error;
>  
>  	error = bq2415x_exec_command(bq, BQ2415X_FAULT_STATUS);
> -	if (error < 0) {
> -		bq2415x_timer_error(bq, "Unknown error");
> -		return;
> -	}
> +	if (error < 0)
> +		goto report_timer_error;
>  
>  	if (boost) {
>  		switch (error) {
> @@ -992,6 +988,10 @@ static void bq2415x_timer_work(struct work_struct *work)
>  	}
>  
>  	schedule_delayed_work(&bq->work, BQ2415X_TIMER_TIMEOUT * HZ);
> +	return;
> +
> +report_timer_error:
> +	bq2415x_timer_error(bq, "Unknown error");
>  }
>  
>  /**** power supply interface code ****/

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
