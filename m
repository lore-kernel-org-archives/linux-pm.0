Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EE25226A4
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 12:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684671; cv=none; b=X5ee+MkgSyeowe/HA3okBroh0E3dGADvVsKayHEMSwSQyjJB6DHdg4KRI9tCJOpd4vS+gj4xOjk8pqFZavwf5muXr+B2xnkLbJQoY91Y5zaAkp4tggmeKPQ4uF0iy3TVOg2uH9I3/PqtDx35N8wlU+3IHbktKBI5CKAf96686Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684671; c=relaxed/simple;
	bh=w6v0UOr6JbOohE/P59sncCpI20ugCKosnuPAQYS1als=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEzyWn3NOQqA66HT4EIHIx9VzH3BgTFfizcC/tI90Z+qhIrUtWu/Sctft9OgvTFSYwga5B+l3YoQKDy93Qw1ZVm9zR8e6NBsdZtVjONVTlQcKYAhFiiC5vN49Qs9TGY6nmhuBHIrppCFEC7MfZNp7RzDLUxXLka9vumvg+RpijQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jf4YQnZb; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jf4YQnZb"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-4a00713639cso15369275e9.1
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 05:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790684664; x=1791289464; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cC37ObDoI6gvj753bjIn2lX4ChGqbdLdiKBVLQx0ab0=;
        b=jf4YQnZbzrszO2R8xP6FF75fWSePuF+jJgqE/SWOsbks/q++EH0zSKq4XR8Sl/gyJp
         fiFjIPT2OZWtqWRKeBcwjpOrAbroY/kENXuvLx13BNhJEV1Y/idS9df7+Ae0BeuBHDUv
         DbJlG7fozeFtrMSm6cjKBurRL45nwZr330OxDeEDqv3HaRBcHoFuyjlby5L9TcQv0xui
         lQKa/et/38f9g3CLqqwd+ETFde/52TsE+vgjaAeXUcpXmP4wKFA/WnEkeJfiIZG7iiFI
         8bAu2SQioajKS5iGPNS1J1Hd44TMMAVW/hq2cWWzavuakN6iKy9NPi8Ypbdu1R6FQnbn
         i7Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790684664; x=1791289464;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cC37ObDoI6gvj753bjIn2lX4ChGqbdLdiKBVLQx0ab0=;
        b=ERNEVUBM22T91mv2axbb78oNoH6nvuYB7iLECdluui7+cN/pRu7aC1JCM00jJ4Qnoh
         oj4hNYJVuoE+AwGJwFM2DI8KDoPGYNjiromaPWL1NanJEHaosd8q6bC7+8KQjoKPBYuw
         yeEK/mVdfUsC6r5y7Y3wkPvWKn/t3QWrNS6C27TTpYJub6EBx1XgGlK5Qbi4DwDUbLHG
         YKAMCcH8X4dsCpi2N+7Up9PN8gDvT+vTYPvhSrDk0SAY78wgAav8tGUTHqsrZitX+Lov
         EyqIN7oSie/ad+IOVjUfGs0cVU7mXtl7VIjB74LjIHNxL0iPS+Bsl4w37rKmDgcBgse0
         dt/g==
X-Gm-Message-State: AFuF++mACLx4ZM8yzzD9lEOpzOt1CE8PpeYUPePO7bP8BCOqFW8lOz6W
	IXNXf4019jkrIqW8o1NrqzXluN2VLEjBRNAXbgQQNJG5bvyady/oSftY
X-Gm-Gg: AYBFou3VlR1M4DR5c9Fcw9Kk16BaJ/prugSlFCc/ba8g9c2irBbqkMTK0tsnNquX/Xh
	LKRXvF85Ee+eKn/MYASiRs9EyiuaM6gw8pRMBMhY3F/0WpmTxvJYIypM3N8uXBnaZHHIZrryJ+Z
	LD96zuYosPS5mSe9Q+oYboGEE5wp6L8wQa0LT2M65eAUruz2XhLWzE543WKK2UyMtJAQx0ahJDt
	U3mugEaKWpG/Swj9Hs75piW/W41ecg0GC94LZAHRMhYst+6rt1fnBYwJs6U+aNzxzvFxR2HAGvz
	TFgf2otE/j2RzB++hiaLi5kP5HlimRiivVawtEZ1nCMV116Hxu/kPEDN0WRsdHQy7Ou56QcwDzT
	zCkhTxLjeKSTCkNGLd7fzH9Zu0TDdYXlvP+HCzmBS05oQuJJ8qOgQigc3E3xVpvxI1ZLAV5LNQb
	2EUnIRc1hEusJu70BOAIcGqkCbjcGVRTsz6HKzpeUoaQngI3o9bGNUiNhMWqOwHJ6oCKcDfq/q5
	h4rM/rKyk+QYHG1GL0KPdKf6oISJAOt4lFcdYWaMK+EOIrG4erb/hhvgbat/hhmTW802UKZaN2V
	w1qkzQvP7RJVYla1fg==
X-Received: by 2002:a05:600c:8486:b0:49e:745d:c317 with SMTP id 5b1f17b1804b1-49fe66b426bmr271918275e9.12.1790684664219;
        Tue, 29 Sep 2026 05:24:24 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:be4b:8730:c872:1736])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfafa23sm70994965e9.14.2026.09.29.05.24.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:24:23 -0700 (PDT)
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
Subject: [PATCH 5/5] soc: renesas: Kconfig: Select POWER_SEQUENCING_RENESAS_PWRRDY for RZ/V2H and RZ/V2N
Date: Tue, 29 Sep 2026 13:24:07 +0100
Message-ID: <20260929122407.219448-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260929122407.219448-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260929122407.219448-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
 drivers/soc/renesas/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/soc/renesas/Kconfig b/drivers/soc/renesas/Kconfig
index a63df28df3b5..5e0389e677a8 100644
--- a/drivers/soc/renesas/Kconfig
+++ b/drivers/soc/renesas/Kconfig
@@ -516,9 +516,13 @@ config SYS_R9A09G047
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

