Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F9C0371CFF
	for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 19:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786736833; cv=none; b=HGoKqbTOJGhDDDcy+1vNsiLm44aoUzEhUD4dzZ6Uh80bsKNNNU1h61yua6pKlM7oTysdFMz2rLpjcNLPceSwRrVdA8MZrE/jw5/xjXWx5qP69utXDMMEjt7ShAy/YG5pdkxdDowC7/TU0QlTPMxML2GZAREvO79j/rMx+7pyC0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786736833; c=relaxed/simple;
	bh=U1JoGZnvbz1lmyls1/v3gPQsEpMLAWDBdYn4o9KJ+Yc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RjZwZOq/QHM0Vu5kF9nqy6FmK0W50qmS+Ad60O+NY2FvsZ3idsEvZdpWvRxNJTlVys2J+MIp9vnlTrUjs1btVPXEp1PsYaf54BkGesXRgbWw0m/LK/m6X+XQMdw26A/eUU5OkkAxbAGr2EobTQahlfH5Oi5VE69h9qTtqpPk0Mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=kazr7Rlq; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="kazr7Rlq"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-ca7c1176317so1183412a12.1
        for <linux-pm@vger.kernel.org>; Fri, 14 Aug 2026 12:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1786736830; x=1787341630; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4pFsg5DaBut5RJmYZBe5aOtRtX/aP+9Aa+0P+1l5WK4=;
        b=kazr7RlqEPdiOEv0GOqS+3z03jFbFKJRHiDQjalQhLdJ5H0QKkmqOpBCRB5JEquP+w
         pAWkGoaWN4FEPftHcyUnA6kZbLM70rtO9YyXhpQ9G+7NxVc2kj7dvtI0i1FRCfgBEq9E
         uY4aX/cPooXbamX5vx2OmciH0L46mGCUllsHY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786736830; x=1787341630;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4pFsg5DaBut5RJmYZBe5aOtRtX/aP+9Aa+0P+1l5WK4=;
        b=SHLUaLUGH+ERbA0bMQElxwX4RIeBo7a2dlwSAIEDu4Ite+lK5kMCEAD3n4uLbocFXD
         5QpM/E85SfuWzjpKvmw7LdKIJx3VsRz2QXR6m7i9jJ/zDn+ZFk1+EnH4+1YWE7rnxL05
         pMpODeC7vHikGs4w4urqmMD42vfxHJ1qzSss1vqZNfgAz+vN3cV49pNyWtGD8yObCLEm
         CdaXkVMwGHHGYa5P5gZpqRAObUWGOfDfVNV/E1Vj/TPds3tDMce6Rot4xukXqY96nj7L
         KWWOtGkiVxL5q/IZfx3zfSyg+7xQ1zSXRvyIoi/9f3M7ZB8klnfCWPkMPolEFg2UuQpw
         gcmg==
X-Forwarded-Encrypted: i=1; AHgh+Rpo3BOWyOKRv9yD3a1dtllqPwnf2vf0BMfxWgdARt0xpqZoK+fsPr4mOGHlgEisKnML7cD8PU3IFg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwcAs82jQwfvn7NZEUxwXuJfoeaLQctcf9JhmBRJ5M6vYqy8M/5
	wPzFz9L4O7+mrIFVS4686YLQCL4xD2yjU2gydCFMiKnmF7MXN7vyjwiS+lZtRswk/g==
X-Gm-Gg: AR+sD10ezlZgvSaGptSM6ohq1HQBfs8vbhoYxX3nch1t3mxZh1d6ASCbWjxCAa510Sj
	6S+4V/Zw57nn7NuC4mSBRSLjMjgFNq8/TbqJgnvasFOjXozzu3xMsc3L7V8wodlFYNBjI23W3jb
	aAyRgGes0ZObONBhLcLaBmO4iYxFqmmPSclYqcWcfuuaaJvscs5q2CZfxVBpF3ldQFQhBsP+Iz2
	fzu5SIYrqSzKnpuraZn/wB1egc51O6CArE5ctxYax/cYs7hVa8vsy6ERK2ZSrNtxu9yDwGAkj/E
	G6UlZ1qX/wLaakamb8h8+9cCoVmn54DhfjU70T409t6QriOKLYolDVakHGacOwtHHa1MyQbRPud
	AG+LlYA5TKhpS2f1hUpBQLyFBS1YJCkIizQf7q+R5ziKyECTUp0ySbgMjrvK6WUOEKLsY4mzPzs
	QhVO47cyWziNamwoUWGSbrVvqVhs0aAEgqESWS6yBTYJxF+WvECSL0faT9updBw5kw+9yl3XFfs
	iv2fHbBeGslo4U5hnPw7vYkZH9S64GmQT7Tl9VMsUltHGA=
