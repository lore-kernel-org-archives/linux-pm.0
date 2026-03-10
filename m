Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9064B3E869A
	for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 20:05:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773173161; cv=pass; b=ENaneorhztD2B42Fh9kPQQlPjmUCIrM6KADNRXEu4SSbM6VUezF8nI9Qvi3MPpeX3cINmgrE4jg/IrEzqMt2y+4Thzfh/d8CikSfcWC4iAfNs7OBaGMCHaLmOzCrvPjtJ8IXx30l2vB3DlyE/FqWwLO9fxBiysWvPoSNBHdbNiE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773173161; c=relaxed/simple;
	bh=yezyjNt08EO4rLNbf8RM2RzmwHaocfDMLvlwLMlLuy0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QnZ/ukbL2hvv3X3IV//o4ZGnjq5D4AYAcfeG3HDOSsnByd94PoGCSDYsNe5dmYSAgG1uqVWSjObNtnrH4yJx4CpQFoQ1YAbHh4FILY97wYWnfmmfnW2BQ9Pwsu37hNVSg7RFJCSeTO8iCSKRiL1b+poJCqQ5K23lJezWphTmgjc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A81T6Fu9; arc=pass smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A81T6Fu9"
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-59e4989dacdso7824278e87.1
        for <linux-pm@vger.kernel.org>; Tue, 10 Mar 2026 13:05:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773173158; cv=none;
        d=google.com; s=arc-20240605;
        b=LtlUUDbmhiuUIvwciG6fQ91P1H4jBl5G2xCCRoaO80Xlqtw4FJECMKgAtGO5Y15att
         4G662jSV+Aqhlr7Vk7TbvbZD6kFukE6bRqfMuH4DVNwlfsNW2/y/nXGKZs5ARCfK+T04
         aEzaYTpTzrHD5Bu6UmePyGgTN/Z6+mB4bcEjks8Px7mYtIdcsiVFPiKXgXAfvIDkB0tl
         7VtnmBSy7U8CVTlzFMhm/RlPgEbyNem97BJyvguDEnkmwCED4+Ry7owwGzDFo/S3HsQv
         ryk0VM39BzyHutXJlBBvQO1feOhs4I6RhS7sNOYrYhqSJnUyvvZc3PoD8pkhy9xDodKw
         6IwA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=pQIXMNQ0k52fsARofvqfUmvTDMoK9RXOBJmQNC6ddnQ=;
        fh=fuyGwCHjkIW5KwDsNnqanEWLGixQ+6zCjjlC8ZWGBC4=;
        b=EYYXhMoWGxvL+84qBJruvz5UFRNvePzCM4XyvaihzbDK8k9zsJ9aa+Fhe8LovUPzv4
         ydezAYocebW0xTx4ubmBcXUhXE9aDIBNEfMI6I0pc5gRGcpe3qZvi6PR8RJwzwOwfobB
         Q3fKzsXu6jyXkjGVAd4mS2W8LPPG8QH1N3LIBFp8SvZNmTgbnK0yg8DkON/ggMtprvBG
         Qv14+0mDULWnZK77R2ZunMNMRndO+RZyoKZmp9BSpOmmQN7uFj7o1S94tMY8e8LHhWaJ
         ByrqOms3rfRd/Id0Z28a6s1IiU69IeW2oUdwKRJPm3P/XCNpqWt2OFhylFFpHpnCQ5dH
         Beeg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773173158; x=1773777958; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pQIXMNQ0k52fsARofvqfUmvTDMoK9RXOBJmQNC6ddnQ=;
        b=A81T6Fu90tE2d7aINcwxIooqEeRxzxvPyJVvnk9Q8SsLzCkYaLcmyYwSGJqjvCpH3k
         IzlFaFD0L1hYTS5v+TWuN22QrekBBncbbCGMeu7pZ606+DVIzo1pY6krCVcC0NpqZqa+
         97yhb+9/8y8R4cJMC0el94KG9vnkwVSi+kV4bObO00WsF8CSIGw3FSmHmkovk1T2GbZF
         3G9XB99nMUbAaKjdQ32J38Nop13AxC3utDRFM3j2jiR97c0OxeW/Bh0fmLLyj+Scnq95
         C1CL3Owtt4cKJNQ1X6PLZkUchARdKtc1TCXVsUKRjnxNB6z9k8dvzRdCBYdWE0JLaeEv
         TabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773173158; x=1773777958;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pQIXMNQ0k52fsARofvqfUmvTDMoK9RXOBJmQNC6ddnQ=;
        b=ksnHwy0L8/Bn8CVxmxJog5lxRH3a6RrIbKrLd+N1zMOph+4RVmD7d9nGplg5UlMuyi
         1CJRdxGfvZ1dmT0jf/irHjNMyEfmX+/demExlColuQsLHV0e0wG4L+Ir3bd16joX7/KO
         B3XW4AKS3w26wmRPVdMwevuJmiEL/gL71nQXpy0IPtnYDmjVdCaoq9fkOhn+Z2eNCN34
         zTMtcXqugn0whIhKCFTBkb4nNqV1vqm7I2M3F/lzAp5PggPNL3LOLIBs/ccrrFu6V32K
         4Eoxqj8neQ5zRebtFQcjiKamvQpPfSpiQYvpiByjBHWU2w8XoZDdNdXUz0o5CFDrHgMx
         h+Nw==
