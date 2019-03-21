From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] MAINTAINERS: Add mailing list for the interconnect API
Date: Thu, 21 Mar 2019 23:08:06 +0100
Message-ID: <4114564.UGys5yUu8D@aspire.rjw.lan>
References: <20190321155050.25847-1-georgi.djakov@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190321155050.25847-1-georgi.djakov@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Georgi Djakov <georgi.djakov@linaro.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Thursday, March 21, 2019 4:50:50 PM CET Georgi Djakov wrote:
> Add a mailing list for patch reviews and discussions related to tuning
> the on-chip interconnects. For now i am not expecting a lot of traffic,
> so let's use the linux-pm@ list.
> 
> Signed-off-by: Georgi Djakov <georgi.djakov@linaro.org>

Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

> ---
> 
> Hi Rafael,
> Please ack the patch if you don't mind this.
> Thanks!
> 
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index e17ebf70b548..186439e7f846 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8046,6 +8046,7 @@ F:	drivers/gpio/gpio-intel-mid.c
>  
>  INTERCONNECT API
>  M:	Georgi Djakov <georgi.djakov@linaro.org>
> +L:	linux-pm@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/interconnect/
>  F:	Documentation/devicetree/bindings/interconnect/
> 
