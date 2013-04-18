From: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
Subject: Re: [PATCH 1/9] ARM: cpuidle: remove useless declaration
Date: Thu, 18 Apr 2013 17:47:05 +0200
Message-ID: <51701579.1040603@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org> <515C1F3B.5040008@linaro.org> <20130418141359.GT14496@n2100.arm.linux.org.uk> <517003CF.5090106@linaro.org> <20130418154236.GY14496@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org>
In-Reply-To: <20130418154236.GY14496-l+eeeJia6m9vn6HldHNs0ANdhmdF6hFW@public.gmane.org>
Sender: linux-tegra-owner-u79uwXL29TY76Z2rM5mHXA@public.gmane.org
To: Russell King - ARM Linux <linux-lFZ/pmaqli7XmaaqVzeoHQ@public.gmane.org>
Cc: deepthi-23VcF4HTsmIX0ybBhKVfKdBPR1lH4CV8@public.gmane.org, linaro-kernel-cunTk1MwBs8s++Sfvej+rw@public.gmane.org, swarren-3lzwWm7+Weoh9ZMKESR00Q@public.gmane.org, linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, patches-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org, nsekhar-l0cyMroinI0@public.gmane.org, rjw-KKrjLPT3xs0@public.gmane.org, rnayak-l0cyMroinI0@public.gmane.org, josephl-DDmLM1+adcrQT0dZR+AlfA@public.gmane.org, linux-tegra-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, horms+renesas-/R6kz+dDXgpPR4JQBCEnsQ@public.gmane.org, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org, lenb-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On 04/18/2013 05:42 PM, Russell King - ARM Linux wrote:
> On Thu, Apr 18, 2013 at 04:31:43PM +0200, Daniel Lezcano wrote:
>> On 04/18/2013 04:13 PM, Russell King - ARM Linux wrote:
>>> On Wed, Apr 03, 2013 at 02:23:23PM +0200, Daniel Lezcano wrote:
>>>> On 04/03/2013 02:15 PM, Daniel Lezcano wrote:
>>>>> The noop functions code is not necessary because the header file =
is
>>>>> included in files which are compiled when CONFIG_CPU_IDLE is on.
>>>>>
>>>>> Signed-off-by: Daniel Lezcano <daniel.lezcano-QSEj5FYQhm4dnm+yROfE0A@public.gmane.org>
>>>>
>>>> I have been involved in the development of this file. I know Rob i=
s no
>>>> longer working on this neither monitoring the code.
>>>>
>>>> Russell are you ok with this patch ? Rafael needs your ack to take=
 this
>>>> patch into its tree.
>>>
>>> I don't know - the description doesn't make it clear.  Surely, what=
 you
>>> checked was that this file is _not_ included in any file which is b=
uilt
>>> when CONFIG_CPU_IDLE is disabled.  In other words, when CONFIG_CPU_=
IDLE
>>> is not defined, arm_cpuidle_simple_enter() is never referenced.
>>>
>>> If that is the case, then it's just that the patch description is t=
he
>>> opposite of what it should be for this patch - and then the patch a=
nd
>>> description match and I don't see any reason to say no to it.
>>>
>>> Then comes the issue of who takes the patch.  It looks like Rafael
>>> would like me to.
>>
>> Actually Rafael was willing to take the patch if you ack it.
>=20
> Well, I want to see a proper description on the patch which describes
> what it _is_ doing before I ack it.  The existing description is just
> plain confusing.

Ok, I will resend.

Thanks
  -- Daniel


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
