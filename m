Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69FF73D6483;
	Wed, 25 Mar 2026 13:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774444266; cv=fail; b=r3cH/RQHbcvDkXdpptcxvPD1fK47A7tvomhcqIDD4bsqDEqa5i5PArwyPLRqXy3s9XW81MHg7oqS+coB7elDppydC4vz6tXXJsestPKoHwTZ9MHLl821nhrpk/oMJMGGMVQJP/0wFU6+9EKZeHWtuMXVURn5mryivK4jA268BaU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774444266; c=relaxed/simple;
	bh=2FzHmr+9rrrADfCvG/ettVJbHNS/8r1mV+oCWUHve4k=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Jm33gRlaJOq9/eu0j/o1FBLRZXoBRPXybdlGm+PgU6G+e1wvq216TaNBz1SAmpClJ6H5i3Q8wIfcuJam0EBxM07v9ExfD904/GSUdKErlpmPa0CL/1rrc85j8jpzmNUXRJBwVOJDLkGg7kDs4+AR6HVvcmw1o2NXQFGLFPpwxGk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=qHgVTY48; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="qHgVTY48"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ApUVTrtL2D+VXrWqHy7d+g4VD6mO1pWufjB60n3w+VvIQBFuI3zPmrgv5QBztxV1o4a80047FCfOA8ZcyQTFdWVmNME67YIxZBeGoXV3c6l3SC3AxDU+Uj/Uyijg77UkYXjaTzq/13/RTNeGuvRdoAGaCVKe0UabS8ileIhRVTJfxaFRBO2uOj+xAlU/ayR+TzMpzRpa9xcxegvoxFV1RUNl03MNxNko9VqaVpvgNKZrBVhMl1kgwKLlwUcmymHb8QUfD4m10HLylArgJOBnhHXmxZGU0lh1mqX+QdZz7C5iMYDYTaXhESuvr+BSVtCB4sPcaKvMqqfNfiIFNA2wkw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2FzxaGE9cFHTDN9DH8SHijN2YSgwmc8c9Y9A9tve/HI=;
 b=RbAaeD3oTyH1lX776kxX5esX2cQnD5Md4M8rLYXwjgAVFsJTXxjl8HsTi6zRWFyacnzR9Z+hVvxnw7yo2eWNF1CB4sY0rEFqxPogj3Zz2BUGapHCc+cWge4AMrxJUCf5lgAFNJyVNkeRsbTlMEX4uGVbKeESIk2Q3pAx1CosLpvWhIF6sS2QDhGuhR6mT0SY2Tb1tFymFa3O0S0AlUVn6jvfErtjIjfi6rw69UL1BNynjj53/7fVXAyOivP8ryH2jnF3PgveFWNy3V13X6L81mHKz8tUPd6BFT3ohzgFmhhHWnFsx6uxk14v4n+WTRAZxnmeIW616O8UDcPL3g/Weg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 198.47.21.194) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=ti.com;
 dmarc=pass (p=quarantine sp=none pct=100) action=none header.from=ti.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2FzxaGE9cFHTDN9DH8SHijN2YSgwmc8c9Y9A9tve/HI=;
 b=qHgVTY48u/cuRD2BEdPrcOP7oTB4NLP6SrbdY3CxO/P3aOUqp8OH6qhYX6bG9I/gVoGr/0/xa3ud2jw34EV4YPM0Xl0o2VHwKzKIVXVkPXW8OBPogJTyd1taiyQSzBJ7PWlqBi7jdQPefjtN3b3HxAmSY63IeYq2bGd1a56DpsM=
