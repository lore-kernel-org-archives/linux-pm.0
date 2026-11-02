Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793613554;
	b=sc0SfbokH40EiQzjw9L9hkJ/YgCp2AR6BMxj7BHf9cm8In8SZJWmz2mPO/u+v+mHdjz7
	 CPsToZ6/fXnBx3fo6oGOmTIMb7qlF1pUKkSUXgQwkFiSUFbqYpetYsOEGccIB/Ukkgsms
	 5NrA3n2zTCZvw9HWjOGzXvcK6mVoHT8/28dncMVAUnp4EopEeil230g/jVNvKvkRnM3+N
	 Uc4crItLT/wpNnDifEU8QeGN9snOP3xqAk/W2I7CVrzxvxJ+GLkhcVBOI2LR8PqRrj16j
	 JDcSAaCJWE9zXdtOjG//QraUupfGPZhiP1A/0NXMBDyIYGktEloV1FaFB+fOcRK28Ug==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793613554;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=DvLqP/tFCRw+lDS6WYFmF22WIsggD1RJMNZO7NQX0Jc=;
	b=qsIm2YkQXzt5Zs6J0Ailcegkq8a9rIaTGZNKHhXmuZJ+/vlWrg5C/PM7Tz01MZzzIKyH
	 HW1nQxYHjrUnJPzEeNCZ+4buQILRBdmxjjC/oYZ1FrduJGGB5pI2qYFAvlHKLEmZ2Akb+
	 bm6gqhKXFgJpN7xgLxMUo1UdRFLPaQMPmUlHrfHif0oYSm5sfaya4L8u5s+s3SY6t76ji
	 wlpW+Mc2F//EIxDlpVES68+ZKoVTNhHXOBkx5xTBC9APu/PYqgDc44QN2QndKDcvptLeB
	 FeuqJAmbSpI8Xu4MtQQpmODg4dMITTIrBThTOjZcRKP92sy+3FGA538WVl5TMbM79Eg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ctdHG2pg;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kHzd1pG2;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A82EB606A335
	for <linux-pm@vger.kernel.org>; Mon,  2 Nov 2026 09:59:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A82EB606A335
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=ctdHG2pg;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=kHzd1pG2
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29A1sj3430382
	for <linux-pm@vger.kernel.org>; Mon, 2 Nov 2026 09:59:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=DvLqP/tFCRw+lDS6WYFmF22W
	IsggD1RJMNZO7NQX0Jc=; b=ctdHG2pgkaQCYWdXQm7JOTj2bSHBkT/Kdf70Gzfw
	vfeGb1ztNVIX+f+hBwpNXGc732fuW673AIMV72by+Z1LoNgJgIx1M3ZdiIbGv+zQ
	9y19vQJ+VpPpsw4/14hqmAMg1vyr6kcg1JarJZWCUVn6e3qUAcg027GTqosZ6889
	d1ew500EPfPPzuqftIbOjo770OdBMtD3Ql/r76k09+LlI7MReICFflm++aLQXPDp
	BUN/ksGQb3w0oVzm0BdunQF3DZzA5KHiL2WBqvtCllJ7xAGQ2h6qoBmjVjj5r/ks
	JWgJ1HV5HM0NyP8jKo53WpIKgv0xKcIMyc8SF3VObcBuaQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hpnmerr5d-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 09:59:12 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93f6f4fe531so459363885a.0
        for <linux-pm@vger.kernel.org>; Mon, 02 Nov 2026 01:59:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793613552; x=1794218352; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DvLqP/tFCRw+lDS6WYFmF22WIsggD1RJMNZO7NQX0Jc=;
        b=kHzd1pG2eqtms50mvSIRtxABHbW6bbKsrPDc2Mbx5dlY/5dZNRjnn9p/pTbVju2Xjn
         vo13Ne/9kBdNKi1i+6Gq+NvC7suqZoNR2FCbCkK7c1kxM+jkj0MKfzHEhIG/m6YP4iKi
         oD9mdavN0bUf7nmQHSla+W/KIc6GeJrLrs6l4Z1zUOgR8Z/9oDzHN4ZHJz3UgIbQ2c2k
         pfI6hPcKpZvtnta4XZuvp6fu2HUxf8s+Zu3JXmsmQcgSjrbACDBkGDx1l73vqlvwOpv2
         wUTs5edpeVMamCt0qXZnVDv1a/Qw4aPX8mrrj5RzJ88M0AnkBQjGEh4tOb0mZ6hpaGXI
         xklA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793613552; x=1794218352;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DvLqP/tFCRw+lDS6WYFmF22WIsggD1RJMNZO7NQX0Jc=;
        b=XmLCmZAXru/RaZkkJlpzPk425ohrA+vUve5Cg9bJNeOir+4hehUjn2o1Udmi761ian
         +Rc5nQ4up/cRPYm3nxM650sY9gW7wgdncjRsND02/XBy99vkanDzt+4q3W9FOZ+LWJ15
         Liww4PGLdblHxKKmmAUCBIbfqA9rhQWD05E8fDMO/5HuJltUFbpWvbk/WAbwEbHy/VQq
         1ffrFs1V2XDXyTizZngRW3PZFT4HztTxeCbw+SNe99YvRPHJT/pBMO96tO+m4nDA5aWU
         r4ygyioFa+LJn5n+iJuiVY9GxqNA/2s0Na+qf4ug2M0iIHp0vu/UwdOANJD+fLeO/iE8
         Gfnw==
