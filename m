From: Heiko =?ISO-8859-1?Q?St=FCbner?= <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
Subject: Re: [PATCH v5 1/2] of: Rename "poweroff-source" property to "system-power-controller"
Date: Tue, 25 Nov 2014 15:52:05 +0100
Message-ID: <1745187.YOripSYQvX@diego>
References: <1416918506-9366-1-git-send-email-romain.perier@gmail.com> <1416918506-9366-2-git-send-email-romain.perier@gmail.com> <20141125144007.9904BC44343@trevor.secretlab.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20141125144007.9904BC44343-WNowdnHR2B42iJbIjFUEsiwD8/FfD2ys@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Cc: Romain Perier <romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, johan-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, lee.jones-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, lgirdwood-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, balbi-l0cyMroinI0@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Am Dienstag, 25. November 2014, 14:40:07 schrieb Grant Likely:
> On Tue, 25 Nov 2014 12:28:25 +0000
> , Romain Perier <romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
>  wrote:
> > It reverts commit a4b4e0461ec5 ("of: Add standard property for poweroff
> > capability"). As discussed on the mailing list, it makes more sense to
> > rename back to the old established property name, without the vendor
> > prefix. Problem being that the word "source" usually tends to be used for
> > inputs and that is out of control of the OS. The poweroff capability is
> > an output which simply turns the system-power off. Also, this property
> > might be used by drivers which power-off the system and power back on
> > subsequent RTC alarms. This seems to suggest to remove "poweroff" from
> > the property name and to choose "system-power-controller" as the more
> > generic name. This patchs adds the required renaming changes and defines
> > an helper function which checks if this property is set.
> > 
> > Signed-off-by: Romain Perier <romain.perier-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
> 
> For both patches:
> Acked-by: Grant Likely <grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
> 
> Let me know if I need to take this series through my tree. Also, does it
> need to go into v3.18 and be backported to stable? Or just v3.19.

The original change [that is fixed now] is only scheduled for 3.19 and in
Mark Brown's tree [0]. So there shouldn't be anything to do for you now.


Heiko



[0] https://git.kernel.org/cgit/linux/kernel/git/broonie/regulator.git/log/?h=topic/power-off
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
