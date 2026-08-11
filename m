Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE13930FF31;
	Tue, 11 Aug 2026 20:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786480516; cv=none; b=LZHGVViXeB4xf6akpT4ejv9XQxu4HbSqmrFkvaOA7fFIUASoTuodiOiSmRbCv1NOy5FzxF43cY+RAqeM01gd8Jn3a1KlMydo+U8gSsCornhCLyqxb5WbNFvU0xzgOM5WzqscelnR44FaSeooX6LiHAt1cOhL1w+dXzWT3+AdCSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786480516; c=relaxed/simple;
	bh=+P82h6mp+hEn0vn1HuUzgSXQCVwUZSASzPwY53+NlTo=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=O6aI1fG+1GtUZqy6ucOFnxl5KOk5klbCn/V0fH87Fy1zmlzEoWBkYI3jup+GBSY+OZBheoMTQViIs5O/0lT42xbWdhyxzAQ8wdwNrtZCv8MdItpzDHS764Kwn85u/Qel1CbbWKcuQaTYHfjLXZlb1K/cedpJl7nfi1hBJY/7fBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YbRUwZxp; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YbRUwZxp"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 559CAC2BCC7;
	Tue, 11 Aug 2026 20:35:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786480516;
	bh=+P82h6mp+hEn0vn1HuUzgSXQCVwUZSASzPwY53+NlTo=;
	h=From:Subject:Date:To:Cc:Reply-To:From;
	b=YbRUwZxpOyr4yZKEOf8++hNPa9ob5CC+qIde2Yk6sZlqi4Xc7dD3FHQk219LE+wBV
	 mzqJRqPXFSK+7G2LGUDYxHI3FzIq+gt9cvcHsKxFTLpyah9lCoWRhrRJu+lq/Tku0K
	 F4Nz7rYXWuVSU8ea4RfME2FSaGyJoR8f8C0pJp6uNTKIr87MW4LNECQDdwvDu9FarF
	 Ywm9f7e+8zHgrJ6qeMEmhVuTMOagf+ZGLt1qZWIBY/X6esIB80TxGfPFeWq0Aq388h
	 HFdAzMjbedleEV5RaXk93OCzt/6tLF8UBXS5BzPoOhfLZbb0x2WYAWuk8PitHZs8Es
	 WKHzqSUioDNcw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31A5FC5CFC1;
	Tue, 11 Aug 2026 20:35:16 +0000 (UTC)
From: Robin Snyders via B4 Relay <devnull+robin.snyders.xyz@kernel.org>
Subject: [PATCH 0/3] power: supply: qcom_smbx: add SMB5 support
Date: Tue, 11 Aug 2026 22:35:03 +0200
Message-Id: <20260811-submit-qcom-smbx-send-v1-v1-0-feec6cfa123a@snyders.xyz>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x3MTQ5AMBBA4avIrE1iLOrnKmJRNZhFiw4iEXfXW
 H6L9x5QjsIKbfZA5EtU1pBAeQZusWFmlDEZyqI0RU2Eeg5eDtzd6lH9cKNyGPEiNI11PFlDTVV
 ByrfIk9z/uuvf9wPxX9CBagAAAA==
X-Change-ID: 20260811-submit-qcom-smbx-send-v1-69acefa61977
To: Casey Connolly <casey.connolly@linaro.org>, 
 Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Robin Snyders <robin@snyders.xyz>, Joel Selvaraj <foss@joelselvaraj.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786480511; l=1365;
 i=robin@snyders.xyz; s=default; h=from:subject:message-id;
 bh=+P82h6mp+hEn0vn1HuUzgSXQCVwUZSASzPwY53+NlTo=;
 b=aIO8pm3D+uXsVtToEKvt+5xvyG+S4IRDgKKHi3c5cHvJ7yGWiCCJBwqoH+t1jaXy7iUiRsVQM
 /oYYMCuqvE0DavUIhYTL7LnjH5vLHIvUKdyxssVTDtlWcpMK8vFwrB4
X-Developer-Key: i=robin@snyders.xyz; a=ed25519;
 pk=Mdk5dNn+Tkcy7BWexDxBLR/s1BNz8WdqDPnr3qtYBIU=
X-Endpoint-Received: by B4 Relay for robin@snyders.xyz/default with
 auth_id=938
X-Original-From: Robin Snyders <robin@snyders.xyz>
Reply-To: robin@snyders.xyz

Add support for the SMB5 charger generation found in PM7250B and
PM8150B to the existing qcom_smbx driver.

The series extends the binding, selects register layouts and electrical
limits from per-PMIC match data, initializes SMB5 with charging and USB
input suspended, and programs a stable AICL rerun interval.

This was tested on a OnePlus 7T Pro (HD1913) with PM8150B. Register
reads confirmed 4.40 V, 1.50 A and 500 mA limits. A 180-second guarded
charging trace and a subsequent 600-second runtime trace completed
without crossing the voltage guard.

The driver was built with LLVM and the binding passed dt_binding_check.
All three patches pass checkpatch --strict.

Based on linux-next 20260810 (3d08ff75a47a).

Signed-off-by: Robin Snyders <robin@snyders.xyz>
---
Casey Connolly (3):
      dt-bindings: power: supply: qcom,pmi8998-charger: add SMB5 PMICs
      power: supply: qcom_smbx: add SMB5 support
      power: supply: qcom_smbx: program AICL rerun time

 .../power/supply/qcom,pmi8998-charger.yaml         |   2 +
 drivers/power/supply/qcom_smbx.c                   | 521 ++++++++++++++++++---
 2 files changed, 457 insertions(+), 66 deletions(-)
---
base-commit: 3d08ff75a47a3e7e2ab45a3bcab6723b4d906422
change-id: 20260811-submit-qcom-smbx-send-v1-69acefa61977

Best regards,
-- 
Robin Snyders <robin@snyders.xyz>


