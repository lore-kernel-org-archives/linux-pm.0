From: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
Subject: Re: [PATCH v3 9/9] arm, arm64, drivers: add a prefix to drivers
 arch_topology interfaces
Date: Mon, 10 Apr 2017 09:32:42 +0100
Message-ID: <20170410083242.GE27538@e104818-lin.cambridge.arm.com>
References: <20170327131825.32134-1-juri.lelli@arm.com>
 <20170327131825.32134-10-juri.lelli@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <20170327131825.32134-10-juri.lelli-5wv7dgnIgG8@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
Cc: linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lorenzo.pieralisi-5wv7dgnIgG8@public.gmane.org, vincent.guittot-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, peterz-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, will.deacon-5wv7dgnIgG8@public.gmane.org, gregkh-hQyY1W1yCW8ekmWlsbkhG0B+6BGkLq7r@public.gmane.org, dietmar.eggemann-5wv7dgnIgG8@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, sudeep.holla-5wv7dgnIgG8@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, morten.rasmussen-5wv7dgnIgG8@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 27, 2017 at 02:18:25PM +0100, Juri Lelli wrote:
> Now that some functions that deal with arch topology information live
> under drivers, there is a clash of naming that might create confusion.
> 
> Tidy things up by creating a drivers namespace for interfaces used by
> arch code; achieve this by prepending a 'atd_' (arch topology driver)
> prefix to driver interfaces.
> 
> Signed-off-by: Juri Lelli <juri.lelli-5wv7dgnIgG8@public.gmane.org>
> ---
>  arch/arm/kernel/topology.c    |  8 ++++----
>  arch/arm64/kernel/topology.c  |  4 ++--
>  drivers/base/arch_topology.c  | 20 ++++++++++----------
>  include/linux/arch_topology.h |  8 ++++----
>  4 files changed, 20 insertions(+), 20 deletions(-)

Acked-by: Catalin Marinas <catalin.marinas-5wv7dgnIgG8@public.gmane.org>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
