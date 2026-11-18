Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795043622;
	b=dHMhbOe+khS9w5f3Z2qMmjlf8N9BbiA/KuZ9zzTaaZPIR2DPqnLCCT3NgcMTjRDBdhuL
	 6rQHhMldqJhWHyG2Yiati8rohcqwot5YMImIyggN3s8Ho9Nii0ZmuSjjyxR0HTs4dUwDr
	 Lj8NcgNAtR3X+04gobq7zxf5W94qkyXjpYqvziNeqt+3PMozfYfll7014lzRmHpSwrPRp
	 HNlTdtO3eRKH+sT5oLhNrcZZzIaTNm/UNmwxc1ADLN3Olb8jggWRLj5Hdz8nQc3z6rdp3
	 NN1cG12XqM1lSOVIGxYZYEbFXlpqYXPrrA2DvAtT+O8gE6bUhwa+Y70/VWEciB0ALrg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795043622;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=Ho/SJRRXKfR8E8InR6yIipzjTEX73uVp+KDQpwqfDkg=;
	b=XstLf129ElnQKoDflmJ1eVIvGCpPWjLnz7J7PL66cGyADTwNhwfds1nBdLO+kUHLSG+i
	 GWAuJ8bOH2SeNtqTXmL8CL2pzfWERli2uuDoCiRKQFJcOKXmjH1zGKsTv1q9GAFOgPgD5
	 +zIeHiZZ5hg2UKKX5LJifcptddL6aYmNz7nTlAnsvrypBCQDsgIkzHLGJoT9vDal9/Qbb
	 Ymwb5cdCFf1cCpZwU1TfEJZkmkz5+lf7Wt8Is8tpONTax5SzgJOuG6fmrACSFpC6dpd8d
	 75r/ee5xaYViRCi+PvPVbXqWfzFZ0bRX8+ucP+sGiu+23NLg1ThyHnmM0PacTaYLJig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMpa0cuf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2068B606A32C;
	Wed, 18 Nov 2026 23:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cMpa0cuf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6E4E1F000C8;
	Wed, 18 Nov 2026 23:13:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795043621;
	bh=Ho/SJRRXKfR8E8InR6yIipzjTEX73uVp+KDQpwqfDkg=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=cMpa0cufPC6YaznjOGX3iUfWZXjMd/fGC3mfBNkREFkGVeMe/ADk7NOoTux1FdylL
	 Qa5KSMD+pB45qc9zcUU3kGCKniViSWI6ya3u5aRy1AbO9RNpWfFMqP5eyHLLe4W//i
	 Iqh4Zxy6ZQjVjEMPMGMG1+SxDoXvIjO50eusH2zYvWb93bklN2FoSHffz/tPDASoOo
	 gEw3T57r5Fyk/hEdUjsp5FSKU1bfBImR7VbrFS8OKGcFBD7WalFq5rbLAnIxTwHlFd
	 cjZMPUzUkYeBX/g3QUypGXWj7tKLqo4ELpiwuDImRH1omRShVSV545fppvwH8w8zuj
	 7lwjdsxLdm2RQ==
From: Yixun Lan <dlan@kernel.org>
Date: Wed, 18 Nov 2026 23:13:09 +0000
Subject: [PATCH v5 1/2] dt-bindings: power: spacemit: Add power domain
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
Message-Id: <20261118-04-k3-pm-support-v5-1-42394acdf3e3@kernel.org>
References: <20261118-04-k3-pm-support-v5-0-42394acdf3e3@kernel.org>
In-Reply-To: <20261118-04-k3-pm-support-v5-0-42394acdf3e3@kernel.org>
To: Ulf Hansson <ulfh@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Paul Walmsley <pjw@kernel.org>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Alexandre Ghiti <alex@ghiti.fr>
Cc: Icenowy Zheng <uwu@icenowy.me>, Iker Pedrosa <ikerpedrosam@gmail.com>, 
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org, 
 spacemit@lists.linux.dev, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yixun Lan <dlan@kernel.org>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1980; i=dlan@kernel.org;
 h=from:subject:message-id; bh=ZGjBATuMj77MYSRucrBFIOVycrvyLdzdato4w2GM7iQ=;
 b=owEB6QIW/ZANAwAKATGq6kdZTbvtAcsmYgBq/jEYKpohQR0yGCw9uurxNdJ+PnPPuBjTE9t2t
 t/WMFrC17uJAq8EAAEKAJkWIQS1urjJwxtxFWcCI9wxqupHWU277QUCav4xGBsUgAAAAAAEAA5t
 YW51MiwyLjUrMS4xMiwyLDJfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5
 maWZ0aGhvcnNlbWFuLm5ldEI1QkFCOEM5QzMxQjcxMTU2NzAyMjNEQzMxQUFFQTQ3NTk0REJCRU
 QACgkQMarqR1lNu+0AKw/+Me+ttXcHAtQDVIGYrjzbLgVr+AYEkQhZRsOanhjx54j9RiOM8g20W
 3IoQTiF9n2QCkHPhbhI0zh9MYN9d9ZMSYlVBUoajkMFnDbAHQuVC/adX60XiFLvEOimIpqywNiV
 YcsqmI9urhcSUP72Y6ah3jc3yB1LiBnJeAkXBpzb6j1ttEt2dh3h8546lgo3b6nssWC2SxzpYHy
 WAXOYNaDrCf6tTdu89QrIGagY7nwN51mJNvlz5NULVtAZvfONZdP7YftsWKKYw6bu1awGuMfFVa
 VolnpcxelgTRaKE5wNnnU33kDDlf4ulS3hrMNsFuII16jmcRc/LL+G1DoP0iPnszP64wgSa10i+
 faJkdxkZhN7zfYth8bZQha1LoSSHNlwUDuOTAHN8/tplZpAteM86dDlSP6tAT6HnV/ZB1ikSbHs
 9AhMCkNhzswoQt8ijdHyXJXRfW9apFO8CcK+ZU+kCeyWQER7yCN/6EN/vQejEDdRfVM5EIc1DgY
 USRXBOjT7uyYPnlpY2hTKZ1tn2kMBAzxnCULT6RlaCsIGT8hVaUw4mS63+yjsTl7dX5Ti+GBPVn
 6fsPYQ7Wmbl/AxEI0rEMUV2WvVQeX/y+rLNx/6uG2wOsxtnPHahJ/MylYNffE4fGH9oPXdLm79Q
 Nvc9qxLyhl8+kHpnP60Rltfs4xMDrA=
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

