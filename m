Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4733D30C15F
	for <linux-pm@vger.kernel.org>; Sun, 17 May 2026 04:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778992570; cv=pass; b=k7Ypya8uOCarro9lpe07XHlKDBQl3swqHDbI7cRrp6jHQyvTTUxJy1bQJYbs787OQBBGiUPvWPd1eYrwxg8SsbUhEd+yPUa19ym/2MXprUgO89X71LO9aJL5Oi30l7Gpfz3ogzUX8PouUPhsKImVXy7/DSwJSz9tDwcogMtD4NY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778992570; c=relaxed/simple;
	bh=3ROR8haixq5iyUq7s9jdGclt/nlPcyVxpVzKqaY2PhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=kL7QJXdl5eN6vtCRbncdIQaHU75mWuG4ySZem+GgnwDHsvzWNdfVBTQfH/cUfTmMsDXXwVUI8MqESMy+dhrRg2Ety4CAvsFDgnvL85GnmzGNZ6/lvmb5HoSbtdEaUE8kvq0+QG0RP87v6ke3pHrJRc3oeLpatHrsMkaT+o6PFpU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TNtilZgr; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TNtilZgr"
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67929ff6dbfso2178248a12.2
        for <linux-pm@vger.kernel.org>; Sat, 16 May 2026 21:36:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778992568; cv=none;
        d=google.com; s=arc-20240605;
        b=L5P6jZn1RryaEAxO5JO4iPnYsUg/TUmGjJQSGSHLJT+zKT6jYTYLQVrYGI5sBwF3tq
         ret+hYK4rNHxQxXJ8Us8XQOyY3kM6khsSONBR2d+isatvb9Dhi8Lvf9zuTEpCpXLzPWf
         bwEgl+BtLOcyv3+vaJmopdbLcp0ctJMckkooVal7w4sZh8XoTjIOQcRd+ulwvWfJQtPm
         E812N7MNYPN7NkZFLVY7h+sUqASYsF3wCQX1i07kDzbaU+IpuhMr4CKMBmb3vqopZcbu
         5zgJKYULSxs8cWTuihw/iFm4zyz7qA2Pf+CZ4qSjJEpv/Zko55S4gog8fBg3WYTCV4/F
         BrtQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JQM4qBv1wE3brKr2hKxWej6MOZp+Tj3Sd6cgQ9f4fd8=;
        fh=XZiCZhpBsw+0nY7W0RkKiZqXn4t1Pj7ghjrhSxdA5Lc=;
        b=TPMjjkdbOqcfQ2KpOXRDqMVCIuOvRBU+i/wpgaKjKu19/8TRn08TfFDsMoeD6HmqRB
         Sx2puHj+l7ft/0pMQfqPhAOpk1WpJNeV9Sm2QF2owTB30CnqHkD+b/+hNg1Aq2ysdAsf
         oO8JtTechGM51W2CuaSxLeyHfN0Dq17WhxN2/al32kU+s8Oh81iehGuTllEOAuOc8O+k
         pOkUFm1turC1D7xcvZtAxph8sKo5S2ActZgklorc/1lVwjcgZvQQENNbf3IgoeI6VYbN
         xqPTUVVyYeDJ26+GnSslMytnQjKtvFY4sVdFEm621E3vdLLgoNuUcuspa9NIeSAsa870
         VEYg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778992568; x=1779597368; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JQM4qBv1wE3brKr2hKxWej6MOZp+Tj3Sd6cgQ9f4fd8=;
        b=TNtilZgrDSObvft0rs72S5LU8/iPtD5TFxdIS/zAxpziEZPYHXoGAeWPOadcggF9Ng
         Xc72sGCuGXSc+e70weVKiVX0yXaEsto6hGwl+Y6TA+z4eb8VXSFu1troVNz781M1hQvm
         4qNWQs8btax8sFq2ydZhfNtkVk+p2E1XS3bcrsL996P+nnWbUlW/+uZLHMl/9cEr905H
         89jKYG9XulBZtBf9IYzKA+z41bE4vQejhoDiMmt4SBKRYMgESMesKG5hyb7Z8d69Ag1b
         0YrRgNDe/+eM/dHZ+eE2FD3AejSub32bUgA6JPRV9qo5eTxbzRAI7fNxLGogSo9ePWcT
         jZBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778992568; x=1779597368;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JQM4qBv1wE3brKr2hKxWej6MOZp+Tj3Sd6cgQ9f4fd8=;
        b=h1lkrPpdBcbaEzETmql2Lb1/uBlLff+7mK/HUO7cTpNHX2Iyf7XJfDsnEmFWE0erDS
         oZ45JZsnoSn/Le7L3EnDHGzu57HMkcILUQwRPL5zJJxLkAastc7bnbSWCyx+wGf/LO+O
         NiYcPrmnza+DUpMQbkOPCF6bhHVAAOVCfBqQg+Gg8NUQmGCMggnA00OopAtSOaXLTGhp
         AnpEK2pllsx1d98AW8m+euIaBl2BmKaGEkGLr/ldN1IF+BlgLsGh/MEv4nhLK4MUiIWB
         /1AFOlfYQpdd+jBnoKn6fTERj9CNSdmO8RoEyo0In+xwre0L9r5LvwTw8UkEsJtfJf+F
         P2Lw==
