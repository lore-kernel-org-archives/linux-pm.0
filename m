Received: from OS0P286CU010.outbound.protection.outlook.com (mail-japanwestazon11011012.outbound.protection.outlook.com [40.107.74.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307F83D333A;
	Wed, 20 May 2026 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.74.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296331; cv=fail; b=TtIzyWWmbSdO59lFqEyFdgrVJ5B62oiieicIxjwBdDk7f25KPDj925DKOUJcF1JAULzjYI7ZJ7hJU+ijk3v1z1n4dwONfxTNQCLyAVxLzgI1f2NXNK5L8ZrO9GwRI2UltkCJgR6iINwrfCoDeeOg9SJ+pt4iFwK8Aj3C9ZDr7rk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296331; c=relaxed/simple;
	bh=vZJ3R+CACKazyW0kATVdwCmL4A8ic4x2QmpaYbHZVkc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZBTFZUbvXtNWiBjEu/eLMrI4/HnZKbQOowltqxG/hEZfHbL1mc0wAdv4IRNe/tQMWolbYtcrq+d55QEK71gvWmLNvXtzDxm2gtMgD0X8C21+pkOVhiJrLQVPuvhMR7jIIp03wEGkbhyTE19KsrSrhKGfYONCvX5mEIaw1Aba6L4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com; spf=pass smtp.mailfrom=renesas.com; dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b=nbMBmLKK; arc=fail smtp.client-ip=40.107.74.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=renesas.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=renesas.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=renesas.com header.i=@renesas.com header.b="nbMBmLKK"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=drfYa7Ivlyu4uGA5Ey99vTeH/rBx90IATpQdPSqjr7KePr0hbIfrli/bkDwBM5DVzrbIsossjyUCLB2/6T1r+7tY2vfOWiz6is2EaJCsoPaGQf/kq/OCi7dtVvsIv4FSrBKvc840PtB9c/4dZkHx+VGsYdP+bNBY7iyKVZ5XCAxt4yQE37ZSv0QflkJmR8cLnxb/TBLHp+a4T1B8QYG6Ac3edLHApcnhKjCkPzBq9mNYgyXPfi+5TPUSZe/z2N+R3r4PTdSND+PgUx1galdE1+zTRsIqoYq6cQtHxVN0KGXvBuOYko/lr7AK6lEQbFJuAe3+epkoiOVir9CAsZfQOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fInPvNYQ/2OlV8GHYfD0EFRsfiVXeUcJ0+rQjq0NDQU=;
 b=m89ozxbn+h8ckZ7FUFFEX1Sb3Ot8Swa0Mp3VawiiEu4C0WmdwJ0JrQxlyo42J62RrJw0bo/EF4y0ZDzfNBU0vMEPfrKzDp5Ywo/L8iiRk3DqLtyOoWFzkM8+xfZf5twyX2KDF5ePwMD/DqyUBPvRICkCr768fIwLfjaWuoncwTrSf4K4Jw0o8Tt8RlcDr4pKcAujTJInBcJQO13ULX1pvtr3T22XtIQnFwPMieGndKYntqZgmXrAm4Xiqdxlu2ROI4kUblcdC0azzSgrqPTHm48akp5c9muwq8RY7+SnX+bVO6Nnl5SZG4yIv189xnqIpFPI3lhRgBQNv/IUF3AKdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 8.62.32.50) smtp.rcpttodomain=arm.com smtp.mailfrom=renesas.com; dmarc=pass
 (p=none sp=none pct=100) action=none header.from=renesas.com; dkim=none
 (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fInPvNYQ/2OlV8GHYfD0EFRsfiVXeUcJ0+rQjq0NDQU=;
 b=nbMBmLKKOy6za+ed7BcvXt3Pxn+Rxrtk2gg6HUOrlLyn3RGWzNThC5rOEZonCPdUgDjai7AH+rfJyIcJxnQ49AeW1EUe9rRm/PG2CkbTIMemWAmGoVc4E3BXnlyeA8ROgIjo2OXwbqpVmXgwHWnkTb76OQL7VSjR4CtSA7UcNCw=
Received: from OS0PR01CA0068.jpnprd01.prod.outlook.com (2603:1096:604:99::15)
 by OS3PR01MB7924.jpnprd01.prod.outlook.com (2603:1096:604:1bd::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 16:58:44 +0000
Received: from OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
 (2603:1096:604:99:cafe::38) by OS0PR01CA0068.outlook.office365.com
 (2603:1096:604:99::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 16:58:44 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 8.62.32.50)
 smtp.mailfrom=renesas.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=renesas.com;
Received-SPF: Pass (protection.outlook.com: domain of renesas.com designates
 8.62.32.50 as permitted sender) receiver=protection.outlook.com;
 client-ip=8.62.32.50; helo=ejcrelay004p.adwin.renesas.com; pr=E
Received: from ejcrelay004p.adwin.renesas.com (8.62.32.50) by
 OS3PEPF0000003C.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.11
 via Frontend Transport; Wed, 20 May 2026 16:58:44 +0000
Received: from vm01.adwin.renesas.com (DEU-5CG20946WF.adwin.renesas.com [10.226.92.217])
	by ejcrelay004p.adwin.renesas.com (Postfix) with ESMTP id E5D3A3000159;
	Thu, 21 May 2026 01:58:41 +0900 (JST)
From: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
To: rafael@kernel.org,
	daniel.lezcano@kernel.org,
	rui.zhang@intel.com,
	lukasz.luba@arm.com
Cc: linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Ovidiu Panait <ovidiu.panait.rb@renesas.com>
Subject: [PATCH mainline-linux] thermal/core: Populate max_state before setting up cooling dev sysfs
Date: Wed, 20 May 2026 16:58:34 +0000
Message-ID: <20260520165835.90974-1-ovidiu.panait.rb@renesas.com>
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
X-MS-TrafficTypeDiagnostic: OS3PEPF0000003C:EE_|OS3PR01MB7924:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 3ee805af-6141-4fcd-265b-08deb6910d61
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|36860700016|82310400026|376014|18002099003|56012099003|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	tnjzP+55zs9AXGgnv025eOyU37Gp5K9ibqowyWCPUBM7Xt6sjQeT5lHePmkwY4wUW68+wbm15RJuxbA5fU/edz0v/6TVz9JgsfA1dpMAwPW7tn3h9rIi5qbDMJvozlLx7iZnaFnKcPjudhg3r1RALW4jXUwzzMNeDaBs/uFDs2gopdVN2L69FxVLEog2MHWNYwvYKdMquOK72t189vVEWfCjGCMjCJlxW1qdOlHbNf33jCRADMgcF5+fHa6dLpGMVY14ZISQf87MkjAlcZ0713VMDuX8fpf36Sh6o47cVt0Cr9r3pgXXxvCq/eygJOHBFeQl+nVBJvhEqjH+wfZMir4uGR3jr4Qtj8vcknulOkFoR5a3ZHHFKYgisCgmpxKCHqlgpU1V6kzr7gNcv2Pk2tzvJsZ4MZ0OdXkAfL4sUb0ZGkDeQuH9B97N1qzkC5mwwVbXMM/mB2SJvXPB9/p32EMuy9lH+LpUwRcaQn5e8kT1agP5BEEYigpG/zAvqwDOcpxHJ05JPTGMvTBFm7r4oqJQwBnj6q4ISsxka/kqtfxThnGQ7sPEweVO0zUy1PLfseSKfGUgcKtFmVu6zQGogRusmUgUlcwl6K07AyRja4yKwTU2IZ4mc7aSq3d6SbmlDTFwoTw3Ok5HXWBmE4qTFArS5w3bAW+O/Rzl1oY8N/RPIdSJ6cCr33lqUTDDCdcYDOMzyIxNzwfsBRCdIk2u4LdvoLPLnrz9HlZkqQsVle4=
X-Forefront-Antispam-Report:
	CIP:8.62.32.50;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:ejcrelay004p.adwin.renesas.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(36860700016)(82310400026)(376014)(18002099003)(56012099003)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	0X274HDYQ/QuD/BASw391sdOU4lfcL4NehQNoAvoX/x2/wiDSblmM7owAeMFLsy2Eaw+xG6UyHXBBRxHs+dNOzMJze2hoiv0S0+xM+VIbwAI/LQLOBWsSyPZ3DiIMV56k6OAbSutzvI6NgApi8gfzziDgXfjl9EzyjFxT2Ci19x10iUH7LdfUhanYYUIgihepBmDOYMQ7HU13NHku3L4/xRw/GXgng6WRHRTVnwM/ijeXXvqR7uvD4Rl9h9w39UYz1HFHIawNQFyARC3S7P89WGuOMavJ18WYDnrqa0TIpQmYn3avbR0Gm3T3pWXKi7QCKrx0HdEU9e4uB781CW5zScSq9gtBjvHQI0d5OMTPHmIFOxU7lw5wGaf8QBN8hvizY6DVJTGLwpUaf9eA8VcffqfnQrwpmrR4xP+qNBuyyfENbC5mQ5fC6zhJFOsm7JY
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 16:58:44.3512
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3ee805af-6141-4fcd-265b-08deb6910d61
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=53d82571-da19-47e4-9cb4-625a166a4a2a;Ip=[8.62.32.50];Helo=[ejcrelay004p.adwin.renesas.com]
X-MS-Exchange-CrossTenant-AuthSource: OS3PEPF0000003C.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7924

Since commit 13f4e660a126 ("thermal/core:
Split __thermal_cooling_device_register() into two functions"),
thermal_cooling_device_setup_sysfs() is called before the
->get_max_state() callback in thermal_cooling_device_add().
However, cooling_device_stats_setup() allocates space based on
cdev->max_state, which is not initialized at that point.

With CONFIG_THERMAL_STATISTICS=y, an out of bounds access happens
inside thermal_cooling_device_stats_update(), followed by a kernel
crash:

Unable to handle kernel paging request at virtual address ffff800081329e60
Call trace:
 queued_spin_lock_slowpath+0x1cc/0x320 (P)
 thermal_cooling_device_stats_update+0x28/0xa4
 __thermal_cdev_update+0x74/0x88
 thermal_cdev_update+0x44/0x58
 step_wise_manage+0x1b8/0x300
 __thermal_zone_device_update+0x270/0x414
 thermal_zone_device_check+0x28/0x40
 process_one_work+0x150/0x290
 worker_thread+0x18c/0x300
 kthread+0x114/0x120
 ret_from_fork+0x10/0x20

To fix this, restore the original ordering of ->get_max_state() and
thermal_cooling_device_setup_sysfs(). Note that with this reordering,
the dev_set_name() and ->get_max_state() error paths now reach
thermal_cdev_release() without setup_sysfs() having run. This is safe
because cdev->stats is NULL in that case and destroy_sysfs() is a no-op.

Fixes: 13f4e660a126 ("thermal/core: Split __thermal_cooling_device_register() into two functions")
Signed-off-by: Ovidiu Panait <ovidiu.panait.rb@renesas.com>
---
 drivers/thermal/thermal_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thermal/thermal_core.c b/drivers/thermal/thermal_core.c
index 4e2a17fdb6a7..9b9fa51067bd 100644
--- a/drivers/thermal/thermal_core.c
+++ b/drivers/thermal/thermal_core.c
@@ -1015,8 +1015,6 @@ static int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void
 	device_initialize(&cdev->device);
 	cdev->devdata = devdata;
 
-	thermal_cooling_device_setup_sysfs(cdev);
-
 	ret = dev_set_name(&cdev->device, "cooling_device%d", cdev->id);
 	if (ret)
 		goto out_put_device;
@@ -1037,6 +1035,8 @@ static int thermal_cooling_device_add(struct thermal_cooling_device *cdev, void
 	if (ret)
 		current_state = ULONG_MAX;
 
+	thermal_cooling_device_setup_sysfs(cdev);
+
 	ret = device_add(&cdev->device);
 	if (ret)
 		goto out_put_device;
-- 
2.34.1

