From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / hibernate: Mark expected switch fall-through
Date: Sun, 12 Aug 2018 13:20:25 +0200
Message-ID: <3172480.Efgj8VWSCo@aspire.rjw.lan>
References: <20180805021200.GA10911@embeddedor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180805021200.GA10911@embeddedor.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sunday, August 5, 2018 4:12:00 AM CEST Gustavo A. R. Silva wrote:
> In preparation to enabling -Wimplicit-fallthrough, mark switch cases
> where we are expecting to fall through.
> 
> Addresses-Coverity-ID: 114713 ("Missing break in switch")
> Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
> ---
>  kernel/power/hibernate.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
> index 9c85c78..38f3f96 100644
> --- a/kernel/power/hibernate.c
> +++ b/kernel/power/hibernate.c
> @@ -638,6 +638,7 @@ static void power_down(void)
>  		break;
>  	case HIBERNATION_PLATFORM:
>  		hibernation_platform_enter();
> +		/* Fall through */
>  	case HIBERNATION_SHUTDOWN:
>  		if (pm_power_off)
>  			kernel_power_off();
> 

Applied, thanks!
