From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 3/5] PM / QoS: Add function
	dev_pm_qos_read_value()
Date: Mon, 5 Sep 2011 09:44:49 +0200
Message-ID: <CAORVsuWKFK3zc9XAwK37QwEw4g3VfuhcUb=rZUSzcyjz2NJcHQ__2990.01413300193$1315208764$gmane$org@mail.gmail.com>
References: <201108310017.03103.rjw@sisk.pl> <201109020007.22743.rjw@sisk.pl>
	<CAORVsuVAzc8Q2tG0-WW+96Ad9GhR5OCq2bAuweggs1rimFMcqg@mail.gmail.com>
	<201109030155.28031.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201109030155.28031.rjw@sisk.pl>
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

On Sat, Sep 3, 2011 at 1:55 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Friday, September 02, 2011, Jean Pihet wrote:
>> On Fri, Sep 2, 2011 at 12:07 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
...

>> >> > =A0*/
>> >> > =A0int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos=
_request *req,
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 s32 value)
>> >> > @@ -195,28 +219,35 @@ int dev_pm_qos_add_request(struct device
>> >> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0return -EINVAL;
>> >> > =A0 =A0 =A0 =A0}
>> >> >
>> >> > - =A0 =A0 =A0 mutex_lock(&dev_pm_qos_mtx);
>> >> > =A0 =A0 =A0 =A0req->dev =3D dev;
>> >> >
>> >> > - =A0 =A0 =A0 /* Return if the device has been removed */
>> >> > - =A0 =A0 =A0 if (req->dev->power.constraints_state =3D=3D DEV_PM_Q=
OS_NO_DEVICE) {
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D -ENODEV;
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> > - =A0 =A0 =A0 }
>> >> > + =A0 =A0 =A0 device_pm_lock();
>> >> > + =A0 =A0 =A0 mutex_lock(&dev_pm_qos_mtx);
>> >> >
>> >> > - =A0 =A0 =A0 /*
>> >> > - =A0 =A0 =A0 =A0* Allocate the constraints data on the first call =
to add_request,
>> >> > - =A0 =A0 =A0 =A0* i.e. only if the data is not already allocated a=
nd if the device has
>> >> > - =A0 =A0 =A0 =A0* not been removed
>> >> > - =A0 =A0 =A0 =A0*/
>> >> > - =A0 =A0 =A0 if (dev->power.constraints_state =3D=3D DEV_PM_QOS_DE=
VICE_PRESENT)
>> >> > - =A0 =A0 =A0 =A0 =A0 =A0 =A0 ret =3D dev_pm_qos_constraints_alloca=
te(dev);
>> >> > + =A0 =A0 =A0 if (dev->power.constraints) {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_pm_unlock();
>> >> > + =A0 =A0 =A0 } else {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (list_empty(&dev->power.entry)) {
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 /* The device has bee=
n removed from the system. */
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 device_pm_unlock();
>> >> > + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 goto out;
>> >> 0 is silently returned in case the device has been removed. Is that
>> >> the intention?
>> >
>> > Pretty much it is. =A0Is that a problem?
>> I think the caller needs to know if the constraint has been applied
>> correctly or not.
>
> However, the removal of the device is a special case. =A0What would the c=
aller
> be supposed to do when it learned that the device had been removed while =
it had
> been trying to add a QoS constraing for it? =A0Not much I guess.
When the device is removed from the system the constraints list id
flushed and the requests are zero'ed using memset.
In that case the caller needs to be aware of that otherwise the next
call to the API will throw an error.

>
> Thanks,
> Rafael
>

Thanks,
Jean
