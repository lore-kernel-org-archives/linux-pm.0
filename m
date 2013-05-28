From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 10/12] ARM: shmobile: r8a7740: Add CPUIdle
Date: Tue, 28 May 2013 08:08:41 +0200
Message-ID: <51A449E9.5020508@linaro.org>
References: <1369645193-3595-1-git-send-email-horms+renesas@verge.net.au> <1369645193-3595-11-git-send-email-horms+renesas@verge.net.au> <51A33D83.905@linaro.org> <20130528035446.GJ13532@quad.lixom.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-sh-owner@vger.kernel.org>
In-Reply-To: <20130528035446.GJ13532@quad.lixom.net>
Sender: linux-sh-owner@vger.kernel.org
To: Olof Johansson <olof@lixom.net>
Cc: Simon Horman <horms+renesas@verge.net.au>, Arnd Bergmann <arnd@arndb.de>, linux-sh@vger.kernel.org, Bastian Hecht <hechtb+renesas@gmail.com>, Magnus Damm <magnus.damm@gmail.com>, Bastian Hecht <hechtb@gmail.com>, arm@kernel.org, linux-arm-kernel@lists.infradead.org, "rafael >> \"'Rafael J. Wysocki'\"" <rafael.j.wysocki@intel.com>, Linux PM mailing list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 05/28/2013 05:54 AM, Olof Johansson wrote:
> On Mon, May 27, 2013 at 01:03:31PM +0200, Daniel Lezcano wrote:
>> On 05/27/2013 10:59 AM, Simon Horman wrote:
>>> From: Bastian Hecht <hechtb@gmail.com>
>>>
>>> We make use of the r8a7740 Suspend To Ram code to plug together a
>>> CPUIdle driver.
>>>
>>> Signed-off-by: Bastian Hecht <hechtb+renesas@gmail.com>
>>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>> ---
>>
>> Shouldn't it go through Rafael's tree ? Or does the patch contains s=
ome
>> dependencies on a code only visible in the ARM tree ?
>=20
> Missing S-o-b from Simon. But this patch clearly builds on the preced=
ing
> one in the series, so merging them independently might not make much
> sense. Getting an ack from Rafael would be nice though.

I was not suggesting to put the driver in the drivers/cpuidle directory
but to merge the driver through Rafael's tree as we decided some weeks
ago [1]. Although having the drivers all over the place does not help t=
o
consolidate the code, so moving them little by little to drivers/cpuidl=
e
makes sense but this is part of another work.

> I was going to say that it should probably go under drivers/cpuidle a=
s
> well, but that just seems silly -- there is practically no code to sh=
are
> with any other platform in this small driver, AND there's not really
> any subsystem-internal data exposed. So it might just make more sense
> to keep it under arch/arm instead.
>=20
> Likewise, looking at the kirkwood and calxeda drivers under drivers/c=
puidle,
> I'm wondering why we thought it was a good idea to merge them there, =
besides
> getting caught up in the "nothing can live under arch/arm any more" f=
renzy.

Having the drivers in the drivers/cpuidle directory like drivers/cpufre=
q
will help to keep a consistency with the code and a single entry point
for upstream and review.

Thanks.
  -- Daniel

[1] https://patchwork.kernel.org/patch/2492841/

--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

