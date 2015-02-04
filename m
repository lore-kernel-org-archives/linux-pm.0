From: Jaewon Kim <jaewon02.kim@samsung.com>
Subject: Re: [PATCH v2 5/6] regulator: max77843: Add max77843 regulator driver
Date: Wed, 04 Feb 2015 10:37:31 +0900
Message-ID: <54D177DB.3020705@samsung.com>
References: <1422939846-29955-1-git-send-email-jaewon02.kim@samsung.com>
 <1422939846-29955-6-git-send-email-jaewon02.kim@samsung.com>
 <20150203162536.GQ21293@sirena.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mailout3.samsung.com ([203.254.224.33]:49051 "EHLO
	mailout3.samsung.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751260AbbBDBhe (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 3 Feb 2015 20:37:34 -0500
In-reply-to: <20150203162536.GQ21293@sirena.org.uk>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Mark Brown <broonie@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, linux-pm@vger.kernel.org, Inki Dae <inki.dae@samsung.com>, SangBae Lee <sangbae90.lee@samsung.com>, Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Lee Jones <lee.jones@linaro.org>, Chanwoo Choi <cw00.choi@samsung.com>, Sebastian Reichel <sre@kernel.org>, Beomho Seo <beomho.seo@samsung.com>

Hi Mark,

2015=EB=85=84 02=EC=9B=94 04=EC=9D=BC 01:25=EC=97=90 Mark Brown =EC=9D=B4=
(=EA=B0=80) =EC=93=B4 =EA=B8=80:
> On Tue, Feb 03, 2015 at 02:04:05PM +0900, Jaewon Kim wrote:
>> This patch adds new regulator driver to support max77843
>> MFD(Multi Function Device) chip`s regulators.
>> The Max77843 has two voltage regulators for USB safeout.
> This looks mostly good, a couple of very small things:
>
>> +static const struct regulator_desc max77843_supported_regulators[] =
=3D {
>> +	[MAX77843_SAFEOUT1] =3D {
>> +		.name		=3D "SAFEOUT1",
>> +		.id		=3D MAX77843_SAFEOUT1,
>> +		.ops		=3D &max77843_regulator_ops,
>> +		.of_match	=3D of_match_ptr("SAFEOUT1"),
>> +		.regulators_node =3D of_match_ptr("regulators"),
>> +		.type		=3D REGULATOR_VOLTAGE,
>> +		.owner		=3D THIS_MODULE,
>> +		.n_voltages	=3D MAX77843_SUPPORTED_VOLTAGE_NUM,
>> +		.volt_table	=3D max77843_regulator_table,
> It's better to make n_voltages be ARRAY_SIZE() for the table, that wa=
y
> there's no need to keep the define and array lined up if someone exte=
nds
> the driver.  A name like _safeout_voltage_table might be clearer too.

I will change n_voltages value to ARRAY_SIZE() instead of define.
And fix volt_table enum variable name.
Thanks to advise.

Thanks
Jaewon Kim