X-Received: by 2002:a05:6a21:a4a:b0:3c3:9070:96b3 with SMTP id adf61e73a8af0-3cc71af165bmr10151406637.3.1786736829719;
        Fri, 14 Aug 2026 12:47:09 -0700 (PDT)
Received: from dianders.sjc.corp.google.com ([2a00:79e0:2e7c:8:dcf8:d626:8503:b94])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-141386a039asm11446346c88.0.2026.08.14.12.47.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2026 12:47:06 -0700 (PDT)
From: Douglas Anderson <dianders@chromium.org>
To: Jassi Brar <jassisinghbrar@gmail.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>
Cc: Douglas Anderson <dianders@chromium.org>,
	Sudeep Holla <sudeep.holla@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Chen-Yu Tsai <wens@kernel.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Michal Simek <michal.simek@amd.com>,
	Samuel Holland <samuel@sholland.org>,
	Sebastian Reichel <sre@kernel.org>,
	Suman Anna <s-anna@ti.com>,
	Thierry Reding <thierry.reding@kernel.org>,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	linux-sunxi@lists.linux.dev,
	linux-tegra@vger.kernel.org
Subject: [PATCH v2] dt-bindings: mailbox: Delete old 'mailbox.txt' bindings file
Date: Fri, 14 Aug 2026 12:46:12 -0700
Message-ID: <20260814124603.v2.1.I8b3ff71c528133e7d6f81fe926fa39e6451d63fd@changeid>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As per mailing-list discussions [1] [2] [3], we want to delete the
following old file from the device-tree bindings that live in the
Linux kernel git tree:
* Documentation/devicetree/bindings/mailbox/mailbox.txt

The old .txt file did have some descriptive text about what some of
the properties meant. Those have been added to the dt-schema
repository in a pull request [4].

Also remove dangling references to `mailbox.txt` across all remaining
device-tree binding documentation files.

Link: https://lore.kernel.org/r/20260722140214.GA548057-robh@kernel.org [1]
Link: https://lore.kernel.org/r/dc7a2041-50a4-482e-9930-566bb3fd1e72@kernel.org [2]
Link: https://lore.kernel.org/r/CAL_JsqKVjQ2m-dzMUENQry-f_YE9QrYSOKoH9CPj1gjj8XkPRA@mail.gmail.com [3]
Link: https://github.com/devicetree-org/dt-schema/pull/202 [4]
Cc: Sudeep Holla <sudeep.holla@kernel.org>
Cc: Jassi Brar <jassisinghbrar@gmail.com>
Cc: Lee Jones <lee@kernel.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
- v1: https://lore.kernel.org/r/20260804133801.1.I8b3ff71c528133e7d6f81fe926fa39e6451d63fd@changeid

Changes in v2:
- Remove dangling mailbox.txt references as per Sashiko.

 .../firmware/nvidia,tegra186-bpmp.yaml        |  6 +-
 .../mailbox/allwinner,sun6i-a31-msgbox.yaml   |  3 -
 .../bindings/mailbox/altera-mailbox.txt       | 12 ++--
 .../mailbox/hisilicon,hi3660-mailbox.txt      |  2 +-
 .../mailbox/hisilicon,hi6220-mailbox.txt      |  2 +-
 .../devicetree/bindings/mailbox/mailbox.txt   | 60 -------------------
 .../bindings/mailbox/ti,omap-mailbox.yaml     |  3 +-
 .../power/reset/xlnx,zynqmp-power.yaml        |  9 +--
 .../bindings/soc/qcom/qcom,aoss-qmp.yaml      |  2 +-
 9 files changed, 15 insertions(+), 84 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/mailbox/mailbox.txt

