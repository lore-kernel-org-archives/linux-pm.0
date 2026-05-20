Received: from DUZPR83CU001.outbound.protection.outlook.com (mail-northeuropeazon11012002.outbound.protection.outlook.com [52.101.66.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E77CF31E83B;
	Wed, 20 May 2026 15:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.66.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779292185; cv=fail; b=Z+IjC7RNpc7dNQTG62n6zKWHBYNutmaH2IWogApJ+Q6d52YLZxzcgBF0xCpqCdQLWVkiAKMP5QlEUthVBF2aYeYyhO6qX3hFgCuCR+l6TgeuVvc0iUMWS6jtduejcAyQMtHCrmPUGwzZxW9EWgR2yJmrnE197Nxg+essTV+QDZw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779292185; c=relaxed/simple;
	bh=cwaDI2vlstKm7zFa5FZ97M4lGcG7GOmMnSdffFERpaQ=;
	h=From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qrpEmXy+03BxwYl9qwT34osqzaiQg+7XcdKCqvH1QUxXrw6D9sh5xuaP3yOHBO/QcSRjG2GkbdgmgPddw5wOxO9RCJ67bP+k2YNCQOw7ePFaLl9K7jYDlv7YrDI+36ztLALuLzqbsIal4GyKR0tiBQCgMNJDKitLMB+kXygkeDw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com; spf=pass smtp.mailfrom=axis.com; dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b=PAxUXgah; arc=fail smtp.client-ip=52.101.66.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="PAxUXgah"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VZ5eQNsO9OVoC3KZp1oU5IprPiDewxe0jkWTcc4K4oR/CXXO8pPq0ceWXHZvSZ+WlE4KANvuxxUFawXZBpbfMYv67XgbszYQoGdABbNnT2YtZuy/JlYbpQ3nC+0Gf/9A2uMqayJQy3gitvT6ZVwJOZh4YjkNup86SyXYM4U2tY4KZmPy5Pu3AjDJARf9XP5Lcawhxg8/ex13XQyMZ+TUhwTs1+7s4VdSfWrJOAzWDj5LQImk+j5X5FTuXjgr28q2MhSxZP173F94dvGdb4/7/RJJxamKMnHC1ydU6b8Ohi7isQqER9eG/ltlc1pHpUyXwWvR1HaaGHx7MekgfugqaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N47dc96fYqFc0W3FNkdR6KHt51ckAAcL+lhKQVIe+xY=;
 b=HbsHQ51T/gNse8LNtkCvfiBx6VCI3f4wB0vG/cgeNTZOVYvF24hml9rMYipC2fVRdLBvkRS7bBAyh1urbDi6XQ74uPdZgciTPQOaCcZEo5aI2NAnXFqkzM/hCDO4QtmacuX3JglcGEANGPS7zGi7BP2Oe11zussao+8or54H7JRuEyN70tESbMefwDndAP8VGKhHx75kCD11IJYzSu6WiejDSv0+QP2X/M+Gr93bo67L4eZlqxYq0CkTYEYTgIOGKt5lFgVIMwqBIaNwNk4NBwjtMtJxUDj37RNb+uhFm5EoaZ6JQsUEeQR5AnodrB+7eOAlfq815LjnzsUrQPoPsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=N47dc96fYqFc0W3FNkdR6KHt51ckAAcL+lhKQVIe+xY=;
 b=PAxUXgahdgEGifd4Gi0iTXhKDS9lQ6vXNtqd5DuRVB0JstGgfBttDn2ExVz13Epmo9+A/rTgyhk6cVj+wO2WOX5lHn1ailVAx8+KcCLm2I7XE6NS5Vi1B90aiEDHsDn5YGd5/BQ8qDgDhKZwVvTLstpylostyRLGgZiH0wtdaYA=
Received: from AS4P251CA0002.EURP251.PROD.OUTLOOK.COM (2603:10a6:20b:5d2::8)
 by VI0PR02MB11712.eurprd02.prod.outlook.com (2603:10a6:800:32d::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.48.14; Wed, 20 May
 2026 15:49:39 +0000
Received: from AMS1EPF00000045.eurprd04.prod.outlook.com
 (2603:10a6:20b:5d2:cafe::5f) by AS4P251CA0002.outlook.office365.com
 (2603:10a6:20b:5d2::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.48.16 via Frontend Transport; Wed, 20
 May 2026 15:49:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000045.mail.protection.outlook.com (10.167.16.42) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.48.11 via Frontend Transport; Wed, 20 May 2026 15:49:39 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Wed, 20 May
 2026 17:49:39 +0200
From: Waqar Hameed <waqar.hameed@axis.com>
To: Sebastian Reichel <sre@kernel.org>
CC: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, <kernel@axis.com>,
	<linux-kernel@vger.kernel.org>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>
Subject: Re: [RFC PATCH 0/2] Add driver for TI BQ25630 charger
In-Reply-To: <cover.1772201049.git.waqar.hameed@axis.com> (Waqar Hameed's
	message of "Fri, 27 Feb 2026 16:35:32 +0100")
References: <cover.1772201049.git.waqar.hameed@axis.com>
User-Agent: a.out
Date: Wed, 20 May 2026 17:49:38 +0200
Message-ID: <pnda4tunkrx.a.out@axis.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF00000045:EE_|VI0PR02MB11712:EE_
X-MS-Office365-Filtering-Correlation-Id: b27de30e-2523-4fa7-bf26-08deb6876709
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|82310400026|1800799024|13003099007|22082099003|18002099003|56012099003|11063799006;
X-Microsoft-Antispam-Message-Info:
	29iqq2OVA+MIjhUayVy0XULkoptgLYOjxh2xUihklrY23wnPm7xEFebQkOk52BS20DjmCQleiqAC7OmHdkwBll0Lc1ZYKa4gugdy5eI7wK+VEpRpIn+ZvOLzp3z53LBE0Qquz5jY/Zp9zLdZdHTahkp29vaDH87cUXwXKzK4DxP/A7N2AjmoBapHGzuJsnUnMqn9QJkfmJ/jq/QYsFAmoOZnsr/Wll8RgZ+k4cQ0ugkZXCikGbdzp78GoFN78D/mtDPSa1TeEicE9tSdA/Tb2hxpPsQuEdNMuvIdD3XqWTITA1t/f7kGYJuEIr1q7I1xaD+LE2E2bHhASaL2ydzfsrrSkqhgq2QYtmtmYLr69KEyYIM8BkfAL3k8DsKaj6ixmXRe4It6IRECuYplZ4D0N41pXjumpc8oV/lh9lGq0sN4HkbTDrYI3qJVhmVuKJQMqCB0lQ+gY/1bSN1c9n0+H0zngX7KcrfHoTtUe/bP9JLziTiTupAaHXlC8C/CmFwUQNDtdh+H3evcy1pmd0qT6Eb254+W3ZNtjPw6FmSda9n1manuUrz8Z1+xotaFffTovS9IiS8leAS3EPdlN3+vhNVELOqxekJGLyftq5yWA78JLLCBGhR+31RHEdf++XWY+qaMVN1coIFnNIlNEAshWQKdBooypn1mMePw8464ATZArx8u+G66eq9cmCS9SxMj40hUgssSV+OnlGTrATZNC+3olJz6oHBKQW3g5TF5frk=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(82310400026)(1800799024)(13003099007)(22082099003)(18002099003)(56012099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	D8cjjfpNwP1Fl5ciyJCOxV+JrUlwVMpUIEXsJaGMIe8WM/wSCQocDVHvg7O4K0MX/tzbXbkT32qwNY8Vw3+jelG1vzQii33Zg/9JhKDzdm/5USuqlvkY4LnzQ8BkXocyxpQHIzYiCchYvzq/Z7Kv0V9Y0X+zitCVh8kgOLEQk1SCkEjf2IZKMnL5W1UByJ8hNVQ+WZJYvqk23Karzj+x1ZeY/DUbGvwYX6FWPt/CTWjNm8Rn6SmCMp9KxT1GFjLMWNKLbUBNdHstAGVnIcQEJJhsLoXSstFVFEdO3uCKKtGQkVSykRld1kqdAQWh0xHZEVQ8cp08rAM/CLZIVVmcJzyFa88YHz5Wn7h2VRIUpFfwxDwwRnkvqY3s6gHig0H85fNyYDEzelWAXatxIuI6DCq1tD0fsXapjiH2AfQv/E9vj6BVIqkxT8a8zE95jl8n
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 May 2026 15:49:39.8361
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b27de30e-2523-4fa7-bf26-08deb6876709
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000045.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR02MB11712

On Fri, Feb 27, 2026 at 16:35 +0100 Waqar Hameed <waqar.hameed@axis.com> wrote:

> This patch series contains a fully working driver for the basic
> functionality for the new TI BQ25630 charger (see datasheet [1]).
> However, some functionality has no straightforward implementation. The
> following features have therefore been left out and hopefully we can
> have some design discussions to reach a clear resolution for the next
> patch version (hence the RFC tag):
>
>   1. The USB OTG functionality (i.e. power *out* from the device) would
>      probably need a minor refactorization to use the MFD sub-system to
>      also register a regulator driver. Looking at the bq257xx driver,
>      this should be the preferred design?
>      
>   2. Other drivers add a custom `sysfs` attributes for BATFET control.
>      See for example rt9471 and bq24190. Is this the preferred approach?
>      Should we add a new power `sysfs` class ABI for this? (There is a
>      TODO left in the code for this.)
>      
>      I reckon it is quite common to have BATFET control for chargers,
>      i.e. being able to set them in "ship mode", "stand-by mode",
>      "shutdown mode" or "idle mode" (example values taken from the
>      `BATFET_CTRL` register field from datasheet [1])?
>      
>   3. This device has liquid detection and corrosion mitigation. I
>      couldn't find any existing device driver with this kind of
>      functionality. The datasheet [1] even mentions "patent pending",
>      although it refers to the USB type-C Specification 2.3... :)
>      
>      When liquid is detected in the charging port, an interrupt is
>      fired. Likewise, an interrupt can be fired when the port is dry
>      enough (according to some configured threshold value). My initial
>      thought was that maybe we can add "liquid detected" to the `health`
>      `sysfs` ABI? However, the question still remains though how one
>      should enable/disable and set threshold values for this (new power
>      class `sysfs` ABI or a custom one only for this driver)?
>
> [1] https://www.ti.com/lit/gpn/bq25630

[...]

Friendly ping incoming!
