From: Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH] PM / Domains: Fix typo in comment
Date: Tue, 26 Jan 2016 15:51:20 -0800
Message-ID: <7hmvrrnblz.fsf@baylibre.com>
References: <1450979471-26623-1-git-send-email-moritz.fischer@ettus.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1450979471-26623-1-git-send-email-moritz.fischer@ettus.com>
	(Moritz Fischer's message of "Thu, 24 Dec 2015 09:51:11 -0800")
Sender: linux-kernel-owner@vger.kernel.org
To: Moritz Fischer <moritz.fischer@ettus.com>
Cc: ulf.hansson@linaro.org, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

+ Rafael, linux-pm

Hi Moritz,

Moritz Fischer <moritz.fischer@ettus.com> writes:

> Signed-off-by: Moritz Fischer <moritz.fischer@ettus.com>

Looks like this isn't yet applied.  It was likely missed because I've
been away and/or wasn't sent to linux-pm or Rafael.

Anyways, could you please re-send including them so Rafael has it in his
inbox and can apply directly.

Also, feel free to add

Acked-by: Kevin Hilman <khilman@baylibre.com>

Thanks,

Kevin

> ---
>  drivers/base/power/domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/base/power/domain.c b/drivers/base/power/domain.c
> index 65f50ec..53e81ac 100644
> --- a/drivers/base/power/domain.c
> +++ b/drivers/base/power/domain.c
> @@ -160,7 +160,7 @@ static int genpd_power_off(struct generic_pm_domain *genpd, bool timed)
>  
>  /**
>   * genpd_queue_power_off_work - Queue up the execution of genpd_poweroff().
> - * @genpd: PM domait to power off.
> + * @genpd: PM domain to power off.
>   *
>   * Queue up the execution of genpd_poweroff() unless it's already been done
>   * before.
