From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 3/5] PM / QoS: Add function
	dev_pm_qos_read_value()
Date: Thu, 1 Sep 2011 17:13:44 +0200
Message-ID: <CAORVsuX=vKiGxHrR4hZjeT4DV0vhUh+MXLwNjoOwgBDu1HRR5A__18069.4931689233$1314930018$gmane$org@mail.gmail.com>
References: <201108310017.03103.rjw@sisk.pl> <201108310021.13800.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108310021.13800.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

On Wed, Aug 31, 2011 at 12:21 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> To read the current PM QoS value for a given device we need to
> make sure that the device's power.constraints object won't be
> removed while we're doing that. =A0For this reason, put the
> operation under dev->power.lock and acquire the lock
> around the initialization and removal of power.constraints.
Ok.

> Moreover, since we're using the value of power.constraints to
> determine whether or not the object is present, the
> power.constraints_state field isn't necessary any more and may be
> removed. =A0However, dev_pm_qos_add_request() needs to check if the
> device is being removed from the system before allocating a new
> PM QoS constraints object for it, so it has to use device_pm_lock()
> and the device PM QoS initialization and destruction should be done
> under device_pm_lock() as well.
Ok that makes sense.
The constraints_state field can be replaced by a combination of
dev->power.constraints and list_empty(&dev->power.entry), which makes
the code more compact and less redundant.

>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> =A0drivers/base/power/main.c | =A0 =A04 -
> =A0drivers/base/power/qos.c =A0| =A0167 ++++++++++++++++++++++++++-------=
-------------
> =A0include/linux/pm.h =A0 =A0 =A0 =A0| =A0 =A08 --
> =A0include/linux/pm_qos.h =A0 =A0| =A0 =A03
> =A04 files changed, 101 insertions(+), 81 deletions(-)
>
> Index: linux/drivers/base/power/qos.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- linux.orig/drivers/base/power/qos.c
> +++ linux/drivers/base/power/qos.c
> @@ -30,15 +30,6 @@
...

>
> @@ -178,8 +202,8 @@ void dev_pm_qos_constraints_destroy(stru
> =A0*
> =A0* Returns 1 if the aggregated constraint value has changed,
> =A0* 0 if the aggregated constraint value has not changed,
> - * -EINVAL in case of wrong parameters, -ENODEV if the device has been
> - * removed from the system
> + * -EINVAL in case of wrong parameters, -ENOMEM if there's not enough me=
mory
> + * to allocate for data structures.
Why not use -ENODEV in case there is no device?

> =A0*/
> =A0int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_reque=
st *req,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s32 value)
> @@ -195,28 +219,35 @@ int dev_pm_qos_add_request(struct device
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
> =A0 =A0 =A0 =A0}
>
> - =A0 =A0 =A0 mutex_lock(&dev_pm_qos_mtx);
> =A0 =A0 =A0 =A0req->dev =3D dev;
>
> - =A0 =A0 =A0 /* Return if the device has been removed */
> - =A0 =A0 =A0 if (req->dev->power.constraints_state =3D=3D DEV_PM_QOS_NO_=
DEVICE) {
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> - =A0 =A0 =A0 }
> + =A0 =A0 =A0 device_pm_lock();
> + =A0 =A0 =A0 mutex_lock(&dev_pm_qos_mtx);
>
> - =A0 =A0 =A0 /*
> - =A0 =A0 =A0 =A0* Allocate the constraints data on the first call to add=
_request,
> - =A0 =A0 =A0 =A0* i.e. only if the data is not already allocated and if =
the device has
> - =A0 =A0 =A0 =A0* not been removed
> - =A0 =A0 =A0 =A0*/
> - =A0 =A0 =A0 if (dev->power.constraints_state =3D=3D DEV_PM_QOS_DEVICE_P=
RESENT)
> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dev_pm_qos_constraints_allocate(dev=
);
> + =A0 =A0 =A0 if (dev->power.constraints) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_pm_unlock();
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (list_empty(&dev->power.entry)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The device has been remo=
ved from the system. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_pm_unlock();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
0 is silently returned in case the device has been removed. Is that
the intention?

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_pm_unlock();
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Allocate the constrain=
ts data on the first call to
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* add_request, i.e. only=
 if the data is not already
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* allocated and if the d=
evice has not been removed.
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dev_pm_qos_constrai=
nts_allocate(dev);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 }
>
> =A0 =A0 =A0 =A0if (!ret)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0ret =3D apply_constraint(req, PM_QOS_ADD_R=
EQ, value);
>
> -out:
> + out:
> =A0 =A0 =A0 =A0mutex_unlock(&dev_pm_qos_mtx);
> +
> =A0 =A0 =A0 =A0return ret;
> =A0}
> =A0EXPORT_SYMBOL_GPL(dev_pm_qos_add_request);
...

Thanks,
Jean
