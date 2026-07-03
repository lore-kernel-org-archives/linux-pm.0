Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4DA3CAA4F
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 11:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783076662; cv=none; b=saQYL7oxej0IFSpu0aTVGSa0WCbofzv/yl1Zd7zGjpItocuGjt/12HnB25hwb7XrSm197N2lgl04mz0RW1OJoCrP85Oh/OmMjb29qhW1ASTRWPFEyY5BDoV30I1CqsQPG18YZ3Uyq4uO57QiL3wfXU2Eg+fdYXbeTjQgiuBHafM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783076662; c=relaxed/simple;
	bh=Lc67Zeaser87yY38PSmcUxCA/6lJ69+b9RUjeSaNZyc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oBuSDVVkPZFLoxu0m/kWKP2oVZPeQ9baHHEu0Zd8DYPxG4cItVoe4pvbHH3cTAC5QmHT3vtRSRoIhM8bMCczBF0hSywLaDN3gpXeT/Fwmb4OMK/XInr7wrIclP3ZLzYyfJ8gOAacuHR8fOpZu4zyhCrbkn9DKWpQtc7PtnYLxR4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=I8Zwvsby; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="I8Zwvsby"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2c9bd2f8bf7so16666995ad.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 04:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1783076660; x=1783681460; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KRv90qFqU2a0K+pYyATTHQRQ7A0Z3yoLXaJNbxqKJ4c=;
        b=I8ZwvsbyWv3A0bs4Vqvux09WzEm/aMxBMmZQly8sPdjlqvH57tf4IL33B+cvTUrsa/
         7IqPhw0gznmvruexhfFiq3vcuvQ0r5OdWRfjl4kKmvbgWQU6f7xb9CCjm+0veGfnVszg
         CY5pUKeaiJ94UR3FTjTvRF/pc9jDn0TUNv5rs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783076660; x=1783681460;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KRv90qFqU2a0K+pYyATTHQRQ7A0Z3yoLXaJNbxqKJ4c=;
        b=a5/AIzVz3Qd+Yy9vdECIma4bv6UE1ZUFobHwhwgI58aysLx8UB+zlgiZ7szPvMU6aY
         F6AtYevAelao/aEiqLK2Tf9EoTgCmdbyD1W7tNKVaOKgBaj65tgDAjulyEz/iuiX3TrS
         U0b2TxgeZqX3u5OUUUWQbcjF56SXA9mqnaFJ1DTEFnASEoabKRKhuv3ZFvDxbmYCkULa
         XSPnKMy3GNMHEcy5kgEvqEKFqo8BT/k7Xa/Tl2VCPsJ8EZT3LSqqmMEtYrDzQ1dRgM9T
         ASA9cLPN/Gh/F4uaflLGiTTkd3xnlk/JY1vhECuLnrRcOmwACgFohZi7uF1NR2X4Qsop
         RMkg==
X-Forwarded-Encrypted: i=1; AHgh+Rqtwh2R8lOSIi+qWNSFc5wqkyvIsaQj+zmCHgdbpxqcnL4U2KhRJF3uLxzSWxTt450SKiAQWEq7cw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yymg1nDIVF7N+swjLkwb3VLWq7VX6VUZ3dYZ7GMhoFg0Vnblfnr
	/5HlwjtPS3agqyt+B4mL8fni1D+/cma1yJGxs0VdpK1F5hpaRB4o69f+4N7Wp91uBQ==
X-Gm-Gg: AfdE7clue9NPzwtoEU+8w7oP/QXe5TXlQhHGjGalVFJYNkCWP3FmfxW18YhNcWHTfWI
	4I7wf2rQb6mbwTgQcZWcqzmgVxRR30yXlSQ+UU3sXOvvWhBOn6zameN2OYPXcCcBfz5SCwFnChD
	q4rTtGgm0nMXKOMQfZaA589oUmvXp3uCjOecM23kSpOwgKKmT0Yc4nxmN0NtT4fFZX5/OjYeEfF
	q1K5aXwg+yxmYvasZFB3RswcBUatGu4/HCy1n/XgVRIK1BlEIpIC5TC2L/DwEI/BWZFKr3wMV1b
	ZPxW6hnJuN2GtUXnHr+cvCmEsiEQabFJkXIkqUWzvkwU1JN2eq+JjanU8NZBz8tEDtFnqwMSf4Z
	eAeW9amfk/ZX68P/DyzqmXqxsZX4ZuhY8NsVAeE2xqrV6bCT0rjs8y6mlrtc9q2pHgoQiLRdKXj
	TMs6tgKvEw2EH7XY+kut0J3cyQs8lwCw+qZbD5jVM8/5DV+SQoZrm8tJwrac2JSOua9Aewz5eJE
	r9qlRSF
X-Received: by 2002:a17:902:d4c3:b0:2c9:d584:49bc with SMTP id d9443c01a7336-2cacaa911b2mr39932695ad.3.1783076659705;
        Fri, 03 Jul 2026 04:04:19 -0700 (PDT)
Received: from wenstp920.tpe.corp.google.com ([2a00:79e0:201d:8:7bc5:6c83:76cd:cbd6])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad6f25e15sm7785315ad.13.2026.07.03.04.04.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jul 2026 04:04:19 -0700 (PDT)
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
Subject: [PATCH v3 10/13] power: sequencing: pcie-m2: support matching on remote "port" node
Date: Fri,  3 Jul 2026 19:03:11 +0800
Message-ID: <20260703110317.1283411-11-wenst@chromium.org>
X-Mailer: git-send-email 2.55.0.rc0.799.gd6f94ed593-goog
In-Reply-To: <20260703110317.1283411-1-wenst@chromium.org>
References: <20260703110317.1283411-1-wenst@chromium.org>
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
Changes since v2:
- Use device_match_of_node()
---
 drivers/power/sequencing/pwrseq-pcie-m2.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/sequencing/pwrseq-pcie-m2.c
index c8ee6df42b81..16a47f76e7ce 100644
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
+		if (remote_port && device_match_of_node(dev, remote_port))
+			return PWRSEQ_MATCH_OK;
+
+		/* Try the remote port parent for other types. */
 		struct device_node *remote __free(device_node) =
 				of_graph_get_remote_port_parent(endpoint);
-		if (remote && (remote == dev_of_node(dev)))
+
+		if (remote && device_match_of_node(dev, remote))
 			return PWRSEQ_MATCH_OK;
 	}
 
-- 
2.55.0.rc0.799.gd6f94ed593-goog

