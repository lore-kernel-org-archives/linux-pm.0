Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D83D73C661D
	for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 11:02:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774868532; cv=none; b=frTGCFlFhWd9imsKAX1PKwqje4815TPjbFnXiYEzrG1czs7UWsM6573gRKjh/CpyAfYt9a3pZ4tsGnnW8fMrttdDspJeyEMwqRCzVazgkmC/RyMa7y51ryaT+udbEG3wnCv8se0TcFnEdcduwHdwLHs4KVMh14WRZVonb8RkehE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774868532; c=relaxed/simple;
	bh=mxrzICpe5NIe8GjG8dLZQudvhcALWguXqUHhxL6pajo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Io78HZOumwoIqPL0RYgdV1o1+Rfk4riiL7p6xEcAGfgYQaXVdhn1fZVTwFhMLaUCjnglY7ANRi58E/EvcHoQwgVxU/+IEw7q64oZjQb/H4pdZzfI5e6FbL4bp7Kf4gBua7FX4iJasDLVo3Fig5D0cvG34z7Ws1uR1gsAQSHnDcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EljSkCwG; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EljSkCwG"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2a7a9b8ed69so42872935ad.2
        for <linux-pm@vger.kernel.org>; Mon, 30 Mar 2026 04:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774868526; x=1775473326; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVSxqj5+EI9WDl5Sz6NGHvDhkfU3nzyVbqnqzEf09AE=;
        b=EljSkCwGHe33EG5TPHSsFeTKynciLg+bctTqTdHhQgmfn4/n79PWTz1xcsOmXWMcEl
         BR4XxxFtGD3J8zP/yOwoHBho9PlqUVd10f0zivop0I1jkNHXPWGwV6qdqISb8IErqbSP
         Y4ZpmudGwcKEECRC4fytDZRae1+wG3ksK+Ss1AQ9h+w9xHjUpJKNk6u5G61GkO2iNBji
         Ix13LgkHrTSw4ZLqXPzuASTxqGsnqwmht3eTckg/5iAxYe9yiNCaUvIOQ9/okWEGVneC
         2lK068IJAbpimJW9nHcbb5dW98QogjDedDXb5cjyCD93KXFrDbkAajfeSvIKwbBRet72
         q7aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774868526; x=1775473326;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YVSxqj5+EI9WDl5Sz6NGHvDhkfU3nzyVbqnqzEf09AE=;
        b=ULtK+M89xkFhIskyAApFLrSu5fNjj5002dN15ATkHiNzCE2imsf+DW7OVb9mdacFky
         /15145EuXWWI7aTHsH2z4nYd8ok1PXvM41Q/pCTOQzF8aMTzttBNe/ctNJgVDvT50csv
         0ECH7ghoW9CHUNZYHxE/PxxQWTwrgpMlPTGxeaAxlNEGDxRZCLNeEbRUziIsJubVlN23
         5utiR7D2WHp2X8u0bUfwrRVV+p2RSON9lXR0+77ETO6K17HY4nbT6VrKvcsLGnb0m+GU
         NbHf/Gbt0UbYI1JechKCN/Mv+3ViN8MTxL1qc8HW+ZCS+fyFpfgFPmfy2eh4xCv6K899
         wwsg==
X-Forwarded-Encrypted: i=1; AJvYcCU/GBCB1GiImPtI1Lyolq/ly44nCuMZyo5BMMfiPnGMeyAQ0qZ/Q2/wBQKp3kOYxrQee7VkuxZnRg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2pNFrhUAdGHRqQU1m6rj6RQN46I1BjJEJL2xPbx3v6xDj0jPF
	/BJn/anFhJsd/bqmAhBPxMSd8CuogeCQva7TgyAPIcSODMUhKVWd0sFh
X-Gm-Gg: ATEYQzxrGXL9NfqSWAZpVrFFevpOON5VfXBsZL/jNxzEsBTvYgMK8T3v9QuGZBcV6wo
	l4jtVOCC5rlE9/1ThjFIed+csFZne3lBfJxHtj97i1tRVy1ypq6W/8LFeNxpQDadgwEfQFucnwk
	90Mrieik5f9s/B7qebyFOBHNhe+DKhge71TrNnLliLf4sh11R3cioUxDPjrYr4Ury5TVLAw2Tj6
	UkuJv5Mt5dtPZE+p8XPJpxxoBN06psxb0elbd1b5mT3loKYbap02BgJ61kcg5MLj/aqZ9x1ZVHH
	BHNtl7/DHLQSPXi6dCiufaRLGYo4JknwReZLOvPucydk8LJpvjkOWjTiUdMfuYgMFco9kDMz7bk
	sWTylGLDHxbBnay4sbBpTOgOAqvEWw3lrtJQUVmSOKJ9gcpTTOLH3VQTOTl3m6+6oWADd6u6GGH
	DbqWJfKpX9azpaQ8oVd6XNaWiIlWkk/f4dcQIPyig=
X-Received: by 2002:a17:902:ef48:b0:2b2:470d:6d18 with SMTP id d9443c01a7336-2b2470d70bbmr78007655ad.8.1774868526411;
        Mon, 30 Mar 2026 04:02:06 -0700 (PDT)
Received: from snowman ([2401:4900:646d:9a6e:3eae:13fa:fe3c:864])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b24279113fsm77701375ad.60.2026.03.30.04.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Mar 2026 04:02:06 -0700 (PDT)
From: Khushal Chitturi <khushalchitturi@gmail.com>
To: sre@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	ulli.kroll@googlemail.com,
	linusw@kernel.org
Cc: daniel.baluta@nxp.com,
	simona.toaca@nxp.com,
	d-gole@ti.com,
	m-chawdhry@ti.com,
	linux-pm@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Khushal Chitturi <khushalchitturi@gmail.com>
Subject: [PATCH v3 2/2] ARM: dts: gemini: Rename power controller node to poweroff
Date: Mon, 30 Mar 2026 16:31:35 +0530
Message-ID: <20260330110135.10316-3-khushalchitturi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330110135.10316-1-khushalchitturi@gmail.com>
References: <20260330110135.10316-1-khushalchitturi@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update the node name for the Cortina Gemini power controller from
power-controller to poweroff since node "power controller" is
reserved for power domain controller.

Signed-off-by: Khushal Chitturi <khushalchitturi@gmail.com>
---
Changelog:
v2 -> v3:
- Used generic node name "poweroff" instead of "gemini-poweroff".

 arch/arm/boot/dts/gemini/gemini.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/gemini/gemini.dtsi b/arch/arm/boot/dts/gemini/gemini.dtsi
index befe322bd7de..910faabf76ef 100644
--- a/arch/arm/boot/dts/gemini/gemini.dtsi
+++ b/arch/arm/boot/dts/gemini/gemini.dtsi
@@ -228,7 +228,7 @@ intcon: interrupt-controller@48000000 {
 			#interrupt-cells = <2>;
 		};
 
-		power-controller@4b000000 {
+		poweroff@4b000000 {
 			compatible = "cortina,gemini-power-controller";
 			reg = <0x4b000000 0x100>;
 			interrupts = <26 IRQ_TYPE_EDGE_RISING>;
-- 
2.53.0