diff --git a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
index 3c44fe607e12..acdc5c1d3d8b 100644
--- a/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
+++ b/Documentation/devicetree/bindings/firmware/nvidia,tegra186-bpmp.yaml
@@ -18,11 +18,9 @@ description: |
   which can create the interprocessor communication (IPC) between the
   CPU and BPMP.
 
-  This node is a mailbox consumer. See the following files for details
-  of the mailbox subsystem, and the specifiers implemented by the
-  relevant provider(s):
+  This node is a mailbox consumer. See the following file for details
+  of the mailbox specifiers implemented by the relevant provider(s):
 
-    - .../mailbox/mailbox.txt
     - .../mailbox/nvidia,tegra186-hsp.yaml
 
   This node is a clock, power domain, and reset provider. See the
diff --git a/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml b/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
index 87d31963c1b7..f58b0d412186 100644
--- a/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/allwinner,sun6i-a31-msgbox.yaml
@@ -17,9 +17,6 @@ description: |
   hold four 32-bit messages; when a FIFO is full, clients must wait before
   attempting more transmissions.
 
-  Refer to ./mailbox.txt for generic information about mailbox device-tree
-  bindings.
-
 properties:
   compatible:
     oneOf:
diff --git a/Documentation/devicetree/bindings/mailbox/altera-mailbox.txt b/Documentation/devicetree/bindings/mailbox/altera-mailbox.txt
index c4dd93f1fed2..87749d251f09 100644
--- a/Documentation/devicetree/bindings/mailbox/altera-mailbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/altera-mailbox.txt
@@ -31,12 +31,12 @@ Example:
 
 Mailbox client
 ===============
