Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A306E4052C7
	for <linux-pm@vger.kernel.org>; Mon,  7 Sep 2026 06:39:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763196; cv=none; b=qB32xdSbN1GJPiB2rYaVxZstV0curOzCKERQo+GzeJJGnrvwl8N8I4sNPE99/UDndoShI0G6E5eoHqOowlywlb+IEhTyGwS1h0Hv8ir4CSmBLsXltN/vli0ey6YENusm6QSdw/2/JeMOqSuiCxwolB9ZPaj8gkfe0I6+xfkhEmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763196; c=relaxed/simple;
	bh=h0l9ezlVSUx1zYmyUm7DkOpsZUTjhGUTeJv6Fx9ui5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=f7+NtqSvZxbyf6v6iI3uf70F7ziiBsaUJjudl5MHgbjw00LLxNEF2YD5Qr3q/7WRG/3bIrLLcr7tGNGtGMvIbQpoMeWVsJ9YPlsNN20RC470QfSzMiTvu9bWFWcqsXw/O9FZYtmCfi0rZ1BvIWZMp+8VDCg3XBYPs7NXO3WtMqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ivmf8i7D; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ivmf8i7D"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-c96c92c0980so1703921a12.3
        for <linux-pm@vger.kernel.org>; Sun, 06 Sep 2026 23:39:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788763194; x=1789367994; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MVnSpK+EJV7kCmLFCff/HQwLZOhkKnWjgpUC9mIQ2vA=;
        b=Ivmf8i7DPqME4D1LCP1koq1s3aP9IdPIXSozINpnSKbtCRxM+URIdkj51D97PXCVav
         vAMd/nIGWgBiWvNzEPrfaRUY9IwFZboBTZmPDYc90akJL8adB0VTFawI3IKJK1ldX9ZR
         uBw04O1OaGkZ4j8eWqnJDKMAYsVsqD/zboTDj49QRC9Fr0mxOC+UDt6yKjP3+NDBAayq
         U3Wx1qq5RSRq6egaQJ4yCI0I9QQULY9kDwCYE/UVOJ45X3jMEHGXkMUBSgZg6UbGoGeX
         GxMals/Oalys8hzUNrzgrJFaHAALBVei+iFhR4cSfd+gL7ljsZi11KdAdi9eqnah8Ahq
         QRwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788763194; x=1789367994;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MVnSpK+EJV7kCmLFCff/HQwLZOhkKnWjgpUC9mIQ2vA=;
        b=UzG2ok0Gc4PnMOAcuII6V4l0mtUeHZonCaRNgntKaMY/pRiHEVsUAUJVfmbIe44eeV
         +RBmg42bl4s048stpIevBdM157BBLeS4djCq5luMZ24VtBHo0X62rENbYLlFfyjC392j
         VCkPMVmH7ucO9dxbT03y9bp0VH9oNfGqWSZd25afgvb080dOIw2S9GG6UHBrFhzaYZLB
         4JaaEhJaCcWM3NoRG8A2XOhyxctFLSfhd/7TiQRt9wPjFvP4ycUe35CJdvy0t/nOTUOQ
         SJdq4T2I8guB+/J7hLTyikdfDzJbsbE2cD5bF70qi8DibKLYTlWktk2moI9QSLNo+5GG
         0BhA==
X-Gm-Message-State: AFuF++lr76bftula6fQ+cCT7OWdgX3GPqWUrwX8zqKQAcTyRnC9bM0h1
	Dfy5YZMR83iH0tDGSoRhgrF14i8KakVyDWSZpY71ivwf6L22/KLzgJWR
X-Gm-Gg: AYBFou3QB3cmgVmnnRAMpzh3zBVHgenwmTD1ZB/nwXIXx530cTJ2hQNxsOLJfRHKYlV
	6CbyiOORh8QelqZYETK80mhL/Vq6daZkT8dpnOV6q+2F/7IZefKWczKdqAaQfTwdDfAyTE8K5B+
	o8T/qfXoXaYurgBCPTD30fWDgT73GD2Vy3hxy/pFnu6Jr207iCEEn4AE7QIVFCqM6tNk5MedyMx
	DbooQCAHXV4mv00REx9tTGNSPi9S4TxDw9DQr4LKMcBdkFgBcovpl0PWFpmOhIT4akF5+EgDpBc
	VtNpqg0E7Ge8FN8bt3+2UPook5CMRP8DLP6/CQjHfTy+lw/hqKleM7AN3VOKOZT3nIb2SgiJruS
	iLS6qdE/TyMVwO3uoyGgyhXlHyH8jyv0k7V2pbpLd6J3LjgpDRWO63a0URJmeApZG2/SQk0dYXh
	CYQavUuXpdTDXoNJJDHI8BImhqx+Frm0gqxKuiUxGTNpDMUzcmiuj+OnTfCiNOajdij3dU50Rrp
	uAJZ5HVSybJog==
X-Received: by 2002:a05:6a21:6442:b0:3da:5b4d:a89f with SMTP id adf61e73a8af0-3da5b4dab37mr16506868637.27.1788763193833;
        Sun, 06 Sep 2026 23:39:53 -0700 (PDT)
Received: from volcano9f6e-hostos.amd.com ([165.204.217.251])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3339b314cfcsm25345322eec.19.2026.09.06.23.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Sep 2026 23:39:53 -0700 (PDT)
From: Hemanth Selam <hemanth.selam@gmail.com>
To: Sebastian Reichel <sre@kernel.org>,
	Hans de Goede <hansg@kernel.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Sebastian Krzyszkowiak <sebastian.krzyszkowiak@puri.sm>,
	Purism Kernel Team <kernel@puri.sm>,
	Santosh Shilimkar <ssantosh@kernel.org>
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/2] power: fix typos in comments
Date: Mon,  7 Sep 2026 12:09:45 +0530
Message-ID: <20260907063947.34852-1-hemanth.selam@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This corrects 2 misspellings in comments.  Each is a separate patch so
that any one of them can be dropped without touching the rest.

Nothing outside comments changes.  Every touched C file was checked by
dropping its comments, replacing each string literal with a placeholder
and collapsing whitespace; what remained was identical before and after,
so the compiled code cannot differ.

The mistakes were found with scripts/checkpatch.pl against the list in
scripts/spelling.txt.  The scanning, the edits and the changelogs were
produced with Cursor running the claude-opus-5 model, from a request to
find and fix spelling mistakes across the tree, and every correction was
then re-checked by the comparison described above.  Words that name an
identifier were left alone deliberately, even when they read as typos,
because correcting the prose would make the comment disagree with the
code it describes.

Tested by building x86_64 defconfig at v7.3-rc1-269-gbc35965f6940, which
is clean.  Nothing else was built, so any patch touching code that
x86_64 defconfig does not compile has been read but not compiled.

Hemanth Selam (2):
  power: supply: fix typos in comments
  power: reset: add missing space in error message

 drivers/power/reset/keystone-reset.c    | 2 +-
 drivers/power/supply/bq25890_charger.c  | 2 +-
 drivers/power/supply/charger-manager.c  | 2 +-
 drivers/power/supply/da9030_battery.c   | 2 +-
 drivers/power/supply/max17042_battery.c | 2 +-
 drivers/power/supply/sbs-charger.c      | 4 ++--
 drivers/power/supply/smb347-charger.c   | 4 ++--
 7 files changed, 9 insertions(+), 9 deletions(-)

-- 
2.48.1

