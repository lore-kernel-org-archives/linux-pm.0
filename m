Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793284789;
	b=ZpkXMsUBCCo4OJ/yN6vbxa4nRCyIqcGHIz8UTLE1jJ2Pi1LCvjWTnmFjaoQPw/pjNipN
	 Lyyg0QeUi+XSvTI/SzYSXh08x2L7G1f3lkBgix2mt6CJBdtgpj4mNYRdhLKYdMeAkep+3
	 T/BprFpvYdfAwDewvR7Bx5RPyio+C9gxCwRBrOJLr4TfJpsk4jIDczluQtx5AP/H7k7fd
	 I18PpkxuLG5kGt4CTNjuzSk/MyrNagOhMMyoQlSiKJz19NgCQlc3d4QTpG7MAXsVErpE6
	 NsQsRrj1Mca5UAwAMXkDDWZYFOulKDHa8/OVjC5Vs96LdSyj9B9PaspYGuvi7bW/GvQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793284789;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uBDKsqEMUUI4osJISoF5o/4t2sYaPTTraFXlQxWlPBk=;
	b=s5BCcwIlE6iAPN7T3hHGgiWxspvQ4OlV0gUEr7S4H+b+YogUJ5+JvN4i0/S05EHKDO3X
	 qqJOezqN9snDcDBlBPyJFgSnsqTV7EH+vY+V5vL6nGEPO8MgZnaBPK+G3GXbFzubDVwiH
	 nChnLO/9E+ilERPbsla3x+TFrKnuWAaJJzQNxujGyoT0miZZcteP5Uqgc6wNQG4pswRYi
	 s2AaEjI+bv6AUJ0ORKkfeBxIIPlv+axGCI2T+JAEs9p5F95aw5IuijutCsjNEchvbM3Wc
	 Q4MbtLvxUl51nNCW+TgIrQbI8vXifKTwkpnwFzq9uAtuUeezeoY7mWtJSXLLO+Pll0g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fPTlg3YK;
	arc=none smtp.remote-ip=74.125.82.43
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F904606A327
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 14:39:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4F904606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=fPTlg3YK
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1846bc43c28so2543444c88.0
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 07:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793284788; x=1793889588; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uBDKsqEMUUI4osJISoF5o/4t2sYaPTTraFXlQxWlPBk=;
        b=fPTlg3YKi8LCEYl7MWaRXbl+fOsMT8EooFaEX/qteZRl8FsZt88RyX9Nz4rh62atDU
         N2mi9nkHHOJC4qFeiUXhTHbjbhHQHXOF+NhhfCQK6iUf4J/Q9ypFok7z2wgCKAPn6EjK
         xZ9kY5ZnP4n+8lX6/VsHr77Tn99+eesUK7yOJOQntEtEMQGRE1D1vlqqCLeQI7lI9/6d
         T6b6GWLz4O6TATQ+xATuCOZzKNxV75JOEocPZj36+KoGY18UuoHpbDZjja7BkGHZcM0B
         8XE+KTQjlqXnRe4OF7u9IeoFkO5y9EWni2EDctTAKHudHO9Rp8OhbT05Vxxf/IOtY+cj
         QvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793284788; x=1793889588;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uBDKsqEMUUI4osJISoF5o/4t2sYaPTTraFXlQxWlPBk=;
        b=PM5972WU5+CxnSQHcWlcmDjMCZv5GN2Lpp3smxWQqppL4ols8nTgrAY/oV0tlB0fjz
         dgj9h5nyBBn/MH+FmfFRmdJshhe/+zsiBdCLgn3bLvDeVrGguw2NBQW1+wQUVOL8jZlM
         6Abr+KZQJY9y0Dw54QqUnl3IqbNaXOWTM/RSseOmNMgt0632aM7503p5pyZneDKHgUsd
         LTiGzx6ybIxuC15gUeqWmbqbPGiGbxcc5/noX/9THU8vjdagoDwfsHwhK8rIdMEnZarB
         i/1sSjVEeAGH6Dzj2FX85Q6TFf5Cy0D7/9eOuScS21l8VPgZZVG6QOFG0AOK1DheFSTP
         itHg==
X-Forwarded-Encrypted: i=1; AKwUvBztZKp9nqtWizushSP9ykFj9L77IUUEvWnXXL2dvY4hhOVoPmSsVb2U6E7qvSZX/5KBE3npnPahJg==@vger.kernel.org
X-Gm-Message-State: AFq9FYLMsK4zdDPydboBxsAQ3VMDQnVdhOiZGbd7v5VSPQwpEVGseVkm
	AlnRdTuDncKOQNXuFXrR1K+FPLP009xNZBV3D1SoZ5r6Q/ZFUHVRt58=
