Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794814805;
	b=K3gWr6KfbOCm6O5KkinxRgsoioNScoblbfMCRLVBw/ZnlsIIIcNuukP/LCVzfuSzdzcy
	 VazKXv7DpZAYci2rS9uFxTq1yJv31/2hORLu1kluR5lqbMR23LpGVmjmrDSOvs4kDITzq
	 sJwdAEfjjWv1AhWLc5Z424pTbT4nTxm00OKExi/lHY8GrWR0KdtpZ8pcCAyeXeO857j/e
	 yu9WJcvl+QsEgPha6TKvkWMJwUb0k7HpbBovXI/HKPFiYjMqH/+VTkv4xOl9sJALybFU1
	 JzEMnwd0kK5hlN/Nygjsht/CelbvN9nGrXai0dt61j67R9r7K80QguWCPXLee00AxCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794814805;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=rKMBgpb0mxyP+6kb+ZdWDKHU+yeBE20Y58pj8NkP9p4=;
	b=U2IVMDZt/GaZIJNdpw2iy4JXzAnHxvht1apnM8mSPjchE8heHQWbai7gY96kSh9xvU0y
	 p3F4PusMoVRUcjyZxqlOjcxk56sQJXOvpzlDOUW6Cpooo8rRDp3/7akpFMRPVCID4TPRD
	 mL8Rra+qesOVzB6FoSmrhb7Wytldy+6ixGAdaWCou6yA8wh27nzrFY7X5ksickm0se7FB
	 4lfuful5cfFtVdI0JEH/lnM703j+9SKZ1NaT8x+wC/MzjAKAksWjQEHF1AwcdEkWb2x29
	 ZfMBsRw6YvNptgwYE0+/Ilpdf8tz8GCjMq8fQm9OnVGhvfSesjEnNjoxY+3nZxnA3aQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mojDRsKq;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFEA60A3807
	for <linux-pm@vger.kernel.org>; Mon, 16 Nov 2026 07:40:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDFEA60A3807
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=mojDRsKq
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4bb68c197c7so13344065e9.1
        for <linux-pm@vger.kernel.org>; Sun, 15 Nov 2026 23:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794814803; x=1795419603; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rKMBgpb0mxyP+6kb+ZdWDKHU+yeBE20Y58pj8NkP9p4=;
        b=mojDRsKqwRrJVUQ5AuDQp92qQp6ai02Mt7rBOXHrgEvaT+gJ1zdQl1Ey87DJi+FYgi
         0sHEMpTaur8fvoBkWjwVO/PRg5JU+6NUw/Bdy/elN9fbPjgtIolRr6zunPblX2MdQRXH
         3Pf4N34SDEvwXAOhzNj49/roxN2DTi6bIiDoF9GLEg1vc+yOr/yKZz+dCddpQWF4T8Dc
         HwtB17SMeTjl8gjSpOAFSnSnukq6ih2u9cB7Tpr7h641/dmzlCENZWP+NSV+JA3/uvaY
         PoPf+lvIKkYr/sq8xjxz5mJ4AFCAPqC8aL805+aiHIyJIjFJFU9KDDitp/53X5L1ns5y
         vjow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794814803; x=1795419603;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=rKMBgpb0mxyP+6kb+ZdWDKHU+yeBE20Y58pj8NkP9p4=;
        b=s2j/RfgmqWhxwB6CqJU7BhZjqdHbZZPTxodl/GyTokJ8/DpMCpPGp2yB5fmvMfz/DT
         gZ8onmsl9efgrXsMem7vMA3LbqtZkyUWHR1+iyT7HyrUbhIc+tzZZ6R/gUtzZBP7VfGz
         OIoeCEHJD7DveBUJCDiNkn/u7kTBMLRwfEsDQC3+LSf/SqBkj6Ig6QK+qJtboLRsevGg
         AyUroxndzJ6txwkxUtjjsigZlHYgkalkdwW6+xE+fMNdoKHu1INQ+BLL0JleszxT0atv
         3WcAUfHKBIwOoJV+P/LyQgMGt4AuWONzPWW98F8mqr5r0HwQzrWHRFZVzFiko0Riqz5j
         5Nag==
X-Forwarded-Encrypted: i=1; AL+hErHkT5UPRXJfJcLwwjUtdM/QAQPm0SbwebU0m62umn5zxxGXLGW9eBw6seP6BJW0l2YumphvMB2wbQ==@vger.kernel.org
X-Gm-Message-State: APuU4Z/CvfaBnS1UowaviplV5OZbrUj6mpfqwF8GrwT3DGxsDDobXNog
	UDDlg3dzBmU4iVuIHv1xkh+UBNtNz4tZsDtx1Gap/O+nYaa4aYLDtXyT
