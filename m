Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90EAC1F5842;
	Fri,  6 Feb 2026 21:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770413466; cv=none; b=Itx7lesyMupofPgTPYAdtAlZ8PtVcgu0BuU8qMmNASMK+DamN98+AScS4v7r/qbrwBo3dDgXSiOGfKN0EFBUL2O1OT2J2rpmU9uVaRJDJheSs9b+F5BM9MVaI+TRiIdFazbgX+YTHZQiYZ5sRQqIz8FQ3mpefA+rsoxecYch5S0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770413466; c=relaxed/simple;
	bh=x22LYQA7RQI0V4YCFqJQoDe+djnYJsrO0SZcJJ6lbgY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HsrMjp5/x4kjswgU9g7paOQMDkikJGei040yU6sa7A1F4xZARLA2sB5UmgovGAK13gLtQ7kODxSgvb13YtxE8O8Xn1jYWa3nQmoNAgxUVTX+X7/ML/q+anbVrUJbJLqul/xYC8txW71qXK0n7PG8cGznedjHK8U0z1V0HrA4NWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0/dapIf; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0/dapIf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69F4BC116C6;
	Fri,  6 Feb 2026 21:31:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770413466;
	bh=x22LYQA7RQI0V4YCFqJQoDe+djnYJsrO0SZcJJ6lbgY=;
	h=From:To:Cc:Subject:Date:From;
	b=C0/dapIfOwXdIgnVaVQ+vtGfFhgUFiAADruaXlX9AJ0hBhHiPiIGt+OAx4Fw8S9yf
	 KikQSTSOg4GfOEesEnlL1ETVk1RxFxppxVhs4CgJjBq7ih3kgOmVojVIyL/HDoYYRX
	 snIDXpNpHHX05bS7QM/RVt6NmULl/+A/1dpiQl3dEj6OqV1PIBCRlumifcpGP+UeTo
	 gE2Gy4Ggurxy7f/0SkNhIGmh2Qxviki1u7rrHS5//yzP5MGa3wK3NKO4Jb6FS4xgl7
	 VqBOII3ZeiPYg6/TVHdhgxnoZn19CuglkAzkRp1ETE0irsL+YqzZhJwpwbWU+SOYgp
	 zZPwjJYIMkcSQ==
From: "Rafael J. Wysocki" <rafael@kernel.org>
To: Linux ACPI <linux-acpi@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>
Subject:
 [PATCH v1] ACPI: button: Call device_init_wakeup() earlier during probe
Date: Fri, 06 Feb 2026 22:31:02 +0100
Message-ID: <4728880.LvFx2qVVIh@rafael.j.wysocki>
Organization: Linux Kernel Development
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="UTF-8"

From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>

Calling device_init_wakeup() after installing a notify handler in which
wakeup events are signaled may cause a wakeup event to be missed if the
device is probed right before the "prepare" phase of a system suspend.

To avoid this, move the device_init_wakeup() call in acpi_button_probe()
before the notify handler installation and add a corresponding cleanup
to the error path.

Fixes: 0d51157dfaac ("ACPI: button: Eliminate the driver notify callback")
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
---

Applies on top of linux-next.

---
 drivers/acpi/button.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/drivers/acpi/button.c
+++ b/drivers/acpi/button.c
@@ -625,6 +625,8 @@ static int acpi_button_probe(struct plat
 		goto err_remove_fs;
 	}
 
+	device_init_wakeup(&pdev->dev, true);
+
 	switch (device->device_type) {
 	case ACPI_BUS_TYPE_POWER_BUTTON:
 		status = acpi_install_fixed_event_handler(ACPI_EVENT_POWER_BUTTON,
@@ -655,11 +657,11 @@ static int acpi_button_probe(struct plat
 		lid_device = device;
 	}
 
-	device_init_wakeup(&pdev->dev, true);
 	pr_info("%s [%s]\n", name, acpi_device_bid(device));
 	return 0;
 
 err_input_unregister:
+	device_init_wakeup(&pdev->dev, false);
 	input_unregister_device(input);
 err_remove_fs:
 	acpi_button_remove_fs(button);



