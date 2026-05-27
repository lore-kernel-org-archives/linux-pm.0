Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C04FA31195C
	for <linux-pm@vger.kernel.org>; Wed, 27 May 2026 06:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779862514; cv=none; b=kiyytUGQYtdAIZa8iu86SQinbg+HV3xcDKNUHyNfLnZdRXEWFR670xGfpdspcp/P6IzXJGiKw48w0mswcrbFjkzpbAFDud+yXNPxIi5lYaeqKuNykM1DVqMpRrtcWSKmA888XcDeW9MYdm9ayZs6rOzQlDgwq4OuW0mFbhbHo0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779862514; c=relaxed/simple;
	bh=+1D3hVb+6Zt/jokGOSsQCDspQRx3xjk+nJ/y2DHFEIo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OQ8f3dh8c3Rhtam3zkTQAsEKS2JL/t1tppauFtDSQYPUX83nlFRuNXPElUL5ZT2tV3YiFbrjhGcUFgLSsKcKHtWgY5IF50VQJEAoReauW9/QDBN8e6ptG7SSTyRmOZyKvPA9i5kZDs8lbnXYZhUD8V5RMc9kEJc0PQ0FvpMSlSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O7Hsgw+j; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O7Hsgw+j"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-365e54bc4cdso826802a91.2
        for <linux-pm@vger.kernel.org>; Tue, 26 May 2026 23:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779862512; x=1780467312; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+1D3hVb+6Zt/jokGOSsQCDspQRx3xjk+nJ/y2DHFEIo=;
        b=O7Hsgw+jGMS7SvQal6bo+TX38F2x6KWaZ6B4h0Mg9Pv4fO3ZxxLMb5BM/QCt+ol7NK
         cksiRAIhijoGGtw4Gdt+OEQ9uBUWyCJWDbo77s8/bO5lUEIaqO7O0I7OKN039TwE/zcg
         2mEqjBwN2w1j2+uhrw9Jw3KD3xQ2kxZLXGK7McpjyIPC1UL0JrbinxWyv7H65kDbD2Nb
         +DtSOzaUEVkSJtSWCPo4rFlZRtJdMOHnEcgnQKl1Qmc7qGFvxgVZNYh4TdcxMjsH3Erj
         W0SU/KATGs1drpkFf58Pp7qeegirEOoKfv+6jdaU1dolg7ZQRrIXbdp6KyoiWIELGfMA
         aGqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779862512; x=1780467312;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+1D3hVb+6Zt/jokGOSsQCDspQRx3xjk+nJ/y2DHFEIo=;
        b=d+mTGTUrmJ+eybVtq8nfsIyXNB1y7T7HGxNsypJCwCnlLb4PEObCtj4KX/NOoQRh2Z
         Dqt7rZGd6kF8OYw2CINsT6K8WNBBJvwMdLTXug9PASQed0xvUV3tWw785LzKejOF5yt9
         afbnfXo2kX8SZ90iB0K5lSYqjHTzHIEh85Tp1xQzWXQT0F+ScN0ixTqUOmWJG1olPuQY
         x/Xp+LRxN8DglSvyxLe7tWVx9BaCnxlghjf3YYpkmwPlZE/LxFbwFcLBSfAckcDDVt6o
         vRZl26XF2U9ek5adQiYhGvwAZS6kLi4FNIBnYKqVldKPqQ2YEZ4aAezfNxCdNkHeu/YO
         mSLA==
X-Forwarded-Encrypted: i=1; AFNElJ+Ezlg3/VQTJ6xRJAun6oBVQ711jwDm+ywSxjnOysJ/DgBaJmgXUfrhVlxoGDzyQCyIyRC6/kRp1Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzKwB+07s6qxZ9nbJo2cltQ3B00xhJgHZ5irrasga9dk2pKbrJh
	dyuNvJZ/qx1GKmqpEe3WbtNpBC3IYL7uXfx0ppEGLx2V5kZxFPmW/V8i
X-Gm-Gg: Acq92OHZpPBa8/SCgwIxdR8KYcP0g7u3yYeqaYW9UC/bOiIjbPKH+OyMcpgkoNOIbBi
	IGoaOlzmJMVnpXJvAW6IAgJfIzW4pV1wXS1AYLm1QJNXbCsKl8NJbYjmoLRZcxRotLg0D7uskuF
	qWRJkNbuoe/h6ssaGJCGiWD6coc74xCf7dVXi/1OjBNXh1eD+Nt/l2rimLP6192ufcCUf02Nf4f
	iwMafsQ62hioKTmN8k/qgcRIEMkcJ4sPdfN50y5k9sLWnF9c4YiUPW+hWTgeYmt4SOG+lFI/Jzj
	wNMwyvV+N5WbJZ+XxhDDOzuSkRkMVyeuKOQ7RXWvRzAu1j5xFMreP382NuFh93HlMoLVjW80vUy
	cQXIlAtWa6AAL2Z2EFLyUuargQD102vq1fYRQ3cdIGbj6+6iYy1GhxvmT/RFbwz/ljBAcuO5y0j
	6v+yNukpl5lAyHbwJ+fMSVYVLN+rk61AkcYnLQZmXIJ7t5
X-Received: by 2002:a05:6a00:a86:b0:82f:99c5:868d with SMTP id d2e1a72fcca58-8415f5f36d9mr10609174b3a.4.1779862511836;
        Tue, 26 May 2026 23:15:11 -0700 (PDT)
Received: from magniquick ([2409:40f3:1420:77e7:78d8:bb76:bcfb:498a])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-841d70df178sm1339088b3a.42.2026.05.26.23.15.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 May 2026 23:15:11 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc: Sebastian Reichel <sre@kernel.org>,
	platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] platform/x86: hp-wmi: Add charge behaviour support
Date: Wed, 27 May 2026 11:45:01 +0530
Message-ID: <20260527061501.10943-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260505200222.157144-1-navonjohnlukose@gmail.com>
References: <20260505200222.157144-1-navonjohnlukose@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Gentle ping on this RFC.

Is this approach acceptable for hp-wmi, or would you prefer this to live
elsewhere / use different gating before I prepare a non-RFC version?

Thanks,
Navon
