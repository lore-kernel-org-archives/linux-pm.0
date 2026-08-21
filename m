Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD703C3F60
	for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 08:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302353; cv=none; b=LkcDb27eJHwLma/6+EPO6rqGoeTFTTV28jYR1FFMk42Abkqln9HnwNl5RcLuei79aa/hJh+V/G4ZWMDtw9V3opnU9b+C2WZMdcpwXOx9DfGCg9KEIf8w4S09K3H24ZVhmpxWWpOHugKdM7qIk+zJKyHUgS1urpfyNhvZ3dSUrso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302353; c=relaxed/simple;
	bh=suf3ilXnFVcB0B7dyiKD6iVLmpNkm+fyipEddhfzl1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q2Ag65E1Zv250Lc1I1u80CeMokI7EYXUPQu2IwzhfTVuIu3+lMeJNVEuBkSvkh/X6nFaK2FmbW3NgH9ZcgBwa+HHZylUkgwak+EDFeOKU2ixNPHDVgvlnW4reqog6GO46LXFbbpqq5HrT363UPMdb2LFVGyEWWlVP57dQwZc2so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=br24S1WN; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="br24S1WN"
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-6a1a546a6bbso1537890a12.1
        for <linux-pm@vger.kernel.org>; Fri, 21 Aug 2026 01:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787302350; x=1787907150; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=wxIJbdtHu5EFzZttDmDXTiKHDXuSlZ7X22WCTLQoMi0=;
        b=br24S1WN3Al6RADHPDZ9qKgFjrI6scZvQHGkM6aimyKLfRklW8MU/zr5bcEYumTv+M
         4n9JktfnnVTEVe/TQ41w0opYMgNsE7B+LUJwlIH64cN53tLDlVL+KMe9Zqpbci+3zKyV
         HvJHH/CK/fkB/Pzazwhp4pLK/Si2LJztAmyi8ZNVVyRL7qfn+wMiVeBZLnMFO0mZu7wm
         x5sTUviFX1bVX26egd0iKEyXZFDEnw6MGdkxfXoFxBSZSYgSoQoHNj6GwBhUFWNhKJ8X
         WtlxmP7CMo1Ui8K+PUiHQUjOrHYi5acLzT3OA8TY+d8YJJ1Hf8BethzVJZ/BZ/82YkWq
         EK3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787302350; x=1787907150;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=wxIJbdtHu5EFzZttDmDXTiKHDXuSlZ7X22WCTLQoMi0=;
        b=CNSped7esJwwXn1vzA3VMNcK5CllYIB6RurY32LEGTx39ukrboClM7Pn5wIxWDdgOb
         LfLQjh5bshqQNhhxedRw8kCVoCa3lBBK2K3gpF7FTZCpFgdt7w/H5V0AbLxQcAeDNndZ
         7LWwefXBYTCoqARGFXG69LWcQOlisTfqV+yA/o2rJir9woP8/9K93uEJBrZi21c7kGZo
         TNTNoDpx/BbecaQnBn9AFsM5WtaWUgjnX6ZQ0uVDIaZ0jmk5lnEe32rXywCiVRFe+Y2W
         JmW7Y1bBl/3wRMMtYzA+w38rGNsFFpuqkoBa25YnZId5rlH0XhCaWIUZ3Go/ywXOBkhQ
         /jJA==
X-Forwarded-Encrypted: i=1; AHgh+Rq90WzD3FPvhgBRnd0kNRfkdWg1rTOQe7iC02nOtyihVFw/3cmwTxBwjHHPxZnfJDKax/Bgrpef7w==@vger.kernel.org
X-Gm-Message-State: AFuF++nOR2hN+tzkYmVN7Hq3aYtSgPRKoy7fdKjYd+sUHMe2ZN5tzyng
	FBO2REJfLCAtWYV1U4XRyZD8cDwaVwB8EOh92KlM3KZkIl7AldyU5J5a
X-Gm-Gg: AR+sD110hqYB5UFfeNVj3FM4L4TnnD647hJijHzhLgia/ffaw94zBY0ofgT4R0DaUPT
	mOLbEBs/dVd/9TuN/PQGMlKNk+yv50xCKnS/kucIklGnoyGCHg8kcC3j6qM+jSTvdAIw+fWtDhe
	lQEzmFIiQxFeUfF9yc8SneGJHOuwoI6oeBW5gVvv0w8K9IlaFMmBX0jkHfs1k4KPXpt5pXuK9xc
	bSDrRpTvi0OIyJ1dzEpPy37p9vUIO5GhXx0Drk3Eh95wxWNLkCg6Dk5omYam/lOY4v9leXWy3st
	SuzOVQ0vRYJnD1MkN+OJ9rvuISMjQIOx5TM3R+VHipsbr57IgCpplrc/hPZlXnZ1h3+Dt/e9DOp
	z+79mFWX2GAw8iZpuCEpdkFnByOtPEKFPR27bg7a7P9VGZTANCA5z0Ibh8RFM+J5ex5KtC9I4A0
	btvXjr0sBiZVB9g215ppa0cizsc60Bmp30f9pcMe5DkkhjPYHgsJwoHQXzhbE6akZilaaPLOveT
	NbOlg==
X-Received: by 2002:a17:907:94d2:b0:c19:473b:dc8f with SMTP id a640c23a62f3a-c246a2eb99amr471049166b.3.1787302349629;
        Fri, 21 Aug 2026 01:52:29 -0700 (PDT)
Received: from Ansuel-XPS24.localdomain ([95.236.20.157])
        by smtp.googlemail.com with ESMTPSA id a640c23a62f3a-c2458b096d9sm422551466b.20.2026.08.21.01.52.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 01:52:28 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Ulf Hansson <ulfh@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: stable@vger.kernel.org
Subject: [PATCH] pmdomain: airoha: fix unselectable AIROHA_CPU_PM_DOMAIN kconfig
Date: Fri, 21 Aug 2026 10:52:15 +0200
Message-ID: <20260821085222.140633-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The AIROHA_CPU_PM_DOMAIN config was wrongly guarded under the Mediatek PM
Domains menu and was unselectable.

Move it outside the menu so it's now visible and correctly selectable by
default on Airoha SoC.

Cc: stable@vger.kernel.org
Fixes: 82e703dd438b ("pmdomain: airoha: Add Airoha CPU PM Domain support")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/pmdomain/mediatek/Kconfig | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/pmdomain/mediatek/Kconfig b/drivers/pmdomain/mediatek/Kconfig
index 8923e6516441..a2eb704a773c 100644
--- a/drivers/pmdomain/mediatek/Kconfig
+++ b/drivers/pmdomain/mediatek/Kconfig
@@ -43,9 +43,12 @@ config MTK_MFG_PM_DOMAIN
 	  This driver is required for the Mali GPU to work at all on MT8196 and
 	  MT6991.
 
+endmenu
+
 config AIROHA_CPU_PM_DOMAIN
 	tristate "Airoha CPU power domain"
 	default ARCH_AIROHA
+	depends on ARCH_AIROHA || COMPILE_TEST
 	depends on HAVE_ARM_SMCCC
 	depends on PM
 	select PM_GENERIC_DOMAINS
@@ -54,5 +57,3 @@ config AIROHA_CPU_PM_DOMAIN
 
 	  CPU frequency and power is controlled by ATF with SMC command to
 	  set performance states.
-
-endmenu
-- 
2.53.0

