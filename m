Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59F5E340401
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783934756; cv=none; b=tDBvdGF3uAB017fhBphfCINz1XtyLIqchj+b/mrUMNhdyTQuYe1xInIUmMb3zGEvkOSQD1nllao+Nfg6I0CPRx6U23Bm60hrMT9EbnSPrnSZe4uULpk9MWNxNUJV74dB2eK89IKpXL5Dt+7bubLNBEXfelbsaRXKQytgqqKyYmc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783934756; c=relaxed/simple;
	bh=IGwU/XzHL5SyWQ9S/hw4TQ6IbW+i1/eFqewpz5BZux4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LctlgIzpleSSg5b2sIPJBKAAjTuWnM5bJ9g1oT8nyti47cjnNFoQi9MJ+Q0UenFjX68q02jeE6Res2cbb0aDbRiYdNaliDT5ObOj113Lh/GXtnlsPUptIpe6LOgO+Hf48hWtJCK7rMA2L42lZLwsRnDH7/vIL+9oSWiYGcbVSDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=D4r0JED/; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=URT92oqC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="D4r0JED/";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="URT92oqC"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6NucU568050
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 09:25:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=NbBmG6kgKD2
	CVzzcP60K4ZcdLZpgmeYKoleCsoDM+Ww=; b=D4r0JED/rr9wtjtCMM66Ly6auYz
	sm6/XhNXWNLB9C3tM/7oD3opkoU+aZjiiGdGe4jdRlPWE56PPsryex3GWydx9IT/
	vNTFlNrL4NCzV4NMMYqXzN6hW+n111kLX5uapuMMoUDJzoul5q1ScU6ZLrDRUxty
	qtsTfnpd5Qq2uRpH/cXbrlSf6D4JQtTLO5YFFDCynhZthA/oOMHat75UzB6h5qjO
	NlnLc+bgy6Mz/ojFMaP8awhQAID9mdBZ2VUdZbiiOF5iLaeVthLzgMJG8G6RSh1t
	eaWpXjiIio7M7VgVfc8DHJzgu9gsEQM8tcqC/FlMvstX/44QZcpBvVNpd+Q==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com [209.85.215.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbe915dnj-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 09:25:54 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id 41be03b00d2f7-c888c687c21so284880a12.1
        for <linux-pm@vger.kernel.org>; Mon, 13 Jul 2026 02:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783934753; x=1784539553; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NbBmG6kgKD2CVzzcP60K4ZcdLZpgmeYKoleCsoDM+Ww=;
        b=URT92oqCOtzZMG0Hd/Ptt6yIQdjqB/xV0UepMtdQumP/0lBLbTdOpqDUd3M/XMQvhH
         k0pGKGkzFJiEypCBqy2fGJNIwinwG2Qtgv4iC2B+PGJ4kbFklfxOivsKmainrC3fpE66
         /W7UA6L8nDGZUTNCb1/iMP3Ot5NBkBPFmqzfGPBUW9oDaWjDRCqdk7zPEIvOLCsgCO6Y
         HbzkbBXzZhmwOB3rkp7UJGYR1y+m86YTBZV8liJexQM7flAty72IwTR+0k6BUbzS3cAl
         tj+5GW7xPl00mnVHMOC+Mv4JHLdGpR15CojcRTq2cUhWjM/+LvzQuas8bG8KOpDB5YQJ
         vFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783934753; x=1784539553;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NbBmG6kgKD2CVzzcP60K4ZcdLZpgmeYKoleCsoDM+Ww=;
        b=cIXJCZhRLyoHNtL7qEA6CrXmLIuFOO/96Mt7uy5xXdI9LvPqZQbZrdKjftjpZizbS8
         Aygu/Refs3/K+dncYm5J5sqB6fmtYJIwnJaL6AtkgrtPhBbiEMwQm46FkZ8t6WEBdOrR
         SR1s6G5IdIIOOOulW+pqXvdzni7wfwZ9W/bI5BF2xlxCFs3PxxIKy3TGtZuTAHEnu/2Z
         afO6ff9RsEXxw//VVzt4Gn/q6/X55C9YUGjLT/d3i/Wcccpuy/QzXJQFHL0MMBq2G11R
         ji3QOPIJdox+cwXv4YVOpZgJfDA32ZFkuDvHRYCFMeOcdnYtmZDahZpob4w5cLIBQTKV
         UtoQ==
X-Forwarded-Encrypted: i=1; AHgh+RrxkssoUvq3dVB/lWDZSKq4799FCuFxyXsBjGoisu+0qJ64PgAL4hHNc8dDZKg9wfY2O5phgoQkew==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTO51n1HllX/tK/5vlygEiMwOdBhhvojPNHHInVg0lsxAiP0nY
	HouSvkVDmo71en3S4KLNNCojn/qII82v8u43LYCcCx1FE+emmNYD9d/6WVgRYs+zgAPL2StEaKZ
	45dGLAtTaCmNvDff5wO9+dZFAM0TLAERl4IJXXK1FkPvExfY7/E7I+enPsomr4w==
X-Gm-Gg: AfdE7ckMhDrRUh8ah+puIoqRhm4pBnSvCDh9d87uhUlfStq56WVy+eD+Wjn87rUOyqH
	f2Ox+0HQq2YzXvWiapD06uLY+AiemFKVUbOu14kXHp9mjlMtH/zKOJzags/p94RTiTbtPGMLArw
	TuNVdUPz6HZwxzV3tFKAd6wx1HvboNV3rfQGIPir6U37j0X7dfKXRT4Lq2C5OmRV0kli3uEhlNL
	eIXTkQpzDsd8U0cV8DvuHp4SbH3odQFv419iFy23/3qp7DjfMv2dt/fFKK4dc0jE+thHYWqeCZY
	mJTh3puWT1gDLSmMwVJLdeCRCd0qgOxrG0c/7+mhaG8FyQruVk1XFUxnj3YXcC2UN62wUGRje5+
	bWhw6TQjUqrwOdEh0AQ5VkMimcRRgoQOP97C4v93qxFu0BIPpA2ovtVZHN7iF8g==
X-Received: by 2002:a17:90a:7307:b0:38e:bfe:81e6 with SMTP id 98e67ed59e1d1-38e0bfe9036mr506240a91.1.1783934753194;
        Mon, 13 Jul 2026 02:25:53 -0700 (PDT)
X-Received: by 2002:a17:90a:7307:b0:38e:bfe:81e6 with SMTP id 98e67ed59e1d1-38e0bfe9036mr506220a91.1.1783934752667;
        Mon, 13 Jul 2026 02:25:52 -0700 (PDT)
Received: from hu-weiden-sha.qualcomm.com (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117d847e17sm67901497eec.18.2026.07.13.02.25.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 02:25:52 -0700 (PDT)
From: Wei Deng <wei.deng@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, mengshi.wu@oss.qualcomm.com,
        quic_chezhou@quicinc.com, cheng.jiang@oss.qualcomm.com,
        shuai.zhang@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        xiuzhuo.shang@oss.qualcomm.com
Subject: Re: [PATCH 1/3] arm64: dts: qcom: hamoa-iot-evk: Describe the PCIe M.2 Key E connector
Date: Mon, 13 Jul 2026 14:55:47 +0530
Message-Id: <20260713092547.4100116-1-wei.deng@oss.qualcomm.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <63643fc3-3a3b-4aef-96b4-de42498cf47b@oss.qualcomm.com>
References: <63643fc3-3a3b-4aef-96b4-de42498cf47b@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TbymcxQh c=1 sm=1 tr=0 ts=6a54af22 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=VjGlub7PaFdePbqR2KAA:9 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDA5NyBTYWx0ZWRfX887tDDHkfX0l
 KKisNKyRvEpPk/pGGiFgCnDn4O4k9Cviq60k4vTLioA3Pcn1Heqy0sJbU3A/Eqd1oZDZtVAuU4V
 beYBMw0BV5qoHgGkBsr1TPy6O8JVHHE=
X-Proofpoint-GUID: I_1QaVkciWTjdy4WNmvdEI66N81GYdST
X-Proofpoint-ORIG-GUID: I_1QaVkciWTjdy4WNmvdEI66N81GYdST
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDA5NyBTYWx0ZWRfX5KeLZjVwF93F
 ys23z2tWkkzAg783ksI4/BhVl+acBYqGmwwgvmYuuLwloW78n3TNn2OfZkesxjJ2sghEHy2SSbq
 s86qvaKvAW9v7UvYfDrXRNgPBydL4wsniki02m5ds1kyl7DebSeW+xBKpa6njTF3Axe1EJDCFvf
 We3VCIWULrlMUyWjAWSc8OZ7BY9u2JKFBEU1ljz5N3/R0NlfGXkD4NbmO50i/q835skj2ZXukHb
 4ycX7eBQzjM8BGJFWrvFnpWmMpqyt/n9q2SUbBY8UWySUFsWugKmMhXtSciTS4kLsx+1w5/p+T0
 GqkQnHTaZm4uJ8dBcsAdzrgqItx3mNEEZaf+VHVo11h7Hm6hBdf/x+kVhMzDKi6raE0zOWEzs0s
 mseuNJ/wCQtRmJqRArmz/2b1d3iTTr1QdoN/t61XiJumVckgocqxxxa9nT7PQ7GxePIg9icNcl8
 0IrBAS2lsitwLOCYBCw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130097

On Fri, 10 Jul 2026, Konrad Dybcio wrote:
> On 7/9/26 9:29 AM, Wei Deng wrote:
> > The hamoa IoT EVK has the PCIe M.2 Mechanical Key E connector to
> > connect wireless connectivity cards over PCIe and UART interfaces.
> > Hence, describe the connector node, link it with the PCIe 4 Root Port
> > node and replace the static BT serdev under UART14 and the
> > chip-specific wifi@0 child node with graph port/endpoints, allowing
> > the pwrseq-pcie-m2 driver to power the card and dynamically create
> > the BT serdev device.
> > 
> > The M.2 Key E connector is powered by vreg_wcn_3p3. WLAN enable is
> > controlled via W_DISABLE1# (GPIO117) and BT enable via W_DISABLE2#
> > (GPIO116), both described as active-low GPIOs on the connector node.
> > 
> > Remove the chip-specific wcn7850-pmu node as the M.2 connector
> > approach replaces the WCN7850-specific power sequencing with a
> > chip-agnostic one managed by the pwrseq-pcie-m2 driver.
> > 
> > Also add 'compatible = "pciclass,0604"' to pcie4_port0 in hamoa.dtsi
> > to allow the PCI subsystem to associate the DT node with the
> > PCI-to-PCI bridge device.
> > 
> > Signed-off-by: Wei Deng <wei.deng@oss.qualcomm.com>
> > ---
> 
> [...]
> 
> > @@ -1025,19 +1004,10 @@ &pcie4_port0 {
> >  	reset-gpios = <&tlmm 146 GPIO_ACTIVE_LOW>;
> >  	wake-gpios = <&tlmm 148 GPIO_ACTIVE_LOW>;
> >  
> > -	wifi@0 {
> > -		compatible = "pci17cb,1107";
> > -		reg = <0x10000 0x0 0x0 0x0 0x0>;
> > -
> > -		vddaon-supply = <&vreg_pmu_aon_0p59>;
> > -		vddwlcx-supply = <&vreg_pmu_wlcx_0p8>;
> > -		vddwlmx-supply = <&vreg_pmu_wlmx_0p85>;
> > -		vddrfacmn-supply = <&vreg_pmu_rfa_cmn>;
> > -		vddrfa0p8-supply = <&vreg_pmu_rfa_0p8>;
> > -		vddrfa1p2-supply = <&vreg_pmu_rfa_1p2>;
> > -		vddrfa1p8-supply = <&vreg_pmu_rfa_1p8>;
> > -		vddpcie0p9-supply = <&vreg_pmu_pcie_0p9>;
> > -		vddpcie1p8-supply = <&vreg_pmu_pcie_1p8>;
> > +	port {
> > +		pcie4port0_ep: endpoint {
> 
> "pcie4_port0_ep", please
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Konrad
> 

Thanks for the review!

Will fix in v2.

-- 
Best Regards,
Wei Deng
