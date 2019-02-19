From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFT/RFC][PATCH] driver core: Fix PM-runtime for links added
 during consumer probe
Date: Tue, 19 Feb 2019 17:16:18 +0100
Message-ID: <CAJZ5v0gm_eKm4FdJUbuwaZwxoWWoHk0BwH25tpQj+9xrgV7zuA@mail.gmail.com>
References: <14371356.imFjPFOrCi@aspire.rjw.lan> <CAPDyKFrZ8Miy9A2wFksJLxePk+O05NtEmf58Q-8BqDdZ7kL7AQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFrZ8Miy9A2wFksJLxePk+O05NtEmf58Q-8BqDdZ7kL7AQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jon Hunter <jonathanh@nvidia.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 19, 2019 at 1:10 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Mon, 18 Feb 2019 at 23:09, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > Commit 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage
> > counter imbalance") introduced a regression that causes suppliers
> > to be suspended prematurely for device links added during consumer
> > driver probe if the initial PM-runtime status of the consumer is
> > "suspended" and the consumer is resumed after adding the link and
> > before pm_runtime_put_suppliers() is called.  In that case,
> > pm_runtime_put_suppliers() will drop the rpm_active refcount for
> > the link by one and (since rpm_active is equal to two after the
> > preceding consumer resume) the supplier's PM-runtime usage counter
> > will be decremented, which may cause the supplier to suspend even
> > though the consumer's PM-runtime status is "active".
>
> Just to confirm, this is the behavior that I see as well.
>
> However, I am a bit a surprised on my side, that I did not run this
> particular test sequence earlier. Sorry about that!
>
> >
> > For this reason, partially revert commit 4c06c4e6cf63 as the problem
> > it tried to fix needs to be addressed somewhat differently, and
> > change pm_runtime_get_suppliers() and pm_runtime_put_suppliers() so
> > that the latter only drops rpm_active references acquired by the
> > former.  [This requires adding a new field to struct device_link,
> > but I coulnd't find a cleaner way to address the issue that would
> > work in all cases.]
> >
> > Fixes: 4c06c4e6cf63 ("driver core: Fix possible supplier PM-usage counter imbalance")
> > Reported-by: Jon Hunter <jonathanh@nvidia.com>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> Besides validating the fix, I can confirm device link add/removal
> during probe works fine, as before.
>
> I also tested the runtime PM autosuspend (several seconds timeout)
> together with DL_FLAG_RPM_ACTIVE - it's working fine! During this
> test, the rpm_active count reaches 3 after probe and the supplier's
> usage count reaches 2. When the consumer becomes runtime suspended,
> after the timeout, these "counts" becomes decremented to 1 and 0, so
> the supplier also becomes runtime suspended.
>
> Tested-by: Ulf Hansson <ulf.hansson@linaro.org>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Many thanks to you and Jon for verifying it!
