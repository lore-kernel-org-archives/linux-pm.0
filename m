Received: from mout-p-103.mailbox.org (mout-p-103.mailbox.org [80.241.56.161])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238A43E120B;
	Mon, 18 May 2026 08:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.161
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779094069; cv=none; b=LbnqWlTsqXriVBUe5/W7uQTrtdEhFRiYtXfPOOr4bI0QbgaeippFQmKAU7sMIOXucvGX36CRMag6Fl5A0BaUZ/P5ct9cEiOjTpsomoWX9JvgoO72IpyvCbRh6Dp1Y3I4SFOp6qEGw1Gz1pHRGDuv3HW+f5qUkC3c7PhLlXQb1DU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779094069; c=relaxed/simple;
	bh=DHPAKjRLYypwh3bA49mBwncAmaZJK8amg2Af0dOXzfY=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=FofwFkESKVJ4aTuzGqrzwbwcw7lbfxcTmP6mDrp3GPt+L3pOZx8JJgt6Wag7U0h2kcc4OatkLRRowyyV6Q8/VFOvQuhkZPz3bl9t+ORISfPM28KgCOqLSUvdm1fUEw5YTzbop0RU84zqze20XxO+MeqVCl9Nvm7f6JRhP/gMTbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=bbj+B+MR; arc=none smtp.client-ip=80.241.56.161
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="bbj+B+MR"
Received: from smtp102.mailbox.org (smtp102.mailbox.org [IPv6:2001:67c:2050:b231:465::102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-103.mailbox.org (Postfix) with ESMTPS id 4gJrzL552tz9v7Y;
	Mon, 18 May 2026 10:47:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779094062;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GlgVOaC185Vrws/963WnBHTcONduokD+jbAIjLcGsU0=;
	b=bbj+B+MRhSa8fFMr2AAd0F2ATSdCQS0S7e9bnjhpQdVICeI0aDR1I/DKWY8DPaDHQluakp
	gwy92Ql3tC9F0fSIRLcOTvK0/ceDXpKh0aDz32TESqF19i1LKdZSVj/eKP/3q6DwPlUuj1
	tXqFSOVJusgezXfrty1crLjjq2YdjDH/ZmAdNVEdZv906xklDJQsImlSz4QHDbxOhy8+bV
	IqcgbA5gV06p4f0DatnC+D0brpT0GEKQMy7e/J23EfwC2AwhXvuy83l4dSI/U6aTll3kDW
	yMB6H+DnXaufj/GVoA4PQFUvipRxmrdALASFF6HHz9yBoh2jhCI0MFe1/ZfLLw==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 18 May 2026 16:46:55 +0800
Message-Id: <DILO6ZRWYPUO.3ULDGZ95JZ9SP@mailbox.org>
Subject: Re: [PATCH v2 2/2] riscv: dts: spacemit: Add cpu scaling for K1 SoC
From: "Shuwei Wu" <shuwei.wu@mailbox.org>
To: "Anand Moon" <linux.amoon@gmail.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, "Viresh Kumar" <viresh.kumar@linaro.org>, "Rob
 Herring" <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
 "Conor Dooley" <conor+dt@kernel.org>, "Paul Walmsley" <pjw@kernel.org>,
 "Palmer Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Yixun Lan" <dlan@kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <devicetree@vger.kernel.org>
References: <20260410-shadow-deps-v2-0-4e16b8c0f60e@mailbox.org>
 <20260410-shadow-deps-v2-2-4e16b8c0f60e@mailbox.org>
 <CANAwSgSNHO3MNewNzpYbhuj4K3NTdfzDC9KPoUHbFH97P4M_UQ@mail.gmail.com>
 <DHUCL24GMX7D.369IWK9DLPZPX@mailbox.org>
 <CANAwSgRt5-t_ah=phGc+CQYHG-CdWJuOX-2VTW6xE7n7EnVsFw@mail.gmail.com>
 <aeaXszeaE62rM6BJ@aurel32.net> <DHYOIIFMGH7J.228ISQ7XYFGKE@mailbox.org>
 <aeevr6Zj3Pwm9wux@aurel32.net>
 <CANAwSgSCo-mESo6=KSc08oUzTWAgzpYu0JaW5KqmnCNiPYHjxQ@mail.gmail.com>
 <CANAwSgRFQiNEi1Ac+sCvJWkj1R+yEPGt0RCjZu-3ZiD0Ffm6Hg@mail.gmail.com>
In-Reply-To: <CANAwSgRFQiNEi1Ac+sCvJWkj1R+yEPGt0RCjZu-3ZiD0Ffm6Hg@mail.gmail.com>
X-MBO-RS-META: nx3ns7n3zttnticfsuooxwsz1st8cz3x
X-MBO-RS-ID: 516b02047a5133bc5ab

Hi Anand,

Thank you for your consistent attention and practical suggestions.

On Sun May 17, 2026 at 12:35 PM CST, Anand Moon wrote:
> Hi Shuwei,
>
> On Wed, 22 Apr 2026 at 11:44, Anand Moon <linux.amoon@gmail.com> wrote:
>>
>> Hi Shuwei,
>>
>> On Tue, 21 Apr 2026 at 22:41, Aurelien Jarno <aurelien@aurel32.net> wrot=
e:
>> >
>> > Hi,
>> >
>> > On 2026-04-21 16:10, Shuwei Wu wrote:
>> > > Hi Aurelien,
>> > >
>> > > Thanks for your addition.
>> > >
>> > > On Tue Apr 21, 2026 at 5:16 AM CST, Aurelien Jarno wrote:
>> > > > Hi Anand,
>> > > >
>> > > > On 2026-04-16 17:07, Anand Moon wrote:
>> > > >> After reviewing the Banana Pi F3 schematics, I confirmed that Buc=
k1 and Buck2
>> > > >> Both supply the CORE_0V9 with 0.9V=C2=B11% rail. To resolve the r=
estriction errors,
>> > > >> I expanded the voltage range in the DTS to 500,000=E2=80=93950,00=
0 =C2=B5V.
>> > > >>
>> sorry I was wrong from the doc below 1.2.1 CORE Power Design
>>
>> The typical core voltage is 0.9 V to 1.05 V. Actual voltage is
>> dynamically regulated by
>> the **remote-sense dynamic voltage** adjustment circuit inside P1.
>> P1 BUCK1 and BUCK2 must be combined to supply the core rail.
>>
>> [1] https://www.spacemit.com/community/document/info?nodepath=3Dhardware=
/key_stone/k1/k1_hw/k1_hw_design_guide.md&lang=3Den
>>
>> > > >> Additionally, I updated the DTS to map the second CPU cluster (co=
res 4=E2=80=937)
>> > > >> to Buck2 to better align with the hardware's power distribution.
>> > > >
>> > > > Actually the output of Buck1 and Buck2 are connected together, so =
they
>> > > > should always be configured with the same output voltage. And both
>> > > > clusters should be mapped to both outputs.
>> > >
>> > > You are right, I received the same response from the official develo=
pers.
>> > >
>> > > Therefore, I'm wondering if an additional regulator-coupled-with: pr=
operty
>> > > definition is also needed here?
>> >
>> correct.
>> > Yes, I think this is the way to go. I even wonder if this shouldn't be=
 a
>> > fix with Cc: stable. This also has to be done for the Milk-V Jupiter
>> > board, I haven't checked the other boards yet, but I guess they all us=
e
>> > the same schematics at that the PMIC level.
>> >
>> > Regards
>> > Aurelien
>> >
>
> The following changes resolve the warning on my setup.
> If possible, please integrate them into the next version.
>
> diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> index c2a1b759d41f..8512c7417f94 100644
> --- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> +++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
> @@ -116,19 +116,19 @@ &cpu_3 {
>  };
>
>  &cpu_4 {
> -       cpu-supply =3D <&buck1_3v45>;
> +       cpu-supply =3D <&buck2_3v45>;
>  };
>
>  &cpu_5 {
> -       cpu-supply =3D <&buck1_3v45>;
> +       cpu-supply =3D <&buck2_3v45>;
>  };
>
>  &cpu_6 {
> -       cpu-supply =3D <&buck1_3v45>;
> +       cpu-supply =3D <&buck2_3v45>;
>  };
>
>  &cpu_7 {
> -       cpu-supply =3D <&buck1_3v45>;
> +       cpu-supply =3D <&buck2_3v45>;
>  };
>
>  &emmc {
> @@ -248,14 +248,14 @@ pmic@41 {
>                 regulators {
>                         buck1_3v45: buck1 {
>                                 regulator-min-microvolt =3D <500000>;
> -                               regulator-max-microvolt =3D <3450000>;
> +                               regulator-max-microvolt =3D <950000>;
>                                 regulator-ramp-delay =3D <5000>;
>                                 regulator-always-on;
>                         };
>
> -                       buck2 {
> +                       buck2_3v45: buck2 {
>                                 regulator-min-microvolt =3D <500000>;
> -                               regulator-max-microvolt =3D <3450000>;
> +                               regulator-max-microvolt =3D <1050000>;
>                                 regulator-ramp-delay =3D <5000>;
>                                 regulator-always-on;
>                         };

As previously discussed, Buck1 and Buck2 are connected and must share the s=
ame
voltage. However, you not only separated them but also set their voltage ra=
nges
to different values, which violates the requirement.

Additionally, in the schematic, 0.9V represents the default output voltage,
not the maximum.

The problem you noted likely stems from different clusters sharing
the same voltage while having different OPP tables.

In the new patch, I will unify them to use the same OPP table.

>
> Thnaks
> -Anand

--=20
Best regards,
Shuwei Wu

