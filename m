Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA61D406802
	for <linux-pm@vger.kernel.org>; Thu,  9 Jul 2026 09:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783591118; cv=none; b=gmn/kb31z7+zTkRYyCpF7EczaPJZDk87Yai5ar1K5YZS7FggZbk/cHZEQsSEYWdhI0XpoyE2b9t34AkvcONLCvk2LAWgrHlNXzV+/kN9ZJTD3CAKJFWtihFY65vBK6FVh/heFA7CX0+Qrp5HPnr9qIsS4feQSeP1dW1iHNW9Q4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783591118; c=relaxed/simple;
	bh=wBafzaV3gjSM9m4C5Xt10gLLMadwusWzqQ8Oa+RTMik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sKGVIinEqeL14w2EDVh5kScXM/VKsIwPoWX0KJEN6IJXE6nsDkJpYDA6OyyltQk7g/FvpHDYCjZj9SXCGX61lMvtd2M2aEc48GgokZcky/q7vaMWRFYGgSb57RgKAVriAJlGpFNxUxVlvUo0j+XgeVv6D8/64GSg03n89HQGZmY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HGewnmle; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HGewnmle"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-2cca0c5799eso14101295ad.0
        for <linux-pm@vger.kernel.org>; Thu, 09 Jul 2026 02:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783591116; x=1784195916; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=+6qS8sNKqohtOzh0Qv5rdb1r/B7Aj2Rva8hJLtH9EXY=;
        b=HGewnmleUf1fRlxmhIvnIY9EShmWAYlRiIQ3qU5pDd72sg5Qmc3Q8PXc1/6Kd1BZq9
         OgEew67NURfR+qa42DXyz1uvm8K5/XRA3Dic0+kygI1hPhbL21hsXRmB5fobDa/VpXLs
         /wxg8fcUDutpgbVKSJdAL00O+/s4BduLJqIBM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783591116; x=1784195916;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=+6qS8sNKqohtOzh0Qv5rdb1r/B7Aj2Rva8hJLtH9EXY=;
        b=o+olw7yftVAzysLKVNMjmtFih6es3P0fTdX64QD3nGgyekYGkYwv94QoTR+sKU0AwA
         3fL3bUgPHwA0QljEVNLOlMNXG6ZltXMUUIkw9bgf9VpuzIsJAVg7aG/Fc29t5Ps9AU6w
         hglVptOEKjzpIubJk81IZ8h1NeHA1Ptr+LcMdnxI5j0lcqhYnX1aIhK+6TfSO0wqyncY
         7Igtd+li+of4xlH6fzB9C3fUUMrZ9M98peRg1HmfRweEV7cfEzWnAxWCZB745FufBFQR
         GEQV9hCKSmuGZPNgEoj/XJEG7SuFNfc99BGQPejMxRCjRgB+5mQEAPsFfs9s/a57OIMV
         J2mw==
X-Forwarded-Encrypted: i=1; AHgh+Rp71oMqm7e+7g1YAF2CIvP2iKn8S8OCaxbIjFvdDCvWGxkZgFkeVvGTtqxeyXqfggAfuX45ILci9g==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsDEXunvlLJugQoHSSmri+JqiMoNlUpdhFThsaA2WbXhfYU1g9
	/jfwZTGcNI0P5VfVpeY8P1ridkgxIJ5ZbZ4RECz7rm8lOSuh96pviiYhzCvJbvw0XA==
X-Gm-Gg: AfdE7ckEPRa1W2Pzx9Xi0wv73DPdGrX7OwEV7Hvaurr/mMk9ziUFTXOc/d1JCSBxUR4
	GASSZBRSAY6DegKKmaV7iOXb4Ktw7m7+GtSF6QuZ9nijAVe8IdGe21s4Kr95RtzSmHFmdHZkJ+z
	Oi2XPObwkrNVaYOT2AYs31hgcKpJsf354mtVzEv1Xt5FEL6BgcBx1eNuEuJbyxKBgDvDXDXOZV0
	QkQR0Oc6XnZH0PfAVDokMJ/1NLVZ41Xr9nGUn/+eVE6yaZhpbNTfDOMLc0W9BtDTqIIyKajQBVe
	bMypyiTVP5SAUr74PlPvl5XvkZ1rU37kLh4AFZZB2gLMabR0njTD+MVlb/qawVe/lYkqUd6YBtS
	NYdOFDzeKdK+42KW6PxZawK/MJ+V+T7Zbc5cFLs2Hk3i/g0BH9F5i9yM3ejgQxyiNWCoS4/Ie4k
	8dHzM/1VlLkNR1sk0ORtqAEAX3XHS2q9W2pz7fYIYUd8cAkS8QRuenzen2GcqYmngsuogabw==
X-Received: by 2002:a17:902:e74e:b0:2ca:e106:8e69 with SMTP id d9443c01a7336-2ccea371b50mr70745585ad.10.1783591116169;
        Thu, 09 Jul 2026 02:58:36 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:bd09:6ddb:180a:69c5])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9d5bd2fsm41082155ad.78.2026.07.09.02.58.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 02:58:35 -0700 (PDT)
From: Chen-Yu Tsai <wenst@chromium.org>
To: Bartosz Golaszewski <brgl@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v4 11/14] power: sequencing: pcie-m2: support matching on remote "port" node
Date: Thu,  9 Jul 2026 17:57:16 +0800
Message-ID: <20260709095726.704448-12-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.795.g602f6c329a-goog
In-Reply-To: <20260709095726.704448-1-wenst@chromium.org>
References: <20260709095726.704448-1-wenst@chromium.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A USB hub can have multiple ports, and this driver needs to
differentiate which port is being matched to. The USB hub driver now
associates the "port" node with the usb_port device, so here we can
use the remote "port" node to check for a match. Then fall back to
the remote device node for the other connection types.

Also rewrite the existing "remote == dev_of_node(dev)" with
device_match_of_node() for consistency.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
Changes since v3:
- Drop redundant device node validity check; device_match_of_node()
  does it internally (Andy)

Changes since v2:
- Use device_match_of_node()
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index 83fe6a1396bc..733190175f84 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -175,9 +175,18 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 	 * parent matches the OF node of 'dev'.
 	 */
 	for_each_endpoint_of_node(ctx->of_node, endpoint) {
+		/* USB port devices are tied to the port nodes. */
+		struct device_node *remote_port __free(device_node) =
+				of_graph_get_remote_port(endpoint);
+
+		if (device_match_of_node(dev, remote_port))
+			return PWRSEQ_MATCH_OK;
+
+		/* Try the remote port parent for other types. */
 		struct device_node *remote __free(device_node) =
 				of_graph_get_remote_port_parent(endpoint);
-		if (remote && (remote == dev_of_node(dev)))
+
+		if (device_match_of_node(dev, remote))
 			return PWRSEQ_MATCH_OK;
 	}
 
-- 
2.55.0.795.g602f6c329a-goog

