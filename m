From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/2] PM / suspend: Add platform_suspend_target_state()
Date: Thu, 6 Jul 2017 05:18:31 +0200
Message-ID: <20170706031831.GE12954@xo-6d-61-c0.localdomain>
References: <20170623010837.11199-1-f.fainelli@gmail.com>
 <20170716023610.4658-1-f.fainelli@gmail.com>
 <20170716023610.4658-2-f.fainelli@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20170716023610.4658-2-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Florian Fainelli <f.fainelli@gmail.com>
Cc: linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm <linux-pm@vger.kernel.org>, Thibaud Cornic <thibaud_cornic@sigmadesigns.com>, JB <jb_lescher@sigmadesigns.com>, Mason <slash.tmp@free.fr>, Kevin Hilman <khilman@kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> Although this callback is optional and documented as such, it requires
> a platform_suspend_ops::begin callback to be implemented in order to
> provide an accurate suspend/resume state within the driver that
> implements this platform_suspend_ops.
> 
> An enumeration: platform_target_state is defined which currently defines
> the standard ACPI_S[1-4] states and can be extended with platform
> specific suspend states.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  include/linux/suspend.h | 25 +++++++++++++++++++++++++
>  kernel/power/suspend.c  | 15 +++++++++++++++
>  2 files changed, 40 insertions(+)
> 
> diff --git a/include/linux/suspend.h b/include/linux/suspend.h
> index 0b1cf32edfd7..6e6cc0778816 100644
> --- a/include/linux/suspend.h
> +++ b/include/linux/suspend.h
> @@ -50,6 +50,16 @@ enum suspend_stat_step {
>  	SUSPEND_RESUME
>  };
>  
> +enum platform_target_state {
> +	PLATFORM_STATE_UNKNOWN = -1,
> +	PLATFORM_STATE_WORKING = 0,
> +	PLATFORM_STATE_ACPI_S1,
> +	PLATFORM_STATE_ACPI_S2,
> +	PLATFORM_STATE_ACPI_S3,
> +	PLATFORM_STATE_ACPI_S4,
> +	/* Add platform specific states here */
> +};
> +

As I tried to explain in the email thread, having list with all the possible platform
states is no-go. We have about 1000 platforms supported...

NAK.
									Pavel
