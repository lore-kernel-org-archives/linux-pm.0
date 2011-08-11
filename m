From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v5 2/3] PM / DEVFREQ: add basic governors
Date: Wed, 10 Aug 2011 18:35:14 -0700
Message-ID: <CAJOA=zMJogYGS9xtcUmU3_a3QmBTy_wz7pf1tk6KUtf4cT1J=A@mail.gmail.com>
References: <1312794188-9823-1-git-send-email-myungjoo.ham@samsung.com>
	<1312794188-9823-3-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1312794188-9823-3-git-send-email-myungjoo.ham@samsung.com>
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

On Mon, Aug 8, 2011 at 2:03 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wro=
te:
> Four CPUFREQ-like governors are provided as examples.
>
> powersave: use the lowest frequency possible. The user (device) should
> set the polling_ms as 0 because polling is useless for this governor.
>
> performance: use the highest freqeuncy possible. The user (device)
> should set the polling_ms as 0 because polling is useless for this
> governor.

Polling is the only practical use for devfreq, assuming a QoS API
exists for DVFS.  As such powersave and performance governors should
be removed.

> userspace: use the user specified frequency stored at
> devfreq.user_set_freq. With sysfs support in the following patch, a user
> may set the value with the sysfs interface.
>
> simple_ondemand: simplified version of CPUFREQ's ONDEMAND governor.

I won't repeate everything from patch 1 of this series, but the
governors should implement the queue/loop logic in the same way that
CPUfreq does, and the individual devices should have their own
delayed_work.

> When a user updates OPP entries (enable/disable/add), OPP framework
> automatically notifies DEVFREQ to update operating frequency
> accordingly. Thus, DEVFREQ users (device drivers) do not need to update

It would be nice if OPP library "notified" devfreq but it does not
today.  OPP library needs notifiers and devfreq can provide handlers
for them.

> DEVFREQ manually with OPP entry updates or set polling_ms for powersave
> , performance, userspace, or any other "static" governors.
>
> Note that these are given only as basic examples for governors and any
> devices with DEVFREQ may implement their own governors with the drivers
> and use them.
>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> ---
> Changes from v4:
> - Added userspace governor
>
> Changes from v3:
> - Bugfixes on simple-ondemand governor (divide by zero / overflow)
> - Style fixes
> - Give names to governors
> ---
> =A0drivers/base/power/devfreq.c | =A0100 ++++++++++++++++++++++++++++++++=
++++++++++
> =A0include/linux/devfreq.h =A0 =A0 =A0| =A0 =A08 +++
> =A02 files changed, 108 insertions(+), 0 deletions(-)

Governors should be split out into their own file, especially since
they need to grow to include polling/queueing logic.