X-Forwarded-Encrypted: i=1; AKwUvBxbQr8Xd8khk1tVYULWXnMdkStYdh6Eur0w81XKIvQfnmU/TtaZ+dEUDeupoONaIIROeJ8NwnhzLw==@vger.kernel.org
X-Gm-Message-State: AFq9FYL/siabgIRMhYB7uv8iXDcfSjI0SUgWA/JLf77Vc5q4muwiUMZU
	p/ELnNiXEccSR2jv6EVUzJ49ud9PwEZAAI6CCsiJHDXjFQQi6E71Zi0JdasGv88OfTAVunD4L7P
	kRqQs8v9fAOeuO0Mr68MF5R8jUqOScAqjcyjt3OBBWu6XKJxifp/Toicmkyh82g==
X-Gm-Gg: AYBFou2K8mwQnd4+2j9Fu0tttH2GXQIFVh1HOd8AjSdxMblcIcBf+prccxvZWHG9NTA
	bNOmBUbnQKetMIw5EEnsjCdRnlh9SKoW6hdjnrLVaScgzvtHtJ1vEzdJe6tCE5YSwEF45OimuGN
	uhKOJRzzWXCb8wycndbPmqZzmHjFZwqGZIR073NAmpcbGx1b4mjNmhkh7LybNFxbcRu0vqARDQU
	ss0NIQXMTD0D3m1HhBCmDzSamflSXeMG2vFnaw9ifLQwWZeYZAARBoFxL6eX+UBDLvQMnFAqZ9K
	YYSnOWvSfiCaeZaQOJ4lfpZGfh18lNWrlVU21Jh+wX2G3d0pk43Z3pvMvxQR7VOBoT4mvEftfB1
	Bz/wrPsw72ty1wP+2s4U//mV/unnemd0QFm2tGsrjhclC4+/pgoGEzASh8pvlEOR6cvww8BU2+g
	S9fjIbiJbDH9K+hK784M5zwwfGE0M3N3ZmCusyuT3ZTSVLtIxMlyfs2OvKQAc0
X-Received: by 2002:a05:620a:4594:b0:93e:c12c:4409 with SMTP id af79cd13be357-944217cece5mr1518815985a.69.1793613551857;
        Mon, 02 Nov 2026 01:59:11 -0800 (PST)
X-Received: by 2002:a05:620a:4594:b0:93e:c12c:4409 with SMTP id af79cd13be357-944217cece5mr1518813585a.69.1793613551287;
        Mon, 02 Nov 2026 01:59:11 -0800 (PST)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfe07551e2sm1516515e87.84.2026.11.02.01.59.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Nov 2026 01:59:09 -0800 (PST)
