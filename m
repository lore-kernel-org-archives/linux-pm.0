Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616612ECE91
	for <linux-pm@vger.kernel.org>; Fri, 28 Aug 2026 01:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787880495; cv=none; b=TM8LjcnNDI7tMl8EI4JFyNfSIHtkdPnJ3P2bqmAGUvNnJmaIvRMwCnhVeFnvx2AmV0SkubaIiyJAz6RX2hojJEDtQs3znqeZC+WQEOWLI/2PWDcl/+x2S0w2Dn7HaP2X0AcKOeL7Z9RGD594YQKgEaJoBvlVumkAIUdktWAxf4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787880495; c=relaxed/simple;
	bh=Sl0a9B9nADNHHFtAngkvL/Yf+242p1ix8kNJ/h47Www=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dOa6jCFBvweMegpAShXhpB6wDSKIyqjQPK2MyUYCOPXTfCGzNQJhoycPEXwdsGixEYEJ5LbwuOZ//v+2I0yMEwLqZ79mPgEXiURqGOJ+KZxrGSRtHUEUgJttYMWmI4XgPB3VmwU8U/tFShbGmG2T6xAl0Q4oiFEjIRZUzJKQOeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CNeiVYTr; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CNeiVYTr"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ce98cb8165so4596155ad.1
        for <linux-pm@vger.kernel.org>; Thu, 27 Aug 2026 18:28:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787880494; x=1788485294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Sl0a9B9nADNHHFtAngkvL/Yf+242p1ix8kNJ/h47Www=;
        b=CNeiVYTr9OEgOc2fEclVcSp0tO6FEXbZNpzel5pCM6manF9ZiNbAel675L1spvzt+n
         Mh6y5Qmdtn+MSyyLtokM1pPCcV4WruTDytnkjEVq/X/wXWyrQK3frjQEph8I323b+hi+
         WzzkeCCblIm/45MsfVQy20FDcaJr6Nfjll6D3vyFsgdbFUmlyAyASHr2colQrAJk1dIw
         NdGXfQwg2ol14dIMK4BTbLMAhGP1FNpQ4n0AS5lviJtdPAjWtX559h3QWII94agnVDTE
         srA35nL9WLfIbQV7Nt44Rg9U7vMuemPNOFisVRjNOA7htyMHrxse36tSv4D6EDqWHbVR
         i8VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787880494; x=1788485294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Sl0a9B9nADNHHFtAngkvL/Yf+242p1ix8kNJ/h47Www=;
        b=AwwCS8mtXysxLoGKosR2S5L/g6r+H55wajptumScYcivihwLQYv6/k712wxc8Rsrkc
         jWqcQDVnmQtI0JYwH/SCf7V1lpoBFywnfaCvbd/tllEbKGVzM6apnlPsBNNm7ryOb5qB
         kK3GWqx7N5+5mSx02KagKQ+x2Hbk/INJA1LB2tN+E0ateRDV4GgyInBP14344FqQkiYc
         CPgDjmiIyt4BZ8wDfnaPce9S/8vxvC5Yn4ROBvF/e3ldn2p/2Bqk7jtchkx8DaxGt1r1
         bb/D59eEhKqrXwVUjta/SSqmBK3s7G0LVGwNdKhYfLdvTpPNb+xsVVlpGHGHauFd6KKB
         BJZQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr3Rz7NxfacvaEuaiiRyUq3nlHX2+OGQxDJ+vmVi+9ez2J6vl6A2OT7V3h9IGZyxVy7LDL5eM4mDg==@vger.kernel.org
X-Gm-Message-State: AFuF++lGQLOwx+wZ6k/6wM3zT8cx88kkXxjW/87/7cI6Y+jiDo6WQT2F
	ukRogjbHZxMWiJyt4wdsP8Sa+V/SRe3AfRvTPKcXfmkhojaAkSUcRGRG
X-Gm-Gg: AR+sD11p1EPJ/dAod2njJ8UyW866xREdqGzuGI6TTPUVJJvuO1dxFH+Y2U3i9afhKlO
	0ZNr1EcqCfDD8WVlbLSeeNQtCyHLQQuXienYp2lXwWWKKjpKB2cHwxxI5/A+Z76UGm0LBp3dz01
	mzju17UF79QswZwMZTT0H159jeldkp4ILYOBps1PjUlYeNaDJmUNv3dv72dIiNP7GYoOYKFjixG
	vl/QEyYyp0dO0A8UaabDHgTXbsakOsIBAt1Sr5k7XBzNu03mGyKQA0BHD7wh98+/Pv07WZn+z1v
	FjX2ZX/q4eiwviRcbLMRBapNbLiP8wYL5oDi9j4AKCNToUNF3Zy604CoZdqeTnClipZPF1hWQJh
	yPgERwezR6YkQX4tWTtFwOTFvbO6C0WeFFg/z5Ak9PaB8FkUUz3zNG3CSAuRF/SNFF7BamOknlp
	rI3cz7sWI4oysM2iWQDeOzfzsGuKC70xTgZAlC061+Qn2sIQRCiM+Gbr2nnsBHFSNc1hN7unB5Y
	A==
X-Received: by 2002:a17:903:a90:b0:2cf:8aa7:7810 with SMTP id d9443c01a7336-2d74cc49176mr37059565ad.2.1787880493557;
        Thu, 27 Aug 2026 18:28:13 -0700 (PDT)
Received: from autotest.lge.net ([27.122.242.71])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d75988d8cesm633415ad.66.2026.08.27.18.28.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 18:28:13 -0700 (PDT)
From: Dongbum Kim <dongbumkim75@gmail.com>
X-Google-Original-From: Dongbum Kim <dongbum.kim@lge.com>
To: hch@infradead.org
Cc: dongbum.kim@lge.com,
	dongbumkim75@gmail.com,
	lenb@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	pavel@kernel.org,
	rafael@kernel.org
Subject: Re: [PATCH] power: use EXPORT_SYMBOL() to export symbol
Date: Fri, 28 Aug 2026 10:28:08 +0900
Message-ID: <20260828012808.2462015-1-dongbum.kim@lge.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ao0v6G68S_W5CBz5@infradead.org>
References: <ao0v6G68S_W5CBz5@infradead.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, Aug 24 2026, Christoph Hellwig wrote:
> ...

Hello,

Thanks for the feedback.
I agree that exporting freeze_timeout_msecs variable is not right way.

The real issue is that the driver thread cannot be frozen until timeout
expired for try_to_freeze_tasks. I think freeze_timeout_msecs value is
necessary for all module, including non-GPL modules, to prevent to fail
try_to_freeze_tasks.

I will reconsider the approach.

Thanks,
Dongbum.
