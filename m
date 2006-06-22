From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: [PATCH] get USB suspend to work again on 2.6.17-mm1
Date: Thu, 22 Jun 2006 23:26:26 +0159
Message-ID: <449B0B19.9000901@gmail.com>
References: <20060622202952.GA14135@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060622202952.GA14135@kroah.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: David Brownell <david-b@pacbell.net>, Mattia Dongili <malattia@linux.it>, Jiri Slaby <jirislaby@gmail.com>, linux-pm@osdl.org, linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Greg KH napsal(a):
> Mattai and Jiri, can you try the patch below to see if it fixes the USB
> suspend problem you are seeing with 2.6.17-mm1?
> =

> David, we really should not be caring about what the children of a USB
> device is doing here, as who knows what type of "device" might hang off
> of a struct usb_device.  This patch is just a band-aid around this area,
> until Alan's patches fix up everything "properly" :)
> =

> thanks,
> =

> greg k-h
> =

> -----------------------------
> Subject: USB: get USB suspend to work again
> =

> Yeah, it's a hack, but it is only temporary until Alan's patches
> reworking this area make it in.  We really should not care what devices
> below us are doing, especially when we do not really know what type of
> devices they are.  This patch relies on the fact that the endpoint
> devices do not have a driver assigned to us.
> =

> Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
> =

> ---
>  drivers/usb/core/usb.c |    2 ++
>  1 file changed, 2 insertions(+)
> =

> --- gregkh-2.6.orig/drivers/usb/core/usb.c
> +++ gregkh-2.6/drivers/usb/core/usb.c
> @@ -991,6 +991,8 @@ void usb_buffer_unmap_sg (struct usb_dev
>  =

>  static int verify_suspended(struct device *dev, void *unused)
>  {
> +	if (dev->driver =3D=3D NULL)
> +		return 0;
>  	return (dev->power.power_state.event =3D=3D PM_EVENT_ON) ? -EBUSY : 0;
>  }
>  =


Yeah, it works just fine.

regards,
-- =

Jiri Slaby         www.fi.muni.cz/~xslaby
\_.-^-._   jirislaby@gmail.com   _.-^-._/
B67499670407CE62ACC8 22A032CC55C339D47A7E
