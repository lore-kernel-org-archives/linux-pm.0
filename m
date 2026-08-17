Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E43C41BA97
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 12:39:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970369; cv=none; b=rPSCLDdrE7rzWI9m4JM5fjFD3HSNjLl/WxzbFl+HpidkDtgs8YtRLBBaPefoMpqzjoDDvsQ3Qi0gdo4ypzkPcqlBfGbOTg3QFXy3TdJjSf/h+HAbkYUrYp0j7iPgE1q/ARZ7DePP4rzxQyFbsim4+4wxhd2p5UdqpwW6jiXkLDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970369; c=relaxed/simple;
	bh=MNPvxiEy0C6PIykCUQd6dAErSez7AzTgKFUW5PHeT8c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ORH926B5QLIW/z6WtMwnzBTM31WVMaPEsv66sJuhTA0fGfly5lZgN5wP9rUler1IfPvuf0UZ5bISRrxxFNiJOhxTeKEUM/BW1+1xmW37iV65ZlF5lTlLTqGbSdWQOxj2iyn5ZRIDFacxbXEWhCKX9Hnw6PFPk/5kXFEm0e5EOy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nPLW+2FO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nPLW+2FO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6FFB1F0155C
	for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 12:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786970367;
	bh=idn/pWXHIgw56/aGT8BcsjeFenZq81CxiFxEILonPKU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=nPLW+2FO2l8magX9nb0VKajLqiCqJsoYKA94q1CksO426LzonHJ2LrF05RKAXrg0F
	 vZShumVsmRGsTcDHJGZSfuwiRkJGF4eXkAQ3W5VMDzKTecjDFpqW7oyRxKwjm+HfuN
	 X894mdGDED43sPHabIrGSAf9brQLkrC8jhk1f/b86k/XP0HEekmRiRySk58J2yUjzd
	 gwgDsRpA4splgCn5Q0rXpFirj6gf2VK/Vt5Hwjaevgt87CH5dlTQGTs9Bgl5r1S2oI
	 v/ze5RzdIaoMYcgYwViyIt18xMOhGyvdRJdwSypAWXPRGjwVOv9GYxRPMbxl8PcHt9
	 U3uBrC/A+qenw==
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5b2a3166398so3715990e87.3
        for <linux-pm@vger.kernel.org>; Mon, 17 Aug 2026 05:39:27 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+Rrs57p+kKdpegSGP4+a6pKHKeeVdHmrpkJlcavtQGzdh3yT00k81Z/mK5/0Bl2Ys0Z+sXUXf2186Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzz/5HKgtCZmG0ucwucOXzcF31wfMGCfnNozMKtEVsKzTc/zdNn
	D2erCaPsT5Okj8Z852YaRurRS8Ff5k4GEWD6xvCAakwqcxeadGj8DpEWeb7VTrno8uQAV6IXNOF
	r0D2VyrXiF8jDUMb2tRnaXrT9tYhwnQ4=
X-Received: by 2002:a05:6512:251f:b0:5b0:82d:e90e with SMTP id
 2adb3069b0e04-5b459166e3emr4172357e87.19.1786970366630; Mon, 17 Aug 2026
 05:39:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260814-kuno-soc-support-v2-0-3079794f0f73@oss.qualcomm.com> <20260814-kuno-soc-support-v2-15-3079794f0f73@oss.qualcomm.com>
In-Reply-To: <20260814-kuno-soc-support-v2-15-3079794f0f73@oss.qualcomm.com>
From: Linus Walleij <linusw@kernel.org>
Date: Mon, 17 Aug 2026 14:39:11 +0200
X-Gmail-Original-Message-ID: <CAD++jLnkhsz8Uhm5UBMhXiAwBp8dnNkh8A_fFL-dnSZQ_CT91w@mail.gmail.com>
X-Gm-Features: AcwNN1Xpg_Z0StBfw_5gikXV84b0FzBwXnDsTOtTS7PYbUy9Cd-ZSMo_wHGUYfc
Message-ID: <CAD++jLnkhsz8Uhm5UBMhXiAwBp8dnNkh8A_fFL-dnSZQ_CT91w@mail.gmail.com>
Subject: Re: [PATCH v2 15/15] ARM: dts: qcom: Add initial device tree for Kuno SoC
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
	Michael Turquette <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, 
	Brian Masney <bmasney@redhat.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Georgi Djakov <djakov@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Thomas Gleixner <tglx@kernel.org>, 
	Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>, 
	Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 14, 2026 at 9:34=E2=80=AFAM Hardeep Sharma
<hardeep.sharma@oss.qualcomm.com> wrote:

> Add SoC-level DTSI (qcom-kuno.dtsi) and IDP board DTS
> (qcom-kuno-idp.dts) for the Qualcomm Kuno SoC.
>
> Peripherals included in this initial set:
>   - Single Cortex-A7 CPU with PSCI idle states
>   - RPMh RSC with clock controller, power domains, and BCM voter
>   - GCC (Global Clock Controller)
>   - TLMM pin controller (110 GPIOs)
>   - Interconnect (aggre-noc, cnoc-main)
>   - GENI UART console (QUP SE3)
>   - SMEM, hardware spinlocks (TCSR mutex)
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>

My comment is addressed so:
Reviewed-by: Linus Walleij <linusw@kernel.org>

Yours,
Linus Walleij
