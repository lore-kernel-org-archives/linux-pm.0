Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEA73E3DB7
	for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 11:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774350452; cv=none; b=j2PCMU+s3E2Tt1itUyqKasNcC3Ram4U64v2Bcy33XlrvvuTpt5Lk9gfrA55KgrJo0BL2uoQwg04LDPP5GM33r2ShtQheuAjdX1ZsGPlTHg7ncA+QunQdFJ+tApBd5uJ9CqdJqe4h6IQgMJpQPGjSr+smMiWtRt/T022n4n/1NDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774350452; c=relaxed/simple;
	bh=At+Iqd/SgYcqAiAgI4rHTyzrH73kXeFcOkiwceJ6J4s=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=AaHX++BY5C0lxQIUNVLISCEJD1EMl3idi43Q9+T8F/Z1E1671MuQBXKVTmVVAIBDC2dyBIBJnqxW3m205hJnTyhdiK5w4rNIWdab90Ly0rFe5DOsfpLXlM7DE2S8K7TN/cYxLejV7XB1QSW2ATOwS4o0QtrZ4o7csLFpq19hEcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=dwxT7PkG; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="dwxT7PkG"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b97bca3797dso148496066b.0
        for <linux-pm@vger.kernel.org>; Tue, 24 Mar 2026 04:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1774350448; x=1774955248; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=97SUz9UBU7Ij4r0LCFNkUHZDbixoh2v3NinEmbjVCXw=;
        b=dwxT7PkGiTnRWinpyBDzxZP79BO7CXEyJ0bfzXWXTiYUqKJgl84pWpiK3kvq6fXPwi
         VjxQnaefumRIGfIcelGa0sPljRTJaE0M9O2KkQbR6n9Fscp7/rQLRTfOEdV2Tl8f3BXR
         8OdNC/xodri8XQwPndNhaKoLB9yuwbDjInbnbxwnYbUtAP3f8DXoRXloEaD4j9qSEm5s
         wJTPzkov5ruwkLpu2EMPiCIZ57Up3zXoVQ9yjqdNHsYYsNrOcPYqJgQE6/GewuTumdEA
         bmsYOYCMZsNzS01Qf/I295zZ+sZEUY33sTZqKZKgS02i+R49uoGbRoEWpIGvPk9e4Cob
         20ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774350448; x=1774955248;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=97SUz9UBU7Ij4r0LCFNkUHZDbixoh2v3NinEmbjVCXw=;
        b=ozdCe2jQXEvfoB1aazAVsZFmG/mvTY4ccVOYQD8itIcfZqL5HJWC2UbTXPOLzfQTu6
         fVbGqpgfbAq46eQUu2ZBpmRZp67WCSIIPTvAQCMcEX4koFppVSi37pAJrXQfBQ0zvCB1
         4CFgX2q+yX51U+5FzWEt354EdSzeXYgAR4M0xnLx7AzU16J/abpmPT0tTxYpWbluK72G
         IMMbdAhDc0ulhwT/Wsl255Td9vFkbM7+kZQbcjJjzG2xbRIwnU8rww+38lE9xIyXHzBg
         75Ddv7noUDCL8CgLr1bRvvKFKtHbCIYxCHC85D37fSW1KSKCfxKZbAKNfd9au7/LDTlc
         tyUA==
X-Forwarded-Encrypted: i=1; AJvYcCUeNn79g9Z7S0Cy0kFONxrTn2Xvy0gzy8jJ8rj5HdLP5fy0sbT1go3a1Fk61KfFfCNPNG7OovkflA==@vger.kernel.org
X-Gm-Message-State: AOJu0YypB/srzHlp5m1kguJAhYCxaioBs0SSFU1muTGtiLDX5koXewCr
	5gavKjiE3mw2vgnndgEtSjvQZWP9gxCUcnkvcsmKbmgyo/4iCBFrT/Fc75FOV76gfAE=
X-Gm-Gg: ATEYQzxM+JJGJpRTB8s0q5gfS0Lrql0XxKwGYPkc3vVcZI+Xr8nGewQ1EO/6K9MvykH
	/7VWwDa7Ey1k7Dvw1iyQdFHdUjbRIKcUyZBeg8jWGOr6vA3mjiGq9W/ltIX6RU3qtwdcqB/2jDy
	M+4Fw/bx/1CDQF9m6+NQuavTZMUYVT2rWDSIjxjraVTO78D+Rpu3R77vhpmI3vbvHSjtyME7Qtd
	7XuC55zSLrbTzg05OxK3EuNY2H6IbyZEpIEop23RPgq25ZskVZpTIGv86925xnWfJnY1EYCG+nN
	Z5ZJwAm66Cwnl0TqOJgFLMVbwW9SG8gmWUycgK+1mGqnu2t8SuT1nDmMugBKBEmdYYo7JQ1YPSD
	smuz7cthal8eIDmpomdXP5O8I6+6dooNJzG890z4j9cbt9cne7gtaqJhSV9BTA1Q3lG6/Mx4hBX
	NprxLKExAoCwNaVqs36YF+wINeTvB8q5+DmqUFnqTxYfMMX8HIfAhxRf/8raTz+q9JYc5f