X-Gm-Gg: AYBFou1bODWSmWZBMY+dMmVDoXSUmyJkh5vShe59BF7iAL8/4SkEWCxHVAV3MbmzgVe
	NvGirLH97H1S9Xty49ZQacDxy3CLHhFKSQEOR7SlSgMyuCMQklLWNFSIyJoQ2JPC0AtNKxvjzUe
	Xy3Dc4aYHHHMN1tI+hQBgwfs+Nhff7C+5OHvA+Z8nljmVFnUacf7lPKdCbUkU30NxnWh2grHwff
	bqBHWHGijXYGeRD7qOs3AYI4sdEABxqR+d0Setw+u2C6EqaN6yrRFDbnW7WNOPdM3GZD1udXzV2
	0Sn/hyA2Y/D1O403WvYaMId7crlDu/AQNzjLm6fCGKa0CHZZ5qti+5cQ/oYmkRgFjEGOUug393c
	FxT8wpNyTdDbOwfhqz/+i1P8E+yS6IdGHOM05m+8Y5h3ieYE3m8aKBw5LTCe5nflF+pEIDs5MQD
	Hayj9eykQ++/hOsqycEXqr2EUxQ2Q95aa3ANnrOFVi5hQjNcWTt5o8sEyzTVoK3xxxd1Ul7NjUT
	Qf5rjCOGewAjEjqTLRPEejFDn1Tj46YaSd4KUeR0ONUyYfIvVh+ueO+hjCMlKLRB/6XSqeb87Ci
	QyphKyaZOT4kPBxiOcajhhki1o3qyB46
X-Received: by 2002:a05:600c:8b05:b0:4a4:4d57:8462 with SMTP id 5b1f17b1804b1-4bb55a99ed0mr197499175e9.24.1794814803044;
        Sun, 15 Nov 2026 23:40:03 -0800 (PST)
Received: from dl360p ([130.61.107.245])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49c603f4d29sm20354115f8f.35.2026.11.15.23.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Nov 2026 23:40:02 -0800 (PST)
From: =?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kaustabh Chakraborty <kauschluss@disroot.org>
Cc: Yassine Oudjana <y.oudjana@protonmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?Adil=20H=C3=BCsrev=20Tepe?= <tadilhusrev@gmail.com>
Subject: [PATCH v1 0/3] power: supply: s2mu005-battery: add S2MU106 (Samsung Galaxy XCover5)
Date: Mon, 16 Nov 2026 10:39:57 +0300
Message-ID: <20261116074000.355176-1-tadilhusrev@gmail.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series adds support for the Samsung S2MU106 PMIC fuel gauge to the
existing s2mu005-battery driver, for the Samsung Galaxy XCover5
(Exynos850).

The S2MU106 fuel gauge shares the S2MU005's direct voltage, current and
state-of-charge registers and their scaling. This was verified on an
XCover5: with the s2mu005 driver bound to the S2MU106 gauge, voltage,
state of charge and the sign of the charge current all read correctly.
It does not, however, share the MONOUT average-monitoring path, so the
S2MU106 variant exposes only the instantaneous values. The XCover5 also
does not wire the gauge's alert line, which patch 2 accommodates.

  1  dt-bindings: add samsung,s2mu106-fuel-gauge
  2  make the alert interrupt optional
  3  add S2MU106 support

Based on v7.4-rc1.

Tool usage
----------
Prepared during XCover5 mainline bring-up with an AI coding assistant
(Claude Code, Anthropic): it compared the S2MU005/S2MU106 fuel-gauge
register maps, drafted these changes and changelogs, and ran a live A/B
comparison on the device under my direction. I reviewed every line,
tested on hardware, and take responsibility for the series. Review
comments are welcome and I will answer them myself.

Adil Hüsrev Tepe (3):
  dt-bindings: power: supply: samsung,s2mu005-fuel-gauge: add S2MU106
  power: supply: s2mu005-battery: make the alert interrupt optional
  power: supply: s2mu005-battery: add S2MU106 support

 .../supply/samsung,s2mu005-fuel-gauge.yaml    |  7 +-
 drivers/power/supply/s2mu005-battery.c        | 71 +++++++++++++++----
 2 files changed, 63 insertions(+), 15 deletions(-)

-- 
2.53.0

