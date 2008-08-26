From: Felipe Balbi <felipe.balbi@nokia.com>
Subject: Re: [patch]full runtime power management for usbhid
Date: Tue, 26 Aug 2008 12:49:15 +0300
Message-ID: <20080826094915.GQ20450__33342.8417369307$1219761681$gmane$org@gandalf.research.nokia.com>
References: <200808261139.14410.oliver@neukum.org>
Reply-To: felipe.balbi@nokia.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200808261139.14410.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: ext Oliver Neukum <oliver@neukum.org>
Cc: jkosina@suse.cz, linux-pm@lists.linux-foundation.org, dmitry.torokhov@gmail.com, linux-usb@vger.kernel.org, linux-input@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 26, 2008 at 11:39:13AM +0200, ext Oliver Neukum wrote:
> --- a/drivers/hid/usbhid/usbhid.h	2008-05-06 13:49:51.000000000 +0200
> +++ b/drivers/hid/usbhid/usbhid.h	2008-05-06 14:58:49.000000000 +0200
> @@ -37,7 +37,10 @@ int usbhid_wait_io(struct hid_device* hi
>  void usbhid_close(struct hid_device *hid);
>  int usbhid_open(struct hid_device *hid);
>  void usbhid_init_reports(struct hid_device *hid);
> -void usbhid_submit_report(struct hid_device *hid, struct hid_report *report, unsigned char dir);
> +void usbhid_submit_report
> +(struct hid_device *hid, struct hid_report *report, unsigned char dir);

void usbhid_submit_report(struct hid_device *hid,
	struct hid_report *report, unsigned char dir);

would look better. Matter of taste. ditto below.

>  	switch (urb->status) {
>  		case 0:			/* success */
> +			usbhid_mark_busy(usbhid);	
						 ^^^^^^^
			you added whitespaces there

-- 
balbi
