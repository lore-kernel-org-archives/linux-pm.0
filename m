From: Alex Courbot <acourbot@nvidia.com>
Subject: Re: usb_wwan_write() called while device still being resumed
Date: Sun, 17 Feb 2013 20:31:52 +0900
Message-ID: <5120BFA8.2000506@nvidia.com>
References: <511CBCE8.9070204@nvidia.com> <87ehgivlmg.fsf@nemi.mork.no> <511DF09F.3070401@nvidia.com> <87r4khu9az.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate03.nvidia.com ([216.228.121.140]:2704 "EHLO
	hqemgate03.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754164Ab3BQL3N convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sun, 17 Feb 2013 06:29:13 -0500
In-Reply-To: <87r4khu9az.fsf@nemi.mork.no>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>
Cc: USB list <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>

On 02/15/2013 08:05 PM, Bj=C3=B8rn Mork wrote:
> Alex Courbot <acourbot@nvidia.com> writes:
>
>> Unfortunately it does not, and fails the same way. On the other hand=
,
>> I do not see the issue when doing the following:
>>
>> diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_=
wwan.c
>> index e4fad5e..1490029 100644
>> --- a/drivers/usb/serial/usb_wwan.c
>> +++ b/drivers/usb/serial/usb_wwan.c
>> @@ -238,8 +238,6 @@ int usb_wwan_write(struct tty_struct *tty, struc=
t
>> usb_serial_port *port,
>>                      usb_pipeendpoint(this_urb->pipe), i);
>>
>>                  err =3D
>> usb_autopm_get_interface_async(port->serial->interface);
>> -               if (err < 0)
>> -                       break;
>>
>>                  /* send the data */
>>                  memcpy(this_urb->transfer_buffer, buf, todo);
>>
>> After doing this I don't see this issue anymore. It looks wrong
>> though. But it seems to work despite the obvious unbalance in autopm
>> calls that results.
>>
>> If I understand you correctly, usb_wwan_write() failing here is not =
a
>> problem in itself, and the ack should just be sent again later?
>
> That was what I thought looking (obviously too) briefly through this.
>
> Most errors from usb_autopm_get_interface_async will be translated to
> EIO before being returned by serial_write.  I believe the userspace
> application should deal with that.  But maybe it just gives up?  Shou=
ld
> we return EAGAIN or something instead?
>
> I don't know.  I am pretty clueless about these things...

Obviously not as much as I am. :) Checking what userspace is doing coul=
d=20
indeed be another trail.

> But looking again, trying to guess why it works fine if you just igno=
re
> the error. I believe that is because you then end up hitting this unt=
il
> the interface is fully resumed:
>
> 		if (intfdata->suspended) {
> 			usb_anchor_urb(this_urb, &portdata->delayed);
> 			spin_unlock_irqrestore(&intfdata->susp_lock, flags);
>                  }

Yes, this seems to be exactly what is happening.

> I am way out of my league here, but I wonder if pm_runtime_get()
> shouldn't return -EINPROGRESS instead if there is a queued resume
> request or an ongoing resume, regardless of disable_depth?
>
> Maybe something like the completely untested:
>
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtim=
e.c
> index 3148b10..38e19ba 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -512,6 +512,9 @@ static int rpm_resume(struct device *dev, int rpm=
flags)
>   	else if (dev->power.disable_depth =3D=3D 1 && dev->power.is_suspen=
ded
>   	    && dev->power.runtime_status =3D=3D RPM_ACTIVE)
>   		retval =3D 1;
> +	else if (rpmflags & RPM_ASYNC && dev->power.request_pending &&
> +		 dev->power.request =3D=3D RPM_REQ_RESUME)
> +		retval =3D -EINPROGRESS;
>   	else if (dev->power.disable_depth > 0)
>   		retval =3D -EACCES;
>   	if (retval)
> ---
> usb_autopm_get_interface_async() will interprete EINPROGRESS as succe=
ss,
> so that would prevent this problem.

That sounds sensefull indeed. If the interface is soon to be resumed,=20
there should be no reason for usb_autopm_get_interface_async() to fail.=
=20
Let's give this a try and bring the idea to the PM people if it works.

In any case thanks a lot for the help, it is extremely useful.
Alex.