Date: Mon, 2 Nov 2026 11:59:08 +0200
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <brgl@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, chejiang@qti.qualcomm.com,
        quic_chezhou@quicinc.com, wei.deng@oss.qualcomm.com,
        jinwang.li@oss.qualcomm.com, mengshi.wu@oss.qualcomm.com,
        stable@vger.kernel.org, Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: Re: [PATCH v1] power: sequencing: qcom-wcn: increase WCN7850
 power-up delay
Message-ID: <6n7g6tamgj4q6k4sslwllqnidobapv7groh3tqc73lmzj2xw6y@e6ya2ozqa3pc>
References: <20261102094800.3225454-1-shuai.zhang@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261102094800.3225454-1-shuai.zhang@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=KZ1HIgYD c=1 sm=1 tr=0 ts=6ae85ef0 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8
 a=H8z_xw01dn0BF6GSKEAA:9 a=CjuIK1q_8ugA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfX3tTXBpv6/d3n
 /SIzdFoZafeTFK1I6GMsntomh1xamhJJO7Av4cysHf90EMwJcz590/B/LVW4LT5jWWbcMxA73pN
 hXp6lH+JcXtdxAYCvq3KQRfMx88kNOcXJUHHQsxXiEjixRIK7KCylDlZkQwsanqxuVS7d9h2tQY
 poOX1Wg2XZGLSLr13EswPWS6fdmgtflawfVrVyzX5P3v3JrFsI5OmOXXS4Sgb+E0rQ4sp6IhxQn
 1SGdtzr6OKno70t6ICpTi+CRF2TCvT1fCi3Aw9wac1qk5BDakcxgrzEu12LDADvwrUmVd7AJ++P
 35ii6Zj3pLQn1wfW4tNQIe0d/LS9EGNv6bf13viPsPtoMyI3KDjMw0L7DDq1NHu5I046+NkeV1F
 Glrh4Cxm03oR1E63cWQXBC/EBECTAhB33NrM+NenOpE6kaCqKfkxyLl7jlEISodDYY+/Pd/4BdV
 fFp5/DSoJ1zEbT3KwsQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDAzOSBTYWx0ZWRfX9X6NTaClzce3
 Hu733oV5ChmSnC94pUp9S6WTr8iOBVbVBNs9h7NT/Rtvb7P86q/Gf2nU0DEYIaCBQ147vAwv1G2
 fHfDx2JNEgGcnLX+WuC+cqrrQ6+b1LE=
X-Proofpoint-ORIG-GUID: _QaMHe0dLhRHDnfsQXDzlM43K-HtSzYb
X-Proofpoint-GUID: _QaMHe0dLhRHDnfsQXDzlM43K-HtSzYb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 clxscore=1015 suspectscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 adultscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020039

On Mon, Nov 02, 2026 at 05:48:00PM +0800, Shuai Zhang wrote:
> When the WCN7850 is powered up from the Bluetooth side first, i.e.
> BT_EN is asserted while WLAN_EN is still low, the chip starts from a
> cold state and is not ready to accept the first HCI command 50 ms after
> BT_EN goes high. The first command (0xfc00, read QCA version) is lost,
> hci_qca does not resend it and fails after the 2 s command timeout:
> 
>   Bluetooth: hci0: Reading QCA version information failed (-110)
> 
> When WLAN is powered first, 50 ms is sufficient, so the failure only
> shows up in the BT-first ordering. Measured on the affected board by
> which enable pin rose first:
> 
>   pwup_delay_ms   BT-first boots   with -110
>   50              9                9
>   75              23               0
>   100             21               0
>   300             20               0
> 
> Raise the power-up delay of WCN7850 to 100 ms. The delay is shared by
> the Bluetooth and WLAN targets, so WLAN power-up also waits 50 ms
> longer.
> 
> Fixes: 2f1630f437df ("power: pwrseq: add a driver for the PMU module on the QCom WCN chipsets")
> Signed-off-by: Cheng Jiang <cheng.jiang@oss.qualcomm.com>
> Signed-off-by: Shuai Zhang <shuai.zhang@oss.qualcomm.com>
> ---
>  drivers/power/sequencing/pwrseq-qcom-wcn.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>

> 

-- 
With best wishes
Dmitry
