Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7AA3C140E
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 09:31:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784280693; cv=none; b=YLsK09wLxQr/MbfA4cdsbu7ag85IaTthDwBtPxd0l7e/r8jCS3dBbdwgp5FrpGuCpeAvUzK+Z+Fj5T0pNdZUJgrOcJBdtwdBuz6G9qOSPyCCSQe4RuQbZq4CT3pRhdT4OYz6xWTjMAx+HBJXHVTwjjByrD5JGaqecljqfT/W/q8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784280693; c=relaxed/simple;
	bh=idyDIDnbrWb05N4rusK5NDUWMXuYrFaoFGUInQ0RKUY=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g3+ow85Bb7fY3vmd2VxwdMw30ScinrAoG1fh8AYvX0rebRMmss0VwTXT2M4aOKabesPdGc3dUI6HFhTeOYAZPcM7109+opS2Y3jW89IXQzqvypmS0CYpnpAqXXT2ijZJ3FK9uMehl3amc2Gk42aH6St5MwCdss60Zif8FfD5OjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAUXZgfE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAUXZgfE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BF371F000E9
	for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 09:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784280692;
	bh=idyDIDnbrWb05N4rusK5NDUWMXuYrFaoFGUInQ0RKUY=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=ZAUXZgfEt4tJUPjuOKXh+I0aEsTaLTqhZkgFdhoVvk8xTRHOR4YKcor5S3GGiJlmO
	 pzlITU0fec9otfVvrqmikj9/kfhsr5fZWbY9xiL7VYzmhT6LdpHkh0KkDNbvTCBf79
	 xv7R8Cat5Bnw8kG+sJJskivwTirKGtJ/cBbirTrsLdEUJ6LLf+hnKlRUVgSkjVj6Wq
	 8R8iYHllTM/2CdwPwDaXQN09XQ/8AExMoePhilJ+I7tcLCkxsxSneTLscQkPxqyZ2s
	 HxOpiMWhGC5Wj6gsENFFyAwumhJ9McYQt19d0ini49zeHUXw+8MD16qi/rOYlJD/3n
	 VlqciQUZ5L99w==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-39c74c469e8so59808011fa.0
        for <linux-pm@vger.kernel.org>; Fri, 17 Jul 2026 02:31:32 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AHgh+RriVQatfi7DdDak0tPXKnMx4gu0oezI1iRaaYJKrkKDy1ZiLpXO+eGUVz9+fPK1JWZl0W/HDThE1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YwrU+o4Oe21U6D+t2kYt7nzFEth2gSccpJOofXUSiu/lKjcPysh
	08gjrXvEDDMgUVKr4W8pKo5TPqiy8BJFzO6vC56jXO64zDtHiYQZnATKWq+VOp3tc/+yHKDkziT
	CSyRhfhprWD8syrm6WvjR7x6z2ftNcHcTSy+VT6+EBw==
X-Received: by 2002:a05:6512:108d:b0:5b0:137f:9467 with SMTP id
 2adb3069b0e04-5b28f9ac5cbmr482378e87.34.1784280690891; Fri, 17 Jul 2026
 02:31:30 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 04:31:29 -0500
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Fri, 17 Jul 2026 04:31:29 -0500
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260716-monza-wireless-v4-7-9b02e6f549d7@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260716-monza-wireless-v4-0-9b02e6f549d7@oss.qualcomm.com> <20260716-monza-wireless-v4-7-9b02e6f549d7@oss.qualcomm.com>
Date: Fri, 17 Jul 2026 04:31:29 -0500
X-Gmail-Original-Message-ID: <CAMRc=MfmfWs=jMB94uiiE0dUtc5hEiYBdV82mOfLsoZUfOXSSQ@mail.gmail.com>
X-Gm-Features: AUfX_myKUmYFvmwFkx01Fktbv79abVzfk5hHWq1rwGSJURh2ZxpSwF-OnLa0xCk
Message-ID: <CAMRc=MfmfWs=jMB94uiiE0dUtc5hEiYBdV82mOfLsoZUfOXSSQ@mail.gmail.com>
Subject: Re: [PATCH v4 07/11] Bluetooth: hci_qca: Embed bt_power in struct qca_serdev
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 16 Jul 2026 18:18:24 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> 'bt_power' is allocated dynamically only for a subset of SOC types, using a
> switch on the SOC type that mirrors the one that follows it. This is about
> to become pointless as the power sequencer path (used by M.2 modules) is
> independent of the SOC type and needs 'bt_power' populated for any type.
>
> Embed 'struct qca_power' directly in 'struct qca_serdev' instead of
> allocating it separately. This drops the extra allocation and its dedicated
> SOC-type switch, and removes the need for NULL checks on the pointer.
>
> No functional change intended.
>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
