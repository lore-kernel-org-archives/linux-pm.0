From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 07/15] PM QoS: add a global notification
 mechanism for the device constraints
Date: Tue, 16 Aug 2011 11:58:38 +0200
Message-ID: <CAORVsuUNxCN7+KZnpJT5Urd07cB+raX6e23ah_9Mp8M07SAyLw__39425.1238358722$1313488882$gmane$org@mail.gmail.com>
References: <1313075212-8366-1-git-send-email-j-pihet@ti.com>
	<1313075212-8366-8-git-send-email-j-pihet@ti.com>
	<201108142350.42260.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201108142350.42260.rjw@sisk.pl>
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
Cc: markgross@thegnar.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

2011/8/14 Rafael J. Wysocki <rjw@sisk.pl>:
> Hi,
>
> There is some code duplication in this patch that should better be
> avoided (details below).
>
> On Thursday, August 11, 2011, jean.pihet@newoldbits.com wrote:
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> Add a global notification chain that gets called upon changes to the
>> aggregated constraint value for any device.
>> The notification callbacks are passing the full constraint request data
>> in order for the callees to have access to it. The current use is for the
>> platform low-level code to access the target device of the constraint.
>>
...

>
> The following code:
>
>> + =A0 =A0 /*
>> + =A0 =A0 =A0* Update constraints list and call the per-device callbacks=
 if needed
>> + =A0 =A0 =A0*/
>> + =A0 =A0 ret =3D pm_qos_update_target(dev->power.constraints,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0&req->n=
ode, PM_QOS_ADD_REQ, value);
>> +
>> + =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 /* Call the global callbacks if needed */
>> + =A0 =A0 =A0 =A0 =A0 =A0 curr_value =3D pm_qos_read_value(req->dev->pow=
er.constraints);
>> + =A0 =A0 =A0 =A0 =A0 =A0 blocking_notifier_call_chain(&dev_pm_notifiers,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0(unsigned long)curr_value,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0req);
>> + =A0 =A0 }
>
> is used in dev_pm_qos_update_request() and dev_pm_qos_remove_request()
> with the only difference being the command given to pm_qos_update_target(=
).
> This asks for a common function, eg. dev_pm_qos_update_target(), containi=
ng
> that code that will be called by all of them (and, apparently, by
> dev_pm_qos_constraints_destroy()).
Ok that makes the code cleaner.

>
> ...
>> @@ -250,9 +329,18 @@ void dev_pm_qos_constraints_destroy(struct device *=
dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* Update constraints list=
 and call the per-device
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0* callbacks if needed
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*/
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pm_qos_update_target(req->dev-=
>power.constraints,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0&req->node, PM_QOS_REMOVE_REQ,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0PM_QOS_DEFAULT_VALUE);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret |=3D pm_qos_update_target(=
req->dev->power.constraints,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 &req->node,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 PM_QOS_REMOVE_REQ,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 PM_QOS_DEFAULT_VALUE);
>
> I'm not sure why you're using the binary or operator here. =A0Shouldn't t=
hat be
> a simple assignment?
>
>> +
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (ret) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* Call the global callbacks i=
f needed */
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 curr_value =3D dev->power.cons=
traints->default_value;
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 blocking_notifier_call_chain(&=
dev_pm_notifiers,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0(unsigned long)curr_value,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0req);
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
In the sake of optimization I had a single return value that
aggregates the return values of the calls target_value and calls the
global notifier callbacks _only once_.

As you suggested it is better to use the common update code, which
makes the code cleaner but also removes this optimization.

>>
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(dev->power.constraints->notifiers);
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 kfree(dev->power.constraints);
>
> Thanks,
> Rafael
>

Regards,
Jean
