Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA108409287
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 15:59:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783526372; cv=pass; b=ABUPPaTIrDY1C6vDDuJqxphkN0G93h9nzxrTfTGADb1Nfk7tAeJPJX7FJ7GSKY8P5GOVa2DfIOQRLv/nMDpaT2aDVFNYnoTridLBV8uqwPW3iD5fDRxaijgbk0xSt6FkJwmRD3OYCMIQPRoSkQnalw0IqooiIW3dlnEp8Q7fQDg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783526372; c=relaxed/simple;
	bh=HIVEgcuKsvKP9oTptdmuFPNK/sIQQFxDjbmix66hFW8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GTeWuUempKr9CLG3tAQMB74wuj15eY+y4xUeGg1OepX7lW50QmMClYj3IJ8dD6XXri1oj8fbQJWUXDOoo/esozoJ3GMvVi6b4Hfmv6bbKsVP23vCkW65+tUiN521nO49yr4LNKqlgglqJ+w7hWCqK7PGyZ1AFwkA2iIT/DOVQuo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=XyA045nB; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NpWBtQ04; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="XyA045nB";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NpWBtQ04"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3PwO2667189
	for <linux-pm@vger.kernel.org>; Wed, 8 Jul 2026 15:59:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	k6RDR7xs+vqWJV5AWHV0iQasXN7uaTYZIuIDBIYGDn4=; b=XyA045nBOM5EH5Ke
	LNkFrfA9nQDJlcveGj2IHyeLt/bwfZVepg2Lvu1e8orRvbvsxiIi7z8zdI274WG1
	boey+aCihWfvPW4e5Nw6dcPx4Vj8dz8y3KDI3BfCIOP9AKlfSYhb48poQ21W5n6j
	gzaStDxvYVKkgOiRbEePjq89MlTbXpRjCEYHnTemwLl3whXN7lv60jJO3ClGjege
	h92FRnTFNsKKDVA9IbE/vq1trLW3UwOxTMH+GILaJxgi77uiIykYMQLx+zAiEJ5B
	tp8+/n+37p6V0FGEd4wpGQ5aC+xKz2KHp7F59PUEvOgGcn+nQivIx0OiMkAUKtu7
	8jOAOg==
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com [209.85.219.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f99hgv2xe-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 15:59:29 +0000 (GMT)
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-8e86066fc53so163406d6.0
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 08:59:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783526369; cv=none;
        d=google.com; s=arc-20260327;
        b=bGGMLJagg3CHtoeUsMNLIN4bBRz325Tl+dqkrWD4hfcSqWj5Pj2BfzySPAIbcv1onF
         SQ4CsBP6FzrfqR3cPJgsLkCOXp31mBaaJqkmVQjYePe+wQhUNgKbdT5cwknftZanjlW6
         O83sEYlngu0OOQljCsQ3RFFggupgRVhtkkUlWKslGg9Co5EQ1gUdpv8ChoPFPXlktsZM
         31tEP9whOELsGB+/F+taSeUjwJpQgIcveLrzelIGRZi5npPj9bCcsfvvGKboBJthS2zU
         CqNrbLglcQ8E32vYK5EpIK4R9LoCMfUwBNonF2VccGKQ2TTiKCItH2CJ1TTKAdLAX2b3
         7XdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=k6RDR7xs+vqWJV5AWHV0iQasXN7uaTYZIuIDBIYGDn4=;
        fh=ApySQqSWfbsMA3zhbfVdt2GU5zE8cYZwz4r/A6FK6UY=;
        b=KxzVxnldnwkdhXjvznL0oTDxUzeEQBHJ9jCjju/2kswMCoW7+pBIqqTI4S8ZNWSpym
         3hrTYfQPJLZLPncuPwP5+FBzB9Ee0ObAP7rCAhESIuV3VExEqflTBWIgI94vAbAf5t9w
         51oD/5OvZbDFKHgCb8dN6UKvkymFAZmEIu52PteCa1NnsPskoc+v1Sys+A1SgyIdOSdt
         2BaJ6oxD9yUsJuivNuvqnaPJXd+N4OkI+GE2BzxeRB3nYf344PSGn1EyRzvKRRUg7DcU
         9ZKYzBk8mb+lO0fGyoJYibdrBpMbah3IHuUmCCNwBrJ2lm0xbSb4TfFZtYJn09EOrBuJ
         NvXg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783526369; x=1784131169; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=k6RDR7xs+vqWJV5AWHV0iQasXN7uaTYZIuIDBIYGDn4=;
        b=NpWBtQ04amdXupl7spST7zeTGHQ9nvmPtcMLhaoY06nvmjtOHE2uXbhUAUl/IMzLxl
         sfH9e4XagAgk/Fdn2vSpjjywHLC9RXbGCieh/qAjyNpPfKpAIv8+xkki/Sp9M4Ck9XyM
         H0Qn6vZOJ3wQHW95ohZH6gV5/FXC4So3bSKQddp8T0NHMHdEy2Xzds3UGLYgdukQQ5YO
         9Paf/8wtSDwmB77OGbqvf66TyYGIDT36V/btmClpavqR2naGKTrCP+rRKddxJmVuGcKd
         a5hUDM7GG4/UwmfSD/1Bw1KauFcmE376mhci7sKniDFA+GHzmOZ4NYxPHpTErXEjg6fu
         SXvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783526369; x=1784131169;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=k6RDR7xs+vqWJV5AWHV0iQasXN7uaTYZIuIDBIYGDn4=;
        b=b+f6AE/nR/X9I7F0MDGwIbHJAuq98MfamW5MDk8atDK6gwH3JkUN1tGqeHQlg5J+a/
         Pmzo/HdLZ+rSFTEHFfSLP/DpjPpQaRpg8+pKoCYrWnbYi7M9rFOMlfzFxIoVkMfv7I/O
         YsFU1WrBShuHL14suw6+mJPeFAGcEmanI1tDASzbp9WODwz/bR7+LPACmvyNphFAnmSC
         /YtBzoVWNTHVwy5HBbT50eWnr20YA9Mq+ZaesJBdEqG/W7g8TYQwrKBuTrX1139x1N7Z
         RS1LPAwqD/lKUCh+9G1GzV9fnIQTxIei9ay0uVy61QRt9YJXfoAXau9ZzWiNTEKRXTsG
         80Ew==
X-Forwarded-Encrypted: i=1; AHgh+RoEPlUuqLfRyJmJCMf0EJDt37GN7hRMng9IkIfcZ3pAJH2UF3H8ZgRs4xcnrBSThVRroKe+S2eKgw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyM6aoyFBlkK2L7X8jSTCUaxqM1IoLyLl6+6lY9xNBZ3lwDpG0x
	YCL0aSr8dKKV/6cYByY4Djwo7SQZXliDDzF76pXxCLznqvg9r21B+88jloPwXLOf7wuVtL8Qz/a
	DoYIF0kO1U3GOGD8K/9rA9mQ5JcovDFUxRZA/Q9NrtwK42paT7YYl9mCiXyBH3mdQlxqNLHs2p9
	0OktpOVwUS4XOotPKeJ0y70zYfnNGZGY7KDGRo
X-Gm-Gg: AfdE7cnz4wFmxbN4QLgoKkjEYBkONZdJlBJS4vykne8IjUwHzwcrnr93Dwy+OYUNh/3
	2bUaFLbM9qGWR49Ky0PbjvssH2vpqmD4zrXSvOrZ0ByYv5W4ML+UnA4t1tGu0cnaKPAQLqUKqYt
	hhbWGv1ILosZRWdSFqgxBXWc8mfNi605asu0AF5HLuZUwqQn1Kd01auIN6t5tfk64LgCJY
X-Received: by 2002:a05:6214:20eb:b0:8f6:9379:ecb with SMTP id 6a1803df08f44-8fd3b9b13b5mr81855066d6.26.1783526368985;
        Wed, 08 Jul 2026 08:59:28 -0700 (PDT)
X-Received: by 2002:a05:6214:20eb:b0:8f6:9379:ecb with SMTP id
 6a1803df08f44-8fd3b9b13b5mr81854656d6.26.1783526368570; Wed, 08 Jul 2026
 08:59:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260609-pm_imx93-v1-0-d06c004b0f51@oss.nxp.com>
In-Reply-To: <20260609-pm_imx93-v1-0-d06c004b0f51@oss.nxp.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Wed, 8 Jul 2026 17:59:17 +0200
X-Gm-Features: AVVi8CeC7wqwD-02BFpq0hOApFiP2f8o6VkvQcjct29H4Ae_roSruiCfTUPVGNA
Message-ID: <CAPx+jO-BkzRPcuxkC4rCwGvXg8io_yD0Cx7zrwC6Sw6t5ff3SQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] pmdomain: imx93: Fix shared MIPI PHY resource management
To: Guoniu Zhou <guoniu.zhou@oss.nxp.com>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Ulf Hansson <ulfh@kernel.org>,
        Peng Fan <peng.fan@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        devicetree@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-GUID: wVE03YDHMtDT5oGbjXzSW-V_VmR-FwhV
