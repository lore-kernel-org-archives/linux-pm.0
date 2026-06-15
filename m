Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C96737DE90;
	Mon, 15 Jun 2026 12:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781525477; cv=none; b=YsF+8dL6CfljAoj4Dq3FjzZyYmcCJHPnEPRV5M3aoMUawBdiUMSm/fGrQxtvN0t5/ZW17UoG+XpR+4qgVSaFszAQ8Xeo0oUzGU040J8Zc47HwVwCaAdQ3+F7HmMRj6uwUEsAcoJGoVe2yyLmBrMbAoHqtXP2bBHTFeo3f+XP/vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781525477; c=relaxed/simple;
	bh=FANZUCVXVRpn2CEeRrNobR3DPc0KUQ/Ujz4qmUnKyFc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=TDcBa/pYP9WlbBFVbdn6xqAml1vpN0aPmX3L3d4d/fLswpWlTOcbCV9KAJPF98XXyixROr2BUHnAPd7ihgrpdX2xppvnp3E312N93xgj5zWVOT8SDiq3UexxBVT3QuUsruQMA3ENsgZhU4unZ/uG/A3h8EzT3wa/DfPwjrv1aP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=Lrd3GhbC; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="Lrd3GhbC"
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4gf89D2qK2z9vCH;
	Mon, 15 Jun 2026 14:11:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1781525472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=C2ni2HKLJTKwWZDPeU4N3Yd1IXA3apJPvhe3IpmDCyc=;
	b=Lrd3GhbCEc5wkRYKdr2J366BSm0U6EkvUYfCptFiN9eJRq+LITYHf3+5N8ANNvuNXLOJ6k
	8lvR3SYktrUnYFp4ZOWQibYOL1iVpIFxe/rD6QJzOFERqj4qbSQN94qDW6hXWEmF+JJ29b
	DPO2Yvp45sdI2YgMxR+Y+EWn8gkC9KuME+ViX54t222iAWcm4PJnydxnAzL7KW0aaytNZp
	ymhDbnOF9Xjo6It6uDPDKzgCDQcVaXews96bYjsd78yjj4BQUodKP6WiKVCJO/c8sug//A
	JpRmUJkSCPmMxotQUfUn/fyX8KiZnmeE5JhH2Z0OsnlMqpf4e/P845hOCqbr/g==
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 15 Jun 2026 20:11:01 +0800
Message-Id: <DJ9M2IDYE6XZ.20RN5AFBYNB9Y@mailbox.org>
Cc: "Rafael J. Wysocki" <rafael@kernel.org>, "Rob Herring"
 <robh@kernel.org>, "Krzysztof Kozlowski" <krzk+dt@kernel.org>, "Conor
 Dooley" <conor+dt@kernel.org>, "Paul Walmsley" <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>,
 "Alexandre Ghiti" <alex@ghiti.fr>, "Yixun Lan" <dlan@kernel.org>,
 <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
 <linux-riscv@lists.infradead.org>, <spacemit@lists.linux.dev>,
 <devicetree@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] cpufreq: spacemit: Add K1 cpufreq driver
From: "Shuwei Wu" <shuwei.wu@mailbox.org>
To: "Viresh Kumar" <viresh.kumar@linaro.org>
References: <20260612-shadow-deps-v3-0-2f3ba88611ff@mailbox.org>
 <20260612-shadow-deps-v3-1-2f3ba88611ff@mailbox.org>
 <bd4s2icqgusnuujvrpoag4cniy3g2e4bumecqxt5yffl77aqpq@kxg4dj4c2wk3>
 <DJ9EFPG561VZ.1WGRYYHJ2W9J9@mailbox.org>
 <wjwkykv555gkeqxabsqcdfn4lomcopawsv7bgm4bydc5likhjs@p3ca3p7wbri5>
In-Reply-To: <wjwkykv555gkeqxabsqcdfn4lomcopawsv7bgm4bydc5likhjs@p3ca3p7wbri5>
X-MBO-RS-ID: 8f80bbf1dd5291ba946
X-MBO-RS-META: edisx4wchww8awjnyt6qkyss1w8jk1uh

