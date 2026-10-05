Received: from TYVP286CU001.outbound.protection.outlook.com (mail-japaneastazon11011064.outbound.protection.outlook.com [52.101.125.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11E1F442391;
	Mon,  5 Oct 2026 11:12:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.125.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791198728; cv=fail; b=WRkt6Kp7/lLyK7qfqNIjDFuF14iq5F6Vumwd8lx4IFMdTOZiMHY/IjlGrv5D04W7VfXjPET0TA1nG6E5PhDdM/DTBjbfAb1Uo8jWcOKtwkuo7vTROKNAIIcp/ek64UEm5JGUkETePQ1tGpvGshFQLkAtdeqexznY0DgYZKmCQN4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791198728; c=relaxed/simple;
	bh=GQUlFJmOCc01IdixbOjCgHJr6+jIPZypHvNtnv0p8m4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BPzIWqjvIU4MWTRLpv6p/PLskrZa9cS5Oi1+GPsaba4scDQ1gbj9qsDdF0kr5i9ccNufmtGJW/v+Mf/k+e6eW6cwuuM2EvNmXWy8KVQE3EQXrz6ADT7Wv2MNMy//9HUK3FWBcFR12eQPuctXWE8wYnEwo44mSU1BQ2S9EG6X11I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=Dtbu0dDA; arc=fail smtp.client-ip=52.101.125.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="Dtbu0dDA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I7ZLgPxy8dk1L3y9X+eWtClZzSH+/fzieO7q+CWBjBL/Jf/83Rmqw8GwSjJ1XwqBV7gm0Mrm4IJcUEr1YPbRgYNM44xc84uLof42Z0bMUAyqK19BFcsW6v6nch1Hdbhwishgd45CBFN7vLIVWQ1/MEx4I5ixJU1ClCzjCOCC3XIalieB4EXYjrZybaGOlAs3yctmT/nfSsG2CkqBw9Z4E2KcA+WUsknqpqWcbROP3NtUySXjjI8GDoXJyOUGTmYjmS2ikKTaw0P6adSCa3jYcR/FnRi6Etd5wVmmmJlmDB/hjjBx907dWfan47BmgR6NGoK/btavBw2IXHF0FSns+w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=h9ytrOFiFo+NIx2j8VTBsaezlQP3ya78mYawVb3DTMg=;
 b=vJBZ+xTRErqGiRABKfvbInGhUTgJDGTUNqPEpcmhR25LSMF7lvmR1LTQALOQcZ5qWO/R6eCHsRhsiA82o/TDrhBM5NijyaGfbDCanbiabt6aXxDmy3kLNjfR3eZ8OkQWOyvHBSs+OKhN0cPacQdI1TkYVYbSO5Knug/HQN3pYm6nHXbvg2eHiv92qnumR7YxfsODvLgPBB6OFkbrVlaxiP82aLnfk0NASTEL9xORocIlkIU8bIVWldiapjy8SrSp4KjFlXC5XkMbH6BZBoumgoczdRdyNMpgNME+bgQf2bRoE8uYh6uBWcIRU6aci/QWACZKOtWmPlEz3lLug+aBrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=kernel.org smtp.mailfrom=renesas.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=renesas.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h9ytrOFiFo+NIx2j8VTBsaezlQP3ya78mYawVb3DTMg=;
 b=Dtbu0dDAc1hXMLp9CAeCO/IBzF0wY8JLwL/QdmixF6k3Kgo5ACp++A97ektuXDv8yn50ePaj/iLxDhAgVMCfpps9KzMsL+HvPzVoQiOASFfXGTlakcbyOHpmbAxtUHs8Wpf/TKC9XMnkL97rNluLC54HF+o8ASMFq9qZidBBaBs=
Received: from TY4P301CA0044.JPNP301.PROD.OUTLOOK.COM (2603:1096:405:36b::8)
 by OS9PR01MB917598.jpnprd01.prod.outlook.com (2603:1096:604:517::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Mon, 5 Oct
 2026 11:12:03 +0000
Received: from TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:405:36b:cafe::5c) by TY4P301CA0044.outlook.office365.com
 (2603:1096:405:36b::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Mon, 5
 Oct 2026 11:12:03 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 8.62.32.50) smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 TYO1EPF00005023.mail.protection.outlook.com (10.167.240.20) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.14
 via Frontend Transport; Mon, 5 Oct 2026 11:12:03 +0000
Received: from vm01.adwin.renesas.com (unknown [10.226.93.89])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id 4BA963000204;
	Mon,  5 Oct 2026 20:12:01 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: rafael@kernel.org,
	lenb@kernel.org,
	pavel@kernel.org
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH] PM: suspend: Do not call suspend_ops->begin()/end() for s2idle
Date: Mon,  5 Oct 2026 11:11:57 +0000
Message-ID: <20261005111157.17256-1-ovidiu.panait.rb@renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYO1EPF00005023:EE_|OS9PR01MB917598:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c2971b32-25ec-45c1-3806-08df22d17c0b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|23010399003|36860700016|82310400026|5023799004|11063799006|56012099006|10067099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	upQbA+hikRKq3XUFv1CfNgvmaOObKL2x6oFaaYiVcjn6L5LWMC3pyswDKUUnTZepZQa/K5qwJa6iR2VI9aQn386zy1MvXrVzuNA6f3EIVmPQkOioBRMIiF4F1ABJus5Nd261uB1LVuvnlkzhx3vh+yVVATUTbi0vSkO8FXuZl5wfeVsOPCNxMzOOnqpEJPfZISWp44AsSgVrfw8OplB1e+hPvxMa4kDymA4elLc9MCxqHiZIuu+6LIOIbZn9PMbOdwdQeDQNse+ItZZTmhBMd6uv97wwmalbLXK/ANQyq7zUbDwUa+qBC5XZR0D1eTD8uMt0yx2rSlSz7zX4OXZgHlXeJENYFyMowOKoZ0Vta1crJYTWhyvjh2CsuZKmCyD9o/t106NZOOjJGN5xazrJX8hm+WowtAtENsAJGdt5Iw+OJbkJOx0fBB2sseRHLbhIKgFu+s22Svci/YzJusT2wEuoPHsQaF5aP1SWmapq9GyadJjPY762LrQlrLkET7rE/lf/T5hijWyUc1SsAESnLsm9DTV0L56Vmx/Nz1Vqduh0lWq8XSjkclk2VB2WNDSitgvrYTaZ9YVqoPJDU18UCg9io06qYKb+hFB41IVPqqHYm8LqXkT4uAV0cr2f1/cZV0Mkj/OtLi3vcC1suQ1yNmZNTeMWkfnPgGbSYIK8j7gTPJzD2K8Ll28DHhtjd0dph3fj2CzoE5Qjt1Kf1UN+PA==
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(23010399003)(36860700016)(82310400026)(5023799004)(11063799006)(56012099006)(10067099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i9BU2as4HPWeioUEFuoCX25+nUhmIS6M1A6YC79To613ch03xR6l4zNefxMmVeJATlRYVNbwqBYusTdMSVQ2B/6YwCA7VR77Ct5Ugn4x1nIlMXTwHL20pSMXEcBSh+9cvpGcIxmQqyqeb4/Wyt6mi/mOmtReks0PLKikCQZH9ZMnqKSzR3Vq/Of/RTaGHohyWHKx/nqxIpEDKipK+G1Ws9lTRPevMH1IE897QWkFKnGHukFj8Enzvp9E1/BQXQnunsBSM0fObRlPT9xrLA+rxjXuAXhAQCcpZJsXRsjr/dtboHmfaa3NhjXoxlX0RCjxJ3Zq1gWi2akCJ1KgEhDpeDmAfnS3+3gTZhUX2XVDEWKZmHn8lm0WEqURsJ4uGIy/b0neEczHcIrTQNEf4c5WczL4M4bzrkeTRBqcXWaXKshZyX6bQGKXml3M5eMEy8pG
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2026 11:12:03.4023
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c2971b32-25ec-45c1-3806-08df22d17c0b
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: TYO1EPF00005023.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS9PR01MB917598

Commit 7602c0ec0bbf ("firmware: psci: Set
pm_set_resume/suspend_via_firmware() for SYSTEM_SUSPEND") made
psci_system_suspend_begin() call pm_set_suspend_via_firmware(), so that
device drivers can prepare for the possible removal of the power before
PSCI SYSTEM_SUSPEND.

Since then, on platforms where PSCI firmware supports SYSTEM_SUSPEND,
pm_suspend_via_firmware() returns true during both s2ram and s2idle.
This is inconsistent, since SYSTEM_SUSPEND is only invoked for s2ram.

This was observed while investigating PCI-related suspend/resume issues
on Renesas platforms (RZ/G3S, RZ/V2H), and was traced to
platform_suspend_begin() falling back to suspend_ops->begin() (PSCI in
this case) when there is no s2idle_ops->begin() callback:

  platform_suspend_begin(PM_SUSPEND_TO_IDLE)
    suspend_ops->begin()
      psci_system_suspend_begin()
        pm_set_suspend_via_firmware()

platform_resume_end() falls back to suspend_ops->end() in the same way.

Since s2idle has its own set of callbacks in s2idle_ops, make
platform_suspend_begin() and platform_resume_end() only invoke those for
s2idle, like the other platform_*() helpers do.

Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 kernel/power/suspend.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/kernel/power/suspend.c b/kernel/power/suspend.c
index 57c44268698f7..32c055df02da7 100644
--- a/kernel/power/suspend.c
+++ b/kernel/power/suspend.c
@@ -306,20 +306,24 @@ static void platform_resume_finish(suspend_state_t state)
 
 static int platform_suspend_begin(suspend_state_t state)
 {
-	if (state == PM_SUSPEND_TO_IDLE && s2idle_ops && s2idle_ops->begin)
-		return s2idle_ops->begin();
-	else if (suspend_ops && suspend_ops->begin)
+	if (state == PM_SUSPEND_TO_IDLE) {
+		if (s2idle_ops && s2idle_ops->begin)
+			return s2idle_ops->begin();
+	} else if (suspend_ops && suspend_ops->begin) {
 		return suspend_ops->begin(state);
-	else
-		return 0;
+	}
+
+	return 0;
 }
 
 static void platform_resume_end(suspend_state_t state)
 {
-	if (state == PM_SUSPEND_TO_IDLE && s2idle_ops && s2idle_ops->end)
-		s2idle_ops->end();
-	else if (suspend_ops && suspend_ops->end)
+	if (state == PM_SUSPEND_TO_IDLE) {
+		if (s2idle_ops && s2idle_ops->end)
+			s2idle_ops->end();
+	} else if (suspend_ops && suspend_ops->end) {
 		suspend_ops->end();
+	}
 }
 
 static void platform_recover(suspend_state_t state)
-- 
2.34.1