X-Authority-Analysis: v=2.4 cv=CviPtH4D c=1 sm=1 tr=0 ts=6a4e73e1 cx=c_pps
 a=wEM5vcRIz55oU/E2lInRtA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=rJkE3RaqiGZ5pbrm-msn:22 a=8AirrxEcAAAA:8 a=v9JiyUteCMCEH8Pa4FgA:9
 a=QEXdDO2ut3YA:10 a=OIgjcC2v60KrkQgK7BGD:22 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-ORIG-GUID: wVE03YDHMtDT5oGbjXzSW-V_VmR-FwhV
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE1NyBTYWx0ZWRfX/SclE7B5hbuR
 t9yUJrFrlQ0HmPdEEJh8adFV1NaKLVdmwsWkSTZY28Hm5smfdkivUmAVLZ67kWGCt3UCv2f6nQY
 pzo1ZwYnrXxysO2qPVxT21kW1eRBQLM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE1NyBTYWx0ZWRfXzhWoxyJWrS7P
 RNA/FYcQwjp2MqCBvEcMp1VsBL9DH7NfXab9YC1QJFfGecyAXc83MY6rz53qcb8ttTNRgx6Rrmj
 xJOpp/1V/JtRhE9wytLPm2ZyYom42O5rfqvjnYe7kJs+NDgVP7OqJg9uTfmkRsd7jzLkHgau91G
 XjHzVOFpOfdCEpWbtZIWR6btMvzeEORlJpR9v82bbtcYiA3KpV95slJe+2DQRlhAWDHLOrWqte/
 Jy/qqhjSAA4hd/w4zc91oJyuuvLhdKe/X4oyGvydy0mRzxxT0w1VVLgAjM1iE9ZoGipJo7eLyA9
 LClm5belvfAI74TKYRELNCJzU4tmWH9p00jBWp/Hs1IJzVA/LqcCdNnEwx7Z1Vy1YkTn66ut5+M
 nLS1IljIykYG+Ez3UKJ92JUZCvjId+Iovsp/Xr9fcybwJ2Vj2hdeURqOanv9FvCwBeCBgVqIbpa
 1O3cXoQe0LiyeGsmvTA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080157

