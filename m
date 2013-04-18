From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 1/9] ARM: cpuidle: remove useless declaration
Date: Thu, 18 Apr 2013 16:31:43 +0200
Message-ID: <517003CF.5090106@linaro.org>
References: <1364991322-20585-1-git-send-email-daniel.lezcano@linaro.org> <515C1F3B.5040008@linaro.org> <20130418141359.GT14496@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-bk0-f43.google.com ([209.85.214.43]:53051 "EHLO
	mail-bk0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965622Ab3DRObt (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 18 Apr 2013 10:31:49 -0400
Received: by mail-bk0-f43.google.com with SMTP id jm19so103703bkc.16
        for <linux-pm@vger.kernel.org>; Thu, 18 Apr 2013 07:31:48 -0700 (PDT)
In-Reply-To: <20130418141359.GT14496@n2100.arm.linux.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: rjw@sisk.pl, deepthi@linux.vnet.ibm.com, linaro-kernel@lists.linaro.org, swarren@wwwdotorg.org, patches@linaro.org, linux-pm@vger.kernel.org, rnayak@ti.com, nsekhar@ti.com, josephl@nvidia.com, linux-tegra@vger.kernel.org, horms+renesas@verge.net.au, linux-arm-kernel@lists.infradead.org, lenb@kernel.org

On 04/18/2013 04:13 PM, Russell King - ARM Linux wrote:
> On Wed, Apr 03, 2013 at 02:23:23PM +0200, Daniel Lezcano wrote:
>> On 04/03/2013 02:15 PM, Daniel Lezcano wrote:
>>> The noop functions code is not necessary because the header file is
>>> included in files which are compiled when CONFIG_CPU_IDLE is on.
>>>
>>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>>
>> I have been involved in the development of this file. I know Rob is =
no
>> longer working on this neither monitoring the code.
>>
>> Russell are you ok with this patch ? Rafael needs your ack to take t=
his
>> patch into its tree.
>=20
> I don't know - the description doesn't make it clear.  Surely, what y=
ou
> checked was that this file is _not_ included in any file which is bui=
lt
> when CONFIG_CPU_IDLE is disabled.  In other words, when CONFIG_CPU_ID=
LE
> is not defined, arm_cpuidle_simple_enter() is never referenced.
>=20
> If that is the case, then it's just that the patch description is the
> opposite of what it should be for this patch - and then the patch and
> description match and I don't see any reason to say no to it.
>=20
> Then comes the issue of who takes the patch.  It looks like Rafael
> would like me to.

Actually Rafael was willing to take the patch if you ack it.


--=20
 <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for=
 ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

