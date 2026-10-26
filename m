Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.40
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793021424;
	b=FnzDWUxJ0cY7SMMKiPbW6yhtZBJBEnYEhC4Z+nDTCayy+V3GkUjsYSoLKP7e6zVJZYa8
	 J3ARVyKKp81FwdpXKZP1F6TykLGc/fE1MVIGKuzB7AOwZfJu7KO3vfGpUWoxEsY/PrccI
	 81qcBQ8IkZDjVnd40W/jz4T0BwcmQetzTqv+/BwUV1n2QJKhWd8Uema4Q9IkOiwU0oEu6
	 05yN15nnADz6EbzwsyrNwPGMK/FvFkSWZQeSbcXvaxiaoDFpZoTuZtJpkEQS0CeJd9hqz
	 cHLK8xEsqMem3fRVDMA/6Tcn/IRtVzxtbHtGOg9dFcorTWnY43Vbbuai5fUZVhQc9lA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793021424;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type:X-Originating-IP:X-ClientProxiedBy:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=q6LTyNLJ44MJr2afpUnePklsH9QfB8xh7wh0Tvewn84=;
	b=T3ctTpo3aTUTmUbQ2jhAb8TZEZwbUkRY9UJmXrK2PPQmk0sx2DlrYMNep3FlsdNZoiay
	 zIHxvxzgeSMkG3gsKUmTsWFo78ID7TA1E9kJqWv9rR7FqKp2Z3DZh0xWAVX8Qvge0H/Fx
	 gsGXDlFWvI04eActG/xs7JRr4n/qNTHd7WF39dT2Zp4I3wga0bRNeDyIvrfpP2+mj4yLC
	 oiYQaAdRMDjDQ3q49uDZ+saRZKYcmCI42KZawmXuRZnjHZatxiJ0k1hA+EJhAp0Fw4J4+
	 hEV9Ol9Fb1zXGCkzplt6B+r+opf8IE1g/ZhzdQ7h6m2gK1Eirr6ITD2qywOlhu2o3jg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=axis.com;
	spf=pass smtp.mailfrom=axis.com;
	dkim=pass header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=cBMBHQtt;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.40
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013040.outbound.protection.outlook.com [40.107.162.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2690C606A325;
	Mon, 26 Oct 2026 13:30:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2690C606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=axis.com header.i=@axis.com header.a=rsa-sha256 header.s=selector1 header.b=cBMBHQtt
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RGENFpAZdq0xzml9Q/FwQ4Z7tPfDycuGnULpqi9n41Q1X2J2Hg/mRDNnxP9VuM/cinhD5hZm1zN9lxNycgwuP553ews4jTWMusDssDjLczpJDLYi/vl3gm3FYR7ywTOejEnFrGjxYSgYsQmZzaWbBHNntwPMoi4F6tgKIAhiTqLNFiaYl1ha6wQn3zMQpB3CjsLYvWUSVkdzffL3DCEc30kmQzSPaKG6z/5WSRaSU1Cp1kbOMNFJLljBvE4Q0lzhEIXS5B6wD84HIyV4rjfYU4BMFZqaMJW1qXd/5tMmIscR2tckpoYPu6CrE1t6lsGDSRVo76N0H9CDkGfOe7Qxfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=q6LTyNLJ44MJr2afpUnePklsH9QfB8xh7wh0Tvewn84=;
 b=s1rDrdPhL0csFtnyHf/s8mM+uvcycwEOqJ2J8IcW/oc4xcnU4aTTpRNcX63yW5HZUc1n+JwqnAWHSEW3P/g73N3tjfMBJOGzunboNULjtRT3UUij+zNaKod4fBB4eJDL4u/qj+gDqkTtnurl1sgxWVRDOPQLMzlrngZYM2Yz/tbhjPgARE4EOxaVIPI0Te/u8OBnEScne+N1tr/wKl0jMBLbQljGvklyaR2Mqqc3GFsJ6pJCNT1JcruyCzicvAs3eUtMV8QteQ7g2L5e6Grr9cJl2bktN6r9OwMJV1UtSIrQKX2tCLquGqc6on28HpLdD+qRBEg4DLYBIUIXhAuYrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 195.60.68.100) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=axis.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q6LTyNLJ44MJr2afpUnePklsH9QfB8xh7wh0Tvewn84=;
 b=cBMBHQttFLnAOomnTQjYqaQAoep95I272qv4zyD4OulfMraoY9dp1mlVtYBmTBCjtbDdbuWU39I6Vhq6onJs2WWaSumsFds2P8ZjpT8dkiNDawhHMsvj+QsjAxY0XG+CZphxvDT5cs3Jhp05+pr62aKM92RRMRDMkSgMl4OClvE=
