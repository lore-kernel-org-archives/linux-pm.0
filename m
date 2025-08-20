Received: from fllvem-ot04.ext.ti.com (fllvem-ot04.ext.ti.com [198.47.19.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 225162737F6;
	Wed, 20 Aug 2025 08:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755678856; cv=none; b=oEnsj/R3RQ9iGjj0H+rcvZybqQV2PJXTdcYoP7FO+REMPCimXQXzsjO5SNUJeuKJKHUk4KbbstqAtnulWGjJfNPplZhn0elatpTCKiGUqfnPQCq3EqNWU64jjeLLgTK7HSS2zddML521t8zYpHGpw97b4b/Jy6TIrUcp7zr7Xjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755678856; c=relaxed/simple;
	bh=of8447HiVJqRdz4rv0HNn1rtX19Kf8ihqdRTHGviwlw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lXJL4rorQNQMeNlFNGc6mKEJJU/Ich+n6K7uTwij0XYg8b8HPDZ4aRIZ+Fztr/LLjkw4Wmh1Gh/6BNW7xThjR87smC95DHz3J90AQUojbVfg1aigZd9eK+i9LRggiYm7OFKSu1dTQHIa9cr3cup9bStKlAPCwByB0W99EF3KNak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=mHqr3Kz4; arc=none smtp.client-ip=198.47.19.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="mHqr3Kz4"
Received: from lelvem-sh02.itg.ti.com ([10.180.78.226])
	by fllvem-ot04.ext.ti.com (8.15.2/8.15.2) with ESMTP id 57K8Y8H7207845;
	Wed, 20 Aug 2025 03:34:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1755678848;
	bh=vUBXrqvedfpHBtOjp4aTmMMFWcJbSWrEMa3VFNLD1mY=;
	h=From:To:CC:Subject:Date:In-Reply-To:References;
	b=mHqr3Kz4/YqUjVRw5hJfQwR3HgK2s8pnnU7wXfk5pM/PgUW+WGcXl0OUU4bH64dP9
	 zXKOVKdTzGYnoFkbnjREX7Z3vFbJRMSgJx1ODtoMCHY+jwhfWydW1ao+jsP0JuLJar
	 kUhcAxNaWhyvsmlncMds5pNPU585pssFl3oZgqOA=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
	by lelvem-sh02.itg.ti.com (8.18.1/8.18.1) with ESMTPS id 57K8Y87q1661123
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=FAIL);
	Wed, 20 Aug 2025 03:34:08 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55; Wed, 20
 Aug 2025 03:34:07 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.55 via
 Frontend Transport; Wed, 20 Aug 2025 03:34:07 -0500
Received: from localhost (ula0502350.dhcp.ti.com [172.24.233.249])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 57K8Y6dJ4133686;
	Wed, 20 Aug 2025 03:34:07 -0500
From: Paresh Bhagat <p-bhagat@ti.com>
To: <nm@ti.com>, <vigneshr@ti.com>, <praneeth@ti.com>
CC: <kristo@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <rafael@kernel.org>, <viresh.kumar@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
        <khasim@ti.com>, <v-singh1@ti.com>, <afd@ti.com>, <bb@ti.com>,
        <s-vadapalli@ti.com>
Subject: [PATCH 1/4] arm64: dts: ti: k3-am62a-main: Fix pinctrl properties
Date: Wed, 20 Aug 2025 14:03:28 +0530
Message-ID: <20250820083331.3412378-2-p-bhagat@ti.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820083331.3412378-1-p-bhagat@ti.com>
References: <20250820083331.3412378-1-p-bhagat@ti.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea

From: Vibhore Vardhan <vibhore@ti.com>

Correct reg length to match end address - start address for main
PADCFG registers.

Signed-off-by: Vibhore Vardhan <vibhore@ti.com>
Signed-off-by: Paresh Bhagat <p-bhagat@ti.com>
---
 arch/arm64/boot/dts/ti/k3-am62a-main.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
index 9cad79d7bbc1..260279702c01 100644
--- a/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am62a-main.dtsi
@@ -267,7 +267,7 @@ secure_proxy_sa3: mailbox@43600000 {
 
 	main_pmx0: pinctrl@f4000 {
 		compatible = "pinctrl-single";
-		reg = <0x00 0xf4000 0x00 0x2ac>;
+		reg = <0x00 0xf4000 0x00 0x25c>;
 		#pinctrl-cells = <1>;
 		pinctrl-single,register-width = <32>;
 		pinctrl-single,function-mask = <0xffffffff>;
-- 
2.34.1