-"mboxes" and the optional "mbox-names" (please see
-Documentation/devicetree/bindings/mailbox/mailbox.txt for details). Each value
-of the mboxes property should contain a phandle to the mailbox controller
-device node and second argument is the channel index. It must be 0 (hardware
-support only one channel).The equivalent "mbox-names" property value can be
-used to give a name to the communication channel to be used by the client user.
+The common mailbox binding properties "mboxes" and the optional "mbox-names"
+can be used. Each value of the mboxes property should contain a phandle to
+the mailbox controller device node and second argument is the channel index.
+It must be 0 (hardware support only one channel). The equivalent "mbox-names"
+property value can be used to give a name to the communication channel to be
+used by the client user.
 
 Example:
 	mclient0: mclient0@400 {
diff --git a/Documentation/devicetree/bindings/mailbox/hisilicon,hi3660-mailbox.txt b/Documentation/devicetree/bindings/mailbox/hisilicon,hi3660-mailbox.txt
index 3e5b4537407d..ec2da5c9e647 100644
--- a/Documentation/devicetree/bindings/mailbox/hisilicon,hi3660-mailbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/hisilicon,hi3660-mailbox.txt
@@ -35,7 +35,7 @@ Client
 
 Required properties:
 - compatible		: See the client docs
-- mboxes		: Standard property to specify a Mailbox (See ./mailbox.txt)
+- mboxes		: Standard property to specify a Mailbox
 			  Cells must match 'mbox-cells' (See Controller docs above)
 
 Optional properties
diff --git a/Documentation/devicetree/bindings/mailbox/hisilicon,hi6220-mailbox.txt b/Documentation/devicetree/bindings/mailbox/hisilicon,hi6220-mailbox.txt
index 044b17f3a77a..de9fbf722bee 100644
--- a/Documentation/devicetree/bindings/mailbox/hisilicon,hi6220-mailbox.txt
+++ b/Documentation/devicetree/bindings/mailbox/hisilicon,hi6220-mailbox.txt
@@ -55,7 +55,7 @@ Mailbox client
 Required properties:
 --------------------
 - compatible:		Many (See the client docs).
-- mboxes:		Standard property to specify a Mailbox (See ./mailbox.txt)
+- mboxes:		Standard property to specify a Mailbox
 			Cells must match 'mbox-cells' (See Mailbox Device Node above).
 
 Optional Properties:
diff --git a/Documentation/devicetree/bindings/mailbox/mailbox.txt b/Documentation/devicetree/bindings/mailbox/mailbox.txt
deleted file mode 100644
index af8ecee2ac68..000000000000
--- a/Documentation/devicetree/bindings/mailbox/mailbox.txt
+++ /dev/null
@@ -1,60 +0,0 @@
-* Generic Mailbox Controller and client driver bindings
-
-Generic binding to provide a way for Mailbox controller drivers to
-assign appropriate mailbox channel to client drivers.
-
-* Mailbox Controller
-
-Required property:
-- #mbox-cells: Must be at least 1. Number of cells in a mailbox
-		specifier.
-
-Example:
-	mailbox: mailbox {
-		...
-		#mbox-cells = <1>;
-	};
-
-
-* Mailbox Client
-
-Required property:
-- mboxes: List of phandle and mailbox channel specifiers.
-
-Optional property:
-- mbox-names: List of identifier strings for each mailbox channel.
-- shmem : List of phandle pointing to the shared memory(SHM) area between the
-	  users of these mailboxes for IPC, one for each mailbox. This shared
-	  memory can be part of any memory reserved for the purpose of this
-	  communication between the mailbox client and the remote.
-
-
-Example:
-	pwr_cntrl: power {
-		...
-		mbox-names = "pwr-ctrl", "rpc";
-		mboxes = <&mailbox 0 &mailbox 1>;
-	};
-
-Example with shared memory(shmem):
-
-	sram: sram@50000000 {
-		compatible = "mmio-sram";
-		reg = <0x50000000 0x10000>;
-
-		#address-cells = <1>;
-		#size-cells = <1>;
-		ranges = <0 0x50000000 0x10000>;
-
-		cl_shmem: shmem@0 {
-			compatible = "client-shmem";
-			reg = <0x0 0x200>;
-		};
-	};
-
-	client@2e000000 {
-		...
-		mboxes = <&mailbox 0>;
-		shmem = <&cl_shmem>;
-		..
-	};
diff --git a/Documentation/devicetree/bindings/mailbox/ti,omap-mailbox.yaml b/Documentation/devicetree/bindings/mailbox/ti,omap-mailbox.yaml
index 8504ceb64806..7e3b7b68841c 100644
--- a/Documentation/devicetree/bindings/mailbox/ti,omap-mailbox.yaml
+++ b/Documentation/devicetree/bindings/mailbox/ti,omap-mailbox.yaml
@@ -53,8 +53,7 @@ description: |
   ==============
   A device needing to communicate with a target processor device should specify
   them using the common mailbox binding properties, "mboxes" and the optional
-  "mbox-names" (please see Documentation/devicetree/bindings/mailbox/mailbox.txt
-  for details). Each value of the mboxes property should contain a phandle to
+  "mbox-names". Each value of the mboxes property should contain a phandle to
   the mailbox controller device node and an args specifier that will be the
   phandle to the intended sub-mailbox child node to be used for communication.
   The equivalent "mbox-names" property value can be used to give a name to the
diff --git a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
index 079ad977b907..60f0882f5381 100644
--- a/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
+++ b/Documentation/devicetree/bindings/power/reset/xlnx,zynqmp-power.yaml
@@ -27,12 +27,9 @@ properties:
       mailbox controller device node and an args specifier
       that will be the phandle to the intended sub-mailbox
       child node to be used for communication. See
-      Documentation/devicetree/bindings/mailbox/mailbox.txt
-      for more details about the generic mailbox controller
-      and client driver bindings. Also see
-      Documentation/devicetree/bindings/mailbox/ \
-      xlnx,zynqmp-ipi-mailbox.txt for typical controller that
-      is used to communicate with this System controllers.
+      Documentation/devicetree/bindings/mailbox/xlnx,zynqmp-ipi-mailbox.yaml
+      for typical controller that is used to communicate with
+      this System controllers.
     items:
       - description: tx channel
       - description: rx channel
diff --git a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
index 8eaa04431d74..e238f100f8ff 100644
--- a/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
+++ b/Documentation/devicetree/bindings/soc/qcom/qcom,aoss-qmp.yaml
@@ -69,7 +69,7 @@ properties:
     maxItems: 1
     description:
       Reference to the mailbox representing the outgoing doorbell in APCS for
-      this client, as described in mailbox/mailbox.txt
+      this client.
 
   "#clock-cells":
     const: 0
-- 
2.55.0.691.gc56d675ccc-goog

