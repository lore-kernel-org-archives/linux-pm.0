Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794470484;
	b=iloWgcQ4XWcI/0ofaKgjDy1PMWA63w3WX9Qrg9o00YCskkTePN1JYu7NkVCRO69BXPpz
	 s4nSNZMZ2ksaQIZnCY3ZsTRyUgYvhJ39r9H48tMm54Sun5xd+Gl8ShwuhR4GVo/+WcON0
	 Q7ncHrANExVayAGj4VCuKu5HxGGFTIB+soIDWpzfJW+CWOgcL9JZqwEmJOOO0OnKXtgZT
	 mltNWDzedEr8FB0NZBjDiwPbGCv3Jcktf4jR/Acm1Y3EZnY3v+orW/OEb1hNXSUST2dea
	 nUUCmCum+iWpW1fzLi9AY4P2ZRhaw22680zFdr1XdCD5GTfJRp/QGBBOmMX0LTlyDNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794470484;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Ho/SJRRXKfR8E8InR6yIipzjTEX73uVp+KDQpwqfDkg=;
	b=cF/6R2HPS21zQJc7Q1iWcL1VzS/p3bAHn+U5vORb/5yrEutYsIcM5qfBCrhC+IsQhJCr
	 HBaxSSpU7XPZkcafj7FHey7jBofU3GXz2lDENKucQ1yd4KyL01EHME7mjy46mrnsUbVVw
	 02bvodrs+zHLLOS0zGeGzTBJQSsZhOsyqrxeeahxY7Mlsb4G0I2ngbMXe7n5p7WIIog5x
	 hQ/gEEtzLxKaC8eaqqEJByKiFf6In3/pUiZMAPpnbRxc+Cp3vk+mNMEDT3MRBESkLVmXJ
	 zvpYzgI+iHR/31LBPadLD6dsTy/Rg9iyuHblp/+Rjm58nyGPNPMfTQTB2UbznSuKu7Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IX86yE0i;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7482606A327;
	Thu, 12 Nov 2026 08:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IX86yE0i
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 233F11F00A06;
	Thu, 12 Nov 2026 08:01:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794470484;
	bh=Ho/SJRRXKfR8E8InR6yIipzjTEX73uVp+KDQpwqfDkg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=IX86yE0iZxcEtAHfeuJL5JpOZ67UmXFn4xmBbABbBa0UsO+e4sJcaDr9iM2WfqGHN
	 o288DfoA0kbfws9DDfgZkNQOVndsS2O40l0a1HdoXRAgwyb67U/6q6nOxVRXh9GI/p
	 0GR9BPeQZ9WCriYLfb7f7Jd644e+U6WvkZjHxk75KuwE/eOawKSvRQIL8Z+qrTPuOD
	 nEhm7jVmQ/hMokN+4rI9924j55yBPxw3sf+LgcaDaYVhFN/hWGOuw0hjEaHKnYHU1Y
	 1EByIWY9rj5y5xt1xKalYhi+KdNX90cjFcHLaV1JuHX7inDwhkBbynOlwxkfgSkE4L
	 U7uXoaJpMPX2Q==
From: Yixun Lan <dlan@kernel.org>
Date: Thu, 12 Nov 2026 08:00:56 +0000
Subject: [PATCH v4 1/2] dt-bindings: power: spacemit: Add power domain
 controller IDs
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261112-04-k3-pm-support-v4-1-de3931aa5153@kernel.org>
References: <20261112-04-k3-pm-support-v4-0-de3931aa5153@kernel.org>
In-Reply-To: <20261112-04-k3-pm-support-v4-0-de3931aa5153@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>, 
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>
Cc: Icenowy Zheng <uwu@icenowy.me>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1980; i=dlan@kernel.org;
 h=from:subject:message-id; bh=ZGjBATuMj77MYSRucrBFIOVycrvyLdzdato4w2GM7iQ=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBq9XJFJRHeM+96J1XxoxUDOhiZQ7PxNdW2PQ0Sn
 IJLqlh44QSJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCavVyRRsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+1DuxAAhE9s65q1bXYp1hReThKLBqb8GyA6p3Y7+JDedJPLBUFOdOzfc6ugT
 h2Mylgd3QbT3c3oO4D2rQhfNuVJ2fXyTfHmtug08hhGrt0L9cQjA0399GU2DbOUBKKbLoNw3vaY
 WyxAuVWVILwsARTWT+uXm/kRnNtyVZAPqcEBXjk5lznKtuPlrLX15/mnxwIIb5+WISuEY6in04b
 pQFRfUNcl7mH4F06NpAQ96Z3IzoyaK+JRDVPvyEKzqG390giTDO3KDaH8rkTInT2+DpX4oRsqiW
 W8VRFbgRIK3NvVRIphReMKdJJYopq/vIw4etLrFYek8xMzA/tDaqUl/78AjL360/HPShcll+//F
 u52/F7UL9NV07kMc30ESQ8lbI/jKUy2mK0xSEZJSRunf6CnxkGpQzY9ftmfZYJFRxlcK4OgYoxS
 WOFkfvX4p7xGjLJn/hENvzqFgPA8PNu/BiFO/HRvQGHjCh/n7Ha4erRnCq09INyEt9VBbWqzc3r
 ghBqbSYd6f9frZZUEUb4AIf/NBOBSWzFC4nOTKbAUdGzvs82kmRBwKqYb+cW2+znMFzab2Mwxn1
 Yb1ny/FBX4DhSLCAqL1Z/KMjgxVRdcN3/U3kfUlDXbURuAhv1TNitOW5TpViUtklJjMA64u0b1R
 rhm9+gWVKzgGFmOjpof0ocGEPNhaEI=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Add initial power domain driver support for SpacemiT K1/K3 SoC, The Power
Domain Controller is SoC internal module which is part of APMU (Advanced
Power Management Unit), it is responsible for managing power across multi
power domains, which includes power on/off, isolation, power-on sequence.

The DT documentation for the power domains already exists in file of
spacemit,k1-syscon.yaml.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Tested-by: Iker Pedrosa <ikerpedrosam@gmail.com>
Reviewed-by: Iker Pedrosa <ikerpedrosam@gmail.com>
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

