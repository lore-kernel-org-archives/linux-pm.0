From: Kevin Hilman <khilman@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: AVS is not maintained via power supply tree
Date: Thu, 30 Jul 2015 15:32:55 -0700
Message-ID: <7ha8ud2s4o.fsf@deeprootsystems.com>
References: <1437772288-22825-1-git-send-email-sre@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1437772288-22825-1-git-send-email-sre@kernel.org> (Sebastian
	Reichel's message of "Fri, 24 Jul 2015 23:11:28 +0200")
Sender: linux-kernel-owner@vger.kernel.org
To: Sebastian Reichel <sre@kernel.org>
Cc: Nishanth Menon <nm@ti.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Sebastian Reichel <sre@kernel.org> writes:

> The adaptive voltage scaling framework is not maintained
> via the power supply tree and has its own entry in the
> MAINTAINERS file, so add an exception in the power supply
> entry.
>
> Signed-off-by: Sebastian Reichel <sre@kernel.org>

Acked-by: Kevin Hilman <khilman@linaro.org>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 8133cef..243f76f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8049,6 +8049,7 @@ T:	git git://git.infradead.org/battery-2.6.git
>  S:	Maintained
>  F:	include/linux/power_supply.h
>  F:	drivers/power/
> +X:	drivers/power/avs/
>  
>  PNP SUPPORT
>  M:	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
