Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD8036B05E
	for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 12:35:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774787705; cv=none; b=hfGDvgpi0YyqWulrhAsopbqWLV6Y9uj0B5DXBts+sYLLFmKYZJTzHwPmCQYqvj8reV7X2f9a9ABxybZz7HSWhIODmXx8tQnxAImWDgWE1mDF880BMdaI8Ler6q9RzGWAUZPXMsMZ4C83aT7yDKCqMfiY9vCXNHiThS48g5/SfT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774787705; c=relaxed/simple;
	bh=oitH4XdOfl+jmDNpdoZa/ejnZrlCgKiTDVXgtFcA4oA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MCLn7QTOjCqAQloKCyrPOqlsKmPKUzH+Nok+BM+RYRp0JzVHB6JA95r7dYuqea5QLTzSTdvYanz5L/N4o3qWdXGFY7iZZ5rXKMhy1GwRhKHaTrvnijlmO4PoGCEqqYTI9NSW7ZhuQCcgkCKvuX3MEcX7GjCQhyzaZMlvubfUL/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nKK0nmdm; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nKK0nmdm"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-354bc7c2c46so2130411a91.0
        for <linux-pm@vger.kernel.org>; Sun, 29 Mar 2026 05:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774787703; x=1775392503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=09DmEJZvX6q03iOvlAg7HJKVIb4nx37LesonFOCNgHw=;
        b=nKK0nmdmWDNc72bm+hEEBZMsmJfOi5D2/PqXphxWRLUTromYCXM0pXzsrocrVjS0Yo
         ujsBVpSTS0LcRsNcAfxOEfKkXnmlRnlSiNkOxWMPJ+gv2xUQBcBbybhEfySvPHNnwulE
         o3PpfTTvlDG0hWiOppIs5e8OdAOhj3hvRYIPGs9oNy3EwJSSvza6lT4p3a2rPch/zgRp
         3yta/IH2K0hM3nO6OutEkzepWBK0EkYga+azTmepNuefNjPiXSorsTsxrWOUXwVv8oFp
         VJi9Tn2sStjSmHXaG4WvZlN3ZnQiV9PfDbobV+I/XXNNmkoM2vTB4gZ9ish311YRR6D9
         AiiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774787703; x=1775392503;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=09DmEJZvX6q03iOvlAg7HJKVIb4nx37LesonFOCNgHw=;
        b=GHB24zwAPtnlkVWnzgl7E/Syr8z4RaOpbAF0HWsdY85OWk0/gJ9AqE+9nNQnxzJXAp
         oRB7PWUQTUr+tSd70hjdSNLLpzhLj2fhIcCrdgkY3vhIcHp/+8lOiFTaUpFHMJdl1piw
         00lt2ppE9putFLPPlA0l8JjOEd82kaqJUBkdsqbstOxYucW0Z3xepFom/kmx5byK09+n
         M/TH+jl6PPolUl6y2WPGJ3NK44Ghr4IJcxnMV7yf1uayVdi6Nwe70sE0WKQU6N9TzizW
         rL4RKoz8hXdDFNjoRfHdGCf1ziStSZdB8T27wo1d402DJhDeSPp6UQ9TFOqmmZP5P2Uw
         7wvA==
X-Forwarded-Encrypted: i=1; AJvYcCW4zPL8Tl61HNXO402KiWIttpD0otU1FrUv0QT4DPeLP3g57+wZgRzxy3JlOqLCiu1tUQFfiIftlw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxQ29Zquvh+e0QLYjjBNfoOau0eT4La/LGmihW5XA7pK6bIYOlt
	W/8teYEPZs2Hev26+Y7hPRiCEVnuUA2o1ASEEir8GTf7LOMCEsgQptWV
X-Gm-Gg: ATEYQzw9J7A6b6iK7dSEjNOYTEzkO1+2FgFITQWfrBkn2V+IBYa9d+lhWk6UtYjeUZ4
	aunK/4Hsakkx54ivnEv/xgoUv6ZqFf17+KX/9ca7m4cTe/W9jEfRjm5sN9SpIfFPtAte0uPB/4H
	XtAvRNn5IUJvuMFpQ0vxHQxV3UT2XShfbYU8UaCw6SJj72k7fH0qxUlESMfkHzgGSSLdoZ7i6ML
	5yq87S+jFQWF+5rooTzldYofa1rwzVxUabrCO/6nGYp16+kF/PLdCj0e+wfPFiONQ7ob6QSInzX
	7s/d3MKtdSoCkRBTlESZbaeNoEISlr2HK7bhX5fScBbReAwWjnrZbit8nE78oweG1CHJPvo6LZK
	Sp7nLVnC+0tvXQIftwPbSCIOe6RM5ctnhr1e2acj6whwGBUsIS5xhyg/9rR3MypFLHDU+6Z2Lco
	2BFaUO64PXpUCtStkeg70gnNzFWmZr5rFVCY9HB2cJMJrxvNX9doYlZqaZSBiFxMT+hhbG9LmE1
	WI=
X-Received: by 2002:a17:902:e54f:b0:2b0:6df2:8cd2 with SMTP id d9443c01a7336-2b0cdc239a3mr94457085ad.19.1774787702960;
        Sun, 29 Mar 2026 05:35:02 -0700 (PDT)
Received: from toolbx.gk.pfsense.com ([103.70.166.143])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427afbe0sm58709665ad.72.2026.03.29.05.34.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 05:35:02 -0700 (PDT)
From: Gopi Krishna Menon <krishnagopi487@gmail.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com,
	robh@kernel.org,
	krzk+dt@kernel.org,
	vireshk@kernel.org,
	conor+dt@kernel.org
Cc: Gopi Krishna Menon <krishnagopi487@gmail.com>,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	soc@lists.linux.dev,
	daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com,
	m-chawdhry@ti.com
Subject: [PATCH v3 0/2] dt-bindings: thermal: st,thermal-spear1340: convert to dtschema
Date: Sun, 29 Mar 2026 18:04:42 +0530
Message-ID: <20260329123449.309814-1-krishnagopi487@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This patch series converts SPEAr Thermal Sensor bindings to DT schema
and removes the thermal_flags property from spear13xx.dtsi.

Changes since v2:
- Reword the commit message and subject to correct explanation in patch 2
- No changes in patch 1
Changes since v1:
- Changed unevaluatedProperties to additionalProperties in the binding
- Reword the commit message and subject in the second patch

Note:
* This patch is part of the GSoC2026 application process for device tree bindings conversions
* https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings

Gopi Krishna Menon (2):
  dt-bindings: thermal: st,thermal-spear1340: convert to dtschema
  ARM: dts: st: spear: remove undocumented thermal_flags property

 .../bindings/thermal/spear-thermal.txt        | 14 --------
 .../thermal/st,thermal-spear1340.yaml         | 36 +++++++++++++++++++
 arch/arm/boot/dts/st/spear13xx.dtsi           |  1 -
 3 files changed, 36 insertions(+), 15 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/thermal/spear-thermal.txt
 create mode 100644 Documentation/devicetree/bindings/thermal/st,thermal-spear1340.yaml

-- 
2.52.0

