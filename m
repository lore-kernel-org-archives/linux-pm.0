Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D734F1E9B3A
	for <linux-pm@vger.kernel.org>; Fri, 12 Jun 2026 04:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781238982; cv=none; b=dyTwc43KI9rqC5FXM4sm8GUjdAuBoh7tSAoS2ew7VGeLHb5Te0Je6hF4ACtrSNSDJ32ejcivpQfFMR1PKq6PxkseXMkJubMaB9Z44NrVvanvTvwHii8S4S6ef7CUriUD6IAuzReUhZEDdPvRzm1gXYUeBobXAt+79fIyHKY0Gxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781238982; c=relaxed/simple;
	bh=VA9Uj7x6YGsbqAp1uyJCms8Kk+z1fYnFr3KjaEsulGc=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:Cc:
	 References:In-Reply-To; b=nvnesOkb0L6yav58DgJiA1k2/mNoJEIP84E1MVObGfRUb/in7bgRX+M6wPybGA7iPZ9XCy6+RrsSzLOjiyroxEgKKgAviWEH7gX6k+vXRW0PCsA9KpglyGm7SnBC+8xE29yWQduVKrwqTiki+1GeHJnNFLEJ3z/q0vZQQGZ5K74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mZAnisAq; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mZAnisAq"
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-490ace40f4bso4691985e9.3
        for <linux-pm@vger.kernel.org>; Thu, 11 Jun 2026 21:36:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1781238979; x=1781843779; darn=vger.kernel.org;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VA9Uj7x6YGsbqAp1uyJCms8Kk+z1fYnFr3KjaEsulGc=;
        b=mZAnisAquRpKj1MLUkQTJX5Nos22Gij72kMS8OTIcCM/GcvXMdoDJ7+g5w6bazUuCn
         AzTq2bcd66QzBkk2W2bJ25HxLH1tOt/hjejFIYm1bGX99+s2Zxib4s2pklpIhf2Ay5xG
         K9gjGCcrmFY5AkW1VMbxNt/4jTMZNdLdJfahPw4O5oXGnIBihbtq7UPrYOvadbKSv877
         /LQGAN1dS4iVu+QW2VYVtXek6hTeIsE/fjxwP68EdP3g+VBzPjz1GsRnUpK9JHgEWmON
         2MFsyMTHg4gpvD4P7WPiFzn+rsvuWngZus7Qm+8pIKFPuevjFnnpGq9seonT76eegcbE
         rIlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781238979; x=1781843779;
        h=in-reply-to:references:cc:to:from:subject:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VA9Uj7x6YGsbqAp1uyJCms8Kk+z1fYnFr3KjaEsulGc=;
        b=jdQzR6KnOj5kmcThybtmLF/6aJ0ensVKuCUbxykJxHO4/tDPO3wIoSz+T3UIQYpINQ
         nH1NLnr8ns79DnhpDqJos52OtfWF3cXCVbo/xSQ+hy/TMp8YwutDaLb16hW+rMoeJSW7
         Id4BYNWE8UKqwrLBUaQm5XjeZXTN5w97Dq3IUzqIErYqsUGGEVlkhqLhsXSNNw1WYNtB
         Wk/aZOBbCqWQ304BsTQQ53WnPwvhGX3On+nKgEK0+nWpNWdU+OxKGVBfhMY/bo/6FC8w
         3rz+2QTbr6Rmanw0TtNEVu71KvAW93GXLkxzRnzacT6VXT/fIQ114py8IZop2721VyNZ
         KXMw==
X-Forwarded-Encrypted: i=1; AFNElJ9tuw4QdpcB2F4kweeiC9w87atQAy6wBuQjNiKYAHafaskaYGrNA85sME7O9fBSFIpqc1iy32mf0A==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5snqE8nYUqK9foLjWPkbPAoscFKFCffvAmLb8w0awGGjEP1+j
	FZOOPEjTKuk9omoOTKtZqdeUtRd2pYcB0YmmYrdyzUV7PuDK186eNstktQTvIBbBISk=
X-Gm-Gg: Acq92OFcjaUqr2apaoul5HcBqjGrarVoq8UJsE/AOcj/ghq2JxTL/QCe0zKP2ePJ6ey
	Zya1e/qwiBFbj8dMB2TIE2SuQ8vP7Omc0R8pn1Ng/ACBPkbLOq4+hyUaJxPD6G17q78IOK1t+jE
	Swii8jMbOWWyJAO3WYVrI07upYfgGMdh9giQW6a0+COxJpZyU3QVvvZg5dtAJyApNVeCqPMJtrx
	y12l02LiKxhXuVKUKkLJ5mFJvCrFFifKSGj2NiE+vNPEdGlbDowzmzjiidRuS7Y90hXIEPfa4FM
	msTZ2msRaTpZFR7M9NHxSPpsVIxbHmg9rAyoHaRPSwQuq0inRfWiFEMCG0PmvYX8owvBCPUJuQP
	kxJMA699WiJHKkYfQ0XcLRwvQrYptmnQs/c1nYU4qa7Yn7A9LhIJC94bsUOVtQX824m50sZUEy0
	9MNUJtiVyXoKVWLMAfMOCENbDHTo31mpMmIC6oOc0Ll0q17gyuYIdx7PAdGgYDPSj01i0ZP3gto
	e501h6C1gVsKg==
X-Received: by 2002:a05:6000:1847:b0:45e:ec18:f207 with SMTP id ffacd0b85a97d-4606db9a69bmr1554180f8f.25.1781238979313;
        Thu, 11 Jun 2026 21:36:19 -0700 (PDT)
Received: from localhost ([94.4.195.193])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f263945sm2067973f8f.8.2026.06.11.21.36.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 11 Jun 2026 21:36:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Jun 2026 05:36:18 +0100
Message-Id: <DJ6SIPW6W26P.1UHJZ5UZQ5ZND@linaro.org>
Subject: Re: [PATCH 0/2] ACPM cpufreq with fast_switch support, fast path
 xfer in ACPM
From: "Alexey Klimov" <alexey.klimov@linaro.org>
To: "Tudor Ambarus" <tudor.ambarus@linaro.org>, "Sam Protsenko"
 <semen.protsenko@linaro.org>, "Krzysztof Kozlowski" <krzk@kernel.org>,
 "Peter Griffin" <peter.griffin@linaro.org>, "Alim Akhtar"
 <alim.akhtar@samsung.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Viresh
 Kumar" <viresh.kumar@linaro.org>
Cc: "Sudeep Holla" <sudeep.holla@kernel.org>,
 <linux-samsung-soc@vger.kernel.org>,
 <linux-arm-kernel@lists.infradead.org>, <linux-pm@vger.kernel.org>,
 <kernel-team@android.com>, <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.21.0
References: <20260612-acpm-fast-xfer-v1-0-1aa6cd2268ba@linaro.org>
In-Reply-To: <20260612-acpm-fast-xfer-v1-0-1aa6cd2268ba@linaro.org>

On Fri Jun 12, 2026 at 5:34 AM BST, Alexey Klimov wrote:
> The series implements acpm_do_xfer_fast() that does as little
> as possible to make it usabe in atomic context to eventually

Sorry, I forgot to add RFC tags. This is RFC/work-in-progress
series.

Thanks,
Alexey

