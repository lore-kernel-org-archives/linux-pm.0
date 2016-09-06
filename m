From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH v2 07/10] driver core: Add support for links to already probed drivers
Date: Wed, 07 Sep 2016 01:13:23 +0200
Message-ID: <1787976.ELaxkTxS9k@vostro.rjw.lan>
References: <1466144820-6286-1-git-send-email-m.szyprowski@samsung.com> <1466144820-6286-8-git-send-email-m.szyprowski@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1466144820-6286-8-git-send-email-m.szyprowski@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, iommu@lists.linux-foundation.org, linux-samsung-soc@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Joerg Roedel <joro@8bytes.org>, Inki Dae <inki.dae@samsung.com>, Kukjin Kim <kgene@kernel.org>, Krzysztof Kozlowski <k.kozlowski@samsung.com>, Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Mark Brown <broonie@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, June 17, 2016 08:26:57 AM Marek Szyprowski wrote:
> Set proper link state if link is created between already probed supplier
> device and to be probed consumer device.
> 
> Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> ---
>  drivers/base/core.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 4e778539b750..d9c5c5542a6b 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -125,7 +125,9 @@ struct devlink *device_link_add(struct device *consumer,
>  
>  	link->flags = flags;
>  	link->status = (flags & DEVICE_LINK_PROBE_TIME) ?
> -			DEVICE_LINK_CONSUMER_PROBE : DEVICE_LINK_DORMANT;
> +			DEVICE_LINK_CONSUMER_PROBE :
> +			(supplier->driver ? DEVICE_LINK_AVAILABLE :
> +			 DEVICE_LINK_DORMANT);
>  	spin_lock_init(&link->lock);
>  
>  	/*
> 

The supplier->driver check is insufficient and racy.

It is insufficient, because supplier->driver is also set during supplier probe
and the probe may still not be successful.

It is racy, because supplier->driver may be modified right after this check.

The only way to address the issue at hand I can see is to add a flag to
indicate to device_link_add() that the supplier has already been probed
successfully.

Thanks,
Rafael