X-Received: by 2002:a17:907:3e8c:b0:b98:33c5:1bb9 with SMTP id a640c23a62f3a-b9833c56776mr1159666366b.35.1774350447853;
        Tue, 24 Mar 2026 04:07:27 -0700 (PDT)
Received: from localhost (144-178-202-139.static.ef-service.nl. [144.178.202.139])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b9833871d8asm625152766b.58.2026.03.24.04.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Mar 2026 04:07:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 24 Mar 2026 12:07:27 +0100
Message-Id: <DHAYQMHGE9CB.1TTDHVA4CZJFD@fairphone.com>
Cc: <linux-arm-msm@vger.kernel.org>, <linux-pm@vger.kernel.org>,
 <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "Brian
 Masney" <bmasney@redhat.com>, "Konrad Dybcio"
 <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v2 0/9] interconnect: qcom: let MSM8974 interconnect
 work again
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Dmitry Baryshkov" <dmitry.baryshkov@oss.qualcomm.com>, "Georgi Djakov"
 <djakov@kernel.org>, "Konrad Dybcio" <konradybcio@kernel.org>, "Bjorn
 Andersson" <andersson@kernel.org>, "Luca Weiss" <luca.weiss@fairphone.com>,
 "Rob Herring" <robh@kernel.org>, "Krzysztof Kozlowski"
 <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>, "Brian Masney"
 <masneyb@onstation.org>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260324-msm8974-icc-v2-0-527280043ad8@oss.qualcomm.com>
In-Reply-To: <20260324-msm8974-icc-v2-0-527280043ad8@oss.qualcomm.com>

On Tue Mar 24, 2026 at 1:10 AM CET, Dmitry Baryshkov wrote:
> Commit d6edc31f3a68 ("clk: qcom: smd-rpm: Separate out interconnect bus
> clocks") moved control over several RPM resources from the clk-smd-rpm
> driver to the icc-rpm.c interconnect helpers. Most of the platforms were
> fixed before that commit or shortly after. However the MSM8974 was left
> as a foster child in broken state. Fix the loose ends and reenable
> interconnects on that platform.

Thanks for taking the time to fix this, really appreciate it! I've been
carrying a partial revert of Konrad's commit for a while to get things
moving again, without taking the time to properly fix this.

I can confirm that my msm8974 phone boots fine on v7.0-rc5 with this
series and your ocmem series applied. Not much possible to test on
display/GPU since that was broken since a few releases ago. I will
probably be applying this on 6.15/6.16 branch which still had
display+GPU support.

Tested-by: Luca Weiss <luca.weiss@fairphone.com> # fairphone-fp2

Regards
Luca


>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> ---
> Changes in v2:
> - Swapped order of clocks and clock-names properties (Konrad)
> - Corrected the ocmem comment regarding core clock (Konrad)
> - Link to v1: https://lore.kernel.org/r/20260323-msm8974-icc-v1-0-7892b8d=
5f2ea@oss.qualcomm.com
>
> ---
> Dmitry Baryshkov (9):
>       dt-bindings: interconnect: qcom,msm8974: drop bus clocks
>       dt-bindings: interconnect: qcom,msm8974: use qcom,rpm-common
>       interconnect: qcom: drop unused is_on flag
>       interconnect: qcom: icc-rpm: allow overwriting get_bw callback
>       interconnect: qcom: define OCMEM bus resource
>       interconnect: qcom: let platforms declare their bugginess
>       interconnect: qcom: msm8974: switch to the main icc-rpm driver
>       interconnect: qcom: msm8974: expand DEFINE_QNODE macros
>       ARM: dts: qcom: msm8974: Drop RPM bus clocks
>
>  .../bindings/interconnect/qcom,msm8974.yaml        |   28 +-
>  arch/arm/boot/dts/qcom/qcom-msm8974.dtsi           |   21 +-
>  drivers/interconnect/qcom/icc-rpm-clocks.c         |    6 +
>  drivers/interconnect/qcom/icc-rpm.c                |   18 +-
>  drivers/interconnect/qcom/icc-rpm.h                |    7 +-
>  drivers/interconnect/qcom/msm8974.c                | 1637 ++++++++++++++=
+-----
>  6 files changed, 1274 insertions(+), 443 deletions(-)
> ---
> base-commit: 8e5a478b6d6a5bb0a3d52147862b15e4d826af19
> change-id: 20260322-msm8974-icc-0ac4c28e139a
>
> Best regards,
> -- =20
> With best wishes
> Dmitry

