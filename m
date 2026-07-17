Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32A9737882A
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 09:28:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280484; cv=none; b=ue9VX8WCEU291R55I3cE1To9sAP+zHKlY9WntKO8+qeDOuQGZoOgfzJd9OBndAdCqyi8iBUfmBKktvgOLORrtfmVJjfihKX3PVeylqrTpXpemCNywbgnjW1R8Ufioy9CJoABJUdvI832ibCWUSJxAXjBmrzwaVUpH2kVIrS99iI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280484; c=relaxed/simple;
	bh=4ZGf7UP3zl3e70veS8oxZPoqDiTbCuZqWoFE8AEdZMU=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pdq1M2rDM9mwwvNZkU7oqMSw2cDDRqiy5pKjz4LnfMJgbpGzqGF2Jckb1is/DTpjLB9KzK70Bpx1q0VMyfdj4cnE6N78h5ajWSgqV1oJaqbDQ2mIPJRAzGoOc/alrXlBTkMsZ5f1BgfHu/14F4Da7rWQWTe4YOVPjrL5jU0Oz/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkQ+oRzm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkQ+oRzm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19DD1F000E9
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 09:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784280482;
	bh=4ZGf7UP3zl3e70veS8oxZPoqDiTbCuZqWoFE8AEdZMU=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=CkQ+oRzmVbxQp6u+HmXN3BUdyD0vPPob8PvnsWAduzSBF9HgvyW48JXl7Oc5IbQJ1
	 UOc8kxArCqeC7XOAyJoaSQ9zk/4dqb1ayfGKdEZWa8HSvIxi6PLZCn/gFTxShhs9qd
	 RND9gmaY+P8a6pPaRNzJrx7wOSSLUG/Ylf2pr9mAQb8OaqnGtwfo2kErnkdDPca9K/
	 rnXQte+stZOjttuplk2qQTzJi075s+MuXoNc+7wCPH7/FvpNoUIji7FFMfk7dsLe8o
	 FuBo8UVolfshD9t+g6fMzgD2R+W2CboPQv+iL/hHwGDyRkw6ycRKrMN6+C0NwDzD5B
	 NTsMq/Gn75/yA==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-5aec6360133so6067847e87.1
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 02:28:02 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RorHN9Jt96WQm7llrl4Tic0MELPumA58OWWKbMNNW6LNJFWbwO6lqMtJXfK1QMoAITU0v7RSYX0sA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwlrniF1J7lWaXFCDjdt0ThjH9PIGwRW1iRZ1ZepAJ60w/0dAW/
	T31dM2GzVrs25itcBS+h2awPlOV+5QT3v427Y1CEaRHYqPQEGrTtJhDNZY4+JZgsuuet9eoFvQQ
	hvXEEj92RKTjYbSqtHxQ6MPGyLQm6x8pFM7FaabpCdg==
X-Received: by 2002:a05:6512:1386:b0:5b1:5afc:1727 with SMTP id
 2adb3069b0e04-5b28faba838mr543668e87.57.1784280481673; Fri, 17 Jul 2026
 02:28:01 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 02:27:59 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 02:27:59 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260716-monza-wireless-v4-9-9b02e6f549d7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com> <20260716-monza-wireless-v4-9-9b02e6f549d7@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 02:27:59 -0700
X-Gmail-Original-Message-ID: <CAMRc=Mf8qof+jcJdL8NnO=E8M05=Fgb-pLgVcmHBvXDLWy=PRA@mail.gmail.com>
X-Gm-Features: AUfX_mzWTRVO5Ehi6fuXebIcMrT3i6w8g-wcOYK8C0cB3JSQGImsbJT66idcqFM
Message-ID: <CAMRc=Mf8qof+jcJdL8NnO=E8M05=Fgb-pLgVcmHBvXDLWy=PRA@mail.gmail.com>
Subject: Re: [PATCH v4 09/11] dt-bindings: connector: pcie-m2-e: Add vendor
 LGA connector compatible
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 18:18:26 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
> Key E interface signals but are physically soldered as an LGA package
> rather than plugged into a real M.2 Key E connector socket. Such designs
> are not actual M.2 Key E connectors, so describe them with a dedicated
> vendor-specific compatible while keeping "pcie-m2-e-connector" as a
> fallback for the shared signal semantics.
>
> Add "qcom,pcie-m2-1418-lga-connector" for the M.2 LGA 1418 found on
> Arduino Ventuno Q (Monaco Monza).
>
> Add "qcom,pcie-m2-1620-lga-connector" for the M.2 LGA 1620 found on
> The Lenovo Thinkpad T14s.
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
