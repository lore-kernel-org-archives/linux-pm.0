From: Chanwoo Choi <cwchoi00-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH 0/3] power: Remove the deprecated extcon functions
Date: Tue, 5 Apr 2016 17:06:05 +0900
Message-ID: <CAGTfZH1A=vt8NojozADUg2HAamVcffDosyvktYD2L2Mu8-FbMA@mail.gmail.com>
References: <1459121142-3768-1-git-send-email-cw00.choi@samsung.com>
Reply-To: cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1459121142-3768-1-git-send-email-cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, David Woodhouse <dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org>, "myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org" <myungjoo.ham-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, linux-kernel <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Ping.

Hi Sebastian,

Could you please review this patch-set?

Regards,
Chanwoo Choi


On Mon, Mar 28, 2016 at 8:25 AM, Chanwoo Choi <cw00.choi-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org> wrote:
> This patch-set removes the deprecated notifier API of extcon framework and
> then use the new extcon API[2] with the unique id[1] to indicate the each
> external connector. Alter deprecated API as following:
> - extcon_register_interest() -> extcon_register_notifier()
> - extcon_unregister_interest() -> extcon_unregister_notifier()
> - extcon_set_cable_state() -> extcon_set_cable_state_()
> - extcon_get_cable_state() -> extcon_get_cable_state_()
>
> And, extcon alters the name of USB charger connector in patch[3] as following:
> - EXTCON_CHG_USB_SDP /* Standard Downstream Port */
> - EXTCON_CHG_USB_DCP /* Dedicated Charging Port */
> - EXTCON_CHG_USB_CDP /* Charging Downstream Port */
> - EXTCON_CHG_USB_ACA /* Accessory Charger Adapter */
>
> [1] Commit 2a9de9c0f08d61
> - ("extcon: Use the unique id for external connector instead of string)
> [2] Commit 046050f6e623e4
> - ("extcon: Update the prototype of extcon_register_notifier() with enum extcon
> [3] Commit 11eecf910bd81d
> - ("extcon: Modify the id and name of external connector")
>
> Chanwoo Choi (3):
>   power: charger-manager: Replace deprecatd API of extcon
>   power: axp288_charger: Replace deprecatd API of extcon
>   extcon: Remove the deprecated extcon functions
>
>  .../bindings/power_supply/charger-manager.txt      |   4 +-
>  drivers/extcon/extcon.c                            | 201 +++------------------
>  drivers/power/axp288_charger.c                     |  77 +++++---
>  drivers/power/charger-manager.c                    |  31 ++--
>  include/linux/extcon.h                             |  59 ------
>  include/linux/power/charger-manager.h              |   4 +-
>  6 files changed, 101 insertions(+), 275 deletions(-)
>
> --
> 1.9.1
>
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
