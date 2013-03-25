From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 07/15] ARM: cpuidle: add init/exit routine
Date: Mon, 25 Mar 2013 22:53:18 +0100
Message-ID: <5150C74E.1040903@linaro.org>
References: <1364234140-514-1-git-send-email-daniel.lezcano@linaro.org> <1364234140-514-8-git-send-email-daniel.lezcano@linaro.org> <20130325181038.GA631@lunn.ch> <51509873.1010408@linaro.org> <alpine.LFD.2.03.1303251616070.1372@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:48548 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933323Ab3CYVxS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 25 Mar 2013 17:53:18 -0400
Received: by mail-wi0-f171.google.com with SMTP id hn17so10760382wib.10
        for <linux-pm@vger.kernel.org>; Mon, 25 Mar 2013 14:53:17 -0700 (PDT)
In-Reply-To: <alpine.LFD.2.03.1303251616070.1372@syhkavp.arg>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: Andrew Lunn <andrew@lunn.ch>, linaro-kernel@lists.linaro.org, magnus.damm@gmail.com, ben-linux@fluff.org, linux-pm@vger.kernel.org, nsekhar@ti.com, patches@linaro.org, rob.herring@calxeda.com, linux@arm.linux.org.uk, rjw@sisk.pl, kevin.hilman@linaro.org, horms@verge.net.au, jason@lakedaemon.net, kernel@pengutronix.de, kgene.kim@samsung.com, plagnioj@jcrosoft.com, linux@maxim.org.za, linux-arm-kernel@lists.infradead.org, lenb@kernel.org

On 03/25/2013 09:28 PM, Nicolas Pitre wrote:
> On Mon, 25 Mar 2013, Daniel Lezcano wrote:
>=20
>> On 03/25/2013 07:10 PM, Andrew Lunn wrote:
>>> On Mon, Mar 25, 2013 at 06:55:32PM +0100, Daniel Lezcano wrote:
>>>> The init and exit routine for most of the drivers are the same,
>>>> that is register the driver and register the device.
>>>>
>>>> Provide a common function to do that in the cpuidle driver for ARM=
,
>>>> so we can get rid of a lot of code duplication in the different SO=
C
>>>> cpuidle drivers.
>>>
>>> Hi Daniel
>>>
>>> Please could you add a comment in the code about which piece is
>>> specific to ARM, because its not obvious to me. Its not like there =
is
>>> a reference to WFI for example. It looks like this code could go in
>>> drivers/cpuidle/cpuidle.c
>>
>> Yes, I agree. At the first glance, the code, as it is, could go in t=
his
>> file but more ARM specific code will be moved to this ARM generic co=
de
>> driver like device tree description and couple idle states. The init
>> function would be more arch specific then.
>>
>> For this reason, I think it is reasonable to move to
>> arm/kernel/cpuidle.c rather than drivers/cpuidle/cpuidle.c first.
>=20
> No.
>=20
> Please move things under drivers/cpuidle/ upfront.
>
> We do want drivers to be gathered according to their purpose and=20
> subsystem, not according to the architecture they belong to.
>=20
> This is a simple maintenance optimization to do so.
>=20
> The reason is when someone wishes to improve the subsystem then that=20
> someone who might know nothing about the ARM or other architectures=20
> won't have to look for obscure drivers buried into arch specific=20
> directories.  When things are gathered under a common directory it is=
=20
> then much easier to perform wide ranging changes to a subsystem.
>=20
> And for those who do know the ARM architecture and wish to modify the=
=20
> ARM driver it is not that hard to locate the driver once.
>=20
> The "downside" for you might be that the activity under drivers/cpuid=
le/=20
> is more closely scrutinized by more people.  But that isn't a bad thi=
ng=20
> either.
>=20
>> In the future, when all the ARM cpuidle driver will be fully
>> consolidated, that will be easier to identify the common parts acros=
s
>> the different arch and then move them to the generic framework.
>=20
> Nothing prevents you from doing that consolidation work right in=20
> drivers/cpuidle/.

I fully agree with you but I think there is a misunderstanding.

The idea is to consolidate the ARM code in the ARM cpuidle driver which
is mostly empty. The init/exit functions could falsely lead someone to
think they could be moved in the generic framework but IMO it is too
soon because the code consolidation will bring some arch specificity an=
d
in this case we will going back and forth. I want to avoid that.

Let me consolidate the ARM driver, cleanup the headers to split the arc=
h
specific code from the rest and then move this driver to
drivers/cpuidle. This is just a question of a week.





--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

