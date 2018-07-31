From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [RFC] PCI: imx: Add multi-pd support
Date: Tue, 31 Jul 2018 10:32:31 +0200
Message-ID: <CAPDyKFpN99iDYf1mcG-G1=AAkiw8OjoynvK+5cBV8GvCs6WtKg@mail.gmail.com>
References: <8018069bc772376caef29e76280e4d0facffdb68.1532455922.git.leonard.crestez@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <8018069bc772376caef29e76280e4d0facffdb68.1532455922.git.leonard.crestez@nxp.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Leonard Crestez <leonard.crestez@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Jon Hunter <jonathanh@nvidia.com>, Shawn Guo <shawnguo@kernel.org>, Fabio Estevam <fabio.estevam@nxp.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Anson Huang <Anson.Huang@nxp.com>, Richard Zhu <hongxing.zhu@nxp.com>, Linux PM <linux-pm@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, dl-linux-imx <linux-imx@nxp.com>, Sascha Hauer <kernel@pengutronix.de>
List-Id: linux-pm@vger.kernel.org

On 24 July 2018 at 20:17, Leonard Crestez <leonard.crestez@nxp.com> wrote:
> On some chips the PCIE and PCIE_PHY blocks are in separate power domains
> which can be power-gated independently. The driver needs to handle this
> by keeping both domain active.
>
> This is intended for imx6sx where PCIE is in DISPMIX and PCIE_PHY in
> it's own domain. Defining the DISPMIX domain requires a way for pcie to
> keep it active or it will break when displays are off.
>
> The power-domains on imx6sx are meant to look like this:
>         power-domains = <&pd_disp>, <&pd_pci>;
>         power-domain-names = "pcie", "pcie_phy";
>
> Signed-off-by: Leonard Crestez <leonard.crestez@nxp.com>

Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

See some comments below...

> ---
>
> Right now if a device has a single power domain it will be activated
> before probe but if it has multiple domains they need to be explicitly
> "attached" to and controlled. Supporting both is a bit awkward, this
> patch makes the distinction based on (dev->pm_domain != NULL).
>
> Maybe the PM core should make this distinction based on a flag in struct
> device_driver instead of number of power-domains? So by default when a
> device has multiple power domains they would would be activated
> together and this patch would be unnecessary.

Activation is deliberately left to be manged by each user, as the PM
core/genpd can't know when powering on the PM domains make sense.

The main reason to why genpd powers on the PM domain for the single PM
domain case, is because of legacy behaviors in drivers. Some drivers
don't call pm_runtime_get_sync() during ->probe(), but instead use
pm_runtime_set_active(), to synchronize the state with the HW. This
means the ->runtime_resume() callback doesn't get invoked for genpd,
hence genpd must power on the PM domain already at attache to cover
this case.

>
> This is marked as "RFC" mostly because I believe it should be handled
> inside PM core, without driver code. Does this make sense to anyone else?
>
> This is independent of recent patches adding suspend/resume support to
> imx pci, but supporting suspend with multi-pd requires adding device
> links, not just activating pds at probe time.
>
> The device_link is marked as "STATELESS" because otherwise a warning is
> triggered in device_links_driver_bound. This seems to happen because the
> pd devices are always marked as "DL_DEV_NO_DRIVER". Maybe they should be
> instead always be marked as DL_DEV_DRIVER_BOUND?

Using STATELESS is correct, because the supplier devices, which are
managed by genpd don't have any driver attached to them.

[...]

Kind regards
Uffe
