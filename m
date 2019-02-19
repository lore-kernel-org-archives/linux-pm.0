From: Jon Hunter <jonathanh@nvidia.com>
Subject: Re: [RFT/RFC][PATCH] driver core: Fix PM-runtime for links added
 during consumer probe
Date: Tue, 19 Feb 2019 10:24:29 +0000
Message-ID: <eeaa7369-31bb-293e-e585-6014e4bcdd14@nvidia.com>
References: <14371356.imFjPFOrCi@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <14371356.imFjPFOrCi@aspire.rjw.lan>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ulf Hansson <ulf.hansson@linaro.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>, linux-tegra <linux-tegra@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


On 18/02/2019 22:08, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Commit 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage
> counter imbalance") introduced a regression that causes suppliers
> to be suspended prematurely for device links added during consumer
> driver probe if the initial PM-runtime status of the consumer is
> "suspended" and the consumer is resumed after adding the link and
> before pm_runtime_put_suppliers() is called.  In that case,
> pm_runtime_put_suppliers() will drop the rpm_active refcount for
> the link by one and (since rpm_active is equal to two after the
> preceding consumer resume) the supplier's PM-runtime usage counter
> will be decremented, which may cause the supplier to suspend even
> though the consumer's PM-runtime status is "active".
> 
> For this reason, partially revert commit 4c06c4e6cf63 as the problem
> it tried to fix needs to be addressed somewhat differently, and
> change pm_runtime_get_suppliers() and pm_runtime_put_suppliers() so
> that the latter only drops rpm_active references acquired by the
> former.  [This requires adding a new field to struct device_link,
> but I coulnd't find a cleaner way to address the issue that would
> work in all cases.]
> 
> Fixes: 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage counter imbalance")
> Reported-by: Jon Hunter <jonathanh@nvidia.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> On top of driver-core/driver-core-next.
> 
> Jon, Ulf, please test!

Thanks Rafael this works for me!

Tested-by: Jon Hunter <jonathanh@nvidia.com>

Cheers
Jon

-- 
nvpublic
