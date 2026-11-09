Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=217.140.110.172
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794266087;
	b=JFOXJAWWdHlmDIvIjZTpvVatmIirWPERxyKd7jCUYoO+8PxG4M1DiotAGzl3FfeLNFKi
	 jPnslTBNeGyikKgwNFr9k3uJoq7gfYz0he+Foi4QFWo4ZsVt3vFncDEwvJcQSzeY3x+vM
	 mPsXxSzJi674k517GKd3nKKgtT6TRdnmNbzI3BK4Too9pDNuMEeRwklztw9cTYOB8+7Vn
	 It1Xa5k43TOAVX/8BE5PAgfF3sCTmwz4lMN3rRd/1/1pNS3jqEHnSgIDXQ8gk/CzRNmxQ
	 P6Dj7JuWPju8ReT4Sbo2Jq7hGqFBuqNY7WB+QJyxn98zUJBdoN1n1cxMwPC/3EGo5bA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794266087;
	h=DMARC-Filter:Received:Received:DKIM-Signature:Message-ID:Date:
	 MIME-Version:User-Agent:Content-Language:To:Cc:From:Subject:
	 Content-Type:Content-Transfer-Encoding;
	bh=xO8dFUoBRR9b7E/mrB9TZ8z7Z5xIk3tDb0/zKRmdy5Y=;
	b=GiL3NeQ8ssF+8C5Y/rJdKjhGuoGhVqo2Fu3hbCw/HsyyqtVvG5yYF9g+POrRX30Kd83M
	 yrzfXfnc/uUdUP2yr4InMIm5RNkm/meAAGorhxd1q6eUHXLNC3hKyNUEAm7AToWOmWa+p
	 F50zuQuf4B0LGFgPJ0k89V4u80vKW7wOOW/MbaknRH4jDNKEp4vYyat2sc9fNnnvozf+Q
	 lrIm748+iHXIpIfBtFOo/AJetfijcl7X6gEEEn1f4kxX782yz08R9z2iuhehqM6gXavv+
	 gEkt0USGYHg/RhX6ATkl04cIT3b9RNdswIvhjXhSDJ0LOASdWxt+NGRsbUg0LA61nFg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=arm.com;
	spf=pass smtp.mailfrom=arm.com;
	dkim=pass header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YcXnbZ6p;
	arc=none smtp.remote-ip=217.140.110.172
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D9C606A31C;
	Mon,  9 Nov 2026 23:14:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 93D9C606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.a=rsa-sha256 header.s=foss header.b=YcXnbZ6p
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8199814BF;
	Mon,  9 Nov 2026 15:14:41 -0800 (PST)
Received: from [10.57.15.53] (unknown [10.57.15.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 970C83F673;
	Mon,  9 Nov 2026 15:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1794266084; bh=NkzW5f+kNTE4U0DBYZJpDW7ShTOf++Eh75jUsIC5Z0w=;
	h=Date:To:Cc:From:Subject:From;
	b=YcXnbZ6ph+iQ9YYrNjmzipTyAfvWZR0xl7nKfZ+c/9pfN6XXpPEjAizStkH2ClCC9
	 dd8EvDw3iqvvdHHy/WRobh2aZ/4aOzg/FxmxlXdki+eCBq4YtAyeWYIOqnppLcdv66
	 D2wwas/yZow+hEeYse4Rbnt8Ss8IdPhx59v3lx98=
Message-ID: <e93f0875-7350-4208-b91a-4aeda1fa7cd7@arm.com>
Date: Mon, 9 Nov 2026 23:14:41 +0000
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: amitsd@google.com, sre@kernel.org
Cc: linux-pm <linux-pm@vger.kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From: Christian Loehle <christian.loehle@arm.com>
Subject: [PATCH] power: supply: max77759: initialize registration,
 configurations
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Booting a Pixel 6 with CONFIG_INIT_STACK_NONE can oops in
internal_create_group() while probing the MAX77759 charger. The probe
only initializes fwnode and drv_data in its automatic power_supply_config.
The power-supply core copies the uninitialized attr_grp into dev->groups,
allowing sysfs to follow an invalid attribute-group pointer.
The local regulator_config is also only partly initialized. Its unused
init_data, regmap and ena_gpiod fields can be consumed by regulator core.
Parsing the device tree does not initialize all of these fields.

Zero-initialize them both configurations before used fields are
assigned.

Fixes: 70d7dd27f6dc ("power: supply: max77759: add charger driver")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Loehle <christian.loehle@arm.com>
---
 drivers/power/supply/max77759_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/max77759_charger.c b/drivers/power/supply/max77759_charger.c
index a93adb266f01..e792327ff14f 100644
--- a/drivers/power/supply/max77759_charger.c
+++ b/drivers/power/supply/max77759_charger.c
@@ -683,8 +683,8 @@ static void max_tcpci_unregister_psy_notifier(void *nb)
 
 static int max77759_charger_probe(struct platform_device *pdev)
 {
-	struct regulator_config chgin_otg_reg_cfg;
-	struct power_supply_config psy_cfg;
+	struct regulator_config chgin_otg_reg_cfg = {};
+	struct power_supply_config psy_cfg = {};
 	struct device *dev = &pdev->dev;
 	struct max77759_charger *chg;
 	int ret;
-- 
2.34.1
