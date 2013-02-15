From: Alex Courbot <acourbot@nvidia.com>
Subject: Re: usb_wwan_write() called while device still being resumed
Date: Fri, 15 Feb 2013 17:23:59 +0900
Message-ID: <511DF09F.3070401@nvidia.com>
References: <511CBCE8.9070204@nvidia.com> <87ehgivlmg.fsf@nemi.mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hqemgate04.nvidia.com ([216.228.121.35]:15245 "EHLO
	hqemgate04.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753671Ab3BOIYE convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 15 Feb 2013 03:24:04 -0500
In-Reply-To: <87ehgivlmg.fsf@nemi.mork.no>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>
Cc: USB list <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>

Hi Bj=C3=B8rn, thanks for the reply!

On 02/15/2013 02:41 AM, Bj=C3=B8rn Mork wrote:
> I believe the usb_autopm_get_interface_async() failing is OK in this
> case, but that should not cause the modem to stop working.
>
> Wonder if this patch solves the problem? :
>
> From: =3D?UTF-8?q?Bj=3DC3=3DB8rn=3D20Mork?=3D <bjorn@mork.no>
> Date: Thu, 14 Feb 2013 18:34:48 +0100
> Subject: [PATCH] USB: usb_wwan: clear port busy state on error
> MIME-Version: 1.0
> Content-Type: text/plain; charset=3DUTF-8
> Content-Transfer-Encoding: 8bit
>
> Reported-by: Alex Courbot <acourbot@nvidia.com>
> Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
> ---
>   drivers/usb/serial/usb_wwan.c |    4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_w=
wan.c
> index 01c94aa..44e106d 100644
> --- a/drivers/usb/serial/usb_wwan.c
> +++ b/drivers/usb/serial/usb_wwan.c
> @@ -230,8 +230,10 @@ int usb_wwan_write(struct tty_struct *tty, struc=
t usb_serial_port *port,
>   			usb_pipeendpoint(this_urb->pipe), i);
>
>   		err =3D usb_autopm_get_interface_async(port->serial->interface);
> -		if (err < 0)
> +		if (err < 0) {
> +			clear_bit(i, &portdata->out_busy);
>   			break;
> +		}
>
>   		/* send the data */
>   		memcpy(this_urb->transfer_buffer, buf, todo);
>

Unfortunately it does not, and fails the same way. On the other hand, I=
=20
do not see the issue when doing the following:

diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwa=
n.c
index e4fad5e..1490029 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -238,8 +238,6 @@ int usb_wwan_write(struct tty_struct *tty, struct=20
usb_serial_port *port,
                     usb_pipeendpoint(this_urb->pipe), i);

                 err =3D=20
usb_autopm_get_interface_async(port->serial->interface);
-               if (err < 0)
-                       break;

                 /* send the data */
                 memcpy(this_urb->transfer_buffer, buf, todo);

After doing this I don't see this issue anymore. It looks wrong though.=
=20
But it seems to work despite the obvious unbalance in autopm calls that=
=20
results.

If I understand you correctly, usb_wwan_write() failing here is not a=20
problem in itself, and the ack should just be sent again later?

 > that should not cause the modem to stop working.

Actually it might also be that the network stack ends up in a bad state=
=20
and remains stuck in it. I don't think the modem by itself is affected.=
=20
All I observe is that no network traffic takes place after this. I'm no=
t=20
familiar enough with networking to make any stronger assumption.

=46WIW, when usb_autopm_get_interface_async() returns -EACCES, the powe=
r=20
parameters of port->serial->interface->dev are as follows:

disable_depth =3D 1
is_suspended =3D 1
runtime_status =3D 2 (RPM_SUSPENDED)

Thanks,
Alex.

