From: =?utf-8?Q?Bj=C3=B8rn_Mork?= <bjorn@mork.no>
Subject: Re: usb_wwan_write() called while device still being resumed
Date: Thu, 14 Feb 2013 18:41:27 +0100
Message-ID: <87ehgivlmg.fsf@nemi.mork.no>
References: <511CBCE8.9070204@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <511CBCE8.9070204@nvidia.com> (Alex Courbot's message of "Thu, 14
	Feb 2013 19:31:04 +0900")
Sender: linux-kernel-owner@vger.kernel.org
To: Alex Courbot <acourbot@nvidia.com>
Cc: USB list <linux-usb@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Alexandre Courbot <gnurou@gmail.com>
List-Id: linux-pm@vger.kernel.org

Alex Courbot <acourbot@nvidia.com> writes:

> The board features a USB GSM modem using the usb_wwan module. Once in
> a while, when the system resumes from LP0, a NET_RX softirq will be
> triggered while the modem is still being resumed, calling
> usb_wwan_write(). This will cause usb_autopm_get_interface_async()
> inside usb_wwan_write() to fail because the runtime PM disable_depth
> is still equal to 1 since device_resume() has not completed yet. As a
> result, the modem just stops working.

I believe the usb_autopm_get_interface_async() failing is OK in this
case, but that should not cause the modem to stop working.

Wonder if this patch solves the problem? :

=46rom: =3D?UTF-8?q?Bj=3DC3=3DB8rn=3D20Mork?=3D <bjorn@mork.no>
Date: Thu, 14 Feb 2013 18:34:48 +0100
Subject: [PATCH] USB: usb_wwan: clear port busy state on error
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Reported-by: Alex Courbot <acourbot@nvidia.com>
Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
---
 drivers/usb/serial/usb_wwan.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/serial/usb_wwan.c b/drivers/usb/serial/usb_wwa=
n.c
index 01c94aa..44e106d 100644
--- a/drivers/usb/serial/usb_wwan.c
+++ b/drivers/usb/serial/usb_wwan.c
@@ -230,8 +230,10 @@ int usb_wwan_write(struct tty_struct *tty, struct =
usb_serial_port *port,
 			usb_pipeendpoint(this_urb->pipe), i);
=20
 		err =3D usb_autopm_get_interface_async(port->serial->interface);
-		if (err < 0)
+		if (err < 0) {
+			clear_bit(i, &portdata->out_busy);
 			break;
+		}
=20
 		/* send the data */
 		memcpy(this_urb->transfer_buffer, buf, todo);
--=20
1.7.10.4
