From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 05/13] PM: QoS: support the dynamic insertion
 and removal of devices
Date: Tue, 2 Aug 2011 12:07:38 +0200
Message-ID: <CAORVsuVrH-tL5S-yRMzauMRvpvEE9v1_ZMDDDdsHdJBGSZW+oA__20551.6370166608$1312279718$gmane$org@mail.gmail.com>
References: <1311841821-10252-1-git-send-email-j-pihet@ti.com>
	<1311841821-10252-6-git-send-email-j-pihet@ti.com>
	<201107310038.30710.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107310038.30710.rjw@sisk.pl>
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
Cc: markgross@thegnar.org, broonie@opensource.wolfsonmicro.com, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

Rafael,

2011/7/31 Rafael J. Wysocki <rjw@sisk.pl>:
> On Thursday, July 28, 2011, jean.pihet@newoldbits.com wrote:
...

>> @@ -113,6 +109,8 @@ void device_pm_remove(struct device *dev)
>> =A0{
>> =A0 =A0 =A0 pr_debug("PM: Removing info for %s:%s\n",
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0dev->bus ? dev->bus->name : "No Bus", dev=
_name(dev));
>> + =A0 =A0 /* Call PM QoS to de-init the per-device latency constraints */
>> + =A0 =A0 pm_qos_dev_constraints_deinit(dev);
>
> I'd call this function "dev_pm_qos_constraints_destroy()" (and the previo=
us
> one "dev_pm_qos_constraints_init()" for consistency).
Ok

...
>> +/* Called from the device PM subsystem at device init */
>> +void pm_qos_dev_constraints_init(struct device *dev)
>> +{
>> + =A0 =A0 plist_head_init(&dev->power.latency_constraints.list, &dev->po=
wer.lock);
>> + =A0 =A0 dev->power.latency_constraints.target_value =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 PM_QOS_DEV_LAT_DEFAULT_VALUE;
>> + =A0 =A0 dev->power.latency_constraints.default_value =3D
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 PM_QOS_DEV_LAT_DEFAULT_VALUE;
>> + =A0 =A0 dev->power.latency_constraints.type =3D PM_QOS_MIN;
>> + =A0 =A0 dev->power.latency_constraints_init =3D 1;
>
> You could avoid adding this field if there were a PM_QOS_UNINITIALIZED
> (or PM_QOS_UNKNOWN) type.
>
> And if you _really_ want to have a separate field, why don't you put it
> into latency_constraints ?
Ok I remove latency_constraints_init and use the type field instead.

...
>
> Thanks,
> Rafael

Thanks,
Jean
