From: Manish Badarkhe <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 1/2] power: supply: add sbs-charger driver
Date: Wed, 21 Dec 2016 15:39:46 +0530
Message-ID: <CAKDJKT4zFB-Q6x5davDYpzgGfkRfoFqTOaL24MQjm_=b2B-Z5Q@mail.gmail.com>
References: <1482247874-28713-1-git-send-email-nicolas.saenz@prodys.net>
 <1482247874-28713-2-git-send-email-nicolas.saenz@prodys.net>
 <CAKDJKT7WWFd2FSAZ6erXF=t1aaCyR0F5px54TiHw7C4PrnKXSQ@mail.gmail.com> <72292f5b-3f81-f097-a87e-56b58098ff2b@prodys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <72292f5b-3f81-f097-a87e-56b58098ff2b-gbiq2sxWoaasTnJN9+BGXg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Saenz Julienne <nicolas.saenz-gbiq2sxWoaasTnJN9+BGXg@public.gmane.org>
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Nicolas

On Wed, Dec 21, 2016 at 3:00 PM, Nicolas Saenz Julienne
<nicolas.saenz-gbiq2sxWoaasTnJN9+BGXg@public.gmane.org> wrote:
> Hi Manish, thanks for the interest.
>
> On 20/12/16 17:54, Manish Badarkhe wrote:
>> Hi Nicola
>>
> [...]
>>
>> Just some general comment, Can you add some more properties here to
>> know voltage and current?
>
> I assume you are mentioning reading current and voltage values. These
> properties are not supported by the sbs-charger standard. All you can do
> is set (write only) the charging current and charging voltage values.
> Yet in all the boards I've worked with it's the sbs-battery compliant
> chip that takes care of it.

thanks for clarifying me.


>> Also, can you add other properties present in charging status register
>> like POWER_FAIL, VOLTAGE_OR,
>> CURRENT_OR etc.
>
> CURRENT_OR and VOLTAGE_OR relate to wrong values in the charging
> voltage/current registers. Since the sbs-battery chip takes care of it I
> don't see any use for it.
> POWER_FAIL marks there is not enough voltage to charge the battery. I
> don't need that information so I did nothing to integrate it. Having a
> quick look at the power supply defines I don't see were it could easily fit.

thanks for clarifying me.

Regards
Manish Badarkhe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
