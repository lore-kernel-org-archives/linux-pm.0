From: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>
Subject: Re: [PATCH v2] power_supply: rt9455_charger: Properly notify
 userspace about charging events
Date: Wed, 8 Jul 2015 10:18:36 +0900
Message-ID: <CAJKOXPfqiQuKvPSWaYQPA06onGSoVhajXW+Q1aEds0MJKpn9Tw@mail.gmail.com>
References: <1436271953-24564-1-git-send-email-anda-maria.nicolae@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1436271953-24564-1-git-send-email-anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Anda-Maria Nicolae <anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
List-Id: linux-pm@vger.kernel.org

2015-07-07 21:25 GMT+09:00 Anda-Maria Nicolae <anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>:
> Charging events this patch refers to are:
> - charger is connected to/disconnected from the power source
> - battery is reconnected to the charger, after it was absent.
>
> When the charger is connected to/disconnected from the power source, CHRVPI
> interrupt occurs and PWR_RDY bit is either set or cleared. PWR_RDY bit is
> updated after 1-2 seconds CHRVPI interrupt has occurred.
> power_supply_changed() should be called after PWR_RDY bit is updated.
> /sys/class/power_supply/rt9455-charger/online file displays the value of
> PWR_RDY bit.
> This way, if the userspace is notified that a charging event has occurred
> and the userspace reads /sys/class/power_supply/rt9455-charger/online file,
> this file is properly updated when the userspace reads it.
> This is the reason why power_supply_changed() is called in
> rt9455_pwr_rdy_work_callback(), instead of being called in interrupt
> handler.
>
> Since no interrupt is triggered when the battery is reconnected to the
> charger, the userspace is never notified that the battery is reconnected.
> This is why power_supply_changed() is called in
> rt9455_max_charging_time_work_callback(), so that the userspace is notified
> that the battery is reconnected.
>
> Signed-off-by: Anda-Maria Nicolae <anda-maria.nicolae-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>
> ---
>
> Updates from v1 version:
> - I have followed Kzrysztof's suggestion and I have added explanations in
> the commit message so that the change is more clear
> - Code is the same as in v1

Thanks, FWIW:
Reviewed-by: Krzysztof Kozlowski <k.kozlowski-Sze3O3UU22JBDgjK7y7TUQ@public.gmane.org>

Best regards,
Krzysztof
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
