From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH 2/2] ARM: cpuidle: Document the code
Date: Wed, 25 Mar 2015 08:03:56 +0100
Message-ID: <55125DDC.9000901@linaro.org>
References: <20150323225828.GC15435@e102568-lin.cambridge.arm.com> <1427190842-30675-1-git-send-email-daniel.lezcano@linaro.org> <1427190842-30675-2-git-send-email-daniel.lezcano@linaro.org> <20150324185144.GB27311@red-moon>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wi0-f172.google.com ([209.85.212.172]:37097 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751148AbbCYHEB (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 25 Mar 2015 03:04:01 -0400
Received: by wixw10 with SMTP id w10so24673283wix.0
        for <linux-pm@vger.kernel.org>; Wed, 25 Mar 2015 00:03:59 -0700 (PDT)
In-Reply-To: <20150324185144.GB27311@red-moon>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, "robherring2@gmail.com" <robherring2@gmail.com>, "arnd@arndb.de" <arnd@arndb.de>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "lina.iyer@linaro.org" <lina.iyer@linaro.org>, "sboyd@codeaurora.org" <sboyd@codeaurora.org>

On 03/24/2015 07:51 PM, Lorenzo Pieralisi wrote:
> On Tue, Mar 24, 2015 at 09:54:02AM +0000, Daniel Lezcano wrote:
>> Add kernel-doc format documentation in the code.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---

[ ... ]

>> + * Returns:
>> + *  0 on success,
>> + *  -ENODEV if it fails to find the cpu node in the device tree,
>> + *  -EOPNOTSUPP if it does not find a registered cpuidle_ops for th=
is cpu,
>> + *  -ENOENT if it fails to find a enabled-method property,
>
> Ultra-nit: "an enabled-method"
>
>> + *  -ENXIO if the HW reports a failure or a misconfiguration
>
> -ENOMEM is missing.
>
> Apart from these ultraminor changes (and thanks for putting it
> together):
>
> Acked-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>

Thanks for review Lorenzo. I fixed the comment and pushed in my tree fo=
r=20
4.1.

  -- Daniel

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

