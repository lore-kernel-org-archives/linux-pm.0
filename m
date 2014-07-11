From: Tuomas Tynkkynen <ttynkkynen-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Subject: Re: [PATCH 12/13] cpufreq: Add cpufreq driver for Tegra124
Date: Fri, 11 Jul 2014 18:29:02 +0300
Message-ID: <53C002BE.90805@nvidia.com>
References: <1405028569-14253-1-git-send-email-ttynkkynen@nvidia.com> <1405028569-14253-13-git-send-email-ttynkkynen@nvidia.com> <CAKohpom9ORXFiUU4=V+CxgN0ZOFLMEhEjHiU8HsYUYDybNXgHQ@mail.gmail.com> <20140711091207.GY23218@tbergstrom-lnx.Nvidia.com> <20140711145735.GB6523@ulmo> <53BFFEAD.7000405@nvidia.com> <20140711151501.GA25810@ulmo>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20140711151501.GA25810@ulmo>
Sender: devicetree-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Thierry Reding <thierry.reding-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: Peter De Schrijver <pdeschrijver-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Viresh Kumar <viresh.kumar-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Linux Kernel Mailing List <linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, Prashant Gaikwad <pgaikwad-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>, Mike Turquette <mturquette-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "Rafael J. Wysocki" <rjw-LthD3rsA81gm4RdzfppkhA@public.gmane.org>, "devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <devicetree-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
List-Id: linux-pm@vger.kernel.org



On 11/07/14 18:15, Thierry Reding wrote:
> * PGP Signed by an unknown key
>
> On Fri, Jul 11, 2014 at 06:11:41PM +0300, Tuomas Tynkkynen wrote:
>> On 11/07/14 17:57, Thierry Reding wrote:
>>
>>>> I don't think that's going to work? The voltage scaling is handled in hw.
>>>
>>> Do we have to handle it in hardware or can we opt to do it in software,
>>> too?
>>>
>>
>> With the PLLX, voltage scaling is done entirely in SW. With the DFLL,
>> it's possible to stay in open-loop mode and do it in SW, but there's
>> not much point in that.
>
> It's kind of ugly how we need to pass the address of the PMU and the
> offset of the voltage control register to the DFLL which will then
> initiate I2C transactions itself. I'm wondering if that plays well with
> the I2C traffic originating from within the kernel.
>

On the hardware level, the two I2C controllers sharing the same pins
have knowledge of each other and won't start transmitting if the bus
is busy (something different from the usual I2C arbitration, that is).
I guess on the kernel side there could be a problem if the voltage 
register is marked cached in the PMIC driver's regmap.

-- 
nvpublic
--
To unsubscribe from this list: send the line "unsubscribe devicetree" in
the body of a message to majordomo-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
