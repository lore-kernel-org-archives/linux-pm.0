From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v9 2/4] PM: Introduce devfreq: generic DVFS
 framework with device-specific OPPs
Date: Wed, 31 Aug 2011 13:05:16 -0700
Message-ID: <CAJOA=zM+MOAd9cCo04EzsegvkbOHRykZpiyappPptpC95b18=w@mail.gmail.com>
References: <1314775779-21399-1-git-send-email-myungjoo.ham@samsung.com>
	<1314775779-21399-3-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1314775779-21399-3-git-send-email-myungjoo.ham@samsung.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: MyungJoo Ham <myungjoo.ham@samsung.com>
Cc: Len Brown <len.brown@intel.com>, Greg Kroah-Hartman <gregkh@suse.de>, Kyungmin Park <kyungmin.park@samsung.com>, linux-pm@lists.linux-foundation.org, Thomas Gleixner <tglx@linutronix.de>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 31, 2011 at 12:29 AM, MyungJoo Ham <myungjoo.ham@samsung.com> w=
rote:
[snip]
> +/**
> + * get_devfreq() - find devfreq struct. a wrapped find_device_devfreq()
> + * =A0 =A0 =A0 =A0 =A0 =A0 with mutex protection. exported for governors
> + * @dev: =A0 =A0 =A0 device pointer used to lookup device devfreq.
> + */
> +struct devfreq *get_devfreq(struct device *dev)
> +{
> + =A0 =A0 =A0 struct devfreq *ret;
> +
> + =A0 =A0 =A0 mutex_lock(&devfreq_list_lock);
> + =A0 =A0 =A0 ret =3D find_device_devfreq(dev);
> + =A0 =A0 =A0 mutex_unlock(&devfreq_list_lock);

You prevent changes to the devfreq list while searching (good) but
after returning the pointer there is no protection from that item
being removed from the list.  Generally "get" and "put" functions do
more than just return a pointer: get functions often increment a
refcount, or hold a lock.  The put function will decrement the
refcount or release the lock.  Maybe you want something like the
following:

mutex_lock(&devfreq_list_lock);
ret =3D find_device_devfreq(dev);
mutex_lock(&devfreq->lock);
mutex_unlock(&devfreq_list_lock);

Then you need a corresponding put which does the mutex_unlock(&devfreq->loc=
k).

It looks like the only consumers of get_devfreq are the sysfs
show/store interfaces, which immediately hold devfreq->lock, so the
above proposal certainly makes fits the existing use case.

Also CPUfreq's "cpufreq_get" function does a nice job of protecting
the object from getting freed with a rw_semaphore.  It is a bit more
"complicated" but makes for good reading.

> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/**
> + * devfreq_do() - Check the usage profile of a given device and configure
> + * =A0 =A0 =A0 =A0 =A0 =A0 frequency and voltage accordingly
> + * @devfreq: =A0 devfreq info of the given device
> + */
> +static int devfreq_do(struct devfreq *devfreq)
> +{
> + =A0 =A0 =A0 struct opp *opp;
> + =A0 =A0 =A0 unsigned long freq;
> + =A0 =A0 =A0 int err;
> +

Put the mutex_is_locked check here?  See more below.

> + =A0 =A0 =A0 err =3D devfreq->governor->get_target_freq(devfreq, &freq);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 opp =3D opp_find_freq_ceil(devfreq->dev, &freq);
> + =A0 =A0 =A0 if (opp =3D=3D ERR_PTR(-ENODEV))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 opp =3D opp_find_freq_floor(devfreq->dev, &=
freq);
> +
> + =A0 =A0 =A0 if (IS_ERR(opp))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return PTR_ERR(opp);
> +
> + =A0 =A0 =A0 if (devfreq->previous_freq =3D=3D freq)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> +
> + =A0 =A0 =A0 err =3D devfreq->profile->target(devfreq->dev, opp);
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 devfreq->previous_freq =3D freq;
> + =A0 =A0 =A0 return 0;
> +}
> +
> +/**
> + * update_devfreq() - Notify that the device OPP or frequency requirement
> + * =A0 =A0 =A0 =A0 =A0 =A0 has been changed. This function is exported f=
or governors.
> + * @devfreq: =A0 the devfreq instance.
> + *
> + * Note: lock devfreq->lock before calling update_devfreq
> + */
> +int update_devfreq(struct devfreq *devfreq)
> +{
> + =A0 =A0 =A0 int err =3D 0;
> +
> + =A0 =A0 =A0 if (!mutex_is_locked(&devfreq->lock)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 WARN(true, "devfreq->lock must be locked by=
 the caller.\n");
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Reevaluate the proper frequency */
> + =A0 =A0 =A0 err =3D devfreq_do(devfreq);
> + =A0 =A0 =A0 return err;
> +}
> +
> +/**
> + * devfreq_update() - Notify that the device OPP has been changed.
> + * @dev: =A0 =A0 =A0 the device whose OPP has been changed.
> + *
> + * Called by OPP notifier.
> + */
> +static int devfreq_update(struct notifier_block *nb, unsigned long type,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 void *devp)
> +{
> + =A0 =A0 =A0 struct devfreq *devfreq =3D container_of(nb, struct devfreq=
, nb);
> + =A0 =A0 =A0 int ret;
> +
> + =A0 =A0 =A0 mutex_lock(&devfreq->lock);
> + =A0 =A0 =A0 ret =3D update_devfreq(devfreq);
> + =A0 =A0 =A0 mutex_unlock(&devfreq->lock);

The whole devfreq_update/update_devfreq pairing is redundant.
update_devfreq's purpose is to make sure the lock is held before going
further, and the only caller of update_devfreq is devfreq_update which
always holds the lock.

This still doesn't stop a bad driver writer from just calling
devfreq_do with an extern.  Perhaps the lock detection should be moved
into devfreq_do and update_devfreq should go away?

> +
> + =A0 =A0 =A0 return ret;
> +}
> +
> +/**
> + * devfreq_monitor() - Periodically run devfreq_do()
> + * @work: the work struct used to run devfreq_monitor periodically.
> + *
> + */
> +static void devfreq_monitor(struct work_struct *work)
> +{
> + =A0 =A0 =A0 static unsigned long last_polled_at;
> + =A0 =A0 =A0 struct devfreq *devfreq, *tmp;
> + =A0 =A0 =A0 int error;
> + =A0 =A0 =A0 unsigned long jiffies_passed;
> + =A0 =A0 =A0 unsigned long next_jiffies =3D ULONG_MAX, now =3D jiffies;
> +
> + =A0 =A0 =A0 /* Initially last_polled_at =3D 0, polling every device at =
bootup */
> + =A0 =A0 =A0 jiffies_passed =3D now - last_polled_at;
> + =A0 =A0 =A0 last_polled_at =3D now;
> + =A0 =A0 =A0 if (jiffies_passed =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 jiffies_passed =3D 1;
> +
> + =A0 =A0 =A0 mutex_lock(&devfreq_list_lock);

Should not lock the list here.  If we lock the list for all major
operations, it nullifies the performance benefit of having a mutex in
struct devfreq.

> +
> + =A0 =A0 =A0 list_for_each_entry_safe(devfreq, tmp, &devfreq_list, node)=
 {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_lock(&devfreq->lock);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (devfreq->next_polling =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&devfreq->lock=
);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Reduce more next_polling if devfreq_wq=
 took an extra
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* delay. (i.e., CPU has been idled.)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (devfreq->next_polling <=3D jiffies_pass=
ed) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 error =3D devfreq_do(devfre=
q);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Remove a devfreq with an=
 error. */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (error && error !=3D -EA=
GAIN) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 dev_err(dev=
freq->dev, "Due to devfreq_do error(%d), devfreq(%s) is removed from the de=
vice\n",
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 error, devfreq->governor->name);
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 list_del(&d=
evfreq->node);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unloc=
k(&devfreq->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(devfr=
eq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;

Should this error handling also unregister the OPP notifier?  This
code duplicates portions of devfreq_remove_device.  I propose instead
here we do the following:

mutex_unlock(&devfreq->lock);
_devfreq_remove_lock(devfreq);
/* this locks the list first,
 * then locks devfreq->lock,
 * then does the house cleaning
 */
continue;

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfreq->next_polling =3D d=
evfreq->polling_jiffies;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* No more polling required=
 (polling_ms changed) */
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (devfreq->next_polling =
=3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unloc=
k(&devfreq->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 continue;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfreq->next_polling -=3D =
jiffies_passed;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 next_jiffies =3D (next_jiffies > devfreq->n=
ext_polling) ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfreq->ne=
xt_polling : next_jiffies;
> +
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&devfreq->lock);
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 if (next_jiffies > 0 && next_jiffies < ULONG_MAX) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 polling =3D true;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 queue_delayed_work(devfreq_wq, &devfreq_wor=
k, next_jiffies);
> + =A0 =A0 =A0 } else {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 polling =3D false;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mutex_unlock(&devfreq_list_lock);

Again, list should not be locked over this whole function.  It blocks
other unrelated devfreq devices from scaling.

> +}

[snip]

> +/**
> + * devfreq_remove_device() - Remove devfreq feature from a device.
> + * @device: =A0 =A0the device to remove devfreq feature.
> + */
> +int devfreq_remove_device(struct device *dev)

Why does this take a struct device*?  Shouldn't it be a struct devfreq*?

If there is a case for removing a devfreq device with only struct
device* as input, how about:

int devfreq_remove_device(struct device *dev)
{
    struct devfreq *devfreq;
    mutex_lock(&devfreq_list_lock);
    devfreq =3D find_device_devfreq(dev);
    mutex_unlock(&devfreq_list_lock);

    return _devfreq_remove_device(struct devfreq *df);
    /* _devfreq_remove_device does the real work and can also be
called from devfreq_monitor */
}

Regards,
Mike

> +{
> + =A0 =A0 =A0 struct devfreq *devfreq;
> + =A0 =A0 =A0 struct srcu_notifier_head *nh;
> + =A0 =A0 =A0 int err =3D 0;
> +
> + =A0 =A0 =A0 if (!dev)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -EINVAL;
> +
> + =A0 =A0 =A0 mutex_lock(&devfreq_list_lock);
> + =A0 =A0 =A0 devfreq =3D find_device_devfreq(dev);
> + =A0 =A0 =A0 if (IS_ERR(devfreq)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(devfreq);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 mutex_lock(&devfreq->lock);
> + =A0 =A0 =A0 nh =3D opp_get_notifier(dev);
> + =A0 =A0 =A0 if (IS_ERR(nh)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 err =3D PTR_ERR(nh);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex_unlock(&devfreq->lock);
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 list_del(&devfreq->node);
> +
> + =A0 =A0 =A0 if (devfreq->governor->exit)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 devfreq->governor->exit(devfreq);
> +
> + =A0 =A0 =A0 srcu_notifier_chain_unregister(nh, &devfreq->nb);
> + =A0 =A0 =A0 mutex_unlock(&devfreq->lock);
> + =A0 =A0 =A0 kfree(devfreq);
> +out:
> + =A0 =A0 =A0 mutex_unlock(&devfreq_list_lock);
> + =A0 =A0 =A0 return 0;
> +}
[snip]