>
> diff --git a/drivers/base/power/devfreq.c b/drivers/base/power/devfreq.c
> index 6f4bd3a..c53bca9 100644
> --- a/drivers/base/power/devfreq.c
> +++ b/drivers/base/power/devfreq.c
> @@ -301,3 +301,103 @@ static int __init devfreq_init(void)
> =A0 =A0 =A0 =A0return 0;
> =A0}
> =A0late_initcall(devfreq_init);
> +
> +static int devfreq_powersave_func(struct devfreq *df,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 unsigne=
d long *freq)
> +{
> + =A0 =A0 =A0 *freq =3D 0; /* devfreq_do will run "ceiling" to 0 */
> + =A0 =A0 =A0 return 0;
> +}
> +
> +struct devfreq_governor devfreq_powersave =3D {
> + =A0 =A0 =A0 .name =3D "powersave",
> + =A0 =A0 =A0 .get_target_freq =3D devfreq_powersave_func,
> +};
> +
> +static int devfreq_performance_func(struct devfreq *df,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 uns=
igned long *freq)
> +{
> + =A0 =A0 =A0 *freq =3D UINT_MAX; /* devfreq_do will run "floor" */
> + =A0 =A0 =A0 return 0;
> +}
> +
> +struct devfreq_governor devfreq_performance =3D {
> + =A0 =A0 =A0 .name =3D "performance",
> + =A0 =A0 =A0 .get_target_freq =3D devfreq_performance_func,
> +};
> +
> +static int devfreq_userspace_func(struct devfreq *df, unsigned long *fre=
q)
> +{
> + =A0 =A0 =A0 if (df->user_set_freq =3D=3D 0)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *freq =3D df->previous_freq; /* No user fre=
q specified yet */
> + =A0 =A0 =A0 else
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *freq =3D df->user_set_freq;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +struct devfreq_governor devfreq_userspace =3D {
> + =A0 =A0 =A0 .name =3D "userspace",
> + =A0 =A0 =A0 .get_target_freq =3D devfreq_userspace_func,
> +};
> +
> +/* Constants for DevFreq-Simple-Ondemand (DFSO) */
> +#define DFSO_UPTHRESHOLD =A0 =A0 =A0 (90)
> +#define DFSO_DOWNDIFFERENCTIAL (5)
> +static int devfreq_simple_ondemand_func(struct devfreq *df,
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0=
 =A0 unsigned long *freq)
> +{
> + =A0 =A0 =A0 struct devfreq_dev_status stat;
> + =A0 =A0 =A0 int err =3D df->profile->get_dev_status(df->dev, &stat);
> + =A0 =A0 =A0 unsigned long long a, b;
> +
> + =A0 =A0 =A0 if (err)
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return err;
> +
> + =A0 =A0 =A0 /* Assume MAX if it is going to be divided by zero */
> + =A0 =A0 =A0 if (stat.total_time =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *freq =3D UINT_MAX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Prevent overflow */
> + =A0 =A0 =A0 if (stat.busy_time >=3D (1 << 24) || stat.total_time >=3D (=
1 << 24)) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 stat.busy_time >>=3D 7;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 stat.total_time >>=3D 7;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Set MAX if it's busy enough */
> + =A0 =A0 =A0 if (stat.busy_time * 100 >
> + =A0 =A0 =A0 =A0 =A0 stat.total_time * DFSO_UPTHRESHOLD) {

Thresholds should not be constants, but should be tuneable parameters,
per-device.  This is yet another reason for revising the existing
relationship between devfreq core code, governors and devices.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *freq =3D UINT_MAX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Set MAX if we do not know the initial frequency */
> + =A0 =A0 =A0 if (stat.current_frequency =3D=3D 0) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *freq =3D UINT_MAX;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Keep the current frequency */
> + =A0 =A0 =A0 if (stat.busy_time * 100 >
> + =A0 =A0 =A0 =A0 =A0 stat.total_time * (DFSO_UPTHRESHOLD - DFSO_DOWNDIFF=
ERENCTIAL)) {

Same as above.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 *freq =3D stat.current_frequency;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return 0;
> + =A0 =A0 =A0 }
> +
> + =A0 =A0 =A0 /* Set the desired frequency based on the load */
> + =A0 =A0 =A0 a =3D stat.busy_time;
> + =A0 =A0 =A0 a *=3D stat.current_frequency;
> + =A0 =A0 =A0 b =3D div_u64(a, stat.total_time);
> + =A0 =A0 =A0 b *=3D 100;
> + =A0 =A0 =A0 b =3D div_u64(b, (DFSO_UPTHRESHOLD - DFSO_DOWNDIFFERENCTIAL=
 / 2));

Same as above.

Regards,
Mike

> + =A0 =A0 =A0 *freq =3D (unsigned long) b;
> +
> + =A0 =A0 =A0 return 0;
> +}
> +
> +struct devfreq_governor devfreq_simple_ondemand =3D {
> + =A0 =A0 =A0 .name =3D "simple_ondemand",
> + =A0 =A0 =A0 .get_target_freq =3D devfreq_simple_ondemand_func,
> +};
> diff --git a/include/linux/devfreq.h b/include/linux/devfreq.h
> index 6ec630b..7131d2a 100644
> --- a/include/linux/devfreq.h
> +++ b/include/linux/devfreq.h
> @@ -57,6 +57,8 @@ struct devfreq_governor {
> =A0* @next_polling =A0 =A0 =A0 the number of remaining "devfreq_monitor" =
executions to
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 reevaluate frequency/voltage=
 of the device. Set by
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 profile's polling_ms interva=
l.
> + * @user_set_freq =A0 =A0 =A0User specified adequete frequency value (th=
ru sysfs
> + * =A0 =A0 =A0 =A0 =A0 =A0 interface). Governors may and may not use thi=
s value.
> =A0* @data =A0 =A0 =A0 Private data of the governor. The devfreq framewor=
k does not
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 touch this.
> =A0*
> @@ -72,6 +74,7 @@ struct devfreq {
> =A0 =A0 =A0 =A0unsigned long previous_freq;
> =A0 =A0 =A0 =A0unsigned int next_polling;
>
> + =A0 =A0 =A0 unsigned long user_set_freq; /* governors may ignore this. =
*/
> =A0 =A0 =A0 =A0void *data; /* private data for governors */
> =A0};
>
> @@ -81,6 +84,11 @@ extern int devfreq_add_device(struct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct devfreq_govern=
or *governor);
> =A0extern int devfreq_remove_device(struct device *dev);
> =A0extern int devfreq_update(struct device *dev);
> +
> +extern struct devfreq_governor devfreq_powersave;
> +extern struct devfreq_governor devfreq_performance;
> +extern struct devfreq_governor devfreq_userspace;
> +extern struct devfreq_governor devfreq_simple_ondemand;
> =A0#else /* !CONFIG_PM_DEVFREQ */
> =A0static int devfreq_add_device(struct device *dev,
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 struct devfreq_dev_pr=
ofile *profile,
> --
> 1.7.4.1
>
>