X-Forwarded-Encrypted: i=1; AJvYcCVL7P+nOmTPaks3+3+tPC+VKbfO+4RJnhpKyFogYQZ+/Dfep9Vx0pBxPH1gLTnEoHlOU3jWNXkf8g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzin18wmpWMxCzV5b476DWrVDAlPAQeawbneHjx9BVttFaT8RST
	V6UqieAb/aY6yb++VFOKdaYMy3PQRr29AZvOtu3hEA0AsJ89SVZsG0Se9KjCJIk69A1lpc7CPgh
	JsgLnx8LnedjMu7GxlM4LHahZAoTU6yA=
X-Gm-Gg: ATEYQzwwzlBatmdBCIuIXlxV/ObhwRWvV54WA0/Kkiv0bWG/h9FZ3cGXjNwYe3bd98a
	yUo48UbyHl/sKm2XEca78nuxidrGtdIV7Bf3opX/Mv4tvGNIzUcg4JTFXbYYTHAGe5VNvBCJfLk
	6prMy1B8CyrpQiGCnomPCpNCXjtUW/UQ/aHiJGTLB5qre4kZYO5TfqZSJAzGtqM3YN6ZQJAHm3U
	egq6U6PvnGgyyqZRIwdlpdGpDafOh8gZdqXobtj+y60JpKbTs6O0mgh7lBUAY5OBB+9bnnNM5Rd
	qVUfPm7sRlU4NdI4Muz02HsG4F/gdYSBpqPoDsh/jYooM6oS9B+egklzsoBg43PVCE72
X-Received: by 2002:a05:6512:608:10b0:5a1:3f3f:a299 with SMTP id
 2adb3069b0e04-5a13f3fa3a2mr3200287e87.45.1773173157485; Tue, 10 Mar 2026
 13:05:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260219-sm8550-ddr-bw-scaling-v3-0-75c19152e921@gmail.com>
In-Reply-To: <20260219-sm8550-ddr-bw-scaling-v3-0-75c19152e921@gmail.com>
From: Aaron Kling <webgeek1234@gmail.com>
Date: Tue, 10 Mar 2026 15:05:44 -0500
X-Gm-Features: AaiRm53YqtD7m1k1WfcVh97y8PC5B6LMFnLkyA1AYIHdfdl0-cKTgK4_AfI5oyY
Message-ID: <CALHNRZ9R1XaYWeTneZmyAvGY-s2-rbSC_=bSV-nC8_zU+bGLqA@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] arm64: qcom: sm8550: add DDR, LLCC & L3 CPU
 bandwidth scaling
To: webgeek1234@gmail.com
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Georgi Djakov <djakov@kernel.org>, Sibi Sankar <sibi.sankar@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Neil Armstrong <neil.armstrong@linaro.org>, Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 19, 2026 at 10:07=E2=80=AFPM Aaron Kling via B4 Relay
<devnull+webgeek1234.gmail.com@kernel.org> wrote:
>
> Add the OSM L3 controller node then add the necessary interconnect
> properties with the appropriate OPP table for each CPU cluster to
> allow the DDR, LLCC & L3 CPU bandwidth to scale along the CPU
> cluster operating point.
>
> Signed-off-by: Aaron Kling <webgeek1234@gmail.com>
> ---
> Changes in v3:
> - Squash the last two patches
> - Link to v2: https://lore.kernel.org/r/20260218-sm8550-ddr-bw-scaling-v2=
-0-43a2b6d47e70@gmail.com
>
> Changes in v2:
> - Squash first two patches
> - Update opp tables in last patch to match how the downstream driver
>   parses those tables
> - Link to v1: https://lore.kernel.org/r/20260207-sm8550-ddr-bw-scaling-v1=
-0-d96c3f39ac4b@gmail.com
>
> ---
> Aaron Kling (2):
>       dt-bindings: interconnect: OSM L3: Document sm8550 OSM L3 compatibl=
e
>       arm64: dts: qcom: sm8550: add cpu OPP table with DDR, LLCC & L3 ban=
dwidths
>
>  .../bindings/interconnect/qcom,osm-l3.yaml         |   1 +
>  arch/arm64/boot/dts/qcom/sm8550.dtsi               | 367 +++++++++++++++=
++++++
>  2 files changed, 368 insertions(+)
> ---
> base-commit: 9845cf73f7db6094c0d8419d6adb848028f4a921
> change-id: 20260207-sm8550-ddr-bw-scaling-b1524827f207
>
> Best regards,
> --
> Aaron Kling <webgeek1234@gmail.com>

What is the normal merge sequence and window for linux-arm-msm? I see
several things that have been picked up for -next recently, but none
of my sm8550 patches that have been reviewed / approved have been
picked up yet.

Sincerely,
Aaron
