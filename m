From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 2/2] driver core: Fix possible supplier PM-usage counter imbalance
Date: Tue, 12 Feb 2019 23:08:50 +0100
Message-ID: <CAJZ5v0iQiks4e4te3eoafD5=27zKSK3DRMZxsnjEvaBBPyt2ww@mail.gmail.com>
References: <5510642.nRbR3bcduN@aspire.rjw.lan> <9351473.C2nPJoyFsE@aspire.rjw.lan>
 <CAPDyKFpVygMvKAVRd4bCkS6v5MotDRO6sb-VCHK+YEQvbLbc4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAPDyKFpVygMvKAVRd4bCkS6v5MotDRO6sb-VCHK+YEQvbLbc4Q@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, Daniel Vetter <daniel@ffwll.ch>, Lukas Wunner <lukas@wunner.de>, Andrzej Hajda <a.hajda@samsung.com>, Russell King - ARM Linux <linux@armlinux.org.uk>, Lucas Stach <l.stach@pengutronix.de>, Linus Walleij <linus.walleij@linaro.org>, Thierry Reding <thierry.reding@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Marek Szyprowski <m.szyprowski@samsung.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 12, 2019 at 10:03 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
>
> On Tue, 12 Feb 2019 at 13:10, Rafael J. Wysocki <rjw@rjwysocki.net> wrote:
> >
> > From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> >
> > If a stateless device link to a certain supplier with
> > DL_FLAG_PM_RUNTIME set in the flags is added and then removed by the
> > consumer driver's probe callback, the supplier's PM-runtime usage
> > counter will be nonzero after that which effectively causes the
> > supplier to remain "always on" going forward.
> >
> > Namely, device_link_add() called to add the link invokes
> > device_link_rpm_prepare() which notices that the consumer driver is
> > probing, so it increments the supplier's PM-runtime usage counter
> > with the assumption that the link will stay around until
> > pm_runtime_put_suppliers() is called by driver_probe_device(),
> > but if the link goes away before that point, the supplier's
> > PM-runtime usage counter will remain nonzero.
> >
> > To prevent that from happening, first rework pm_runtime_get_suppliers()
> > and pm_runtime_put_suppliers() to use the rpm_active refounts of device
> > links and make the latter only drop rpm_active and the supplier's
> > PM-runtime usage counter for each link by one, unless rpm_active is
> > one already for it.  Next, modify device_link_add() to bump up the
> > new link's rpm_active refcount and the suppliers PM-runtime usage
> > counter by two, to prevent pm_runtime_put_suppliers(), if it is
> > called subsequently, from suspending the supplier prematurely (in
> > case its PM-runtime usage counter goes down to 0 in there).
> >
> > Due to the way rpm_put_suppliers() works, this change does not
> > affect runtime suspend of the consumer ends of new device links (or,
> > generally, device links for which DL_FLAG_PM_RUNTIME has just been
> > set).
> >
> > Fixes: e2f3cd831a28 ("driver core: Fix handling of runtime PM flags in device_link_add()")
> > Reported-by: Ulf Hansson <ulf.hansson@linaro.org>
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
>
> I have tested a several various common probe sequences (including
> error paths) by using my RPM test driver, no issues found. Of course
> it also fixes the problem that occurred while deleting the device link
> during ->probe(). Thanks a lot!
>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>
> Tested-by: Ulf Hansson <ulf.hansson@linaro.org>

Thank you!
