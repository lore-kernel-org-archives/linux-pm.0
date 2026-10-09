Received: from mail-qk2-f6.google.com (mail-qk2-f6.google.com [74.125.230.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57D5250C2B5
	for <linux-pm@vger.kernel.org>; Fri,  9 Oct 2026 18:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570720; cv=none; b=qWuOsRbqp7dLx/ZWGvBgWhhlNv61cdvneUXtobNm4v5oGGjDDCcNtKumqt+W1Ec4taXF+L2l0tvwbX5eQdCs9ZqEN59mPWHNXlL0EmTXRBhsX0yksUDq+4RCQyCoX9rk280jSOH7FtfIAEfMCoYJDU6nSGzduj0r9a0ZnlcLO2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570720; c=relaxed/simple;
	bh=LyDjS/8+V+if69g/8tSmRRGt/NJFu3rP46F002zZ4Cs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SC0n9EQdx3s2j+L8qChIJ3tr0AiThXXSlyYXPu24lqSdGFzPjPp78CXdd+4sdvo3SmPrrcOFg79A9YbP36uiFwq23ffFZKnSo+deOXPzVfo78CQdAyZ1evStA/16BPlAQDOELllOOVO1OWU+71QbGUKSy8yMX6m+d4sPiAtivxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bc0/u3Gx; arc=none smtp.client-ip=74.125.230.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bc0/u3Gx"
Received: by mail-qk2-f6.google.com with SMTP id af79cd13be357-93bfb25817cso521769085a.0
        for <linux-pm@vger.kernel.org>; Fri, 09 Oct 2026 11:31:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791570716; x=1792175516; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=t3TR1mx/d+lJPdCos6SlZvIHemcM3rDJJZi+7utetLY=;
        b=bc0/u3GxHfiZhcBjk++0zACLW2yFi0JL45fOEXlahYX6MKqxS6PXG4lNCB8TRamlxd
         9mWp9Z+ICqk3s/EmXo7bvxSG7bWxhuSAdRW/41lyD0YW81gIEwWhfEGdPPbAUl1U+co5
         MioDLXx1fsgqC4oi2hbNZzM0uaeMsMjixLcD+IeEFaovw4NgtbVOc2+l/EZ19L7siqcE
         ai0ZRenOfauZfk960i4C+R2NzwZ8mK4ozKmNjv4dNSMDT5t0G4AZozI5UG9EwLj8ktSA
         zjSX+U8aEYk7BKqaMh7KDIoGO/Y8oppHeec+9gsJ4O5XvdO6GxUTU0TackY9EoyKNQ3Z
         NWsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791570716; x=1792175516;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=t3TR1mx/d+lJPdCos6SlZvIHemcM3rDJJZi+7utetLY=;
        b=dVHdRhWBi1Pd5MKVoJBNeTjqRUO66akqwZAbz42ST4+bRveka+cd2l7Hn8RGRjv/lR
         PErGRSV/k0bHatyNjvHshj5XHlQNQYd9K4/KX0VX0bvqy0TiTV1GOWMxRxvXs2Kp0UAC
         bMgJgCaKnsX2f60y8JyAvBYIsIRiu1cXfUhI4A2Wz/ndGHdkN9sK1/+TmuY5XAxk8Or0
         kDyPRHY1kMkiZH4Abg4fm8Z43SWRuV4+qzN7WzeEUn86T9OxAReHWwJnU6VxDpJe+58z
         zwXedBp2cVI7iuwdw+wJ7Rth43UqYZRtjjR86ZPrcxLLRDBHEAn9/5nisvhfxw21YZHW
         r9TA==
X-Forwarded-Encrypted: i=1; AKwUvByC2pUVI64JscPUK+0wk5qBELHzg5uRh2K0v0WPUVN4fMq5XMxgfFmvqIuKdImDN9tMbDZW2KWEog==@vger.kernel.org
X-Gm-Message-State: AFq9FYIA78aBFwMgPbhilwKFZKN5W15PL91iGQgsvXQNYn4KqfuYhPIn
	QHZwGG6cIUh+7Wb5rK5q1rUJss6BELKDMgeVWu/nsnH1SfroOWXWgPiV
X-Gm-Gg: AYBFou0MxO4tcVyQYUPjxmJa6C3umchdOYtIJEh8Scy2noC6Mi6V71hST6QNR+X64HA
	GW5Zq5+fhoYy0kLgNbX+QSBNi66VyKzBYJToIuBs0C6j9jx8MO6Qhe427flZVbnZiXyz0EX6fCv
	8ln02sjWZ/zIM+jce/ViHHcPH93FjXTlwBVdnbNn40oUGbxgMrPI1f4ZF4ruwcv386cnGcxEJVP
	gM15KGvMCz44hEVRC6VxoP6aJCMvnMHRi0UgEXNnONmfl3beLGZQ94T8QisBuaYcCvSvIcvsvGF
	5cz3gmhAVOJxtzYp1xHaitTKSsKvVYRFOBDyPvifp86jj+hopmo9rpSrYX68M78xDZ5vOddCDOl
	7/0V1MGBCOsagf6T7ImibmjMJ7NGxbFGDGJQQBh4k4WfsnNnprf0oFgYMUDG8urciDzVJQi84N6
	Nr3uVCYgK0UtU+1kLQRB2G02fJgX9fUgtdT+S7NM78eV/fYqL4XGwMhYfmGpjzIXa2/QY2kYZkD
	lBjoMz1hP0k01clLL3Jyj1ty7cldXHGbKWO3L/V6qJZKGZ/qWV5Dd2cdcNwhn4ozWKp4UufBgg=
X-Received: by 2002:a05:620a:2719:b0:93e:c12c:9b6a with SMTP id af79cd13be357-93ec12c9ec2mr324347685a.69.1791570716065;
        Fri, 09 Oct 2026 11:31:56 -0700 (PDT)
Received: from [10.10.18.223] (wsip-64-207-253-118.tu.ok.cox.net. [64.207.253.118])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-93eb9898b5fsm245594685a.32.2026.10.09.11.31.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Oct 2026 11:31:55 -0700 (PDT)
From: Ryan Brue <ryanbrue.dev@gmail.com>
Date: Fri, 09 Oct 2026 13:31:47 -0500
Subject: [PATCH 2/2] arm64: dts: mediatek: mt8173: Mark the lowest CPU OPPs
 for suspend
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261009-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-v1-2-9100f79b4080@gmail.com>
References: <20261009-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-v1-0-9100f79b4080@gmail.com>
In-Reply-To: <20261009-rbrue-suez-upstreaming-mtk-cpufreq-suspend-opp-v1-0-9100f79b4080@gmail.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, 
 Viresh Kumar <viresh.kumar@linaro.org>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: Roman Vivchar <rva333@protonmail.com>, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791570710; l=1226;
 i=ryanbrue.dev@gmail.com; s=20260906; h=from:subject:message-id;
 bh=LyDjS/8+V+if69g/8tSmRRGt/NJFu3rP46F002zZ4Cs=;
 b=J47TQSnGOTnk7vsmC3v8Kas19C3nd1y/Zu6+lW8xPqNDlmOqarof7ubUNN1IzHNMZfvh7R48y
 usvOVSj7ssJB5+xrCWh60GlbUy9459bvWBzwCVFOTeRmefrkRGhAbr5
X-Developer-Key: i=ryanbrue.dev@gmail.com; a=ed25519;
 pk=KsUvVaP//v/2q+ZBuacc7cLbsyEYn+AD71Sn28oZWKo=

Both clusters otherwise enter system sleep at whatever OPP the governor
last chose. On the Amazon Fire HD 10 (2017), entering suspend-to-RAM with
both clusters at their highest OPP measured 63.5 mA, against 52.0 mA
when they suspend at 507 MHz. Mark the 507 MHz OPP of each cluster, the
lowest in both tables, as the one to suspend at. mediatek-cpufreq uses
it for system sleep, and a kernel without that support ignores it.

Assisted-by: LLM
---
 arch/arm64/boot/dts/mediatek/mt8173.dtsi | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/mediatek/mt8173.dtsi b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
index 78c2ccd5be13..7f1af15cb934 100644
--- a/arch/arm64/boot/dts/mediatek/mt8173.dtsi
+++ b/arch/arm64/boot/dts/mediatek/mt8173.dtsi
@@ -56,6 +56,7 @@ cluster0_opp: opp-table-0 {
 		opp-507000000 {
 			opp-hz = /bits/ 64 <507000000>;
 			opp-microvolt = <859000>;
+			opp-suspend;
 		};
 		opp-702000000 {
 			opp-hz = /bits/ 64 <702000000>;
@@ -93,6 +94,7 @@ cluster1_opp: opp-table-1 {
 		opp-507000000 {
 			opp-hz = /bits/ 64 <507000000>;
 			opp-microvolt = <828000>;
+			opp-suspend;
 		};
 		opp-702000000 {
 			opp-hz = /bits/ 64 <702000000>;

-- 
2.55.0

