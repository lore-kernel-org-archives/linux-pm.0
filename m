From: Ohad Ben-Cohen <ohad@wizery.com>
Subject: generic runtime pm callbacks
Date: Mon, 6 Sep 2010 15:32:09 +0300
Message-ID: <AANLkTikJ5sSQzZ8XL_04_VqzKKPZBRHGtMAQvdz9bfOS__21430.9545154267$1283776412$gmane$org@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: linux-mmc@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

I'm adding Runtime PM support to the SDIO subsystem, and was planning
to use the generic runtime pm handlers.

Those handlers return -EINVAL if the driver didn't explicitly define
the runtime pm handlers:

That may result in some drivers defining nop handlers, just to return
0 (in case there's nothing else they need to do).

Do we want that ?

Alternatively, we may want to allow drivers to enable Runtime PM (by
taking the appropriate action for their subsystem, e.g. calling
put_noidle in probe and get_noresume in remove), but still not define
any runtime pm handlers (implicitly always returning a success), with
something like:

diff --git a/drivers/base/power/generic_ops.c b/drivers/base/power/generic_=
ops.
index 304c831..531762a 100644
--- a/drivers/base/power/generic_ops.c
+++ b/drivers/base/power/generic_ops.c
@@ -49,7 +49,7 @@ int pm_generic_runtime_suspend(struct device *dev)
=A0 =A0 =A0 =A0const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->p=
m : NULL;
=A0 =A0 =A0 =A0int ret;

- =A0 =A0 =A0 ret =3D pm && pm->runtime_suspend ? pm->runtime_suspend(dev) =
: -EINVAL;
+ =A0 =A0 =A0 ret =3D pm && pm->runtime_suspend ? pm->runtime_suspend(dev) =
: 0;

=A0 =A0 =A0 =A0return ret;
=A0}
@@ -68,7 +68,7 @@ int pm_generic_runtime_resume(struct device *dev)
=A0 =A0 =A0 =A0const struct dev_pm_ops *pm =3D dev->driver ? dev->driver->p=
m : NULL;
=A0 =A0 =A0 =A0int ret;

- =A0 =A0 =A0 ret =3D pm && pm->runtime_resume ? pm->runtime_resume(dev) : =
-EINVAL;
+ =A0 =A0 =A0 ret =3D pm && pm->runtime_resume ? pm->runtime_resume(dev) : =
0;

=A0 =A0 =A0 =A0return ret;
=A0}

What do you think ?

Please note that the generic pm_generic_runtime_idle handler does
allow drivers not to explicitly define a runtime_idle handler.

Thanks,
Ohad.
