Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E3E242E8FF
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 08:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788769521; cv=none; b=F4NblfXhNdtS9uH1hGGpQnCw0BGZEYapzYSk9v8NHmp0IurNBcMRkE5sfSVSdsDeXZ/kITesPuS4i3HJNxy9JZuwPVatjokePvTVnEhBnS98eTTWVQfCAMMz/5P2a14pbfHWjcIEeTKgQu89yTY4imwdWkPj86JsVxYNip1PEE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788769521; c=relaxed/simple;
	bh=YwwXDITrHHOI/tnNPbpDQ2w9+IDTcZFl8lduFluzO2E=;
	h=From:In-Reply-To:MIME-Version:References:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=K64yBFDTECoCT1JsfexR+i9k+bddbmVV+KAA0EKfbKkHMikBktrKIwRy0KjZb1i/LpjGi8Utkacqzv0YVSm4019eukHVjbHsyTC4IVcVqr8iwrjBD6onPXHRoxV5yKIyFMH+wFgGp0wqDubtV8lfPAljP+pxMuQZ+UwYb6CKwtY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ULsTnKAQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ULsTnKAQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB3561F0155A
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 08:25:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788769518;
	bh=YwwXDITrHHOI/tnNPbpDQ2w9+IDTcZFl8lduFluzO2E=;
	h=From:In-Reply-To:References:Date:Subject:To:Cc;
	b=ULsTnKAQzP4Np5s1bqId/yehpqMbm9QOEtxxXTuAb4E/MMSOLJ9rEtLEN6p4x55jD
	 T/r4OHWZfTi6LjemNXEQppaD/UhMZrS26WRqR/8ZgdT6PaITzkqMylq0ygwSyBDKjj
	 riRWeoHkC99k+tOdERLXGIQlm6JAT00wBXiyuZiGcwqSYVqb4DU8jGKSiWJD2nKJNO
	 eNBtBVcjI0tqhAsGgI7nGn5qBGwCkEzY0zgW984nLq2H469KdkMfVRhng0S3GwgTWu
	 mb6j2O4j3h68v2ktS47Jk24XEHxB4QVaYDv/Wswlji9xLJnQ+my6Onv52mHWxcpFEV
	 yHea/UILx9bGQ==
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5b01910b499so2835838e87.0
        for <linux-pm@vger.kernel.org>; Mon, 07 Sep 2026 01:25:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AKwUvBy77kRmRFR96rzO8O5UC36SbuA75YuwWtx9lhXJzIydIpjfcsbSYjFDVpZyFOHWCXPBPYYiXzh+xw==@vger.kernel.org
X-Gm-Message-State: AFuF++nh9TSGoi/hUoz4VgPUUluP3VHBKnOXm5gmjAcV8YcK7gLM3wYy
	MmYDsrx7uRyHWkD7A6o2Ih6aYiZVYBIrfS1D/lIVg5ARt7RMLm2mFUafAlupS1uS89DdocPX3Vh
	osyLrUPOl6nfetJqOhzwgWHUaRAfQu9UeMzQ7DIhofg==
X-Received: by 2002:a05:6512:3e07:b0:5b6:10bc:dc46 with SMTP id
 2adb3069b0e04-5b610bcdcefmr3876506e87.29.1788769517527; Mon, 07 Sep 2026
 01:25:17 -0700 (PDT)
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 7 Sep 2026 01:25:14 -0700
Received: from 969154062570 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 7 Sep 2026 01:25:14 -0700
From: Bartosz Golaszewski <brgl@kernel.org>
In-Reply-To: <20260904-monza-wireless-v6-9-d8c5042b3efd@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260904-monza-wireless-v6-0-d8c5042b3efd@oss.qualcomm.com> <20260904-monza-wireless-v6-9-d8c5042b3efd@oss.qualcomm.com>
Date: Mon, 7 Sep 2026 01:25:14 -0700
X-Gmail-Original-Message-ID: <CAMRc=MccfYEMEgvcpy=RfJpNd628OGk=SmMwtjc+pJZkucQFsQ@mail.gmail.com>
X-Gm-Features: AcwNN1XwqFAXrmXYpOAQWADX08FTIyLnGttd5Dhn81G4LPN9Mia5iK__VVgYFVo
Message-ID: <CAMRc=MccfYEMEgvcpy=RfJpNd628OGk=SmMwtjc+pJZkucQFsQ@mail.gmail.com>
Subject: Re: [PATCH v6 09/11] Bluetooth: hci_qca: Flatten struct qca_power
 into struct qca_serdev
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: linux-pci@vger.kernel.org, linux-pm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
	linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org, 
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, Manivannan Sadhasivam <mani@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Marcel Holtmann <marcel@holtmann.org>, 
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Fri, 4 Sep 2026 17:42:24 +0200, Loic Poulain
<loic.poulain@oss.qualcomm.com> said:
> struct qca_power currently only groups a handful of fields
> (vreg_bulk, num_vregs, vregs_on, pwrseq) that are exclusively used
> from struct qca_serdev, via its embedded bt_power member. The extra
> indirection level does not provide any isolation or reuse benefit,
> and just adds qcadev->bt_power.<field> noise throughout the driver.
>
> Drop struct qca_power and move its fields directly into
> struct qca_serdev, updating qca_init_regulators() to take a
> struct qca_serdev pointer instead. No functional change intended.
>
> Suggested-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---

Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
