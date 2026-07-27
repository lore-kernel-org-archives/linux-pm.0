Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010031.outbound.protection.outlook.com [52.101.84.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B176837A48A;
	Mon, 27 Jul 2026 12:25:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785155137; cv=fail; b=SFG2sA4QhVeutRGwlvWheA8mXq6QUdTrOAwCtRYlHi8sJ6ezQ2Unl6g86201JZNyEdcwQ6rltCvoSBDgW+WNu5kXTh/XbCe0/sy+YgrfMPgDPFiXjStbgNnLCjDAnmsoeiBWc6gwZzZIp15U5gl7ONIRV5KrW0WmhBuXqs+Xdok=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785155137; c=relaxed/simple;
	bh=i5vYx8g830uFOwbsfDbu4V5GnM56AX13wIKVVihFX14=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oR0ytuhjuD4Q85zCWhFite2ED0lHbaxDha0BwjgGEpX8Nx/22MX5xXEjNM/EnlWkNl+6SjgEgkWlbKurqbiUC85sXrmxFntIZKlkRJMud0E1yrZ9japU4YQI8W+aE5F4TKn5YE609pdCFJPBiHNPfgYbL+9woKje96iPnDo6/8Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=Xmd0jWfo; arc=fail smtp.client-ip=52.101.84.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Xmd0jWfo"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uaB124xfyEN9mDNsEDA9aGWugY2zMoQeGctPhTsA8uCWHFSji7ydpu+DXYJjzHOK9RjtwUcaQ8+mMcRsxLvVjw8jtUZ26idWlNx/JpAM762q8x9mA2PKlnGdCJLPsy2fkeSfBtrazaUKPgzKRNIGiFqMx73iwhb5nTMQ6va25CNjDyRUigOphig9GSQcCexf5nq5mtlwV9Kquc8bNXGjKyOos9gXvslGUTd19LeGoE+4aH+JReDtvO39L0I5kgPZLzZe4Xz+ZNbMq5JNhrfwk7b7sOvqKjmsNNdDPliZTAmQ+Qe8bh4I8JNIuxMhLierFZD5qNlYRKhdoeCnrCZ+yg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4d9Wlw21XpPoKkZQJsy/NrxmyRyp5ICkHCHhhnuOsZo=;
 b=xm41Pmk/MFSuEoIrgEb8KKSvH3NBQXyZLakxZtKWsCAy/LfWJwNM5+GAD69YPLYPJ04SiRTerEW7a3Tv+Ve3cUtzqHRqgHfktrDnDH0FxKECrsBFaKIQEEp0aFhQUTzn+yZVVSp6ZvwH+Ogi8HwIbi/B4OBMvAmZSlqQqkNYsuhT8vGXaiNl+5cWL7l+A+nTf9PR0CY2utbvNiUUb3Ldqneoqlvk9Wrfwfv6S3V5ZLpPIu8zwOI8MiguVuj3lhI2zWhSpgrdWzKGMP86l/C86aBDmBqv8WojgKgbN64WinXPyd3r+UelAUhiw5EgCKDBQI2vNuEPbUiseg7AJ9Pr0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4d9Wlw21XpPoKkZQJsy/NrxmyRyp5ICkHCHhhnuOsZo=;
 b=Xmd0jWfoWdS2nNBq98ptX34gehXHssRyTkYSZ+yMBQdZMFLO1BVrsuoH4MNljL/Zx3xcHlyS535MXkez5+/+iD1/Y0SPWhhokvYwpN3HCO9Q4viH8kLGIELrfJM0zPmwRxKSr3bcTHFLOCRlpLnxGwFfm25uD4ZmB58IOkl2pH4=
Received: from AM8P189CA0003.EURP189.PROD.OUTLOOK.COM (2603:10a6:20b:218::8)
 by AS8PR02MB9460.eurprd02.prod.outlook.com (2603:10a6:20b:5a4::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 12:25:32 +0000
Received: from AM3PEPF00009B9F.eurprd04.prod.outlook.com
 (2603:10a6:20b:218:cafe::9e) by AM8P189CA0003.outlook.office365.com
 (2603:10a6:20b:218::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Mon,
 27 Jul 2026 12:25:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AM3PEPF00009B9F.mail.protection.outlook.com (10.167.16.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 12:25:32 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 27 Jul
 2026 14:25:31 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 01/10] power: supply: Add sysfs entry for system load
 control
In-Reply-To: <amAPPg45CD8c2JX1@venus> (Sebastian Reichel's message of "Wed, 22
	Jul 2026 03:25:16 +0200")
References: <cover.1782746851.git.waqar.hameed@axis.com>
	<3290b7eabb9dff19d77ff50d5ff1c4db4d37bdc1.1782746851.git.waqar.hameed@axis.com>
	<pnda4sb3vyh.a.out@axis.com> <amAPPg45CD8c2JX1@venus>
User-Agent: a.out
Date: Mon, 27 Jul 2026 14:25:31 +0200
Message-ID: <pndv7a0oc04.a.out@axis.com>
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
X-MS-TrafficTypeDiagnostic: AM3PEPF00009B9F:EE_|AS8PR02MB9460:EE_
X-MS-Office365-Filtering-Correlation-Id: e6c24141-3b5f-4f46-f5e7-08deebda273f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|1800799024|376014|4143699003|11063799006|56012099006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	MqOIjjEjqcm+Jfi8K2pP8iuvnkr4HuHbQvehwMxsJ7Hil3+fr/qYutZurfExOVwshED2m2ZR2kgOhHY73Pq6OCPYrne5p4m8bjhgVxu2gv0dfP88AVujs7XVzFTPbu4qFhwwpydusiaiNwhKbkPoKEKqLu2lWxByjUOmwC2HL4saZDnd4NUtOTG73DGtLPUr/hErhdLlAuZyTRLVbd0vLKmB5+OArW5kqpevrpG9uep+Tjdg6QZqRq5pJos8IIHokbWjA5Oj1RSjGQeeq6iOu83zNLN5AKY+bdCalIpaP9+6urdJFiqOO5r8Npyn1gQdpgQgdJZuwWb1D7k0ZNnzS//VHysZu/r/47yp3ktzD7HiI9eWMVa8skEfsg2o22WzQnseboI/fWrK63sC/g7KvxNhlz7RNrvF3QrGoVNiqbXnwJ6vSuTkIO4UFdiUbdLMeYPO5NQSrwuP8AP4+b77zBsODAjVBEeiob7oroqAlWyDdWUVVCsKarBStyqDyipi/xKzRR1TUYtSwshTGRzgQd1BccBBZrLv7uarkdaG/iU13Qj0ECGWjyThWdNXo3LCcgsWD1yAPZIAxPZ5AYzFyEF342Vwjf90ahriBE+nIxbAHZ2QGP1sAc4cjyxQH0zKVk41EQmsR2CuibuPwDyLs/67z4yyw90x4WYdnfrLCHM2wCB+ER3B5B6vklJQZKM/C9qFtLev4cxG9UswbVB07w==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(1800799024)(376014)(4143699003)(11063799006)(56012099006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	IWn3vEiEWU84+s2LtqVRe4zFUanzCdTgyLCp3Z+txmUZfHsLiBLGEcUdwK93BnHs58izORooDnws/506RyUlRfbccZe/KBsRvX4G0gchXhRoNodyHzDCbLtYEjcAVGiB5mkdMnfSxTI/jdL9xffJRa+/Dbgy+zaC0LZIsgIjpgheQUTP4EBfRiB8IzWewhKRPNWQhwF2lEbUdyf6q3Jw0Pla89vCmBkKX+VS+KiS8UAhCTGx26wi3PteXCKiD1amGQdOETdraaD6NIprGUCVBZc57je7CEvxxRRomp95/xky+MY8Fl/t+0pm6BtIIIiXDLpZOg4R9DOeMLjdHOCDFSMO9P145AHSfvHDHAdpu1umHofa3G6GNDHSsfKIDqYHeUQ4J+TkUquYWuWgLExPLf15uEO9mKLb0wmtpIFoiePwNGitR3532Uv19O+odM0J
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 12:25:32.6648
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e6c24141-3b5f-4f46-f5e7-08deebda273f
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM3PEPF00009B9F.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR02MB9460

On Wed, Jul 22, 2026 at 03:25 +0200 Sebastian Reichel <sre@kernel.org> wrote:

> Hi,
>
> On Wed, Jul 01, 2026 at 11:23:02AM +0200, Waqar Hameed wrote:
>> On Mon, Jun 29, 2026 at 17:44 +0200 Waqar Hameed <waqar.hameed@axis.com> wrote:
>> 
>> [...]
>> 
>> > diff --git a/Documentation/ABI/testing/sysfs-class-power b/Documentation/ABI/testing/sysfs-class-power
>> > index 32697b926cc8c..2287b207311cd 100644
>> > --- a/Documentation/ABI/testing/sysfs-class-power
>> > +++ b/Documentation/ABI/testing/sysfs-class-power
>> > @@ -590,6 +590,30 @@ Description:
>> >  
>> >  		Valid values: 0 - 100 (percent)
>> >  
>> > +What:		/sys/class/power_supply/<supply_name>/load_switch
>> > +Date:		June 2026
>> > +Contact:	linux-pm@vger.kernel.org
>> > +Description:
>> > +		Devices can control the connection from power to system load.
>> > +		For example, with a field-effect transistor between a battery
>> > +		and the system load (BATFET). This entry controls such switch.
>> > +		The obvious states are "on" and "off", i.e. there is a
>> > +		connection or not, respectively. However, many devices can also
>> > +		enter special modes such as "low-power", "shipping" or "deep
>> > +		sleep". In these modes the switch is usually off and the
>> > +		quiescent current quite low.
>> > +
>> > +		Access: Read, Write
>> > +
>> > +		Valid values:
>> > +
>> > +		============= ==================================
>> > +		"On"      (1) Power is connected to the load.
>> > +		"Off"     (2) Power is disconnected to the load.
>> > +		"Standby" (3) Low-power mode.
>> > +		"Ship"    (4) Ship mode.
>> > +		============= ==================================
>> 
>> `"Unknown" (0)` needs to be added here as well...
>
> I see the issue, that userspace has no idea, which values are
> supported by a specific device. I think it's better to follow
> the same style, that is already used for e.g. charge_types, so
> that the file reads something like this:
>
> [On] Standby Ship
>
> E.g. provide all supported values for the specific device and
> mark the current value with square brackets.

Alright, let's do that then.

>
> P.S.: I've applied the unrelated cleanup patches from this series.

Thanks, I'll make sure to rebase then. Will send soon after the vacation
period (a month).
