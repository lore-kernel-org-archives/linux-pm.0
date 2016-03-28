From: Rob Herring <robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/3] power: charger-manager: Replace deprecatd API of
 extcon
Date: Mon, 28 Mar 2016 16:07:37 -0500
Message-ID: <20160328210737.GA21044@rob-hp-laptop>
References: <1459121142-3768-1-git-send-email-cw00.choi@samsung.com>
 <1459121142-3768-2-git-send-email-cw00.choi@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <1459121142-3768-2-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Mon, Mar 28, 2016 at 08:25:40AM +0900, Chanwoo Choi wrote:
> This patch removes the deprecated notifier API of extcon framework and then use
> the new extcon API[2] with the unique id[1] to indicate the each external
> connector. Alter deprecated API as following:
> - extcon_register_interest() -> extcon_register_notifier()
> - extcon_unregister_interest() -> extcon_unregister_notifier()
> 
> And, extcon alters the name of USB charger connector in patch[3] as following:
> - EXTCON_CHG_USB_SDP /* Standard Downstream Port */
> - EXTCON_CHG_USB_DCP /* Dedicated Charging Port */
> - EXTCON_CHG_USB_CDP /* Charging Downstream Port */
> - EXTCON_CHG_USB_ACA /* Accessory Charger Adapter */
> 
> So, the name of external charger connector are changed as following:
> - "USB" -> "SDP"
> - "TA" -> "DCP"
> 
> [1] Commit 2a9de9c0f08d61
> - ("extcon: Use the unique id for external connector instead of string)
> [2] Commit 046050f6e623e4
> - ("extcon: Update the prototype of extcon_register_notifier() with enum extcon
> [3] Commit 11eecf910bd81d
> - ("extcon: Modify the id and name of external connector")
> 
> Signed-off-by: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
> ---
>  .../bindings/power_supply/charger-manager.txt      |  4 +--
>  drivers/power/charger-manager.c                    | 31 ++++++++++++++--------
>  include/linux/power/charger-manager.h              |  4 +--
>  3 files changed, 24 insertions(+), 15 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/power_supply/charger-manager.txt b/Documentation/devicetree/bindings/power_supply/charger-manager.txt
> index ec4fe9de3137..73193e380dc2 100644
> --- a/Documentation/devicetree/bindings/power_supply/charger-manager.txt
> +++ b/Documentation/devicetree/bindings/power_supply/charger-manager.txt
> @@ -65,13 +65,13 @@ Example :
>  		regulator@0 {
>  			cm-regulator-name = "chg-reg";
>  			cable@0 {
> -				cm-cable-name = "USB";
> +				cm-cable-id = 5; /* EXTCON_CHG_USB_SDP */

Sorry, but delete the charger-manager binding and start over. It looks 
designed around the needs of Linux, not what the h/w looks like. You're 
changing the driver and having to change the DT in a non-compatible way 
is the first clue.

>  				cm-cable-extcon = "extcon-dev.0";

What is this!? The linux device name?

>  				cm-cable-min = <475000>;
>  				cm-cable-max = <500000>;

This is set by the USB spec...

>  			};
>  			cable@1 {
> -				cm-cable-name = "TA";
> +				cm-cable-id = 6; /* EXTCON_CHG_USB_DCP */
>  				cm-cable-extcon = "extcon-dev.0";
>  				cm-cable-min = <650000>;
>  				cm-cable-max = <675000>;

--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
