From: Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH v3] PM / AVS: rockchip-io: add driver handling Rockchip io domains
Date: Wed, 24 Sep 2014 16:27:07 -0700
Message-ID: <7hwq8sk3as.fsf@deeprootsystems.com>
References: <1410475735-10278-1-git-send-email-dianders@chromium.org>
	<7hy4tog61r.fsf@deeprootsystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <7hy4tog61r.fsf-1D3HCaltpLuhEniVeURVKkEOCMrvLtNR@public.gmane.org> (Kevin Hilman's message of
	"Fri, 12 Sep 2014 09:25:04 -0700")
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
Cc: "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, Heiko Stuebner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>, Ulf Hansson <ulf.hansson-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rafael.j.wysocki-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, Nishanth Menon <nm-l0cyMroinI0@public.gmane.org>, Linus Walleij <linus.walleij-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, olof-nZhT3qVonbNeoWH0uzbU5w@public.gmane.org, Arnd Bergmann <arnd-r2nGTMty4D4@public.gmane.org>, Mark Brown <broonie-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Addy Ke <addy.ke-TNX95d0MmH7DzftRWevZcw@public.gmane.org>, Sonny Rao <sonnyrao-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, pawel.moll-5wv7dgnIgG8@public.gmane.org, mark.rutland-5wv7dgnIgG8@public.gmane.org, ijc+devicetree-KcIKpvwj1kUDXYZnReoRVg@public.gmane.org, galak-sgV2jX0FEOL9JmXXK+q4OQ@public.gmane.org, sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Dmitry Eremin-Solenikov <dbaryshkov-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>, dwmw2-wEGCiKHe2LqWVfeAwA7xHQ@public.gmane.org, grant.likely-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, linux-rockchip-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

Kevin Hilman <khilman-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org> writes:

> Rafael,
>
> Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org> writes:
>
>> From: Heiko St=C3=BCbner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
>>
>> IO domain voltages on some Rockchip SoCs are variable but need to be
>> kept in sync between the regulators and the SoC using a special
>> register.
>>
>> A specific example using rk3288:
>> - If the regulator hooked up to a pin like SDMMC0_VDD is 3.3V then
>>   bit 7 of GRF_IO_VSEL needs to be 0.  If the regulator hooked up to
>>   that same pin is 1.8V then bit 7 of GRF_IO_VSEL needs to be 1.
>>
>> Said another way, this driver simply handles keeping bits in the SoC=
's
>> general register file (GRF) in sync with the actual value of a volta=
ge
>> hooked up to the pins.
>>
>> Note that this driver specifically doesn't include:
>> - any logic for deciding what voltage we should set regulators to
>> - any logic for deciding whether regulators (or internal SoC blocks)
>>   should have power or not have power
>>
>> If there were some other software that had the smarts of making
>> decisions about regulators, it would work in conjunction with this
>> driver.  When that other software adjusted a regulator's voltage the=
n
>> this driver would handle telling the SoC about it.  A good example i=
s
>> vqmmc for SD.  In that case the dw_mmc driver simply is told about a
>> regulator.  It changes the regulator between 3.3V and 1.8V at the
>> right time.  This driver notices the change and makes sure that the
>> SoC is on the same page.
>>
>> Signed-off-by: Heiko St=C3=BCbner <heiko-4mtYJXux2i+zQB+pC5nmwQ@public.gmane.org>
>> Signed-off-by: Doug Anderson <dianders-F7+t8E8rja9g9hUCZPvPmw@public.gmane.org>
>> Reviewed-by: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
>> ---
>> Changes in v3:
>> - Changed compatible string as per Santosh.
>
> Thanks, I like the new string better.
>
>> - Added code docs about the slop in 1.8V and 3.3V as per Santosh.
>> - Moved some #defines to the top as per Santosh.
>
> All nice changes, thanks Santosh!
>
> Reviewed-by: Kevin Hilman <khilman-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>
> Rafael, how do you want to handle drivers/avs/* ?  Along with Nishant=
h,
> I'm maintaining everything there currently (only one driver :)), and
> since I recommended $SUBJECT driver go into drivers/avs[1], I'm happy=
 to
> queue it for you and update MAINTAINERS to cover drivers/avs/* instea=
d
> of just smartreflex.c.
>
> Let me know how you'd like to proceed.

=46or the benefit of the archives... Rafael and I talked off-list and
agreed that I'll queue it up for him and update MAINTAINERS to reflect
maintenance of drivesr/power/avs

Kevin
--
To unsubscribe from this list: send the line "unsubscribe devicetree" i=
n
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
