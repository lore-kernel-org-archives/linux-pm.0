From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 5/9] ARM: tegra2: cpuidle: change driver initialization
Date: Wed, 03 Apr 2013 14:09:55 +0200
Message-ID: <515C1C13.801@linaro.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org>  <1364553095-25110-5-git-send-email-daniel.lezcano@linaro.org>  <5155BB27.4000405@wwwdotorg.org>  <515C101F.1020801@linaro.org> <1364988239.16957.78.camel@jlo-ubuntu-64.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <1364988239.16957.78.camel-yx3yKKdKkHfc7b1ADBJPm0n48jw8i0AO@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>
Cc: Stephen Warren <swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org>, "rjw-KKrjLPT3xs0@public.gmane.org" <rjw-KKrjLPT3xs0@public.gmane.org>, "linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org" <patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>, "linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org" <linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org>, "linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org" <linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, "linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org" <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>, "rnayak-l0cyMroinI0@public.gmane.org" <rnayak-l0cyMroinI0@public.gmane.org>, "linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org" <linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>, "horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org" <horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org>, "santosh.shilimkar-l0cyMroinI0@public.gmane.org" <santosh.shilimkar-l0cyMroinI0@public.gmane.org>, "arnd-r2nGTMty4D4@public.gmane.org" <arnd-r2nGTMty4D4@public.gmane.org>, "lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org" <lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, "nsekhar-l0cyMroinI0@public.gmane.org" <nsekhar-l0cyMroinI0@public.gmane.org>
List-Id: linux-pm@vger.kernel.org

On 04/03/2013 01:23 PM, Joseph Lo wrote:
> On Wed, 2013-04-03 at 19:18 +0800, Daniel Lezcano wrote:
>> On 03/29/2013 05:02 PM, Stephen Warren wrote:
>>> On 03/29/2013 04:31 AM, Daniel Lezcano wrote:
>>>> Initialize the idle states directly in the driver structure.
>>>>
>>>> That prevents extra structure declaration and memcpy at init time.
>>>
>>> Joseph, can you please review/ack patch 5/9 and patch 6/9. Thanks.
>>
>> Thanks Joseph to review the patches.
>>
>> Rafael is expecting an Acked-by.
>>
>> If you are ok, with these patches, is it possible to ack them please=
 ?
>>
> OK.
>=20
> The 5/9 and 6/9 of this series.
> Acked-by: Joseph Lo <josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org>

Thanks Joseph.




--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
