Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FCF442B0F
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.168.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784905630; cv=pass; b=c1k519cpIXJ7hq/QXCX1VSKaewPPHjOAKQYoAsxAI7WYWXAteUN3ipFgzAegNCfn23Et/WWRcKyOgZXSEshBNoRwE/GgxQdZRudTmKRHthAACdAeZ1GlfYVdiV+4KmzEuWu4QdUEgjGS0qCuNGXWO9sPeIDLA+AmVcUlRyqjRO0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784905630; c=relaxed/simple;
	bh=TqF3wLHIA1jAdZt0Tltgjjcw3xRF7uJIwJwkCK9UGR8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ukyGgysfvxpJP2hdQDR8BqwpS6cb8uFtgNirkhZjpQrP1eqL7hUUDFDDytu69qy0ohH8VM5tvie/Vh1r3rsrvzTPgg3sU6p64w5BhUEVPc25KucSl3Bs8V+oPc9wFFOR31HReXV8wnjdQUqLSLT1sG5SSwt2tBcaGtfuNrlxx1c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=CMNYH8YK; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JxpEU75B; arc=pass smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="CMNYH8YK";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JxpEU75B"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66ODbA263344414
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:07:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=; b=CMNYH8YKsP0vLnKa
	kg5kejSOcOGDDykg6w4NaAMhIZjMwg5Hvpg2qVVAeGFA6SXIkFXHAI/V9jYZZTSy
	RttEgtp4bwm6aE9p1KGLNE0/MB+O/oivlVfzYqqXeDZ/TYz39Fv1fPEUWjQMmKmB
	ZOhZL4fM89UgzYGiONz5xZQQ8LEp9cpVqsU7E9WNOiG8/iFseatouKgfxZnlVqh6
	rWFhOjCyVDJkJyyzui4Pk9uGykx+T9GFLHJOTV+t4bciz5za3v7JZndxoHiqDk4w
	c6pEZ4xZYfHEQPLIJ2zTQeesRUAuDTSkH8JP6vyj4qfAeEMOO27lPxff5lNMPRVs
	QuKvrQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fm8cf0hux-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 15:07:04 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-92e8004d60eso84893085a.1
        for <linux-pm@vger.kernel.org>; Fri, 24 Jul 2026 08:07:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784905624; cv=none;
        d=google.com; s=arc-20260327;
        b=coX0bMW8RgwFZsX2ipmkbNPwcu+Bi4lBnjtdu/NhhxXJxZpBMrIiInfxX2PwSsHRTo
         xWN7UY3ZYLsJjI3gKlxj6Y/PwtUyvctOiBILsdFCLZAx+SInx1AP6QVIl2L8dgpW+Tru
         nDdnDP/AZWWtUCQ9NY+G9zkoqhxPaq76EQ72wn6e08mNWv/f8O47t+1+5QcZc94wNcwi
         a4PFDbFIvxZgzcEyMZQo49T+9AZurfFhqKlXhzkAndcZ0e3a49xQKKqegmmPEl6qFmXu
         H2AjV3lfIQUE2ai8BBfCzHG3Grmtke0r4Qtvkp8D+gvb57HzwXx6GPFiFrlP1b+kUEIH
         Caxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=;
        fh=981TFLNIgRahmlqD0AoDNJd+qbF3jRAgZXSCnaDB8P8=;
        b=FT5TclCh7XcPhwqDAKNOULl1EMRlc86LDoEZUNKWDctEt3NH95+ifRQJvyMCJbecfg
         CK5LNxY4zI7q9rAmgV/GSy4wjlG/4ljd/jpG5GVsWnTGs7BVBE5IGmdqxvtUej9KhX04
         qLKW/jArqXKacrp9FwSy9lVJfA0rAOFlSn97c/ccTP/YJEkbfvzgqr3S7ykZUYCV+7bA
         EefbH5svziPapKyEU1R7YRgGEjShtHHQhQ1z5eBxMwgHG9ChsfiIQH7u9dkg8ji5jeZM
         gHnualycxwX9rKxnCwV9CGlBUFrDnroHGoHFZ5cgBcMg0NwOpObw89ff9up2rDy8cCvD
         G+cw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784905624; x=1785510424; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=;
        b=JxpEU75BJcGFAaPUZ+/wUj6q4yHKXfY+srcPSOK3Ckb61ZNhg6GD4cHqefnm8+C3Wt
         AVBnMScCSDWTsDiCqZMgzmpzO2IabglLt7S/4izdAo5QNYmo9lPP1qNYTCB55nktSkpl
         PEOlnhRQm1E8t7VhCgg+OcAs9P12PJnGc+LQ2Ax9H9a7BprU6n14k6UuyLWBc/4P7QzC
         segY1AS+4t+ZAlWyPN3TzL4REiGQ1GNX+QqC/pAhZt1w2cnLBldPjfG/OpjZty9TMOvj
         yRx7jll5WINMV755kkXIlQwftSOHHiV31VdJA1WxamHS6Bl1+dIMApug/WLStHu2Lc+c
         VJ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784905624; x=1785510424;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=6iZwoWyplh10gQFqizgnNT67wlnEGukSQwIPfNxV3K4=;
        b=U5Vdx0L/w/gSOqTyJM8VRa5wIEmycPVzFrIVVBsfCZKdNxiO0RseOFejXcfD+lxSOj
         gIJUaoSU5BfKxdOoH5EBh7sloBcN14sULCQFXvNbO/Kbe+UzOFnWek0sFsfoI8uGSJPu
         3O2/uwlwSLYIykENr//Jfa6Gz2pvA17qJ+hhhf3EFl6rw2EWVwuO2eQeQS3VHBUj/1hq
         sBAfm8UEGbQIVOCuGM+HctYmUEi364r7fyvfQFZQRnw9yjakwecFW/z05x4Aj1m8rlwp
         BcAhIHMu8G/Kfed3akZVwQ38TQ8Rjn0ZmSCHjQRT5wsLV+5knyogvhmtE7DOW2wW6GRb
         6O6g==
