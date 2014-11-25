From: Caesar Wang <caesar.wang@rock-chips.com>
Subject: Re: [PATCH v19 0/5] Rockchip soc thermal driver
Date: Tue, 25 Nov 2014 08:46:27 +0800
Message-ID: <5473D163.9070708@rock-chips.com>
References: <1416805142-27304-1-git-send-email-caesar.wang@rock-chips.com> <20141124201807.GA20404@developer> <1771961.FfLxNDNiti@diego>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from regular1.263xmail.com ([211.150.99.137]:36554 "EHLO
	regular1.263xmail.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750774AbaKYAqi (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 24 Nov 2014 19:46:38 -0500
In-Reply-To: <1771961.FfLxNDNiti@diego>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: =?UTF-8?B?SGVpa28gU3TDvGJuZXI=?= <heiko@sntech.de>, Eduardo Valentin <edubezval@gmail.com>
Cc: rui.zhang@intel.com, zyf@rock-chips.com, dianders@chromium.org, linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, linux-doc@vger.kernel.org, cf@rock-chips.com, dmitry.torokhov@gmail.com, huangtao@rock-chips.com, fzf@rock-chips.com

Heiko,

=E5=9C=A8 2014=E5=B9=B411=E6=9C=8825=E6=97=A5 07:39, Heiko St=C3=BCbner=
 =E5=86=99=E9=81=93:
> Hi Caesar,
>
> Am Montag, 24. November 2014, 16:18:12 schrieb Eduardo Valentin:
>> Hello Caesar,
>>
>> On Mon, Nov 24, 2014 at 12:58:57PM +0800, Caesar Wang wrote:
>>> This series patchs tested on rk3288 SDK board and pinky-v1,v2 board=
=2E
>>> I believe the driver can be used on the rk3288-evb board.
>>>
>>> Add this driver, The system will shutdown when
>>> the thermal temperture over 100C.If for some reason we are unable t=
o
>>> shut it down in orderly fashion (kernel is stuck holding a lock or
>>> similar)
>>> then hardware will reset it.
>>>
>>> The patchs 1/5,2/5 can applay Eduardo's Branch
>>> git://git.kernel.org/pub/scm/linux/kernel/git/evalenti/linux-soc-th=
ermal.g
>>> it [branch "next-kernel"]
>>>
>>> 	remote =3D origin
>>> 	merge =3D refs/heads/next
>> I applied your patches 1 and 2 in my -linus branch, and luckily will=
 be
>> accepted for 3.19.
> and I've taken patches 3, 4 and 5 into my dts branch for 3.19 .
>
> I've adapted the commit messages in some places and removed the
> 	/* sensor		ID */
> comments from the rk3288-thermal.dtsi.
>
OK,
Thanks!

> Heiko
>
>
>

--=20
Best regards,
Caesar


