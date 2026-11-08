Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794134181;
	b=UKxY4HxzOMaE4YDj/CZZ5hkdCrKkOZ3lni08ZkzDYzpcVB1Ecbf/5YP6YfbOn5KbOAsT
	 rhGWFbF2Gnq3Gw8UR+ta00RarTKiHkBg/gmDt0/5vwEisk8CNQz6unP9D0k/3ws6u6Xxf
	 ilSDOzoTZM+c0t24B8ZtrQh4tKQRjCc45mZIEie+cHZ2Xboq/v5sIw5guEgAa3jPaWn8L
	 crqQPShI7n89UdPOgZ2EBFGNFSKNFvB0O5Qp+bfK0mmlD+4sh6jPNKwIab9DeT8QiiO29
	 0mL++bumJrxlTVGXxDZdISFuY972o9NH03Prad6nxyrIhyA6wa2Ucm3ODqjynUmYLzQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794134181;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=KK9NjKBQVwDD/CXpCVVduyC6A+LtlFiYYxKc6QYa3Bo=;
	b=1lo4ATpsPMSJXVcAgvpvLF+mNgt+0BlFBTWB+QnCS1Xa05HdEMtbcfkcWXjnT6U6kDdv
	 f3vmkLpfKTUM2zNBbAXqaVrhlAgllly7AG3+p+QvC024ylV9wC2a5WpCbyo8cWix48o1w
	 STRiLQrmAhu+NDD4oVzrR4ueZxgS94fdxDhlCLAyDaQwJX8YWCAEsw6i097iEWZCMPUGx
	 Pg6bXhAQyO/hXZuDyC+sGIHaZRYDGgWdPfLvXiXR3Rv2HS8fiIven1EKwiQ9QIy/j2BTn
	 kfdSqwyS2khgCBwSebDkRCqfzqC4ruPVHSnHN6Q5dGf6+HC1pCjYbcDFEefo/ZDVE0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ujz7Wsxz;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC506606A31C;
	Sun,  8 Nov 2026 10:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ujz7Wsxz
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A90E31F008A1;
	Sun,  8 Nov 2026 10:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794134180;
	bh=KK9NjKBQVwDD/CXpCVVduyC6A+LtlFiYYxKc6QYa3Bo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Ujz7WsxzEzpfr2LWtiW1c7aqJSFeBlPUl4DWAtQZqLSmdnphhk/gCS+eJfEKIo9Rk
	 WU42X+Dy24oIjDYG7kZebObH8embKD8S+3a1CYGfiSZ4wa/MMOm27ZbgWdesNcyC7y
	 TkkhCNX60GHT8fvsxWQB5kVdQupBuYAim+6PdC481ZbdM9ghJ6Dk6iSz8ODaXoHEGt
	 EqjE7es5dhDDcIUGO7iseUcsKNj7jZYvUOZR+Uexxn+Er3heICJOo3qeWGN8sFXy/K
	 PJbP0KPKWzT3WX2HbhNtNBWRaI/TzFIHvsARKbjt3UMCk96C3m48/sRs+HGE3xrhCI
	 a5duPF8WRLAAg==
From: Yixun Lan <dlan@kernel.org>
Date: Sun, 08 Nov 2026 10:36:01 +0000
Subject: [PATCH v3 1/2] dt-bindings: power: spacemit: Add power domain
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
Message-Id: <20261108-04-k3-pm-support-v3-1-b9dc0857039b@kernel.org>
References: <20261108-04-k3-pm-support-v3-0-b9dc0857039b@kernel.org>
In-Reply-To: <20261108-04-k3-pm-support-v3-0-b9dc0857039b@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1878; i=dlan@kernel.org;
 h=from:subject:message-id; bh=5A3P3lNyfLxpWqu9V/0ASbTdE7gwL6dSptdYzkszeFk=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBq8FCWIamQTn7+yPfQcaEcSjMrBuFi8AXoSGsx4
 KgpDA93b4aJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCavBQlhsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+3tjQ/+MWDSOSxb7zCV4jtiy4KsdOBfTgVWxfqDSQwm3bNzdkvwtajtA2Hkk
 xUb0EX67nh9FIFRfUZFoxjiO7iDj/cpH01YbPLnitLHVLWp1XqcS8tRYcriAkEMylul+9v8EoAg
 2dW+arWwPw8QEqoWlDnDZPAiIpLyyxP1goTwABthVAqsHOBlOj5QDpi3Fxlaor82d+p/MuV0xxk
 CNLpZyiAAM7ucNhVkGt4QG0cigEkyKsEJvXsdkUsdtfButUo1rqyeCGRKJ41TyOElnOP+fLv06S
 rAJp639xL18Wcr5hKKdtEEvl9Ba47xQb1OQCp0W/XCTnxLuHB9qQvstAa5e80cm4+wdlyBeEpbL
 R7Cf9M5GYfy5syd7dYVpruRpAPsYehLo+rTzZS55xCXNwZUr4DgDu5vRsyT/Wt40RFX87WoFR7Y
 gouGgchIMuBJccbcooBUJu0ElCZSGzsxn7sjhX/eZysD9ycge/nq+yoXW7UcY6mMnnUW7x5hGae
 PNJ1RlIWx/pWwMp8Z1nAxp1iMHS/XmNL0ESYqkuqTjL5Uu06EhtBfDhGekhHDfUWa9RU57bh/F4
 3OaxrRxN6aoc0HcFNHJCdcTYSOXUqbCpiteuJaj/ZyyQ6y0DsKdd/ruxinh3+wRWw7WpY4qwSJI
 zs0Ms0YG/q57iFpEICruTmbiUECIeo=
X-Developer-Key: i=dlan@kernel.org; a=openpgp;
 fpr=50B03A1A5CBCD33576EF8CD7920C0DBCAABEFD55

Add initial power domain driver support for SpacemiT K1/K3 SoC, The Power
Domain Controller is SoC internal module which is part of APMU (Advanced
Power Management Unit), it is responsible for managing power across multi
power domains, which includes power on/off, isolation, power-on sequence.

The DT documentation for the power domains already exists in file of
spacemit,k1-syscon.yaml.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
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