X-Forwarded-Encrypted: i=1; AHgh+RodFoZxXFfrlwOb4/Fi+5qfxAbPflVLG2tWT7RTK0XELXi4kKx4JddNU3XrfTn3G4WCDo+kIKCQaw==@vger.kernel.org
X-Gm-Message-State: AOJu0Ywue5Vkq6phN5ZQvLfvhpaLjBHyCHO3iXdpaaNBkjP0+XNjgRDa
	d7rdsA5ahL1PmN0VPGerlFl5f7U9RY0G8UGkQMzmqAwrOx/jj/pWBSE0bdNqtvJgC8Y4tpgvgnP
	JAZNPI4Eio0akV2IxjSwcX215i6sDUDcJQOLgd734+aOzK0rB4IDLhJbDZzrxtiB2vqQfig0+/p
	9lfoTcAI4WX/rGeyW0ETVdRSjFZNDzYEEg+ds0
X-Gm-Gg: AR+sD13rxfGeT4IBp5OXh61kObPL8P1+pXH49cxpxQ6bTFnqjUay81GzFALjj3dUZ9K
	04+OBEOMwFTxSMl6PP4BngXxH0qwDy/84ql3eJT6CoLOacRbCLX6LmFZPhkgdvLRmOlpavoz00C
	3IScJK04rZ8Wl0A522w9KrfMVCOY1fXyAQYY1zlOVZ4vG0yNGQVhd184Vrfw==
X-Received: by 2002:a05:620a:1b81:b0:92e:c118:18a9 with SMTP id af79cd13be357-93103a65117mr772233385a.92.1784905623929;
        Fri, 24 Jul 2026 08:07:03 -0700 (PDT)
X-Received: by 2002:a05:620a:1b81:b0:92e:c118:18a9 with SMTP id
 af79cd13be357-93103a65117mr772229085a.92.1784905623517; Fri, 24 Jul 2026
 08:07:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260720-pdev-set-fwnode-instead-of-of-node-v1-0-2dee93f42c54@oss.qualcomm.com>
 <20260720-pdev-set-fwnode-instead-of-of-node-v1-5-2dee93f42c54@oss.qualcomm.com>
