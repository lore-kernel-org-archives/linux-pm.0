From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: Re: [PATCH v3 5/6] regulator: max77843: Add max77843 regulator driver
Date: Thu, 05 Feb 2015 15:27:03 +0900
Message-ID: <54D30D37.5010301@samsung.com>
References: <1423025771-4139-1-git-send-email-jaewon02.kim@samsung.com>
 <1423025771-4139-6-git-send-email-jaewon02.kim@samsung.com>
 <20150204202645.GG21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout1.samsung.com ([203.254.224.24]:52406 "EHLO
	mailout1.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751190AbbBEG1G (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Feb 2015 01:27:06 -0500
In-reply-to: <20150204202645.GG21293@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Beomho Seo <beomho.seo@samsung.com>

Hi Mark,

2015=EB=85=84 02=EC=9B=94 05=EC=9D=BC 05:26=EC=97=90 Mark Brown =EC=9D=B4=
(=EA=B0=80) =EC=93=B4 =EA=B8=80:
> On Wed, Feb 04, 2015 at 01:56:10PM +0900, Jaewon Kim wrote:
>> This patch adds new regulator driver to support max77843
>> MFD(Multi Function Device) chip`s regulators.
>> The Max77843 has two voltage regulators for USB safeout.
> Applied, thanks.

I made a mistake in this patch.
volt_table value was not fixed correctly.
I will send fixed driver soon. plz change it.

Thanks,
Jaewon Kim

