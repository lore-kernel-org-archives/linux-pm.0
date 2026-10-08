Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89240376A16;
	Thu,  8 Oct 2026 03:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791431096; cv=none; b=R5bUebMSt6JCz93Ho49Xv1dB32LjQlaU6GL5Wpmftyxdh9KEkNSflHpXZneSM6Do7HLD+70NdyMGhiZTqK5u5XGA5V/+H5brta8G2b62w4ivW/IRYHL6d+DfArOU4eTwObRyzMciKvVy+HDsL05ziVdwDHo/WWhsM/09fDjZwMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791431096; c=relaxed/simple;
	bh=QlqJblKuhAA3EiGFjajHVXf12N2MoHmXmxnk4dgF040=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fs2MZetViPRa2yCphoRrGHoycWTBa1lfYO1FXZdcWokfIJayzKFOhde9hqL9brizvLa/G1AlVApIM6s80OVBqRAnhFRniuRcWosZyv2l7S4IPc68j6n+Z7bzmOw/Ht8f+lYcuhB/J7OoEUfJHoYfYdEu7Ix6v88zL4RIj8wptgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VJ61bnLC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VJ61bnLC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70A5C1F00898;
	Thu,  8 Oct 2026 03:44:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791431095;
	bh=9OGrLzrV+k4C141eOEXKJ2WEI1GS+Fu7qqA+QD003aw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=VJ61bnLCdzyJsxTVY4C89pVG86XsmE7UfWfgO2eyFUzZMhBR1dYSFBfg7EmFt2Jmw
	 udVYmfSBTKnH75DB8IJ6XYfosRjkXSUk9j5GBxtjtHf81wY/WDE4wAp+7+wjol09E7
	 EJGu2Fw3HfbjHEETFPt04SL8G/j96nucK2++2ip6VjkkIkGvotf+Jo1d/l8gSfgyV/
	 pQUvsbVQUFNKts/KrAFO4lv6rXq6MouZadmuTrMRHV/Q+6+NvFqkxxAVaWMsBDatNc
	 hkN8pegURFTR5XhQwZZVfl79a/0zfAtfZM8BQK/vvz5SoEaaPP+DGL84AKW/WhuDXP
	 vjzUa6BeW8lZQ==
From: Yixun Lan <dlan@kernel.org>
Date: Thu, 08 Oct 2026 03:44:29 +0000
Subject: [PATCH v2 1/2] dt-bindings: power: spacemit: Add power domain
 controller IDs
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-04-k3-pm-support-v2-1-6f778a53dd2d@kernel.org>
References: <20261008-04-k3-pm-support-v2-0-6f778a53dd2d@kernel.org>
In-Reply-To: <20261008-04-k3-pm-support-v2-0-6f778a53dd2d@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Icenowy Zheng <uwu@icenowy.me>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@kernel.org>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1727; i=dlan@kernel.org;
 h=from:subject:message-id; bh=QlqJblKuhAA3EiGFjajHVXf12N2MoHmXmxnk4dgF040=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBqxxGqbQvBgGPkcrYm9cjIaLczfwcpG454RtDC7
 4IxS4kXMZiJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCascRqhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+09YQ//d/8shNnx2yQwpJ/XLgxTeLWrUmrs919qsuAmWXO3fMy07ZilubJiv
 JyiEbBJx8jEw4wxekHeb8xjbdIei7sR97d0duaHr8IrlXxdnGWF9XhXewm1x28yZeep9czO9yMi
 bOge2l0ucKxIXRDFACPe151OtDNCC+EJIMCYCbZrUOIBTHTsKFNNMAAg5bJc5Z7Y2JfhdMV/2vx
 sla4Q74TKBcdRlMBXVyJBhWUgZI6BHiyBZExiTRX+aqzFSVsWufcLaysYjbyf3p/qi/YfhVqprQ
 O6ha/2ALO5BlwWLg4/WbQSAsSIKGVAupjGc8TqeFT2NC5DKGNEpYhkjLKKGRDBjaYoHyVaLzYI6
 5+kdhz2BoFs7QgMbBsKeFtrxFh/pc+9W5TKVwaSrgqfPeJdzPlCY1IUn2dmXLdU5kJcBCjph/ro
 SaOhZC9VqmgnZMo1t5qjalvZYOlvxnYFIYSSnuYCgJJLySQ9M0rL/M88+b6vl8FDuWiY3vWVd19
 FayzEddPniPwkHj9myx/KMJleBhHgtU7XPeXg+hnigomxZIa1r5zMR5HVcl+vISHbXhYMZoM1YG
 1+aZARMwnYc5NJyoIGXOm7GhZ3BlnINL3FD1ndtYL3LDNp3zfyPBupEZujIVk5LxRV0w4CDLNT6
 M0RVzZP7WZH0dO45davDpMhiqpwHVI=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Add initial power domain driver support for SpacemiT K1/K3 SoC, The Power
Domain Controller is SoC internal module which is part of APMU (Advanced
Power Management Unit), it is responsible for managing power across multi
power domains, which includes power on/off, isolation, power-on sequence.

Signed-off-by: Yixun Lan <dlan@kernel.org>
---
 include/dt-bindings/power/spacemit,k1-power.h | 14 ++++++++++++++
 include/dt-bindings/power/spacemit,k3-power.h | 12 ++++++++++++
 2 files changed, 26 insertions(+)

diff --git a/include/dt-bindings/power/spacemit,k1-power.h b/include/dt-bindings/power/spacemit,k1-power.h
new file mode 100644
index 000000000000..41ef540b5c44
--- /dev/null
+++ b/include/dt-bindings/power/spacemit,k1-power.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_SPACEMIT_K1_POWER_H_
+#define _DT_BINDINGS_SPACEMIT_K1_POWER_H_
+
+#define K1_PMDOMAIN_VPU		0
+#define K1_PMDOMAIN_GPU		1
+#define K1_PMDOMAIN_LCD		2
+#define K1_PMDOMAIN_ISP		3
+#define K1_PMDOMAIN_AUDIO	4
+#define K1_PMDOMAIN_GNSS	5
+#define K1_PMDOMAIN_HDMI	6
+
+#endif
diff --git a/include/dt-bindings/power/spacemit,k3-power.h b/include/dt-bindings/power/spacemit,k3-power.h
new file mode 100644
index 000000000000..519fbf946312
--- /dev/null
+++ b/include/dt-bindings/power/spacemit,k3-power.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+
+#ifndef _DT_BINDINGS_SPACEMIT_K3_POWER_H_
+#define _DT_BINDINGS_SPACEMIT_K3_POWER_H_
+
+#define K3_PMDOMAIN_VPU		0
+#define K3_PMDOMAIN_GPU		1
+#define K3_PMDOMAIN_AUDIO	2
+#define K3_PMDOMAIN_LCD0	3
+#define K3_PMDOMAIN_LCD1	4
+
+#endif

-- 
2.56.0

