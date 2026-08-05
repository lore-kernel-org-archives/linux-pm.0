Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86F0B402BB7
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 09:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785923016; cv=none; b=Mau06LuAs2hkkylC26mWktebpuQuHGIkju4gwCZKbbB0D678pnpOj8WK+UDRbwbWczNLv85CXk02gelhlxl7nIV1nekMoVXvVGS4tjOWaPzJ6fUKC6BKcD71Sz6tnFbp6OyR8ub5qDmVu0ewnR8wGNjVf6Phwa8B+Yaj34w96v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785923016; c=relaxed/simple;
	bh=kzl3LjyJT/cJK/tPZUC90cNqEiloCIZi3VNBGZx0Tq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=MBh79BjbEHtUzP3BXRbiCa+/UHBmyexpIalLRAjy2rcHmKLqsHrd2l+Eioat4kbOSwsSFCps/zUIzY+ftqHhth8lYKirRPpjdKH4Onue0X3PR9scdLFRIxX9aqsfMjB1La3XevbZNHZLg7WThXC4PXCt/D92Sp1ABPoFflBp5J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCQO3DcH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCQO3DcH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58EF41F00ACA
	for <linux-pm@vger.kernel.org>; Wed,  5 Aug 2026 09:43:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785923015;
	bh=SEWTlYII+fUiWyq0/uoUuvMRCEnuw1WDu85hQtFf3VU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=hCQO3DcHzM5OwFzJnbxCc2BtoLhw84uSoJObv3WWEU7S50MmdZ/m0h/kpMLpomsIO
	 SHwkAonZkmpeNs4n1vGFjGYqPTabxNG2V78pvT5KM3YmgyZBu+XGJAsH9Xiq2O5jgG
	 a/oZVC3RA4DecqBaChbrmb6g+N51leP985+bZauNXJXuYxMpP3W8clSwPgx602uDwu
	 vvXCQr2IJg5DNuBosmJBZ3hB91HztVMPDWRpsF+pdJJ9J+FsEsJvU+3/IXZeFbgdro
	 J7MTm7DVaKJEML/Az29fBr6BINps/uyUYpGh2IKF4qMkNwxVd7cDBfoVZEQdLL7N4p
	 CgqA70cgOZbQA==
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-6a0a4aa99bdso1108615a12.1
        for <linux-pm@vger.kernel.org>; Wed, 05 Aug 2026 02:43:35 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RpaWdPCcGzwr8JllvoQPZXrc+5U0aWHvu3aX8/9JrrdtTa+hCy5jrY2bfobeWDFkh1qpVOVHiw8tw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzuijGFJ65ETW+gTk1aUEp2Ki9KuJglqrKJiU1y1k88lWf0ELv1
	MDh3iFSfmdvDKhYQ4yCS5MfF9p2FdPTms+pJ4zKCJXD693eIniDSfeC76Q+TgGOeHNSwla80zZG
	JizOJd5GGYg2xBiH5BJOr01nJlcZF3lw=
X-Received: by 2002:a05:6402:5406:b0:6a0:567c:c2fe with SMTP id
 4fb4d7f45d1cf-6a14f28888fmr2928147a12.20.1785923013927; Wed, 05 Aug 2026
 02:43:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1785829933.git.zhoubinbin@loongson.cn>
In-Reply-To: <cover.1785829933.git.zhoubinbin@loongson.cn>
From: Huacai Chen <chenhuacai@kernel.org>
Date: Wed, 5 Aug 2026 17:43:58 +0800
X-Gmail-Original-Message-ID: <CAAhV-H43c5OWGfE+XepeMbwJvE1US1VapxSTYOh4W77pbRLdXQ@mail.gmail.com>
X-Gm-Features: AUfX_myJZvZcsFRImM9vvMYUz6MxKvw7tjGf7bRkBFSUuLm8GX_22dr9CRByV7g
Message-ID: <CAAhV-H43c5OWGfE+XepeMbwJvE1US1VapxSTYOh4W77pbRLdXQ@mail.gmail.com>
Subject: Re: [PATCH v4 0/5] thermal: loongson2: Add support for
 Loongson-2K0300 SoC
