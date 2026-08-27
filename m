Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAFBC483BD0;
	Thu, 27 Aug 2026 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787843293; cv=none; b=A1VSF9sHtRqVc+zerTZwFMXsOABLMk7iH0XGjMr1sPdhb2as0ea5dtzI68bWVt2APMOx8clo4P1SVmpBvaBp/bUzLPKSCJNFBSRt7ffbjM+HUa0jwsvkPFldXyxXYd1cqiR0NtTOX4e+Ug1eASAjszwWF9772jE6CVUuLqvzENE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787843293; c=relaxed/simple;
	bh=dVYvzEppO2pPUKYstsQdYN2jleJ3lqvLPQR5wwcusqA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sGGFJfYc8synHJtBbV+MvoGwGiauhitCpeZNBh0ffZeyrkPr/7XzOg9YedOh/DKNiow0VhkjCxermU3gtOtKtD+9s6vCxO5HvqdRm0lvjoX5ch1ghe+hXaDK5Y3sSb43tIn/vrZUaxcCiC0bNyR0JZlWiDnN+eJByR5E6EneH+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mD/xNTic; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mD/xNTic"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C9711F00A3A;
	Thu, 27 Aug 2026 15:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787843291;
	bh=REUiWLZBpAm8J9plb/EvFp2cF7Tg7aKKMbRLogplyT8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=mD/xNTicN4aze+5KV83nRJFflAicKt5gZAzIhM1gb7XATn1a0mKhQX/4WKCm5s2Bn
	 G6+D/7JrQabFdA1BON95x9SrkVVJj++/II/VDmKBnHZINad9uwZZZCzqzvz2SDRNTZ
	 0/uXp+u0gMQzLjMKyXzq1JL8AkfYidbqHA+fpW2zPZ4JqCivR5DzqoP046N7FToNv/
	 XCAqHA2q2yfUtQg5DJZqFjj02+6l7kx9i7gh6rdLP/jqOxkDalrEnXQYKxc1ZrhSGP
	 46Y3UStA/uAKpVecVm5GqV9rhC2KBWIyGGDEVvDpbiwGmA/1jg3xHItdvhLoaUta1g
	 Y7XNpS7kPA4JQ==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Thu, 27 Aug 2026 17:07:50 +0200
Subject: [PATCH 1/4] arm64: tegra: Add PWM fan on Jetson AGX Orin DevKit
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260827-tegra264-fan-v1-1-3c55f0c748b1@nvidia.com>
References: <20260827-tegra264-fan-v1-0-3c55f0c748b1@nvidia.com>
In-Reply-To: <20260827-tegra264-fan-v1-0-3c55f0c748b1@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Jonathan Hunter <jonathanh@nvidia.com>, 
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1166; i=treding@nvidia.com;
 h=from:subject:message-id; bh=RTy/4knbQgueNxfnsO/GoXlbqXxK6yhD8UYQSoiy2Zw=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqkFLVlX+VBwRsRDsCXjT22xZDEFdBzrPBgDdWp
 +/LU2kG4U6JAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCapBS1QAKCRDdI6zXfz6z
 oa7ED/4nDjDnM3RHQ2auCqSkjot6J2gai54r5gSTxRcrS5+vKwY6JCpojzt2NWOKG/I4X09124p
 HTUhvFkiDDG9vuDqN0+taOITI9fSPw+4qBPZZ2hXfcZwhyqlx4RrF+b+pDbyG0ig/Wtw8SBY6Db
 KA9iVTM/sA+w3xx30E8WL8GGSrVi6oVdpwsTmLEGQooK1xrDlurGqqWE6maooLUxdF1vSROqOI8
 w1kzcYS8X6x0x7AMuccBANNkRNoXIbeaYgT4Xb7liriDDgDPOoVxP/owHKIbdEEwEPqAPz6L/Ja
 0/JqQjbruA0uqfTgnz4ML78IQHtN7zNNMBnfNmu0ASZDAsNKNWT2KDCEE6kDOkQEQDMP4WYqWBV
 CjdSiXL5+o5YTQqCA4M5sELqXRdJWZeOvr5MVUXacx+Eth94yCgdzlioMA5UGOShdsPyxNMR/ss
 j+nVOYmn73gKh16dNhcIxlgMkSyQj1vrgVLdX8NG1ukWTEPsHKq+hGB8pPO64R3EGFSttsSHhC4
 R/Jg3R3YVojPt6JVeGFFolFGUFTjfN13poFVIlmLmtBX83tLLFEdNSrBDxiLq0t9rdFJt3YWfox
 a8TknXZ5XAcTsVs+O0qQtt2hV3HT68MafuvAWxdK4NT+MN2uzPSldqdQCR/VovRp7pjFIwVTVUQ
 r2vNyxzIrQNtgCw==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

Without a PWM fan device node to actively control the PWM, the fan will
either stop or run at full speed, depending on the state of the PWM when
the controller's clock gets turned off during boot.

One is bad for the system's lifetime and the other is very annoying for
anyone in close proximity to the device, so add the PWM fan in device
tree to fix this.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra264-p4071-0000+p3834.dtsi | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra264-p4071-0000+p3834.dtsi b/arch/arm64/boot/dts/nvidia/tegra264-p4071-0000+p3834.dtsi
index 45f8df9bbfd6..4550e843f513 100644
--- a/arch/arm64/boot/dts/nvidia/tegra264-p4071-0000+p3834.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra264-p4071-0000+p3834.dtsi
@@ -9,4 +9,17 @@ aliases {
 	chosen {
 		stdout-path = "serial0:115200n8";
 	};
+
+	bus@0 {
+		pwm@c6a0000 {
+			status = "okay";
+		};
+	};
+
+	fan: pwm-fan {
+		compatible = "pwm-fan";
+		cooling-levels = <77 102 140 192 255>;
+		pwms = <&pwm4 0 40000>;
+		#cooling-cells = <2>;
+	};
 };

-- 
2.55.0

