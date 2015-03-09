From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [RFC/PATCH 0/6] Add CPUIdle support for Renesas SoCs
Date: Mon, 09 Mar 2015 16:32:26 +0100
Message-ID: <54FDBD0A.5060001@linaro.org>
References: <1425444946-3084-1-git-send-email-keita.kobayashi.ym@renesas.com> <54F89A23.1060008@linaro.org> <54F97599.7050904@renesas.com> <20150309152155.GC456@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20150309152155.GC456@linaro.org>
Sender: linux-sh-owner@vger.kernel.org
To: keita kobayashi <keita.kobayashi.ym@renesas.com>
Cc: Lina Iyer <lina.iyer@linaro.org>, horms@verge.net.au, rjw@rjwysocki.net, linux-sh@vger.kernel.org, linux-pm@vger.kernel.org, magnus.damm@gmail.com
List-Id: linux-pm@vger.kernel.org

On 03/09/2015 04:21 PM, Lina Iyer wrote:
> On Fri, Mar 06 2015 at 02:38 -0700, keita kobayashi wrote:
>> Hi Daniel

[ ... ]

>>>
>>> Hi Keita,
>>>
>>> the platform approach to pass private data from the arch specific t=
o
>>> the cpuidle driver no longer accepted. Unfortunately, there is no
>>> alternate solution upstream.
>>>
>>> But hopefully, there is a patchset [1] submitted for upstreaming
>>> which unify arm32/64 into a single generic cpuidle driver and use t=
he
>>> DT to define the idle functions to be used.
>>>
>>> I suggest you have a look at this patchset if it can fit your need.
>>>
>>>   -- Daniel
>>>
>>> [1] https://lkml.org/lkml/2015/3/3/271
>>
>> Thank you for information.
>> I will take a look at the patch series.
>
> Hi Kieta,
>
> Please also have a look at the v15 of the cpuidle support for QCOM So=
C.
> Sent just now.  It is based on [1].

Lina's patchset is available at:

https://www.mail-archive.com/devicetree@vger.kernel.org/msg64700.html

Thanks
   -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

