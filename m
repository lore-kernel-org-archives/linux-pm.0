From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v2] clocksource: sh_cmt: Only perform clocksource suspend/resume
 if enabled
Date: Wed, 05 Aug 2015 18:59:21 +0200
Message-ID: <55C240E9.1070205@linaro.org>
References: <1436874064-2729-1-git-send-email-geert+renesas@glider.be>	<55A7B47F.7060202@linaro.org>	<CAMuHMdU-+-+zygoZneBe9SWM1u8VCmpYOMSB00v29KS4HX-37g@mail.gmail.com> <CAMuHMdU+dwETiSk4=rgpykbJt03Fe4dnSmHYJP6G_xC4M45N3w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAMuHMdU+dwETiSk4=rgpykbJt03Fe4dnSmHYJP6G_xC4M45N3w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Geert Uytterhoeven <geert+renesas@glider.be>, Thomas Gleixner <tglx@linutronix.de>, Linux PM list <linux-pm@vger.kernel.org>, Linux-sh list <linux-sh@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 08/05/2015 03:56 PM, Geert Uytterhoeven wrote:
> Hi Daniel,
>
> On Thu, Jul 16, 2015 at 4:03 PM, Geert Uytterhoeven
> <geert@linux-m68k.org> wrote:
>> On Thu, Jul 16, 2015 at 3:41 PM, Daniel Lezcano
>> <daniel.lezcano@linaro.org> wrote:
>>> do you mean to test if the patch [1] solves your problem.
>>>
>>>    -- Daniel
>>>
>>> [1] https://lkml.org/lkml/2015/1/16/81
>>
>> I'll give it a try after my holidays...
>
> Apparently that patch was integrated in v4.2-rc1, while I still see t=
he problem
> on recent kernels.
>
> Furthermore, that patch handles clockevents, not clocksources.
> struct clocksource doesn't seem to have a way to check if it's enable=
d,
> so I still need my patch.

Hmm, I see. I will take this patch as a fix then.

Thanks.
   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
