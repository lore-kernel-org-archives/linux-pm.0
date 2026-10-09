Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E8CB3B3BE7
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 16:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791565047; cv=none; b=T/E3pfvocugdYhehZ6FWrSApxOcJawTrl1dQOS9v8ydmzY/aUPNKj7BiKfwwYSUB3T8ud1u2XfMPxRyLoAQ80w+G4wFcP0xy8yqxTwd16mBMth4V5oPvfN1vXSvWWCST8VMGH7eIQ4OOIZk/2f891ubu8HVnXczB8xG7hPYKY9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791565047; c=relaxed/simple;
	bh=S0ooHVwsSm9j92TkP4B5RF5jogq2Eb0nglNby8lex/A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FHgPTqdtg4cKaaW85MI13NTi9X1sNjCYha1kl/MG7bbauh7EJXLIH77u+RoUfkLoySsLucDY1YVSO9y3jVfR1qKkALeAMqFKll2Z3v68K849Mrsn98RVYnBicjLB3/h6oQObbR0vYKOZlRbETHJsQh60lephgTIBzDfOWkCqxAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IjuOQ4hV; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IjuOQ4hV"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-48c4207ac26so28069f8f.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 09:57:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791565043; x=1792169843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SmxImwdyKaCz4AQnY1VDiMchfMQezVpc247Y5c7VBv4=;
        b=IjuOQ4hVVBgo3ulePEn6N/HAIjxkXU/w3sy0M41az5iL5E+HFSm0A3LR+ueavOLlt/
         6G7i8eK75i8yA+dx2ZjsqH7HoR01SFs1qPPdrryxwNRCxaWHZ/cLOMd8GwvSfGHe1WBN
         Ur8Pgw/QjLqfQMb9FFLZZPY9+mjt7q+3flGZv/hG5kXQ8oOw+JyeBDQylFbA8Nivd82E
         trnGoDPhrY4AcA6fMImAr8c3Imlt/7LxKUBSo0SCL4bx8LlKTVT12VQIqq/hy9swN2JY
         +giL/VKZtyhx1cQpXh1dkiUk0T1HKVOd+kc50SgnV4WZF+n9GD8eaRXCVdHm5m8Bws0r
         uSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791565043; x=1792169843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=SmxImwdyKaCz4AQnY1VDiMchfMQezVpc247Y5c7VBv4=;
        b=0thgx3vV0hNGMddD1RJ/gT9tzdHUkw3bIV5YEML8DbLi0X8DW3uHCboRGuwCaIrQ/z
         /UkZ5c8DBLduHPUc1SMjWAx9mZadfqxpzhovFuFXn52tu4wbGjyJWsFVFLvEFOSaqQgl
         ilLau88/XW8lkerUI1e1b0vzsTz9pZJ8OxrPU9KhQwaALOCB8Xouf1Z6WoD3Le+uLepX
         OiLePu359Q/624gMgwUzfpSTT2JQLSqe1UlFH2ppZnmYgXFWNyUtEzoQih0OJxh5WLYY
         PnD8/8IJvgk+GVjoG19tF81Z8Y7P1lH++guL8qLxjCyyd/OwIssrq3OUu4YRS9qMNY34
         Qecw==
X-Gm-Message-State: AFuF++mOqdUaPw9YLRZsSYdOrYYpj/hxcxKfmuAJ6sfWNXsgbjbJUy3T
	rqPltg7LmfBK/76H9CffpvQxBLbk4WYrgxuM/Vzd4SgG9pOVJW4ieQwD
X-Gm-Gg: AYBFou2jSZcgz7VePR8YdSoQ/lqjjH2sBaENvEPlqHkvBfGHjkK/xff6xvHWkAdf23W
	Z11maEaH9B7I65AS8lDxq2a6cdP13PJeyHzNTp8IyLmpWsbDcH73RG+iNu+HWiCQhETlmwuMt3q
	W0De11cN6dbiViffAXwxb7+V/AU/CqxrK4Sn7wroUqZ1ejkVURYFe0XzRSRp58kzwrvw/LrF2es
	/IzGMOx+q3bsM6Wsm9lPvfBcRxVG6xT4EOEu006e7wavTLFpRj43nGinFT4ZoVdaJ8WVtJ8uXtP
	LTvwXahgX81b3IET0PisQ38H3PquHOOmdbnEAV32koqyfcs/kL7K6pNz0B9Fb4voiE8BPNXPgp/
	O2wZoENO2zfvvsWRehfHPIbk4pEWzpBgYq4wWWDKnvyQ81QsyBS3Qlb98sY2KgPdADaj8a1pwjt
	f0h4ioyc1jjhaIRfVtYHix9E+bXhJxjiWT8PuO7Zf5hlTnlwfP+KwWR53qCYQ7tS5wZBtUmFDAU
	I5Bb23pcVtChLgDnyXkZQORwXBg9mvG1rwTCvbNk/xniSHcudPh2pktFJdCz1afJWGfoEVBHzr8
	GlVwrOpbEx2lkjy52A==
X-Received: by 2002:a05:600c:1e06:b0:49e:69ff:c6b1 with SMTP id 5b1f17b1804b1-4a18e4f1630mr47392405e9.31.1791565043429;
        Fri, 09 Oct 2026 09:57:23 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:e93d:161b:5ff8:cb57])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a18bf1358asm70667395e9.4.2026.10.09.09.57.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 09:57:22 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Prabhakar <prabhakar.csengg+renesas@gmail.com>,
	Biju Das <biju.das.jz@bp.renesas.com>,
	Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
	Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 5/5] soc: renesas: Kconfig: Select POWER_SEQUENCING_RENESAS_PWRRDY for RZ/V2H and RZ/V2N
Date: Fri,  9 Oct 2026 17:57:10 +0100
Message-ID: <20261009165710.1320233-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261009165710.1320233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20261009165710.1320233-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RZ/V2H and RZ/V2N SYSC drivers register auxiliary devices for
power sequencing, which require the pwrseq-renesas-pwrrdy driver to bind
to them.

Select POWER_SEQUENCING and POWER_SEQUENCING_RENESAS_PWRRDY from the
RZ/V2H and RZ/V2N SYSC configurations so the power sequencer driver is
built whenever SYSC support for these SoCs is enabled.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v1->v2:
- No change
---
 drivers/soc/renesas/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index b7abca4559df..32cd0d9c8758 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -517,9 +517,13 @@ config SYS_R9A09G047
 config SYS_R9A09G056
 	bool "Renesas System controller support for R9A09G056 (RZ/V2N)" if COMPILE_TEST
 	select SYSC_RZ
+	select POWER_SEQUENCING
+	select POWER_SEQUENCING_RENESAS_PWRRDY
 
 config SYS_R9A09G057
 	bool "Renesas System controller support for R9A09G057 (RZ/V2H)" if COMPILE_TEST
 	select SYSC_RZ
+	select POWER_SEQUENCING
+	select POWER_SEQUENCING_RENESAS_PWRRDY
 
 endif # SOC_RENESAS
-- 
2.55.0

