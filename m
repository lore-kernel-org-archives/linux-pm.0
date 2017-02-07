From: Andy Shevchenko <andy.shevchenko-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH] power: supply: Add driver for TI BQ2416X battery charger
Date: Tue, 7 Feb 2017 13:08:21 +0200
Message-ID: <CAHp75VfWNd8p7eg9TU2SNC1dqBMf0fmkbEVmkWOWcDqHrDgOLQ@mail.gmail.com>
References: <1486429749-12973-1-git-send-email-wojciech.ziemba@verifone.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1486429749-12973-1-git-send-email-wojciech.ziemba-VFDYytZz4I1Wk0Htik3J/w@public.gmane.org>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Wojciech Ziemba <wo.ziemba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Sebastian Reichel <sre-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Rob Herring <robh+dt-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, Mark Rutland <mark.rutland-5wv7dgnIgG8@public.gmane.org>, wojciech.ziemba-VFDYytZz4I1Wk0Htik3J/w@public.gmane.org, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, devicetree <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 7, 2017 at 3:09 AM, Wojciech Ziemba <wo.ziemba-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
> There is interest in adding a Linux driver for TI BQ2416X battery
> charger. The driver supports BQ24160 chip, thus can be easily extended
> for other BQ2416X family chargers.
> Device exposes 'POWER_SUPPLY_PROP_*' properties and a number of knobs
> for controlling the charging process as well as sends power supply change
> notification via power-supply subsystem.

Some style related comments

0. Less lines of code -> better! (but not be too eager)
1. Use GENMASK()
2.
int ret = -EINVAL;

if (a)
 ret = x;
else if (b)
 ret = y;

>> else
>> ret = -EINVAL;

Those are redundant.

if (ret)
 return ret;

3. #ifdef:s are ugly.
For CONFIG_PM_SLEEP functions just use
__maybe_unused attribute.

4. Try to avoid #ifdef CONFIG_OF (this will limit driver for OF case
when it might be used elsewhere, e.g. ACPI case)

5. Check headers and library for existing helpers. I believe some of
your bit operations and such already have nice helpers in kernel.

-- 
With Best Regards,
Andy Shevchenko
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