Received: from AS9PR06CA0778.eurprd06.prod.outlook.com (2603:10a6:20b:484::32)
 by DU0PR02MB9586.eurprd02.prod.outlook.com (2603:10a6:10:41e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 13:30:21 +0000
Received: from AMS1EPF00000092.eurprd05.prod.outlook.com
 (2603:10a6:20b:484:cafe::7) by AS9PR06CA0778.outlook.office365.com
 (2603:10a6:20b:484::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 13:30:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 195.60.68.100) smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=axis.com;
Received-SPF: Pass (protection.outlook.com: domain of axis.com designates
 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com; pr=C
Received: from mail.axis.com (195.60.68.100) by
 AMS1EPF00000092.mail.protection.outlook.com (10.167.242.89) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 13:30:21 +0000
Received: from pc67007-2609 (10.4.0.13) by se-mail10w.axis.com (10.20.40.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1748.39; Mon, 26 Oct
 2026 14:30:20 +0100
From: Waqar Hameed <waqar.hameed@axis.com>
To: Randy Dunlap <rdunlap@infradead.org>
CC: Sebastian Reichel <sre@kernel.org>, Mauro Carvalho Chehab
	<mchehab+huawei@kernel.org>, <kernel@axis.com>, <linux-pm@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] docs: ABI: power: rt9471: Add newline for paragraphs
In-Reply-To: <45832309-7569-4a9c-b24a-f7838407caa1@infradead.org>
References: <cover.1792965060.git.waqar.hameed@axis.com>
	<eb8f0f6be0386b0f114c3d7cf2be1594d062d94b.1792965060.git.waqar.hameed@axis.com>
	<45832309-7569-4a9c-b24a-f7838407caa1@infradead.org>
Date: Mon, 26 Oct 2026 14:30:20 +0100
Message-ID: <pndmrs0vbbn.a.out@axis.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: se-mail11w.axis.com (10.20.40.11) To se-mail10w.axis.com
 (10.20.40.10)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000092:EE_|DU0PR02MB9586:EE_
X-MS-Office365-Filtering-Correlation-Id: ef5d8709-d4ed-45a2-61d1-08df336548b2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|1800799024|36860700016|23010399003|22082099003|18002099003|3023799007|56012099006|11063799006|4143699003|261022075727099003|10067099003|261009223027099003|261021135927099003|261021121427099003;
X-Microsoft-Antispam-Message-Info:
	05Ga0+M7B7fp34zNi+oUncrnyxAzQpiU5a4rlmhBplDBcTnregl7w67OigL16wo6asdez+hpJ3Mr32lT38trZyc1s5ebhQyQL6I+EidER0YFtIAG/kUsePKbdLHNIZuYlY7Dh348gXLqFm21iEcgPzswsQ0Ltpi9UmfeQiPRE2umOugK3vj6ZtebG9dAf/az4XRE2k4ZniOHXasaYUdSs/NFgtw+JH5f3ujqn6Vxx0ZlHTGbVLYEFCq3b6sihgWdIUEgjK/RsomY2FksCHPJ168NzSRTvxniqpjHdQfB8/QxluEzxjtQSl2QFXEDLZZjMXUnvJ2xtGKI/+X9UAsvqX44SjKaLsXmPyeza7cpr5bzYmC0eXBccL/oCWMfUoqo7MDUrL1dEmaeI8or7yLAjb9guNKgCTHSt9Uo+KS5t0rs3t0TebwXz1Q4019gf1s4xXxXsmCxlc1cSHvHrqaEPYG1Qp4bONNmTILLfGozwjh0wPUoBGO+jMoxXZQiUIoDJ8xVcckuTKns7K+lzISGjW+7vYU+xgsnTpR4iRNipMaRQUhHrhMGzrsDeH5izsxKY4R4skquOVcIZdYKvOgcANj3bB+cko9zuHe91sjx/qs+eHYyqyqgKlD+R8V+TTofr/Ym42MCGjY/oh84UI2KRo7mQJHkEsaRHgZVBdBMwvc=
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(1800799024)(36860700016)(23010399003)(22082099003)(18002099003)(3023799007)(56012099006)(11063799006)(4143699003)(261022075727099003)(10067099003)(261009223027099003)(261021135927099003)(261021121427099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nERcVfBXaaxkL90ExucBZ6i/OTTIDioz31asOEsDAeBkKXeA52o+B9GHNVC4ajZGIf5siRAmG5My4KL6AC4RfxoBlqbOF8qhoLblPnnQg5B3OV2ZsiiyOx/TggCkgA1UL56r4uoQMptGS1I0M7jTTPGI5pMVstpR48fkfhbrATNpOcze8VTXYcbIsgrw6hPOoIDBEf9QhIGHtiZ0WX4U8OQNRhrp5EFsERQrVHKGAfajV1+jS2I5HOJEb9f2DcQDJg67U4/gVYnqrD2uTw7gz8tbIXmH5mrizAy2pH/WxTyZGcrFcs2E1cZFAOk0GDVXfWlKv884KHuRpU22/N+4PHV5h5d2LwR5tsko06UOCb6jaYG+Kz6QZiTK2+qpgWRdvMTfYgISyDRHfNckYFs9pcSUhFdRlKWC11ZJwK7WBlggB9eJ50zzcPFK5SR3hdQM
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 13:30:21.3904
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ef5d8709-d4ed-45a2-61d1-08df336548b2
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000092.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR02MB9586

On Sun, Oct 25, 2026 at 19:29 -0700 Randy Dunlap <rdunlap@infradead.org> wrote:

> Hi,
>
> On 10/25/26 3:05 PM, Waqar Hameed wrote:
>> To split paragraphs in reStructuredText, an empty line is needed.
>> Otherwise the output will be:
>>
>>   Access: Read, Write Valid values: - 1: enabled - 0: disabled
>>
>> Add a newline in order to properly format it as intended:
>>
>> Reported-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
>> Closes: https://lore.kernel.org/oe-kbuild-all/20261020101625.01874245@foz.lan/
>> Signed-off-by: Waqar Hameed <waqar.hameed@axis.com>
>> ---
>>  Documentation/ABI/testing/sysfs-class-power-rt9471 | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/Documentation/ABI/testing/sysfs-class-power-rt9471 b/Documentation/ABI/testing/sysfs-class-power-rt9471
>> index 04a771cd23512..c306e2ead6bb7 100644
>> --- a/Documentation/ABI/testing/sysfs-class-power-rt9471
>> +++ b/Documentation/ABI/testing/sysfs-class-power-rt9471
>> @@ -12,6 +12,7 @@ Description:
>>               the action before the device really enter shipping mode.
>>
>>               Access: Read, Write
>> +
>>               Valid values:
>
> It would look nicer to add a blank line here (and below) so that the 2
> following lines are processed as bullet items.
> (as Mauro suggested)
>
> Same for patch 5/7.

Oh, missed that one! Will fix in next version then. Thanks!

There are _a lot_ similar cases of this in the directory. I'll let
someone else clean those up...

[...]
