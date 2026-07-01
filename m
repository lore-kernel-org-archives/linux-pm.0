Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013045.outbound.protection.outlook.com [52.101.83.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05843EEAC1;
	Wed,  1 Jul 2026 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.83.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782897789; cv=fail; b=Xa6hU9atZoNkWuvkKjOKm35X5D0G5PlZiWELIigYo9OcvOjJi+rom1AKpRs9/pwCGYNvZJKhQucLQoe86N6WvKGwMuTuRUUtrn0BJthwqlraA4xjnDI263PI2A0KIP/ykri0Zw3Ho3SeAdDq7iGEFooHVBaAGc0oD8BwvyBizcU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782897789; c=relaxed/simple;
	bh=GQG3hzC4XTydwYFE1IiZvnX8tGgC1XmbbYZnsT10gDo=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TINQ1CsZDFnyPOBp+h8HQuUn27Da4FRWcERdXrrOLN78XNwgR5GdHkEly4/G8JiEQ2rnmUEgCK3oWWH041LIGfeL6F+vbSxm437vPASRxGRTJ1WsFLPZabvbJlelmO6hKalVYA0lkj1srzvtFK9fS5+UmOOZr7w2t5Q27DvRNkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=pYM5CmIW; arc=fail smtp.client-ip=52.101.83.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="pYM5CmIW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LX+WoWbwP0dDuWxGiReNpsYTfiLItrAF2tiAKYZe/9MWhlpgw0iTyShLDrM/w4wtBsYbl61HCyExgoL1NciJn7fDprT9x5g1KvNba58Ht4t5upG6nG8W9zNCjdjpfRMhuXz3BEtfhL5iDLKpxvpGNCqR4Bdi6xFKdPZMAfaInTxR3rfmYWzrI4GDpY9Vz6rWdrGROvqA5p5yBfXJeSmnjFunhGmyGq/A1aV7h1Ifh8sI13uH8yZvXgp2uJFCBJ77w/g8M/p5q+SiloAOvN+33SOS206EWSN2NpifM1XrqLuBNvufe8hb6XjdS+9q2ZR2dPXF5k0g/Vm4S6l0gQiOVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cRJjIpnJYKXuOJmq5w8qW79v/movmeeu1ubDctkZtXw=;
 b=dbxvcjkyx+EGymzw/wmG6ZdeC6yYiRvi/rt8+r1QVTcJblCzZopji3oLCuI/YCEdDGKLzDPEneDXWlX1/a+LFG35DyV2UEc2xpCjGzALbmxBMTzeNx9AAemWvuVFj9Q/aJY86CnWQrSyYMMaEDckgLc2ivPQbTGwSe7zxKzwDCpNQGRS856QOLn3mawladfyRchyPl9JyScGSSG9jN2MpHyDc1uDA0eSr9hTMA6vb/UQ8B8OHFcZFhMScaZMW2FzxCr9YoiW22Nuiv3eo6zS+pRtZCBsi3HoRHs/wuXlglH0xKdz8KKoy1m4jyxTFwr/9vbNhBXrmyfi2TC2HAHNFA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cRJjIpnJYKXuOJmq5w8qW79v/movmeeu1ubDctkZtXw=;
 b=pYM5CmIWS93GL/OmV1UYUEbLkOuiVQFjXJ4jrf6DSWmlaAH/V1xxgsdoxPBkCjnKyuraH2GmcpJwj34ctG1ziXvCBUSsBBMD1ejE6fdqHGTL475ASuplk3qbICTsKiiaHcdGkVdZ5jtkh32ZWsGsHm4nwfvYBl0V3DZhFd/PxaA=
Received: from AS4P250CA0029.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:5e3::19)
 by AS8PR02MB8589.eurprd02.prod.outlook.com (2603:10a6:20b:54a::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:23:03 +0000
Received: from AMS0EPF000001B0.eurprd05.prod.outlook.com
 (2603:10a6:20b:5e3:cafe::5) by AS4P250CA0029.outlook.office365.com
 (2603:10a6:20b:5e3::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.9 via Frontend Transport; Wed, 1
 Jul 2026 09:23:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001B0.mail.protection.outlook.com (10.167.16.164) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 09:23:03 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 1 Jul
 2026 11:23:02 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] power: supply: Add sysfs entry for system load
 control
In-Reply-To: <3290b7eabb9dff19d77ff50d5ff1c4db4d37bdc1.1782746851.git.waqar.hameed@axis.com>
	(Waqar Hameed's message of "Mon, 29 Jun 2026 17:44:56 +0200")
References: <cover.1782746851.git.waqar.hameed@axis.com>
	<3290b7eabb9dff19d77ff50d5ff1c4db4d37bdc1.1782746851.git.waqar.hameed@axis.com>
User-Agent: a.out
Date: Wed, 1 Jul 2026 11:23:02 +0200
Message-ID: <pnda4sb3vyh.a.out@axis.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail10w.axis.com (10.20.40.10) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001B0:EE_|AS8PR02MB8589:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f6b93e7-4e5a-4c69-3290-08ded7525a6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|18002099003|22082099003|56012099006|4143699003|11063799006;
X-Microsoft-Antispam-Message-Info:
	25F4ZUrU2EcUE+lxGrxZPrQiwm3YRHU2aUcNOEOAyn6dPQNV5UVdqUOdSOcLEUfPl01rNw/jzE/awe1KX3q0LAGNL7H5tbcxQNA78b8vBlQTBL/lxvD1NqBU+eLVICRrBLviduh7oiXfsCB/vBO+8xtg3SCIMsvbRXwooB2RAuRO3MbQS+l7xmw9d4qQghCJIP0hZcsvtsctsTQRJkWEVg0Szq77BIOdB1Z2iaGzpcfs4sxUwLZkv00fMUQIflRlOBLkGmDDtJBZOnmbQpY59SIoy+kB3OPoAetMrK88XXmIIBs7NxPyJwZXRKjf0N/ztynN4tSUqUzgYId7Fm+3IZvjNS+NFwJv1vkOJdPEjOma4BW6skCFC/AImkEHPimz6NtVDOgj9KSi+KUu2F6HCFBP54YjBTVKhA0FD48Jp0Z7kvIHFEa5jrh2STYmCbZZHuTOLq5791A2eAV0A38UjVqBKkHLhxjjEywFqqLo6NOxtS3XPWnW9e0Z56y8AbeHnpSUoGLO7mOFifyHws99lHNl79tOvHPa48jFZMHy7Q1AjqmGSCHlg0xWOTqeA5p83r1D/o5bfbFaLGbo207h+wc1vcjutlcrp/0ISUtGXjyQOC5nyX5/3qeGqjt+X/l9cfRn6l9NAzCe2+kwTRb8uid6Dbp2P60FsrKbzw5+wDVJX7+x/kb0Kujx4qDzedaZlyIWO7VnCzXuK9MJZ4RrYg==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(22082099003)(56012099006)(4143699003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xEz8lASGdrVkShE8ddMw5/fZoOQmJh3aPO6uko9SvuwJNVgRx5eguQKPwKmUXxBQUm2V3cO9jRpi2budjUDD0JutamgSTGNkpSkhhs3SfNOpt1nKe0m5jdpLtJ0V80vvaH6ZRlYTCWfPESbACQeJXrmiJjCh/WooEp/ME42//H0V+6WSSdExD99CkdZcgmdyh6+D4q3efnlWlJY2AAwdh7PGofMQEHnq6xjc6t7ZjkHjS5listTFj+bdFl5Nf1QGqxMNA/nEOZgHSipoCMw/jJ0hl2HYedtv3t5FRttwFbpKFgp+al6mWxRz+KRWTJeTY1i3JLORzZIEh51x3EprlmXATUaX61l+QJVfJE9o4r+NsjYd3qLbxscJ7YMo5fiA6Z/tw9DW5Neqk2B+be6Ly78+z8jMH3FMef0RsmdrSGvduUBVIx0FjKMa2mAz8kFd
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:23:03.7258
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f6b93e7-4e5a-4c69-3290-08ded7525a6e
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B0.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB8589

On Mon, Jun 29, 2026 at 17:44 +0200 Waqar Hameed <waqar.hameed@axis.com> wrote:

[...]

> diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
> index 32697b926cc8c..2287b207311cd 100644
> --- a/Documentation/ABI/testing/sysfs-class-power
> +++ b/Documentation/ABI/testing/sysfs-class-power
> @@ -590,6 +590,30 @@ Description:
>  
>  		Valid values: 0 - 100 (percent)
>  
> +What:		/sys/class/power_supply/<supply_name>/load_switch
> +Date:		June 2026
> +Contact:	linux-pm@vger.kernel.org
> +Description:
> +		Devices can control the connection from power to system load.
> +		For example, with a field-effect transistor between a battery
> +		and the system load (BATFET). This entry controls such switch.
> +		The obvious states are "on" and "off", i.e. there is a
> +		connection or not, respectively. However, many devices can also
> +		enter special modes such as "low-power", "shipping" or "deep
> +		sleep". In these modes the switch is usually off and the
> +		quiescent current quite low.
> +
> +		Access: Read, Write
> +
> +		Valid values:
> +
> +		============= ==================================
> +		"On"      (1) Power is connected to the load.
> +		"Off"     (2) Power is disconnected to the load.
> +		"Standby" (3) Low-power mode.
> +		"Ship"    (4) Ship mode.
> +		============= ==================================

`"Unknown" (0)` needs to be added here as well...
