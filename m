From: Manish Badarkhe <badarkhe.manish-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH v4 1/2] power: supply: add sbs-charger driver
Date: Tue, 20 Dec 2016 22:24:52 +0530
Message-ID: <CAKDJKT7WWFd2FSAZ6erXF=t1aaCyR0F5px54TiHw7C4PrnKXSQ@mail.gmail.com>
References: <1482247874-28713-1-git-send-email-nicolas.saenz@prodys.net> <1482247874-28713-2-git-send-email-nicolas.saenz@prodys.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1482247874-28713-2-git-send-email-nicolas.saenz-gbiq2sxWoaasTnJN9+BGXg@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Nicolas Saenz Julienne <nicolas.saenz-gbiq2sxWoaasTnJN9+BGXg@public.gmane.org>
Cc: sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

Hi Nicola

On Tue, Dec 20, 2016 at 9:01 PM, Nicolas Saenz Julienne
<nicolas.saenz-gbiq2sxWoaasTnJN9+BGXg@public.gmane.org> wrote:
> This adds support for sbs-charger compilant chips as defined here:
> http://sbs-forum.org/specs/sbc110.pdf
>
> This was tested on a arm board connected to an LTC4100 battery charger
> chip.
>
> Signed-off-by: Nicolas Saenz Julienne <nicolas.saenz-gbiq2sxWoaasTnJN9+BGXg@public.gmane.org>
> ---
>  v3 -> v4
>  - drop "lltc,ltc4100" compatible string for now
>
>  v2 -> v3:
>  - add readable_reg() function to regmap config
>  - update compatible strings with part number
>
>  v1 -> v2:
>  - add spec link in header
>  - use proper gpio/interrupt interface
>  - update regmap configuration (max register & endianness)
>  - dropped oldschool .supplied_to assignments
>  - use devm_* APIs
>  drivers/power/supply/Kconfig       |   6 +
>  drivers/power/supply/Makefile      |   1 +
>  drivers/power/supply/sbs-charger.c | 274 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 281 insertions(+)
>  create mode 100644 drivers/power/supply/sbs-charger.c


Just some general comment, Can you add some more properties here to
know voltage and current?
Also, can you add other properties present in charging status register
like POWER_FAIL, VOLTAGE_OR,
CURRENT_OR etc.

Don't know weather it is feasible to add or not and Also, let me know,
if it is already been covered in
some part of the code.

Thanks
Manish Badarkhe
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