In-Reply-To: <20260720-pdev-set-fwnode-instead-of-of-node-v1-5-2dee93f42c54@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Fri, 24 Jul 2026 17:06:51 +0200
X-Gm-Features: AUfX_mxUpEE-_djVPIMU7ZvWbbzhCFmItK3_9wrfK5-RcRFUSwGHiGhMmnFjL0c
Message-ID: <CAPx+jO9=HWwr4jGoCcWAM6fKTTrg3TphgPiNX+4yvfnyEZa_pg@mail.gmail.com>
Subject: Re: [PATCH 5/8] pmdomain: imx: use platform_device_set_fwnode()
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Danilo Krummrich <dakr@kernel.org>,
        Madhavan Srinivasan <maddy@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
        Andi Shyti <andi.shyti@kernel.org>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Doug Berger <opendmb@gmail.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Ulf Hansson <ulfh@kernel.org>,
        Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>, Lee Jones <lee@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Srinivas Kandagatla <srini@kernel.org>, brgl@kernel.org,
        driver-core@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org,
        iommu@lists.linux.dev, netdev@vger.kernel.org,
        linux-pm@vger.kernel.org, imx@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, mfd@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDEzNiBTYWx0ZWRfX/zq+mz0tr3rd
 ax871PUZnDHVriIFQ1w58wgV90pMp7y0sAhHCgpwM4d4Jo1MRDp/lks+IGUa/jDUhQxRkJGfOoU
 7bILMvHR6aU4h4vygDOhkuLj+oCqOeU=
X-Proofpoint-GUID: w4k5sFKVjvh5Ody3vOjCbmyKxFHp7Iob
X-Proofpoint-ORIG-GUID: w4k5sFKVjvh5Ody3vOjCbmyKxFHp7Iob
X-Authority-Analysis: v=2.4 cv=er/vCIpX c=1 sm=1 tr=0 ts=6a637f98 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8 a=VwQbUJbxAAAA:8
 a=RwuSGLWl7VkFDbmKPUAA:9 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDEzNiBTYWx0ZWRfX+az2Bwmyv/Hj
 pH49emIcsyyofOQSvV7v3xVUS1ypca1cRdC7q+T99DpY+dVXYnPRW8yfzGR+KHRxiHbku6YulS9
 +GIpWpvjVhfydWMaO3yquRmMmXlx+mY6V3xZDOp4nQ7YLM8E2EiNLwHCuTnH9yXczyM8fa8Llvq
 tzA/E9Iw94lQHlBoCLMIrh0Sl+WQa9atgutMfjJJK/yFREhHc2SWfUmw4+8syM1RBz/gx8RfG2e
 MG4bAKQCmS7muJpgjseXafQZPqRJXIs/sL0NolAVHjxq3zdl1Un9eCCWqea9rVogZLTAxChYK9w
 zmPPjXu7APTifVI2u8NMPq3n3oUhltQdDixTSl7jEvIZcRCLTZVaqGB06Sl4SVD+SCiP7xYOb3h
 0YJCaFKsZlOa2g+FpTsD0RL0DmgFt1PtCkI96SYqu3uydtpbKwwPadr84/lHyToFPnl8WeqdPXS
 FmF17/8Fnr5t4mQgEHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240136

On Mon, Jul 20, 2026 at 11:25=E2=80=AFAM Bartosz Golaszewski
<bartosz.golaszewski@oss.qualcomm.com> wrote:
>
> Prefer the higher-level platform_device_set_fwnode() over the
> OF-specific platform_device_set_of_node() for dynamically allocated
> platform devices.
>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

Acked-by: Ulf Hansson <ulfh@kernel.org>

Kind regards
Uffe

> ---
>  drivers/pmdomain/imx/gpc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/imx/gpc.c b/drivers/pmdomain/imx/gpc.c
> index abca5f449a226fbae4213926e1395c413160c950..c147eaf048ba2b79a744ec870=
29420981581e48e 100644
> --- a/drivers/pmdomain/imx/gpc.c
> +++ b/drivers/pmdomain/imx/gpc.c
> @@ -487,7 +487,7 @@ static int imx_gpc_probe(struct platform_device *pdev=
)
>                         domain->ipg_rate_mhz =3D ipg_rate_mhz;
>
>                         pd_pdev->dev.parent =3D &pdev->dev;
> -                       platform_device_set_of_node(pd_pdev, np);
> +                       platform_device_set_fwnode(pd_pdev, of_fwnode_han=
dle(np));
>
>                         ret =3D platform_device_add(pd_pdev);
>                         if (ret) {
>
> --
> 2.47.3
>
