From: Colin Cross <ccross@google.com>
Subject: Re: [Update][PATCH 7/9] PM / Runtime: Generic clock
 manipulation rountines for runtime PM (v3)
Date: Wed, 27 Apr 2011 16:04:09 -0700
Message-ID: <BANLkTimHkKq9+0z-4CZs=34GNO6Ab0wZPQ__10707.2248276838$1303945521$gmane$org@mail.gmail.com>
References: <201104130205.26988.rjw@sisk.pl> <201104242330.13607.rjw@sisk.pl>
	<201104242342.58326.rjw@sisk.pl> <201104272348.24084.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201104272348.24084.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-sh@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Apr 27, 2011 at 2:48 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Many different platforms and subsystems may want to disable device
> clocks during suspend and enable them during resume which is going to
> be done in a very similar way in all those cases. =A0For this reason,
> provide generic routines for the manipulation of device clocks during
> suspend and resume.
>
> Convert the ARM shmobile platform to using the new routines.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
>
> Hi,
>
> This (hopefully final) version of the patch has a couple of bugs fixed in
> clock_ops.c.
>
> Thanks,
> Rafael
>
> ---
> =A0arch/arm/mach-shmobile/pm_runtime.c | =A0140 -----------
> =A0drivers/base/power/Makefile =A0 =A0 =A0 =A0 | =A0 =A01
> =A0drivers/base/power/clock_ops.c =A0 =A0 =A0| =A0423 +++++++++++++++++++=
+++++++++++++++++
> =A0include/linux/pm_runtime.h =A0 =A0 =A0 =A0 =A0| =A0 42 +++
> =A0kernel/power/Kconfig =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 =A04
> =A05 files changed, 479 insertions(+), 131 deletions(-)
>
<snip>
> +void pm_runtime_clk_remove(struct device *dev, const char *con_id)
> +{
> +       struct pm_runtime_clk_data *prd =3D __to_prd(dev);
> +       struct pm_clock_entry *ce;
> +
> +       if (!prd)
> +               return;
> +
> +       mutex_lock(&prd->lock);
> +
> +       list_for_each_entry(ce, &prd->clock_list, node)
Braces
> +               if (!con_id && !ce->con_id) {
> +                       __pm_runtime_clk_remove(ce);
> +                       break;
> +               } else if (!con_id || !ce->con_id) {
> +                       continue;
> +               } else if (!strcmp(con_id, ce->con_id)) {
> +                       __pm_runtime_clk_remove(ce);
> +                       break;
> +               }
> +
> +       mutex_unlock(&prd->lock);
> +}
>
> +/**
> + * pm_runtime_clk_acquire - Acquire a device clock.
> + * @dev: Device whose clock is to be acquired.
> + * @con_id: Connection ID of the clock.
> + */
> +static void pm_runtime_clk_acquire(struct device *dev,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 str=
uct pm_clock_entry *ce)
> +{
> + =A0 =A0 =A0 ce->clk =3D clk_get(dev, ce->con_id);
> + =A0 =A0 =A0 if (!IS_ERR(ce->clk)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 ce->clock_active =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_dbg(dev, "Clock %s managed by runtime P=
M.\n", ce->con_id);
> + =A0 =A0 =A0 }
> +}
> +
> +/**
> + * pm_runtime_clk_suspend - Disable clocks in a device's runtime PM cloc=
k list.
> + * @dev: Device to disable the clocks for.
> + */
> +int pm_runtime_clk_suspend(struct device *dev)
> +{
> + =A0 =A0 =A0 struct pm_runtime_clk_data *prd =3D __to_prd(dev);
> + =A0 =A0 =A0 struct pm_clock_entry *ce;
> +
> + =A0 =A0 =A0 dev_dbg(dev, "%s()\n", __func__);
> +
> + =A0 =A0 =A0 if (!prd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 mutex_lock(&prd->lock);
> +
> + =A0 =A0 =A0 list_for_each_entry_reverse(ce, &prd->clock_list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ce->clk) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev, "Clock is not =
ready for runtime PM\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_clk_acquire(dev,=
 ce);
Why delay the call to clk_get until the first suspend?  Also, this
will always print an error during the first call to suspend.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ce->clock_active) {
I don't think clock_active is necessary, and the name is misleading.
Why not use if (ce->clk)?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_disable(ce->clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ce->clock_enabled =3D false;
Clock enables are already refcounted, do you really need a flag as
well?  In what situations would pm_runtime_clk_remove get called,
which currently needs to know when the clock is enabled?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mutex_unlock(&prd->lock);
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * pm_runtime_clk_resume - Enable clocks in a device's runtime PM clock =
list.
> + * @dev: Device to enable the clocks for.
> + */
> +int pm_runtime_clk_resume(struct device *dev)
> +{
> + =A0 =A0 =A0 struct pm_runtime_clk_data *prd =3D __to_prd(dev);
> + =A0 =A0 =A0 struct pm_clock_entry *ce;
> +
> + =A0 =A0 =A0 dev_dbg(dev, "%s()\n", __func__);
> +
> + =A0 =A0 =A0 if (!prd)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 mutex_lock(&prd->lock);
> +
> + =A0 =A0 =A0 list_for_each_entry(ce, &prd->clock_list, node) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (!ce->clk)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_runtime_clk_acquire(dev,=
 ce);
If the clock was not present during suspend, should you be enabling it
during resume?

> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (ce->clock_active) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 clk_enable(ce->clk);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ce->clock_enabled =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mutex_unlock(&prd->lock);
> +
> + =A0 =A0 =A0 return 0;
> +}
