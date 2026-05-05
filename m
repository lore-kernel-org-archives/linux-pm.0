Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0581A682E
	for <linux-pm@vger.kernel.org>; Tue,  5 May 2026 20:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778011653; cv=none; b=oAj8Xf3Cy3I63UNqLAh7x92TKAY8iw3SNi78rd3G9e1aQeszEtP+BBYDvqmXRwoepMtAB2YOJn57Oo4nIadcUSi3TtWDgmR8rv1ctZas0oaAT1tLoV8gWKK9lVrfEvAYXsmON8IoLpdUW56hrj91lToljFVO++u1dnUtKU7DJXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778011653; c=relaxed/simple;
	bh=72OHu7enNqcJFfpBOsKNgC5fc40GMPq9oSc/T3JEAVE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PkdzmNJCYP5wQb0Q5opNTp2wVVyCUJ2QPf4WQ2k6iNZ1oLDdnHu70itUHtSjZ/F2flt9v0ldH6e8gBQrcSkpLraELcZt1YfDvXWVEa7VgXWNvGmta41J1viM7KlsKE5beUyCG2msgP9b+aqJdxatDEOPFd9i91eHp/Q8MofvhoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pYo0wYzc; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pYo0wYzc"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2a3e79fe2b8so3092155ad.1
        for <linux-pm@vger.kernel.org>; Tue, 05 May 2026 13:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778011651; x=1778616451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FZMEaIxTwwgj3zyVbxHfeuR77dvZtji4RLCiRmy4JEA=;
        b=pYo0wYzcUgdfp2dMrhUrritbC7OF+K2w3WXeYMtk4b69N1QsW91yVPf8RBHaIvKWxC
         nSM2zNz1sfhc4olvDkSC/lMOl6MA0jmtoCtHgjZBz/L/Yr3Lt+QCYEdhA81KTiadOAeQ
         ynSpsP9/8398xYy70xBryUsdLW1I8crA5lkpuS3+AejUeJ6uN+ycnLYfMGHFIlrwHj/a
         NQMFgRsDb5L6eO55Esp6cTDKnAYnXD1F7I1h8wws+N4G+iTB6KuxyqLgRTyT02PsWquf
         rmhR1HSII5uy0wL3dFHXZybTLBKcjgvxPNC+LK+jsB2+Ks7cMhYO1Q0rYuuwwd+Ypayh
         L8ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778011651; x=1778616451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=FZMEaIxTwwgj3zyVbxHfeuR77dvZtji4RLCiRmy4JEA=;
        b=WEtcnQz7tgBMpgJxi5WcssQnVwwbjTI2M6y5ZwYhtFfYxQC/M/Kc3PCpBuADv3XtPi
         fH0jZdhUSOOl3iTn/qtr1jLZMhiG+gntsLcSht+DmZ5yzPGWZip9jMU/2DmDQgNXUDwX
         SdxRfsZsrJvkil16bvXxuwcgjb8yf004dYsVX8j4ZOMUMbEyHTUUXVFv/qBzhTHa0va7
         5bG1/eViDL/noKn+CkjYwxF22JuyZSifS3lN5/mWoMDc0/4E4gcBfciPj2buY3HKuv9L
         vh4NLTGi4RDKtToOBOwcuqTAnQj0fO9M6U2ZUG7bIUKRkVm9YiDLulRTmsut9VJa3BMU
         Jp8Q==
X-Forwarded-Encrypted: i=1; AFNElJ8w83lB5mJvehvXqrNJ2qotnb+d/2YXxP4Y4QkMzWIj9txY8zF5dXN1HaJDfKnpO+sndhOoQJU2yg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxBVMUggSccLPRGjlh/1HTWz4lTpIVY6i6TTPWy6FWSyEk6oNoD
	V9hx74Yl2pgBjfYgvVP5/ERQRp7J9RfmhIvKt1UD0QFb1i+qwnHUHzEM
X-Gm-Gg: AeBDiespBWVFE+yVpf29qmH4ViHBsJOvWOfsF2AZ8hpwYgoh6Znw4Xz5e+FMMreqztA
	qtLbPsVKqUpRxV9e9BTjUg4pLGS1ePEmZmS7UcH6z6FRaLnzTbdYhNZD8Z2fL1s/i11PcnjUpyv
	bvpoYDcYOHT+iRWaK5VqBnlTvi6Mn1NsYATAy4MPptioMD8CXqfJ+47yzm1Me3Xlc7AM5+NkXVF
	dkJkGGXvVAWQ96XkTingS+Z0M4800wu7WFK5S06jygERXOYMehIgVGnEWc8bGW5Al/BgTLxEvhF
	hJzEnUH/9pFFcizWAHAt8NdCOLstBZaJCDgsj7YXzWxarxlA9xVsiSmohNYhzSssUP+qFxma9Bh
	akZr2c8c+PU0RqAAaK/QH21QWpcSxMMZ2AZ7TgbRTDxa1bVdPz0FM71mY1znnr2p4t+ZIRiztRN
	QOkonUUMw9ppVZrKDW/wgaFMbEWSTeIlEb7b9+NRih
X-Received: by 2002:a17:903:1a2f:b0:2b9:42a3:6013 with SMTP id d9443c01a7336-2ba7afccfa5mr1584845ad.1.1778011651275;
        Tue, 05 May 2026 13:07:31 -0700 (PDT)
Received: from magniquick ([45.112.148.110])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ba7ca37a5esm659045ad.81.2026.05.05.13.07.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2026 13:07:30 -0700 (PDT)
From: Navon John Lukose <navonjohnlukose@gmail.com>
To: Hans de Goede <hansg@kernel.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>
Cc: platform-driver-x86@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jorge Lopez <jorge.lopez2@hp.com>
Subject: Re: [RFC] HP laptop charge mode control via POWER_SUPPLY_PROP_CHARGE_BEHAVIOUR
Date: Wed,  6 May 2026 01:37:24 +0530
Message-ID: <20260505200724.158389-1-navonjohnlukose@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <abfc9469-5d47-4e83-8c3c-03138f1b2ade@kernel.org>
References: <20260427140857.397971-1-navonjohnlukose@gmail.com> <abfc9469-5d47-4e83-8c3c-03138f1b2ade@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

I sent the hp-wmi implementation RFC as a standalone thread by mistake
instead of replying here.

The submitted patch is:

  Subject: [RFC PATCH] platform/x86: hp-wmi: Add charge behaviour support
  Message-ID: <20260505200222.157144-1-navonjohnlukose@gmail.com>

Sorry for splitting the discussion. I should have threaded it under this
RFC thread.

Thanks,
Navon
