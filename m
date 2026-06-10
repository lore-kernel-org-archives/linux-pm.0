Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E418F3B5DED
	for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 08:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781080925; cv=none; b=MH0hkXSm793As3IUDYQvvWnZKh73D58nSR/iqYhmVFkzU9BwQdHoKyr57gtZderJbwI+S5BMMF5zwhF/y7VWOxY2C2ph+jI98eQCM8ZGq04y/KjHzWFlMYyUugqsHdJHxYLOgE+W6wkEIwPCPVUvZxT1zj7PEZLUozSJKiNkCmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781080925; c=relaxed/simple;
	bh=Q230lnY0gVIEr7GJLHqky4UKLxDQyNEVo5h765AhfJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YoDHZCmb/HHHnECbQx5tTKQ/Y4TAq+l/Schtsjl7CnHjsjmYu1MQHRdQ4v3J0U6YyGhxWR3xrExLXUgj/qMusYipD746d8HcCMVQpAJPKusk9NRVn0WjFn2txaT7Qv1m9E9BRoUemTZHM88F1UA7Vo5Z6g2DwdF/G5lPccacnM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Q6w9RDxF; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Q6w9RDxF"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2c0b9328c4aso45094105ad.0
        for <linux-pm@vger.kernel.org>; Wed, 10 Jun 2026 01:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1781080923; x=1781685723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OS442Iy4WHxSdJHdZSOdZpr7Kbl6vNC1J8JNZ1Janxs=;
        b=Q6w9RDxFczGEkAJjDHzISYkh32EV/GVUcvrUUaV27U+mn2Ebvskd9lzBaHss0VRlki
         /KGqDphVexrsdYmJidEiBNSv7jVSAAKZjrf/wpqAMz3DQ9psFtweva8cXC6Gotll0nos
         t9lcp8TZjW/FDQ4nWz7kzRaCA/zRKkYHxlsDk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781080923; x=1781685723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OS442Iy4WHxSdJHdZSOdZpr7Kbl6vNC1J8JNZ1Janxs=;
        b=GbgiNIZxd//a6U/NdqbgvedvT3DjY7S11FPjJFgPfpcHcReE3iapo9hTNvZ6nA4AFO
         oAh3V75yHFLc/dbgv/xKYkeCY1gMEz8yxewjABd8f/qGbYoRSvabnWWnPH9H65TMbNZl
         v7pXhkEPPc5ex/rMHeSPFEG1bs6G/GuL1x89uCVTBbY1mctx0PcVwB9Mj8eFDv/yiRhE
         1z9fuFQIH/y8WmnGyBFRZnst5tXx5bCKZLmO+/BKh7eIK/O7kmQmbTU9cVE5UI0nKCG4
         2qzUxu6j11s4gdCM2g2SqcFRtPKzULLOUPzcdIxtxZhMXGKbIJl8wDKrRhZ3LTmUCbNG
         mYWg==
X-Forwarded-Encrypted: i=1; AFNElJ8k31TJuwX1J/7F8OF8h3V5o3WRxJoi5q3kn7VtyRVmXOPuw2und3wYUNzn9IbxUhODeju5jZ0q1w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx8WibNYzJDExfZPUTreVoa9SENe/gSxx4qz6Y5aYywhFfy8aka
	Xj2xc/x7MdjxEKLfMyQ+wGUMVys/coDabxabJMy88X70Q3LaLgir1BGNdE65ytpc9w==
X-Gm-Gg: Acq92OFOZmVv8SuzsBDE9ng3+1t5McU8zb9zxa4Fa2A27meuDYuNd2cXtOfaOPs7PG+
	10GQopN4ZWuFOYWNf8PIYy9+Fqow8hfgxbXpeaY6UuFz1/eHc+Wl0fB3DAa9gYd6g4TBuKhnrdH
	QJySKD2J8CpqLXmTL68fwgRWL8nJ4HVBQzBTVbSe1FqLy70WBU/YOZgBDf73IwWSIlt9Cl94CrC
	4rg/LASHpr24bgfRMIUV8wlO5Wcf1zhcnnjAUbHdITnZ/MelTnyI0BhuZkVBd9xxS5SOa719O3Q
	fZsZ4Fg11WzT2ZWbO1k5Of5LaMdD1cOqFcbFkTVoh34cO8O86A0CQHeEuoNir+lfqufjEoudGr4
	aBLxTmYYGReK7YdGe8gncL9+/DX2co2vZODOXw9gJBoKqPDxBH3rxUPQMhp6FMi7zJ8dvLkgAQn
	DoDO2d3uTewvGGK944ejjzue2K79YJcptxcswvQOWsU/kboza+KjcEs5Id5VBXU806G/BevQ7/C
	K/bs23ripBgn4ZNjA==
X-Received: by 2002:a17:902:cecc:b0:2c2:9254:4c22 with SMTP id d9443c01a7336-2c2a1c66cbcmr79859165ad.17.1781080923157;
        Wed, 10 Jun 2026 01:42:03 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:3870:6325:16c:d35c])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c164f890b2sm239223725ad.26.2026.06.10.01.41.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 01:42:02 -0700 (PDT)
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
Cc: Alan Stern <stern@rowland.harvard.edu>,
	Chen-Yu Tsai <wenst@chromium.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-pm@vger.kernel.org,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <mani@kernel.org>
Subject: [PATCH v2 10/16] power: sequencing: pcie-m2: support matching on remote "port" node
Date: Wed, 10 Jun 2026 16:40:44 +0800
Message-ID: <20260610084053.2059858-11-wenst@chromium.org>
X-Mailer: git-send-email 2.54.0.1099.g489fc7bff1-goog
In-Reply-To: <20260610084053.2059858-1-wenst@chromium.org>
References: <20260610084053.2059858-1-wenst@chromium.org>
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

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index e82821655fc4..49293376956b 100644
--- a/drivers/power/sequencing/pwrseq-pcie-m2.c
+++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
@@ -176,8 +176,17 @@ static int pwrseq_pcie_m2_match(struct pwrseq_device *pwrseq,
 	 * parent matches the OF node of 'dev'.
 	 */
 	for_each_endpoint_of_node(ctx->of_node, endpoint) {
+		/* USB port devices are tied to the port nodes. */
+		struct device_node *remote_port __free(device_node) =
+				of_graph_get_remote_port(endpoint);
+
+		if (remote_port && remote_port == dev_of_node(dev))
+			return PWRSEQ_MATCH_OK;
+
+		/* Try the remote port parent for other types. */
 		struct device_node *remote __free(device_node) =
 				of_graph_get_remote_port_parent(endpoint);
+
 		if (remote && (remote == dev_of_node(dev)))
 			return PWRSEQ_MATCH_OK;
 	}
-- 
2.54.0.1099.g489fc7bff1-goog

