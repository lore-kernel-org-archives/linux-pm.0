From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: [RFC] PM / Runtime: Make autosuspend_delay == 0 work as intended
Date: Mon, 02 Jun 2014 14:42:59 +0200
Message-ID: <87ppir4h4c.fsf@nemi.mork.no>
References: <1401704952-32046-1-git-send-email-bjorn@mork.no>
	<3312453.gOy4hhKZIh@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from canardo.mork.no ([148.122.252.1]:49314 "EHLO canardo.mork.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752246AbaFBMnG convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 2 Jun 2014 08:43:06 -0400
In-Reply-To: <3312453.gOy4hhKZIh@vostro.rjw.lan> (Rafael J. Wysocki's message
	of "Mon, 02 Jun 2014 14:14:45 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: linux-pm@vger.kernel.org, Alan Stern <stern@rowland.harvard.edu>

"Rafael J. Wysocki" <rjw@rjwysocki.net> writes:

> Alan has to see this in the first place.
>
> On Monday, June 02, 2014 12:29:12 PM Bj=C3=B8rn Mork wrote:
>> OK, I don't like the result I came up with here.  So I am sending th=
is
>> as an RFC in the hope that smarter people than me can come up with
>> something nicer. I hope the patch illustrates my problem:  While
>> trying do debug some runtime suspend issues in a driver, I temporari=
ly
>> set autosuspend to 0 to deliberately make it aggressive enough for m=
y
>> driver to fail. I was surprised to learn than this effectively
>> *disabled* autosuspend if the driver ever return -EBUSY from the
>> runtime suspend callback.
>
> That results from pm_runtime_autosuspend_expiration() always returnin=
g 0 in
> that case.

Yup.

>> I believe that is too unexpected to be
>> acceptable. Either we should not allow 0, or we should make it work
>> at least as well as 1.
>>=20
>>=20
>> Bj=C3=B8rn
>> 8<--------------
>> We should always reschedule if the driver runtime suspend callback
>> returns -EBUSY and the driver updated the last_busy time.  But if
>> autosuspend_delay is 0, then this cannot be detected because
>> pm_runtime_autosuspend_expiration() always returns 0.
>>=20
>> Fix by rescheduling if autosuspend_delay is 0.
>>=20
>> Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
>> ---
>>  drivers/base/power/runtime.c |    8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runti=
me.c
>> index 67c7938e430b..c52e630a2e54 100644
>> --- a/drivers/base/power/runtime.c
>> +++ b/drivers/base/power/runtime.c
>> @@ -421,6 +421,7 @@ static int rpm_suspend(struct device *dev, int r=
pmflags)
>>  {
>>  	int (*callback)(struct device *);
>>  	struct device *parent =3D NULL;
>> +	unsigned long retry_delay =3D 0;
>>  	int retval;
>> =20
>>  	trace_rpm_suspend(dev, rpmflags);
>> @@ -441,7 +442,7 @@ static int rpm_suspend(struct device *dev, int r=
pmflags)
>>  	/* If the autosuspend_delay time hasn't expired yet, reschedule. *=
/
>>  	if ((rpmflags & RPM_AUTO)
>>  	    && dev->power.runtime_status !=3D RPM_SUSPENDING) {
>> -		unsigned long expires =3D pm_runtime_autosuspend_expiration(dev);
>> +		unsigned long expires =3D pm_runtime_autosuspend_expiration(dev) =
+ retry_delay;
>> =20
>>  		if (expires !=3D 0) {
>>  			/* Pending requests need to be canceled. */
>> @@ -571,8 +572,11 @@ static int rpm_suspend(struct device *dev, int =
rpmflags)
>>  		 * reschedule another autosuspend.
>>  		 */
>>  		if ((rpmflags & RPM_AUTO) &&
>> -		    pm_runtime_autosuspend_expiration(dev) !=3D 0)
>> +		    (pm_runtime_autosuspend_expiration(dev) !=3D 0 ||
>> +		     ACCESS_ONCE(dev->power.autosuspend_delay) =3D=3D 0)) {
>> +			retry_delay++;
>>  			goto repeat;
>> +		}
>>  	} else {
>>  		pm_runtime_cancel_pending(dev);
>>  	}
>
> Well, as I said.
>
> Perhaps pm_runtime_autosuspend_expiration() could simply treat
> power.autosuspend_delay equal to 0 in a special way, but then what ab=
out
> power.autosuspend_delay equal to 1?

Is that going to cause similar problems? Hmm, I guess it is if the
callback takes so long that the timeout is reached when we get here?

In which cases do you *not* want to retry runtime suspend on -EBUSY fro=
m
the driver callback? If you don't retry, then the device will not
runtime suspend at all until the next time the driver updates last_busy=
=2E
And if the driver always is busy some time after such updates, then
runtime suspend is effectively disabled.

Should drivers just update last_busy more agressively, and make sure to
update it both when starting some hardware transaction and when
finishing it? That would make the suspend callback run again when the
hardware is not busy anymore, and would probably make stuff work withou=
t
any PM core changes.



Bj=C3=B8rn