X-Gm-Gg: AYBFou1XfJ4leSB6E7W+zHiz4nlq9b/sojAGc5i+aeOZxVlFUtdTqGNL6kQznPvfiL8
	nVcoS/w7GsIk5CCkaxW52rc0Ehs9FyaEDeMKj7ZyyuCEMqDcKUpXhpc9qBqdNNlK6uP9HFzs5HJ
	bGlGs5sJdc5hNYYGXD8WOn3ZN2V4sxxmA1KaRpIvIyTmDtwJdxug+mJwcOvhvAkVBOmLQrFbmth
	w7ICocgojA+Z51xlyDDCkNrzjm9pWmRyx1Sx6E6TsIISq+m0znIMJxO/iAdNr/DTNxaF3LRXE0D
	5XK+Q1CNlouV4kTEulZPLfZ+D9SLfSD6t8+Z/Q0z0nViiij3Qnj93ab2/ihvdEEkn/9j5rAvHCp
	ynar/lirqebSNVBRAkNF0jxfa6xJOhaIfguYvzKqZrl3UgHGJBrtmVN4HwR+vPZ5IMRXWnBp6CE
	zB8sE8j/oYQkh1Hw9V1cyVQ0WkD5HwOzoRAw5rdZ4iv83QwkcJ6DFyve1neZLD3G5sesR/WGTvA
	bCyFMSwzYcA5gWuheHyDv0DRGI786ksc8JnGlk53PRqIU5FrQA8gCc72ECQ2N5rhI1ocHpvoKML
	8a206eKSQod70zBTE4YRzENt77FJxlcj7e4yPVn8/QKK2h7x5Pj1bLF6i2nl/0LvhiQ=
X-Received: by 2002:a05:7022:ed07:b0:1a4:c892:b14f with SMTP id a92af1059eb24-1a6ced8e7afmr7393000c88.29.1793284788293;
        Thu, 29 Oct 2026 07:39:48 -0700 (PDT)
Received: from at-Standard-PC-Q35-ICH9-2009 ([106.202.115.216])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1a75cdd21c3sm15396439c88.4.2026.10.29.07.39.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 07:39:47 -0700 (PDT)
From: Atharva Tiwari <atharvatiwarilinuxdev@gmail.com>
To: k@chaosmail.tech
Cc: alexandre.belloni@bootlin.com,
	andy@kernel.org,
	asahi@lists.linux.dev,
	atharvatiwarilinuxdev@gmail.com,
	bhelgaas@google.com,
	bp@alien8.de,
	brgl@kernel.org,
	dave.hansen@linux.intel.com,
	dlechner@baylibre.com,
	dmitry.kasatkin@gmail.com,
	eric.snowberg@oracle.com,
	griffin@kroah.com,
	hansg@kernel.org,
	hpa@zytor.com,
	ilpo.jarvinen@linux.intel.com,
	j@jannau.net,
	jarkko@kernel.org,
	jic23@kernel.org,
	jmorris@namei.org,
	lee@kernel.org,
	lenb@kernel.org,
	linusw@kernel.org,
	linux-acpi@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-rtc@vger.kernel.org,
	linux-watchdog@vger.kernel.org,
	linux@roeck-us.net,
	mfd@lists.linux.dev,
	mingo@redhat.com,
	neal@gompa.dev,
	nuno.sa@analog.com,
	paul@paul-moore.com,
	pavel@kernel.org,
	platform-driver-x86@vger.kernel.org,
	rafael@kernel.org,
	roberto.sassu@huawei.com,
	serge@hallyn.com,
	sre@kernel.org,
	sven@kernel.org,
	tglx@kernel.org,
	wim@linux-watchdog.org,
	x86@kernel.org,
	zohar@linux.ibm.com
Subject: Re: [RFC PATCH 14/14] mfd/macsmc: add ioctl to access smc keys
Date: Thu, 29 Oct 2026 10:39:26 -0400
Message-ID: <20261029143926.1246-1-atharvatiwarilinuxdev@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <525E5B4D-A947-4567-9FCD-5FFF2CA8B161@chaosmail.tech>
References: <525E5B4D-A947-4567-9FCD-5FFF2CA8B161@chaosmail.tech>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> This should either be dropped from the series, or be hidden behind a
> `melt_my_mac`-style module flag, or switched to a whitelist approach.
> We do not know what keys will be introduced in new smc firmware
> versions, and there are already keys that should not be randomly poked
> at.

1. The patch is required, atleast on intel macs, as without writing GPU and CPU
	states to smc, the system gives PROCHOT signal under small load
	, and heats up a lot.

2. the smc dosent expose keys of nature that can physically damage the system
	it only exposes power/volt data, and the most you can poke is reboot
	keys and gpu/cpu p-states.

3. If a person is randomly touching keys, Its their problem and not ours.

4. There are a lot of things that can mess the system way more and permanently
	than smc (undervolting for example), but they are not safe guarded, why
	should this be then?