On Tue, Jun 9, 2026 at 8:24=E2=80=AFAM Guoniu Zhou <guoniu.zhou@oss.nxp.com=
> wrote:
>
> The i.MX93 MIPI DSI and CSI domains share control bits for clock and
> reset in the media block controller. This creates a resource conflict
> where one domain can inadvertently disable shared resources while the
> other domain is still active, leading to system instability.
>
> This series fixes the issue by introducing a dedicated MIPI PHY power
> domain that owns the shared clock and reset control bits. The DSI and
> CSI domains are then made subdomains of this PHY domain, ensuring proper
> reference counting and preventing premature resource shutdown.
>
> Tested on i.MX93 EVK with concurrent DSI and CSI operations.
>
> Signed-off-by: Guoniu Zhou <guoniu.zhou@oss.nxp.com>

Both patches applied for fixes and by adding fixes/stable tag to
patch1 as well, thanks!

Kind regards
Uffe


> ---
> Guoniu Zhou (2):
>       dt-bindings: power: imx93: Add MIPI PHY power domain
>       pmdomain: imx93-blk-ctrl: Extract PHY as shared domain for DSI/CSI
>
>  drivers/pmdomain/imx/imx93-blk-ctrl.c       | 60 +++++++++++++++++++++++=
+++++-
>  include/dt-bindings/power/fsl,imx93-power.h |  1 +
>  2 files changed, 59 insertions(+), 2 deletions(-)
> ---
> base-commit: 3b7a18a34e8d3b14c7c926f033488a0350de9759
> change-id: 20260608-pm_imx93-6ccc1aa11932
>
> Best regards,
> --
> Guoniu Zhou <guoniu.zhou@oss.nxp.com>
>