Received: from SA9P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:806:25::16)
 by IA4PR10MB8610.namprd10.prod.outlook.com (2603:10b6:208:55f::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9745.20; Wed, 25 Mar
 2026 13:10:55 +0000
Received: from SN1PEPF00026367.namprd02.prod.outlook.com
 (2603:10b6:806:25:cafe::75) by SA9P221CA0011.outlook.office365.com
 (2603:10b6:806:25::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9723.31 via Frontend Transport; Wed,
 25 Mar 2026 13:10:28 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 198.47.21.194)
 smtp.mailfrom=ti.com; dkim=none (message not signed) header.d=none;dmarc=pass
 action=none header.from=ti.com;
Received-SPF: Pass (protection.outlook.com: domain of ti.com designates
 198.47.21.194 as permitted sender) receiver=protection.outlook.com;
 client-ip=198.47.21.194; helo=flwvzet200.ext.ti.com; pr=C
Received: from flwvzet200.ext.ti.com (198.47.21.194) by
 SN1PEPF00026367.mail.protection.outlook.com (10.167.241.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.21 via Frontend Transport; Wed, 25 Mar 2026 13:10:53 +0000
Received: from DFLE212.ent.ti.com (10.64.6.70) by flwvzet200.ext.ti.com
 (10.248.192.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 08:10:43 -0500
Received: from DFLE201.ent.ti.com (10.64.6.59) by DFLE212.ent.ti.com
 (10.64.6.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Wed, 25 Mar
 2026 08:10:42 -0500
Received: from lelvem-mr06.itg.ti.com (10.180.75.8) by DFLE201.ent.ti.com
 (10.64.6.59) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20 via Frontend
 Transport; Wed, 25 Mar 2026 08:10:42 -0500
Received: from localhost (lcpd911.dhcp.ti.com [172.24.233.130])
	by lelvem-mr06.itg.ti.com (8.18.1/8.18.1) with ESMTP id 62PDAfrR4037479;
	Wed, 25 Mar 2026 08:10:42 -0500
Date: Wed, 25 Mar 2026 18:40:41 +0530
From: Dhruva Gole <d-gole@ti.com>
To: Gopi Krishna Menon <krishnagopi487@gmail.com>
CC: <sre@kernel.org>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<lee@kernel.org>, <conor+dt@kernel.org>, <daniel.baluta@nxp.com>,
	<simona.toaca@nxp.com>, <m-chawdhry@ti.com>, <linux-pm@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] dt-bindings: reset: st: convert to dtschema
Message-ID: <20260325131041.qafej5qzbs6iyypt@lcpd911>
References: <20260325130623.36710-1-krishnagopi487@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260325130623.36710-1-krishnagopi487@gmail.com>
X-C2ProcessedOrg: 333ef613-75bf-4e12-a4b1-8e3623f5dcea
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN1PEPF00026367:EE_|IA4PR10MB8610:EE_
X-MS-Office365-Filtering-Correlation-Id: 32edde6f-fbd0-49d0-d520-08de8a6ff1ff
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|22082099003|18002099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	hGE2udhz5EgVBfqWEUaGBDnkroK1q95m4ZJ7NKCWO2iIkFRy4kLTJ7O0V/IEdz1Bi1IBowQ2ifznPvDjqB620dIeT81pf1+Llud7dsLMrLzDYwprx3a6dOb79NVuZgeJGbCOZAkvp6cqH7on9lhh0YOLjEdUHGP9OcdjnYMWQquKydtHb85AUYLLZpRHf/aOCF1BcYFSSZhTIljw7D10l7spNXeQdVbO39C84EDEE2AIIoG6NVGthOvtkyqVE9jUgq0STeYvgPitpjM6WcRjNO2ic6U+Gs58JJAfwnV49VAXYIbAKYB5wforqwFtsdugXwAUfIbEMQxqqjT9k1poZunpducnhKeKDUYfF97vNVpICKT/z21aNphdnacAFgIP6GSj5oMscbYWZoXO+KrsXSLygnaXL7gBVGWIrMJ2wEJTnVfcLiy24OUrfMiEExV6ubiZbGZcFqnVwJ4RNfmG35kQltN4CO09NyVGCa7m/xh/WWMFuW0o3clkczjmahv0BlGwFD2obl4t5LlMZljMZXMAKN2XIQc51IfYufDVBnhOTnwHYOdrIUJOxBXVhmaj6oHCzklHBC41r0NYW3/xlVgTavlWzqGdA82p256r9PSMU0M2U9hAJuMrcy5jE5k8jF5miM8vABynbugcAGgXadYLsW91c8RGeQwseWjCrCM6QPmEI92SPk0RyZC07mTsDiZUxTnRXfm+Z88YCpR/1FXlwLjXuqsBWwAdCwdXkVo=
X-Forefront-Antispam-Report:
	CIP:198.47.21.194;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:flwvzet200.ext.ti.com;PTR:ErrorRetry;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(22082099003)(18002099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	imLv1J1J5gTcT/5z1KFsv1EzKx604eQwPIzWFgFwd0fON62niMOE1P/5iMGf9zv2zreoHbNDCMIHYcG7wx3uWwZarg7ncNHZUy2Za+ckAunAJr7XXNYkcp+cR43YIQEd2JelpsJzSZOLDytHrLzXb8t1ENyIvrG4ay1JzI5Ws0jO0JjsuET2GszN6gO3MEnhCyXNA1OymddioxECa8ygAwIIGg+xmjq/ecmFOfaJ6hTa1mvDvmgwy/wU4IaX2hT1H5/fpVCOK8mhW21iWVaken8sE/3MKHzeh0Tw/DBtzKM1lvO1Znx5voXZeMPtOIXHZ+PPK3NlynsrbmJqeBwIyk+91Fq43ALO63fITJCXa2AQSi41mI+UMKJ6aY6lMO13GrI84PvEBwy6ZfQDveYv9hemWyzI73o0Kh+xUphMQcwjHfrkk5/0atWRxO/Np0Gh
X-OriginatorOrg: ti.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2026 13:10:53.8484
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 32edde6f-fbd0-49d0-d520-08de8a6ff1ff
X-MS-Exchange-CrossTenant-Id: e5b49634-450b-4709-8abb-1e2b19b982b7
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e5b49634-450b-4709-8abb-1e2b19b982b7;Ip=[198.47.21.194];Helo=[flwvzet200.ext.ti.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF00026367.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR10MB8610

On Mar 25, 2026 at 18:36:21 +0530, Gopi Krishna Menon wrote:
> Convert the STiH4xx reset controller bindings to DT schema.
> 
> Signed-off-by: Gopi Krishna Menon <krishnagopi487@gmail.com>
> ---
> Changes since v1:
> - Changed unevaluatedProperties to additionalProperties
> - Removed the Suggested-by tags

Reviewed-by: Dhruva Gole <d-gole@ti.com>

> 
> Note:
> * This patch is part of the GSoC2026 application process for device tree bindings conversions
> * https://github.com/LinuxFoundationGSoC/ProjectIdeas/wiki/GSoC-2026-Device-Tree-Bindings
> 
>  .../power/reset/st,stih407-restart.yaml       | 31 +++++++++++++++++++
>  .../bindings/power/reset/st-reset.txt         | 11 -------
>  2 files changed, 31 insertions(+), 11 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml
>  delete mode 100644 Documentation/devicetree/bindings/power/reset/st-reset.txt
> 
> diff --git a/Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml b/Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml
> new file mode 100644
> index 000000000000..0dd7f5e98157
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/reset/st,stih407-restart.yaml
> @@ -0,0 +1,31 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/reset/st,stih407-restart.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ST SW reset controller
> +
> +maintainers:
> +  - Lee Jones <lee@kernel.org>
> +
> +properties:
> +  compatible:
> +    const: st,stih407-restart
> +
> +  st,syscfg:
> +    description: phandle of the syscfg node
> +    $ref: /schemas/types.yaml#/definitions/phandle
> +
> +required:
> +  - compatible
> +  - st,syscfg
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    reset {
> +      compatible = "st,stih407-restart";
> +      st,syscfg = <&syscfg_sbc_reg>;
> +    };
> diff --git a/Documentation/devicetree/bindings/power/reset/st-reset.txt b/Documentation/devicetree/bindings/power/reset/st-reset.txt
> deleted file mode 100644
> index b63948737d80..000000000000
> --- a/Documentation/devicetree/bindings/power/reset/st-reset.txt
> +++ /dev/null
> @@ -1,11 +0,0 @@
> -*Device-Tree bindings for ST SW reset functionality
> -
> -Required properties:
> -- compatible: should be "stih407-restart".
> -- st,syscfg: should be a phandle of the syscfg node.
> -
> -Example node:
> -	restart {
> -		compatible = "st,stih407-restart";
> -		st,syscfg = <&syscfg_sbc_reg>;
> -	};
> -- 
> 2.52.0
> 

-- 
Best regards,
Dhruva Gole
Texas Instruments Incorporated
