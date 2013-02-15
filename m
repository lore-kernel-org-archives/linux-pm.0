From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn-yOkvZcmFvRU@public.gmane.org>
Subject: Re: usb_wwan_write() called while device still being resumed
Date: Fri, 15 Feb 2013 12:05:08 +0100
Message-ID: <87r4khu9az.fsf@nemi.mork.no>
References: <511CBCE8.9070204@nvidia.com> <87ehgivlmg.fsf@nemi.mork.no>
	<511DF09F.3070401@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <511DF09F.3070401-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> (Alex Courbot's message of "Fri, 15
	Feb 2013 17:23:59 +0900")
Sender: linux-usb-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: USB list <linux-usb-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-pm@vger.kernel.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel@vger.kernel.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Alexandre Courbot <gnurou-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Alex Courbot <acourbot-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org> writes:

> Unfortunately it does not, and fails the same way. On the other hand,
> I do not see the issue when doing the following:
>
> diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_w=
wan.c
> index e4fad5e..1490029 100644
> --- a/drivers/usb/serial/usb_wwan.c
> +++ b/drivers/usb/serial/usb_wwan.c
> @@ -238,8 +238,6 @@ int usb_wwan_write(struct tty_struct *tty, struct
> usb_serial_port *port,
>                     usb_pipeendpoint(this_urb->pipe), i);
>
>                 err =3D
> usb_autopm_get_interface_async(port->serial->interface);
> -               if (err < 0)
> -                       break;
>
>                 /* send the data */
>                 memcpy(this_urb->transfer_buffer, buf, todo);
>
> After doing this I don't see this issue anymore. It looks wrong
> though. But it seems to work despite the obvious unbalance in autopm
> calls that results.
>
> If I understand you correctly, usb_wwan_write() failing here is not a
> problem in itself, and the ack should just be sent again later?

That was what I thought looking (obviously too) briefly through this.

Most errors from usb_autopm_get_interface_async will be translated to
EIO before being returned by serial_write.  I believe the userspace
application should deal with that.  But maybe it just gives up?  Should
we return EAGAIN or something instead?

I don't know.  I am pretty clueless about these things...

But looking again, trying to guess why it works fine if you just ignore
the error. I believe that is because you then end up hitting this until
the interface is fully resumed:

		if (intfdata->suspended) {
			usb_anchor_urb(this_urb, &portdata->delayed);
			spin_unlock_irqrestore(&intfdata->susp_lock, flags);
                }

>> that should not cause the modem to stop working.
>
> Actually it might also be that the network stack ends up in a bad
> state and remains stuck in it. I don't think the modem by itself is
> affected. All I observe is that no network traffic takes place after
> this. I'm not familiar enough with networking to make any stronger
> assumption.

> FWIW, when usb_autopm_get_interface_async() returns -EACCES, the powe=
r
> parameters of port->serial->interface->dev are as follows:
>
> disable_depth =3D 1
> is_suspended =3D 1
> runtime_status =3D 2 (RPM_SUSPENDED)

Yes, that makes pm_runtime_get() return -EACCES.

I am way out of my league here, but I wonder if pm_runtime_get()
shouldn't return -EINPROGRESS instead if there is a queued resume
request or an ongoing resume, regardless of disable_depth?

Maybe something like the completely untested:

diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.=
c
index 3148b10..38e19ba 100644
--- a/drivers/base/power/runtime.c
+++ b/drivers/base/power/runtime.c
@@ -512,6 +512,9 @@ static int rpm_resume(struct device *dev, int rpmfl=
ags)
 	else if (dev->power.disable_depth =3D=3D 1 && dev->power.is_suspended
 	    && dev->power.runtime_status =3D=3D RPM_ACTIVE)
 		retval =3D 1;
+	else if (rpmflags & RPM_ASYNC && dev->power.request_pending &&
+		 dev->power.request =3D=3D RPM_REQ_RESUME)
+		retval =3D -EINPROGRESS;
 	else if (dev->power.disable_depth > 0)
 		retval =3D -EACCES;
 	if (retval)
---
usb_autopm_get_interface_async() will interprete EINPROGRESS as success=
,
so that would prevent this problem.


Bj=C3=B8rn
--
To unsubscribe from this list: send the line "unsubscribe linux-usb" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