To: Binbin Zhou <zhoubinbin@loongson.cn>
Cc: Binbin Zhou <zhoubb.aaron@gmail.com>, Huacai Chen <chenhuacai@loongson.cn>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Yinbo Zhu <zhuyinbo@loongson.cn>, zhanghongchen <zhanghongchen@loongson.cn>, 
	"Rafael J . Wysocki" <rafael@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, 
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>, Lee Jones <lee@kernel.org>, 
	devicetree@vger.kernel.org, linux-pm@vger.kernel.org, mfd@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

For the whole series:
Reviewed-by: Huacai Chen <chenhuacai@loongson.cn>

On Tue, Aug 4, 2026 at 8:41=E2=80=AFPM Binbin Zhou <zhoubinbin@loongson.cn>=
 wrote:
>
> Hi all:
>
> This patch series adds thermal zone support for the Loongson-2K0300 SoC.
>
> The Loongson-2K0300's thermal sensor is generally compatible with the
> existing Loongson-2K series, but it features several key differences:
> 1. It has an independent CPU ID register for reading chip version
> information.
> 2. The raw temperature output field has been extended from 8 bits to 11
> bits.
> 3. The temperature calculation formula has been updated to incorporate a
> correction factor based on the version information.
>
> To ensure robustness on older hardware revisions, a fallback mechanism
> is included: if the calculated temperature falls outside the valid range
> (-55 TO 125),  the driver falls back to a simpler calculation and prints
> a warning.
>
> The patches have been validated on the Loongson-2K0300 development board.
>
> Thanks.
> Binbin
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D
> V4:
>  - Rebase on linux-mfd/for-mfd-next;
> Patch (3/5):
>  - Remove the `compatible` adding to the `select` node.
>
> Link to V3:
> https://lore.kernel.org/all/cover.1785480242.git.zhoubinbin@loongson.cn/
>
> V3:
> Patch (2/5):
>  - New patch for moving thermal_ops to chip_data;
> Patch (3/5):
>  - Correct spelling errors;
> Patch (4/5):
>  - Add Acked-by from Conor, thanks;
> Patch (5/5):
>  - Keep loongson2_thermal_data->chip_data as const, and use
>    data->flags as the private data.
>  - Renmae LOONGSON2_THSENS_OUT_10B_MASK ->
>    LOONGSON2_THSENS_OUT_11B_MASK;
>
> Link to V2:
> https://lore.kernel.org/all/cover.1784619512.git.zhoubinbin@loongson.cn/
>
> V2:
> Patch (1/4):
>  - New patch form Sashiko;
> Patch (2/4):
>  - New patch for adding chipid syscon compatible;
> Patch (3/4):
>  - Use `loongson,chipid` phandle replace reg property;
> Patch (3/4):
>  - Refact `calib_offset` calculate routing;
>  - Add LS2K0300_OLD_FUSE_FLAG flag.
>
> Link to V1:
> https://lore.kernel.org/all/cover.1783670011.git.zhoubinbin@loongson.cn/
>
> Binbin Zhou (5):
>   thermal/drivers/loongson2: Correct thermal sensor registration loop
>   thermal/drivers/loongson2: Move thermal_ops to chip_data for SoC
>     scalability
>   dt-bindings: mfd: syscon: Allow syscon compatible for Loongson-2K0300
>     chip id
>   dt-bindings: thermal: loongson,ls2k-thermal: Add compatible for
>     Loongson-2K0300
>   thermal/drivers/loongson2: Add support for Loongson-2K0300
>
>  .../devicetree/bindings/mfd/syscon.yaml       |   1 +
>  .../thermal/loongson,ls2k-thermal.yaml        |  73 +++++++++---
>  drivers/thermal/loongson2_thermal.c           | 110 ++++++++++++++++--
>  3 files changed, 156 insertions(+), 28 deletions(-)
>
>
> base-commit: b1eb3de64d02cec71b419b9918d1697797fa156d
> --
> 2.52.0
>
