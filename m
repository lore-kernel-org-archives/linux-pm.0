From: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v4 1/2] ARM: keystone: pm: switch to use generic pm domains
Date: Thu, 20 Nov 2014 17:30:53 -0800
Message-ID: <7hppchpcfm.fsf@deeprootsystems.com>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>
	<1709760.E0jX3Myv0h@wuerfel> <546C7FDD.7030906@ti.com>
	<2900095.WIocOu7ue2@wuerfel>
	<CAPDyKFqeZ3YU2OEN4tCOdcQ0pAho67Q8U_eCEOroG9aS0mp+-Q@mail.gmail.com>
	<546DD87B.3080806@ti.com>
	<CAPDyKFrBhZyqozM98_4pPdW0EMFt5W6VX1X7cz6Z=yNhW4vYTA@mail.gmail.com>
	<CAMuHMdWtHT7QX3Kpa-GCLa49ToGODwjnNVgfxDzJzcM-FU1ffg@mail.gmail.com>
	<546E0970.5090301@ti.com> <7hh9xtr5ac.fsf@deeprootsystems.com>
	<CAMuHMdV7zASj8_NtLRir1VubXEKTkq0vBGMXeYXDACu8UC2tZA@mail.gmail.com>
	<7hbno1r1af.fsf@deeprootsystems.com>
	<CAMuHMdVXGPu7x706NxqO3rn3KuRbPbD_ZQsJtDH4Hf31AaRR+Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <CAMuHMdVXGPu7x706NxqO3rn3KuRbPbD_ZQsJtDH4Hf31AaRR+Q-JsoAwUIsXosN+BqQ9rBEUg@public.gmane.org>
	(Geert Uytterhoeven's message of "Thu, 20 Nov 2014 22:54:07 +0100")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org>
Cc: Grygorii Strashko <grygorii.strashko-l0cyMroinI0@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, ssantosh-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "linux-pm@vger.kernel.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Grant Likely <grant.likely-s3s/WqlpOiPyB63q8FvJNQ@public.gmane.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-kernel@vger.kernel.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "devicetree@vger.kernel.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Dmitry Torokhov <dmitry.torokhov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Geert Uytterhoeven <geert-Td1EMuHUCqxL1ZNQvxDV9g@public.gmane.org> writes:

> On Thu, Nov 20, 2014 at 10:48 PM, Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> wrote:
>>>> So what exactly are we talking about with "PM" clocks, and why are they
>>>> "special" when it comes to PM domains?  IOW, why are the clocks to be
>>>> managed during PM domain transitions for a given device any different
>>>> than the clocks that need to be managed for a runtime suspend/resume (or
>>>> system suspend/resume) sequence for the same device?
>>>
>>> (Speaking for my case, shmobile)
>>>
>>> They're not. The clocks to be managed during PM domain transitions are the
>>> same as the clocks that need to be managed for a runtime suspend/resume
>>> (or system suspend/resume) sequence.
>>>
>>> The special thing is that this is more a platform than a driver thing: the same
>>> module may have a "PM/functional" clock (that is documented to enable/disable
>>> the module) on one Soc, but noet on another.
>>
>> So why isn't the presence or absence of the clock described in the .dtsi
>> for the SoC instead of being handled by special PM domain logic?
>
> It is. Cfr. the presence/absence of clocks for renesas,rcar-gpio nodes.

Hmm, OK, Good.  

So now I'm confused about why the PM domain has to do anything special
if the presence/absence of the clocks is already handled by the DT.

Kevin



--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
