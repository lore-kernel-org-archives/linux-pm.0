From: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: [PATCH v4 1/2] ARM: keystone: pm: switch to use generic pm domains
Date: Thu, 20 Nov 2014 22:54:07 +0100
Message-ID: <CAMuHMdVXGPu7x706NxqO3rn3KuRbPbD_ZQsJtDH4Hf31AaRR+Q@mail.gmail.com>
References: <1415631557-22897-1-git-send-email-grygorii.strashko@ti.com>
	<1709760.E0jX3Myv0h@wuerfel>
	<546C7FDD.7030906@ti.com>
	<2900095.WIocOu7ue2@wuerfel>
	<CAPDyKFqeZ3YU2OEN4tCOdcQ0pAho67Q8U_eCEOroG9aS0mp+-Q@mail.gmail.com>
	<546DD87B.3080806@ti.com>
	<CAPDyKFrBhZyqozM98_4pPdW0EMFt5W6VX1X7cz6Z=yNhW4vYTA@mail.gmail.com>
	<CAMuHMdWtHT7QX3Kpa-GCLa49ToGODwjnNVgfxDzJzcM-FU1ffg@mail.gmail.com>
	<546E0970.5090301@ti.com>
	<7hh9xtr5ac.fsf@deeprootsystems.com>
	<CAMuHMdV7zASj8_NtLRir1VubXEKTkq0vBGMXeYXDACu8UC2tZA@mail.gmail.com>
	<7hbno1r1af.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <7hbno1r1af.fsf@deeprootsystems.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: Grygorii Strashko <grygorii.strashko@ti.com>, Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>, ssantosh@kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Rob Herring <robh+dt@kernel.org>, Grant Likely <grant.likely@secretlab.ca>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 20, 2014 at 10:48 PM, Kevin Hilman <khilman@kernel.org> wrote:
>>> So what exactly are we talking about with "PM" clocks, and why are they
>>> "special" when it comes to PM domains?  IOW, why are the clocks to be
>>> managed during PM domain transitions for a given device any different
>>> than the clocks that need to be managed for a runtime suspend/resume (or
>>> system suspend/resume) sequence for the same device?
>>
>> (Speaking for my case, shmobile)
>>
>> They're not. The clocks to be managed during PM domain transitions are the
>> same as the clocks that need to be managed for a runtime suspend/resume
>> (or system suspend/resume) sequence.
>>
>> The special thing is that this is more a platform than a driver thing: the same
>> module may have a "PM/functional" clock (that is documented to enable/disable
>> the module) on one Soc, but noet on another.
>
> So why isn't the presence or absence of the clock described in the .dtsi
> for the SoC instead of being handled by special PM domain logic?

It is. Cfr. the presence/absence of clocks for renesas,rcar-gpio nodes.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