X-Forwarded-Encrypted: i=1; AFNElJ9Dpe24PX8bZ6LPMrrsCn98XzYQ++FisNWRiErPnG4YOoT+vTdM5H6dfIY4tYs4Mw5vcBEnd0NjkA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yyr9eDzIUJ2AZp5hlvXSJEHlAPOE1bfN0mtSuGeTjzpMQq6ldPA
	+Mu/QOmL/xbqUvVySzTUW3aUlOfv1gR+cqjwfeZuyij4PmkCbHLXdzZobYJHVOh5j1WRjR2Dv30
	AhseUoTAigGTjaTG04R+aYpH1E7xpY+A=
X-Gm-Gg: Acq92OFlc76H2AtaSKeBfodKhfOJeSBRDhCxGNhRkwH3kpHIAQ0hptAGIv8G+LlUwrw
	dTIXE/ya9qZBWPX9K50X03iQs0ZujWh7KumZ1Mrnw/hooMZSN8Iq1trAnb57lggKQK3K1q0fWHd
	sTRaZu/bPrgKL/rcc59PVtuKQmJa6KVN9YYU0RYnY1UVY0wJL0BRBhUycv1/zpBgUdGlrnLvJyv
	NAao1/z8f+S3suzYCG9c1wCjsYVMuP+UV2P7DwlCmHAyeil2WbQgagiNucgE0sqeGxdEM3mkj3x
	H+TARw==
X-Received: by 2002:a05:6402:4541:b0:676:9c6d:5c59 with SMTP id
 4fb4d7f45d1cf-683bc4b0a51mr3550891a12.2.1778992567465; Sat, 16 May 2026
 21:36:07 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260410-shadow-deps-v2-0-4e16b8c0f60e@mailbox.org>
 <20260410-shadow-deps-v2-2-4e16b8c0f60e@mailbox.org> <CANAwSgSNHO3MNewNzpYbhuj4K3NTdfzDC9KPoUHbFH97P4M_UQ@mail.gmail.com>
 <DHUCL24GMX7D.369IWK9DLPZPX@mailbox.org> <CANAwSgRt5-t_ah=phGc+CQYHG-CdWJuOX-2VTW6xE7n7EnVsFw@mail.gmail.com>
 <aeaXszeaE62rM6BJ@aurel32.net> <DHYOIIFMGH7J.228ISQ7XYFGKE@mailbox.org>
 <aeevr6Zj3Pwm9wux@aurel32.net> <CANAwSgSCo-mESo6=KSc08oUzTWAgzpYu0JaW5KqmnCNiPYHjxQ@mail.gmail.com>
In-Reply-To: <CANAwSgSCo-mESo6=KSc08oUzTWAgzpYu0JaW5KqmnCNiPYHjxQ@mail.gmail.com>
From: Anand Moon <linux.amoon@gmail.com>
Date: Sun, 17 May 2026 10:05:50 +0530
X-Gm-Features: AVHnY4KOL2rGt_SSoRHMzxpCQMBvp_fsFHr614JlPdf6906rsMFKS9vQD857v9s
Message-ID: <CANAwSgRFQiNEi1Ac+sCvJWkj1R+yEPGt0RCjZu-3ZiD0Ffm6Hg@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] riscv: dts: spacemit: Add cpu scaling for K1 SoC
To: Shuwei Wu <shuwei.wu@mailbox.org>, Anand Moon <linux.amoon@gmail.com>, 
	"Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Yixun Lan <dlan@kernel.org>, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org, 
	spacemit@lists.linux.dev, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Shuwei,