Hi Viresh,

Thanks for pointing it out.

On Mon Jun 15, 2026 at 2:34 PM CST, Viresh Kumar wrote:
> Hi Shuwei,
>
> On 15-06-26, 14:12, Shuwei Wu wrote:
>> The clusters have separate clocks, but they share the same voltage suppl=
y.[1]
>> So two independent policies would be unsafe: one policy could lower the =
shared
>> voltage while the other cluster is still running at a higher frequency.
>
> No, both will vote for the regulator contraints using CPU device and the
> regulator core will make sure it doesn't break any of them. This is what =
all
> frameworks do, regulator, clk, etc.
>
>> This means they can't use different policies.
>
> This is incorrect.
>
>> From a hardware perspective, the eight cores of the K1 are homogeneous,
>> so using the same policy for them is relatively reasonable.
>
> Right, but this is inefficient. One cluster can be idle, or in low freq m=
ode
> while other can be in higher. They MUST be two policies.

Yes, you're right. Two policies are not inherently unsafe.
The regulator framework handles multi-consumer voting correctly.

The actual problem was using single value opp-microvolt. With one cluster a=
t
a low frequency holding a precise [950000, 950000] on the shared rail, and =
the
other requesting [1050000, 1050000] for 1.6 GHz, the regulator finds no
intersection:

~ # echo 1600000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_setspeed
[  544.744195] buck1: Restricting voltage, 1050000-950000uV
[  544.757073] cpu cpu0: _set_opp_voltage: failed to set
              voltage (1050000 1050000 1050000 mV): -22
[  544.771304] cpufreq: __target_index: Failed to change
              cpu frequency: -22

The fix is to use the <target min max> triplet for the lower OPPs so the
regulator always has a valid intersection:

-    cpu_opp_table: opp-table-cpu {
+    cluster0_opp_table: opp-table-cluster0 {
         compatible =3D "operating-points-v2";
         opp-shared;
         opp-614400000 {
-            opp-microvolt =3D <950000>;
+            opp-microvolt =3D <950000 950000 1050000>;
         };
         opp-819000000 {
-            opp-microvolt =3D <950000>;
+            opp-microvolt =3D <950000 950000 1050000>;
         };
         ...
         opp-1600000000 {
             opp-microvolt =3D <1050000>;
         };
     };
+    cluster1_opp_table: opp-table-cluster1 {
+        // same OPP entries and voltage ranges as above
+    };
-    &cpu_0 { operating-points-v2 =3D <&cpu_opp_table>; };
+    &cpu_0 { operating-points-v2 =3D <&cluster0_opp_table>; };
     ...
-    &cpu_7 { operating-points-v2 =3D <&cpu_opp_table>; };
+    &cpu_3 { operating-points-v2 =3D <&cluster0_opp_table>; };
+    &cpu_4 { operating-points-v2 =3D <&cluster1_opp_table>; };
     ...
+    &cpu_7 { operating-points-v2 =3D <&cluster1_opp_table>; };

This way the low frequency cluster accepts up to 1.05 V on the rail.
That is safe: high voltage at low frequency costs power but does not cause
instability.

With two cpufreq-dt policies (one per cluster) and these ranges, neither cl=
uster
blocks the other. Tested on BPI-F3 and OrangePi Rv2 boards, works as expect=
ed.

Does this look good to you, or would you prefer a different approach?
>
>> I used a K1-specific driver because cpufreq-dt only manages one CPU cloc=
k
>> through the CPU device used for the OPP transition.
>> On K1, the policy needs to control two independent cluster clocks and on=
e shared
>> regulator, so the driver has to update the second cluster clock explicit=
ly and
>> keep the ordering safe: raise voltage before raising either cluster, and=
 lower
>> both cluster clocks before lowering the shared voltage.
>>=20
>> [1] https://lore.kernel.org/spacemit/aeaXszeaE62rM6BJ@aurel32.net/

--=20
Best regards,
Shuwei Wu
