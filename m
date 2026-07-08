Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96044CA279;
	Wed,  8 Jul 2026 18:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535752; cv=none; b=hh2NXXZ5NM1Ft1xcK4ywq6HjZHorCGqP3RL2womw3A3kJorJ9u7fE9TP2MwTeBNdxMcMh+lKYIVv8SmRLkXOp+4YiDP1npvn/re1T29YvFy6tJ5mgA0CC0e3MOz1HD1qnZ3ouItbqCgXjkjH5axYxodquLiyY2wucQnW+ivjxWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535752; c=relaxed/simple;
	bh=V8h8fOy96kMGTzSYO/it/sabGhxCdOFuqn/LzOeuV1A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=n6zGXoVeVUU21d1jI+3KU4RqJ9y2SAhTE1olNkZVSjJyLKvpkVdYQcfhiwqESfbWJp2Cz1bxufPtIEzNPX/yJ6zGb1g/5C+X9Z1snW0bT+MxF2LCgXsuaRvbwzazizjsMxRq6FNCWY6g51TPBaMn8WVi2wWx37wESg0npg+iYdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AlyqkgsD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AlyqkgsD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 913AC1F000E9;
	Wed,  8 Jul 2026 18:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783535750;
	bh=sypjKMXLwT/17lGNDmA1RWP7DGdmuI/L1PHjYPDxb9I=;
	h=From:To:Cc:Subject:Date;
	b=AlyqkgsDqMsFAWorEiFbplXwUUj2HEwtw4q/pX/qIC7QN5SqeV0QcNECLpvMZe931
	 N+hBPOMKAbI3Q41QEfh6r0roWqhvNjn5IS7V0TWthpAuxuYwKRyfIHmPegZ9qpzSny
	 rmeAzebIeiwto5T14VzR3R2lsiDdK4RTBwC65RNYGEhCF9Fe6lDgZHuBDSnTa8LvXU
	 Yz3W2cRFnWXWTHayov12q0rdOiyFrrzNgVAse2EP4xyL3q03RhyQhmAE3d5NLORTkm
	 j+U7gXGA78Z5pYZmFBwAnkRisIPFcpVHG6ROvOPmjJ0xSkbUP71PXXWjB2oNsaCz+B
	 rltouzpNO50kw==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>,
 Armin Wolf <w_armin@gmx.de>
Subject: [PATCH v1] ACPI: fan: Use devm_acpi_install_notify_handler()
Date: Wed, 08 Jul 2026 20:35:47 +0200
Message-ID: <2866967.mvXUDI8C0e@rafael.j.wysocki>
Organization: Linux Kernel Development - Intel
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>

Replace the custom open-coded devres-based management of an ACPI notify
handler with devm_acpi_install_notify_handler().

No intentional functional impact.

Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---
 drivers/acpi/fan_core.c |   25 ++++---------------------
 1 file changed, 4 insertions(+), 21 deletions(-)

--- a/drivers/acpi/fan_core.c
+++ b/drivers/acpi/fan_core.c
@@ -489,26 +489,6 @@ static void acpi_fan_notify_handler(acpi
 	}
 }
 
-static void acpi_fan_notify_remove(void *data)
-{
-	struct acpi_fan *fan = data;
-
-	acpi_remove_notify_handler(fan->handle, ACPI_DEVICE_NOTIFY, acpi_fan_notify_handler);
-}
-
-static int devm_acpi_fan_notify_init(struct device *dev)
-{
-	struct acpi_fan *fan = dev_get_drvdata(dev);
-	acpi_status status;
-
-	status = acpi_install_notify_handler(fan->handle, ACPI_DEVICE_NOTIFY,
-					     acpi_fan_notify_handler, dev);
-	if (ACPI_FAILURE(status))
-		return -EIO;
-
-	return devm_add_action_or_reset(dev, acpi_fan_notify_remove, fan);
-}
-
 static int acpi_fan_probe(struct platform_device *pdev)
 {
 	int result = 0;
@@ -556,7 +536,10 @@ static int acpi_fan_probe(struct platfor
 		if (result)
 			return result;
 
-		result = devm_acpi_fan_notify_init(&pdev->dev);
+		result = devm_acpi_install_notify_handler(&pdev->dev,
+							  ACPI_DEVICE_NOTIFY,
+							  acpi_fan_notify_handler,
+							  &pdev->dev);
 		if (result)
 			return result;
 



