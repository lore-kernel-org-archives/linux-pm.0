From: "Turquette, Mike" <mturquette@ti.com>
Subject: Re: [PATCH v6 1/4] PM / OPP: Add OPP availability change
	notifier.
Date: Thu, 18 Aug 2011 15:06:03 -0700
Message-ID: <CAJOA=zO-MVEzC9bceapJZ-UH=i8xP=VRTD=f=LzZibW3rwmqsw@mail.gmail.com>
References: <1313663262-15308-1-git-send-email-myungjoo.ham@samsung.com>
	<1313663262-15308-2-git-send-email-myungjoo.ham@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1313663262-15308-2-git-send-email-myungjoo.ham@samsung.com>
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

On Thu, Aug 18, 2011 at 3:27 AM, MyungJoo Ham <myungjoo.ham@samsung.com> wr=
ote:
> The patch enables to register notifier_block for an OPP-device in order
> to get notified for any changes in the availability of OPPs of the
> device. For example, if a new OPP is inserted or enable/disable status
> of an OPP is changed, the notifier is executed.
>
> This enables the usage of opp_add, opp_enable, and opp_disable to
> directly take effect with any connected entities such as CPUFREQ or
> DEVFREQ.
>
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>
> ---
> Added at devfreq patch set v6 replacing devfreq_update calls at OPP.
> ---
> =A0drivers/base/power/opp.c | =A0 28 ++++++++++++++++++++++++++++
> =A0include/linux/opp.h =A0 =A0 =A0| =A0 12 ++++++++++++
> =A02 files changed, 40 insertions(+), 0 deletions(-)
>
> diff --git a/drivers/base/power/opp.c b/drivers/base/power/opp.c
> index b23de18..39e16c3 100644
> --- a/drivers/base/power/opp.c
> +++ b/drivers/base/power/opp.c
> @@ -73,6 +73,7 @@ struct opp {
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 RCU usage: nodes are not modified in the lis=
t of device_opp,
> =A0* =A0 =A0 =A0 =A0 =A0 =A0 however addition is possible and is secured =
by dev_opp_list_lock
> =A0* @dev: =A0 =A0 =A0 device pointer
> + * @head: =A0 =A0 =A0notifier head to notify the OPP availability change=
s.
> =A0* @opp_list: =A0list of opps
> =A0*
> =A0* This is an internal data structure maintaining the link to opps atta=
ched to
> @@ -83,6 +84,8 @@ struct device_opp {
> =A0 =A0 =A0 =A0struct list_head node;
>
> =A0 =A0 =A0 =A0struct device *dev;
> + =A0 =A0 =A0 struct srcu_notifier_head head;
> +
> =A0 =A0 =A0 =A0struct list_head opp_list;
> =A0};
>
> @@ -404,6 +407,7 @@ int opp_add(struct device *dev, unsigned long freq, u=
nsigned long u_volt)
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev_opp->dev =3D dev;
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 srcu_init_notifier_head(&dev_opp->head);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0INIT_LIST_HEAD(&dev_opp->opp_list);
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0/* Secure the device list modification */
> @@ -428,6 +432,11 @@ int opp_add(struct device *dev, unsigned long freq, =
unsigned long u_volt)
> =A0 =A0 =A0 =A0list_add_rcu(&new_opp->node, head);
> =A0 =A0 =A0 =A0mutex_unlock(&dev_opp_list_lock);
>
> + =A0 =A0 =A0 /*
> + =A0 =A0 =A0 =A0* Notify the changes in the availability of the operable
> + =A0 =A0 =A0 =A0* frequency/voltage list.
> + =A0 =A0 =A0 =A0*/
> + =A0 =A0 =A0 srcu_notifier_call_chain(&dev_opp->head, OPP_EVENT_ADD, new=
_opp);
> =A0 =A0 =A0 =A0return 0;
> =A0}
>
> @@ -504,6 +513,11 @@ static int opp_set_availability(struct device *dev, =
unsigned long freq,
> =A0 =A0 =A0 =A0mutex_unlock(&dev_opp_list_lock);
> =A0 =A0 =A0 =A0synchronize_rcu();

I'm not an RCU expert.  Is the above synchronize_rcu call still needed
with the addition of the srcu_notifier_call_chain below?  The newly
added src_notifier_call_chain will result in the following call graph:

srcu_notifier_call_chain
 -> __srcu_notifier_call_chain
    -> srcu_read_lock
        -> __srcu_read_lock
            -> srcu_barrier

>
> + =A0 =A0 =A0 /* Notify the change of the OPP availability */
> + =A0 =A0 =A0 srcu_notifier_call_chain(&dev_opp->head, availability_req ?
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0OPP_EVEN=
T_ENABLE : OPP_EVENT_DISABLE,

Nitpick: I'm not a fan of conditional statements as func parameters.

> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0new_opp);
> +
> =A0 =A0 =A0 =A0/* clean up old opp */
> =A0 =A0 =A0 =A0new_opp =3D opp;
> =A0 =A0 =A0 =A0goto out;
> @@ -512,6 +526,7 @@ unlock:
> =A0 =A0 =A0 =A0mutex_unlock(&dev_opp_list_lock);
> =A0out:
> =A0 =A0 =A0 =A0kfree(new_opp);
> +

Nitpick: unnecessary whitespace addition.

> =A0 =A0 =A0 =A0return r;
> =A0}
>
> @@ -643,3 +658,16 @@ void opp_free_cpufreq_table(struct device *dev,
> =A0 =A0 =A0 =A0*table =3D NULL;
> =A0}
> =A0#endif =A0 =A0 =A0 =A0 /* CONFIG_CPU_FREQ */
> +
> +/** opp_get_notifier() - find notifier_head of the device with opp
> + * @dev: =A0 =A0 =A0 device pointer used to lookup device OPPs.
> + */
> +struct srcu_notifier_head *opp_get_notifier(struct device *dev)
> +{
> + =A0 =A0 =A0 struct device_opp *dev_opp =3D find_device_opp(dev);
> +
> + =A0 =A0 =A0 if (IS_ERR(dev_opp))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 return ERR_PTR(PTR_ERR(dev_opp)); /* matchi=
ng type */
> +
> + =A0 =A0 =A0 return &dev_opp->head;
> +}
> diff --git a/include/linux/opp.h b/include/linux/opp.h
> index 7020e97..53d4538 100644
> --- a/include/linux/opp.h
> +++ b/include/linux/opp.h
> @@ -16,9 +16,14 @@
>
> =A0#include <linux/err.h>
> =A0#include <linux/cpufreq.h>
> +#include <linux/notifier.h>
>
> =A0struct opp;
>
> +enum opp_event {
> + =A0 =A0 =A0 OPP_EVENT_ADD, OPP_EVENT_ENABLE, OPP_EVENT_DISABLE, OPP_EVE=
NT_MAX

I don't see OPP_EVENT_MAX used anywhere else in the code.  What is it's pur=
pose?

Regards,
Mike

> +};
> +
> =A0#if defined(CONFIG_PM_OPP)
>
> =A0unsigned long opp_get_voltage(struct opp *opp);
> @@ -40,6 +45,8 @@ int opp_enable(struct device *dev, unsigned long freq);
>
> =A0int opp_disable(struct device *dev, unsigned long freq);
>
> +struct srcu_notifier_head *opp_get_notifier(struct device *dev);
> +
> =A0#else
> =A0static inline unsigned long opp_get_voltage(struct opp *opp)
> =A0{
> @@ -89,6 +96,11 @@ static inline int opp_disable(struct device *dev, unsi=
gned long freq)
> =A0{
> =A0 =A0 =A0 =A0return 0;
> =A0}
> +
> +struct srcu_notifier_head *opp_get_notifier(struct device *dev)
> +{
> + =A0 =A0 =A0 return ERR_PTR(-EINVAL);
> +}
> =A0#endif =A0 =A0 =A0 =A0 /* CONFIG_PM */
>
> =A0#if defined(CONFIG_CPU_FREQ) && defined(CONFIG_PM_OPP)
> --
> 1.7.4.1
>
>
