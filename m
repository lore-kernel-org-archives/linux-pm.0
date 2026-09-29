Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E83B35218B9
	for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 12:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790684672; cv=none; b=cKaWqGeU3FdplDBu5emkh+S+6FGuGclRbPpUZHBuE0xto6O8AGaeh3ZJEcixTRWI5HtDPkA17UoOSo/gMerePLnN1FqkczBVd7WUTV4M6EqXN7NwfjUwo1tdWeOwbCHkuQos2bD8IgMxMLMm9dWCyc3/jKD2Nkxgfe4ViQY5nuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790684672; c=relaxed/simple;
	bh=l7JUlcdxUdbVr9PpUiwfgJ8/noDknqrKGPkiFy6dD5Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WkiIw//nWJSZTGDYEYJLd/f0f5dMnJT8GIoIcoBt6cysi/DPUU/VAyKCTfEh7cgOEMPrrk7kMwL4Rwgf7ft6MH2pCZW184yzxYl28JcJ0O/siEXOFl6m6Wx8nY9nNGbtlWzWV7Tqc+2uiL3/b+GSNM+tKKuGNVc9wIdP2drcSPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QEmrF/9d; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QEmrF/9d"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49ff9621c5dso21736005e9.0
        for <linux-pm@vger.kernel.org>; Tue, 29 Sep 2026 05:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790684660; x=1791289460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rBOXZc0qdz6ZNCoiP6xwhuNMyL4baEtGYSge9bdsO9g=;
        b=QEmrF/9dVOoFsyXBDu2uyiOLiaWksetKYlv1j/Z/BVJJLxgEVauCicNklLANwNe3cO
         E8Gq7OBfrLd1zirMMDQ9W5SmwgFrCWowho9c4N+Gdsa+/LNkTwhS9yb8VLTTuqOAwXst
         GleYe0PktyGgSjL6RArMx2YqR9ZXF9x6giu+m2dDa7e1nRdkMYY1BC13xHURF9ND7T5m
         mktuCImlwZJ8KHI5DpAHnl11qg9n8qO+kC74yAglR4fgvjHeU7MziOyc6typ8tElizb+
         5uIuMAex1Z0C4t2rC6LSTiKlfYs/eXpktXfSx+ViJj/oVNuRskY/zMktJ5Pd1zPNNPTf
         TDaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790684660; x=1791289460;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rBOXZc0qdz6ZNCoiP6xwhuNMyL4baEtGYSge9bdsO9g=;
        b=kILXcw5qei/CaHXouyNAcpUltK/9C6+qxxaz+Nat/2enDcdkkyNm3r0m0zRb/2wM+Q
         ZesdBJ5R7XrD80xBBmrH1m/77FYAdK2+AIcVdLz3KhWHnn2hB9KQQ3ZcYHkQKY20YDCY
         cC6pnljp3JuC7L6UbR0m9y8cZ1OMcVlq3Y0993DD9nPDyeXxrO2khqARj+Zfk78OnJmI
         Whf+c+E114SKGHPJnQrOnlHIDYsMVXIEM0DxOYrLbV7o48OnQ9Hn2oUOJgf2DebGdQ1q
         DXrL7CfdhV4dYPnuXrVrctj8mf9/craP1oebwD5mhJ5YuNBw10YMxjpGtr7EpGSDomHG
         2wDw==
X-Gm-Message-State: AFuF++l/ScPWt/scWPQA/of7oSojy2/kuY0GA9Clio9iwk7RvBf1kJas
	EdotJqaeGBggQcbrRmxx2C+7dwN4bqkRUbK75CJ3b7R5naDq0BuECkAn
X-Gm-Gg: AYBFou34HjzVseFFOMKyCsgyQN6v5qy7pLPdkWy2+neLFD230pUt62LsXBney5Lro8E
	q0Wnau9lAF0XKoKaZtDDJy4Im51XmNQOZeTgltvkyfbb8W3VhReVYdz8JuowQHj/7kcLtUaamdH
	yjNuLU98qC6X5iu5zj9cEnxnIM2Y2lR7Ez4wwczsayrI3Q61iN3zy9VBn+YP8xcuphv1BrnP26G
	yWS31FwS9PBODIOzEUzUWzXd7EtN8+sUc1x8JwNrUyQpYAdIP+dW3NMYiNF/IBOsGlMs4y2811b
	pIFZuiBDgtlugKIe+k8/+SQNA3ogSRthLsTyju5An+Jz7Sbkq0VhDvR5m8nrzj7z00tOZzU9MPA
	1bLdAAfjg8yep4LA2YLnFOwOwjUbBBjTbVEJH0wr7AxwvslnX1q0y8b5kGGrknmjSPoTdC6rWTY
	wi4QoTPax6IEH8NVwo7+Zmkj+nTXqNofuvEJEnKf7MJ0Brr1m6b8Tp670hLvoNGWVz2oaSeddAs
	GnQW6V1CQ4vzXX/opIA7f1dZpHObaAXbyyZqBGJNkezlzdHgAzfPRoNeO6DMpKn2VGGpbA7SRJp
	wJ13FHpA4GyHulHl+Q==
X-Received: by 2002:a05:600c:3514:b0:49f:ce72:e931 with SMTP id 5b1f17b1804b1-49fe6701e7emr276449655e9.35.1790684660244;
        Tue, 29 Sep 2026 05:24:20 -0700 (PDT)
Received: from iku.example.org ([2a06:5906:61b:2d00:be4b:8730:c872:1736])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a00cfafa23sm70994965e9.14.2026.09.29.05.24.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 05:24:19 -0700 (PDT)
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
Subject: [PATCH 0/5] Add ADC power sequencing support for RZ/V2H(P) and RZ/V2N SoCs
Date: Tue, 29 Sep 2026 13:24:02 +0100
Message-ID: <20260929122407.219448-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

Hi all,

This patch series adds support for ADC power sequencing on the RZ/V2H(P)
and RZ/V2N SoCs. It introduces per-SoC probe functions for the
renesas-pwrrdy power sequencer driver and ensures that the necessary
Kconfig options are selected for these SoCs.

Note, the ADC driver and binding patches have been posted separately.

Merge strategy:
option #1:
 - Once the pwrseq-renesas-pwrrdy driver is merged in only then
   the sysc driver can be merged via renesas tree.
option #2:
 - Merge all the patches via renesas tree.

Cheers,
Prabhakar

Lad Prabhakar (5):
  soc: renesas: rz-sysc: Make power sequencer auxiliary device name SoC
    specific
  soc: renesas: r9a09g05[67]-sys: Instantiate power sequencer auxiliary
    device
  power: sequencing: renesas-pwrrdy: Add per-SoC probe via driver data
  power: sequencing: renesas-pwrrdy: Add RZ/V2H(P) and RZ/V2N A/D
    converter support
  soc: renesas: Kconfig: Select POWER_SEQUENCING_RENESAS_PWRRDY for
    RZ/V2H and RZ/V2N

 .../power/sequencing/pwrseq-renesas-pwrrdy.c  | 109 +++++++++++++++++-
 drivers/soc/renesas/Kconfig                   |   4 +
 drivers/soc/renesas/r9a08g046-sysc.c          |   1 +
 drivers/soc/renesas/r9a09g056-sys.c           |   2 +
 drivers/soc/renesas/r9a09g057-sys.c           |   2 +
 drivers/soc/renesas/rz-sysc.c                 |   6 +-
 drivers/soc/renesas/rz-sysc.h                 |   2 +
 7 files changed, 122 insertions(+), 4 deletions(-)

-- 
2.55.0

