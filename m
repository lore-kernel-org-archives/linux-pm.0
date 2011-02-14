From: Dirk Hohndel <hohndel@infradead.org>
Subject: Re: USB suspend issue with 2.6.38-rc2 -- still there in
	RC4-g795abaf
Date: Mon, 14 Feb 2011 12:40:28 -0800
Message-ID: <m31v3a8i4j.fsf__10002.5720931173$1297930448$gmane$org@x201s.gr8dns.org>
References: <Pine.LNX.4.44L0.1101251021310.1867-100000@iolanthe.rowland.org>
	<m38vxibfez.fsf@x201s.gr8dns.org>
	<AANLkTik4e0UoMbtMUSsyym_y-Y-xcTzdJK26zzGk719f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTik4e0UoMbtMUSsyym_y-Y-xcTzdJK26zzGk719f@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linux PM List <linux-pm@lists.linux-foundation.org>, Linux USB List <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 14 Feb 2011 11:33:01 -0800, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> Does it suspend reliably if we just get rid of the crap that looks for errors?

Yes. I tried all combinations I could think of. Docked. Undocked.
Docking while suspended. Undocking while suspended. Did something like
20 suspend / resume cycles in a row. All works.

I will continue to play with this but for now I consider this solved

> As mentioned, there's no _point_ to looking at errors. Reacting to
> errors in suspend can only make things worse, not better. If the
> suspend of some device fails, then it fails. Big deal. Take the
> machine down regardless.
> 
> Trial patch attached. Untested. It may do nasty things to your pets.

Pets didn't mind at all (but I kept them away from the machine, just in
case)

/D


>  drivers/usb/core/driver.c |   33 +++++++++------------------------
>  1 files changed, 9 insertions(+), 24 deletions(-)
> 
> diff --git a/drivers/usb/core/driver.c b/drivers/usb/core/driver.c
> index fca6172..e302189 100644
> --- a/drivers/usb/core/driver.c
> +++ b/drivers/usb/core/driver.c
> @@ -1173,7 +1173,6 @@ done:
>   */
>  static int usb_suspend_both(struct usb_device *udev, pm_message_t msg)
>  {
> -	int			status = 0;
>  	int			i = 0, n = 0;
>  	struct usb_interface	*intf;
>  
> @@ -1186,36 +1185,22 @@ static int usb_suspend_both(struct usb_device *udev, pm_message_t msg)
>  		n = udev->actconfig->desc.bNumInterfaces;
>  		for (i = n - 1; i >= 0; --i) {
>  			intf = udev->actconfig->interface[i];
> -			status = usb_suspend_interface(udev, intf, msg);
> -			if (status != 0)
> -				break;
> +			usb_suspend_interface(udev, intf, msg);
>  		}
>  	}
> -	if (status == 0)
> -		status = usb_suspend_device(udev, msg);
> -
> -	/* If the suspend failed, resume interfaces that did get suspended */
> -	if (status != 0) {
> -		msg.event ^= (PM_EVENT_SUSPEND | PM_EVENT_RESUME);
> -		while (++i < n) {
> -			intf = udev->actconfig->interface[i];
> -			usb_resume_interface(udev, intf, msg, 0);
> -		}
> +	usb_suspend_device(udev, msg);
>  
> -	/* If the suspend succeeded then prevent any more URB submissions
> -	 * and flush any outstanding URBs.
> +	/* Prevent any more URB submissions and flush any outstanding URBs.
>  	 */
> -	} else {
> -		udev->can_submit = 0;
> -		for (i = 0; i < 16; ++i) {
> -			usb_hcd_flush_endpoint(udev, udev->ep_out[i]);
> -			usb_hcd_flush_endpoint(udev, udev->ep_in[i]);
> -		}
> +	udev->can_submit = 0;
> +	for (i = 0; i < 16; ++i) {
> +		usb_hcd_flush_endpoint(udev, udev->ep_out[i]);
> +		usb_hcd_flush_endpoint(udev, udev->ep_in[i]);
>  	}
>  
>   done:
> -	dev_vdbg(&udev->dev, "%s: status %d\n", __func__, status);
> -	return status;
> +	dev_vdbg(&udev->dev, "%s: suspend\n", __func__);
> +	return 0;
>  }
>  
>  /**

-- 
Dirk Hohndel
Intel Open Source Technology Center
