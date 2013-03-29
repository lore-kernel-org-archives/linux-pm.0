From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/9] ARM: cpuidle: remove useless declaration
Date: Fri, 29 Mar 2013 12:53:46 +0100
Message-ID: <515580CA.30008@linaro.org>
References: <1364553095-25110-1-git-send-email-daniel.lezcano@linaro.org> <51557DC6.5060104@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <51557DC6.5060104-l0cyMroinI0@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Santosh Shilimkar <santosh.shilimkar-l0cyMroinI0@public.gmane.org>
Cc: rjw-KKrjLPT3xs0@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, arnd-r2nGTMty4D4@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 03/29/2013 12:40 PM, Santosh Shilimkar wrote:
> On Friday 29 March 2013 04:01 PM, Daniel Lezcano wrote:
>> The noop functions code is not necessary because the header file is
>> included in files which are compiled when CONFIG_CPU_IDLE is on.
>>
> Well the inline function was to avoid buid breaks when
> !CONFIG_CPU_IDLE.
>> Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>> ---
> Function without definition will break the build, No? Just
> declaration isn't won't help to get the build through.
>=20
> Ofcourse if all idle drivers are build *only when*
> CONFIG_CPU_IDLE=3Dy, then the patch is should
> be fine.

Yes, it is case AFAICT.


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