On Wed, 22 Apr 2026 at 11:44, Anand Moon <linux.amoon@gmail.com> wrote:
>
> Hi Shuwei,
>
> On Tue, 21 Apr 2026 at 22:41, Aurelien Jarno <aurelien@aurel32.net> wrote=
:
> >
> > Hi,
> >
> > On 2026-04-21 16:10, Shuwei Wu wrote:
> > > Hi Aurelien,
> > >
> > > Thanks for your addition.
> > >
> > > On Tue Apr 21, 2026 at 5:16 AM CST, Aurelien Jarno wrote:
> > > > Hi Anand,
> > > >
> > > > On 2026-04-16 17:07, Anand Moon wrote:
> > > >> After reviewing the Banana Pi F3 schematics, I confirmed that Buck=
1 and Buck2
> > > >> Both supply the CORE_0V9 with 0.9V=C2=B11% rail. To resolve the re=
striction errors,
> > > >> I expanded the voltage range in the DTS to 500,000=E2=80=93950,000=
 =C2=B5V.
> > > >>
> sorry I was wrong from the doc below 1.2.1 CORE Power Design
>
> The typical core voltage is 0.9 V to 1.05 V. Actual voltage is
> dynamically regulated by
> the **remote-sense dynamic voltage** adjustment circuit inside P1.
> P1 BUCK1 and BUCK2 must be combined to supply the core rail.
>
> [1] https://www.spacemit.com/community/document/info?nodepath=3Dhardware/=
key_stone/k1/k1_hw/k1_hw_design_guide.md&lang=3Den
>
> > > >> Additionally, I updated the DTS to map the second CPU cluster (cor=
es 4=E2=80=937)
> > > >> to Buck2 to better align with the hardware's power distribution.
> > > >
> > > > Actually the output of Buck1 and Buck2 are connected together, so t=
hey
> > > > should always be configured with the same output voltage. And both
> > > > clusters should be mapped to both outputs.
> > >
> > > You are right, I received the same response from the official develop=
ers.
> > >
> > > Therefore, I'm wondering if an additional regulator-coupled-with: pro=
perty
> > > definition is also needed here?
> >
> correct.
> > Yes, I think this is the way to go. I even wonder if this shouldn't be =
a
> > fix with Cc: stable. This also has to be done for the Milk-V Jupiter
> > board, I haven't checked the other boards yet, but I guess they all use
> > the same schematics at that the PMIC level.
> >
> > Regards
> > Aurelien
> >

The following changes resolve the warning on my setup.
If possible, please integrate them into the next version.

diff --git a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
index c2a1b759d41f..8512c7417f94 100644
--- a/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
+++ b/arch/riscv/boot/dts/spacemit/k1-bananapi-f3.dts
@@ -116,19 +116,19 @@ &cpu_3 {
 };

 &cpu_4 {
-       cpu-supply =3D <&buck1_3v45>;
+       cpu-supply =3D <&buck2_3v45>;
 };

 &cpu_5 {
-       cpu-supply =3D <&buck1_3v45>;
+       cpu-supply =3D <&buck2_3v45>;
 };

 &cpu_6 {
-       cpu-supply =3D <&buck1_3v45>;
+       cpu-supply =3D <&buck2_3v45>;
 };

 &cpu_7 {
-       cpu-supply =3D <&buck1_3v45>;
+       cpu-supply =3D <&buck2_3v45>;
 };

 &emmc {
@@ -248,14 +248,14 @@ pmic@41 {
                regulators {
                        buck1_3v45: buck1 {
                                regulator-min-microvolt =3D <500000>;
-                               regulator-max-microvolt =3D <3450000>;
+                               regulator-max-microvolt =3D <950000>;
                                regulator-ramp-delay =3D <5000>;
                                regulator-always-on;
                        };

-                       buck2 {
+                       buck2_3v45: buck2 {
                                regulator-min-microvolt =3D <500000>;
-                               regulator-max-microvolt =3D <3450000>;
+                               regulator-max-microvolt =3D <1050000>;
                                regulator-ramp-delay =3D <5000>;
                                regulator-always-on;
                        };

Thnaks
-Anand
