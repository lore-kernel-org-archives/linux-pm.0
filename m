Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793708988;
	b=gjTi2nlQ4xAXKn13qdI+NKwEHdqxEQi8pGlG8nOTDte1zyMce3c8BJquTIRma57Cmw4C
	 pUXYfmaS/vDNMK5HJPAdAGWBCpKarepCanie5OaY7wfqVPyNHXzrP3Trq/2abxHqrTFbp
	 xKigrAZfMAOn8taSxGW+EGvxeKx22aguAuvpFeDvU6Xnnrin9LJEFjUML2kzT49wfCBAU
	 +UOpbiDR21nHp+/NAbt1EkKwV1bSxdLtKVezJnB8dB9tnDpiYmdFnltj6wIJtdMYx1b/c
	 CyL2TPWi/0hsB1bw0GqZF9o8H+w8ynsj/2AlgxSxb7dC6wX2fR+jU/i4+nC0oyriZ4w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793708988;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=IDI+igDoc6QkC7pgWT8Wprn1keJKc8oLjyvAr5GbucA=;
	b=qpLe/pLH89iw2sXftQeZ9MlfeuQ7Jq4NHy4dpZvpqOnBJHhU+5DT0we6ebSfLAweIZCh
	 3H+7jBechkouHu+Ze6D8wr8SupVbXpshtAnoUXTzFqx2n7t+fHEI8aM1BbfqfBRKSvSxf
	 NhXa/2buqSeIEWT6ham/LbNQrUcs1MbZO3FVjx2dW/hnJw2vMYbCrgIMzRnEbmxcFP9r8
	 jZWr1CPrgsjkbezivD2S56enBh1pW5ezapCr8/NS9LanMx8NLBIo3nYuZ+yAXvmGsqx+f
	 6OxpPFjLJw3uDsqphpWci/E7oFejmdk02FhKaLpvmvRvXMYd+Eywxmwx7fD/mex0D1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EDDclsUC;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gugOoYN2;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05DD606A324
	for <linux-pm@vger.kernel.org>; Tue,  3 Nov 2026 12:29:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C05DD606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=EDDclsUC;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gugOoYN2
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3CPELY3820187
	for <linux-pm@vger.kernel.org>; Tue, 3 Nov 2026 12:29:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IDI+igDoc6QkC7pgWT8Wprn1keJKc8oLjyvAr5GbucA=; b=EDDclsUCxxBMMyPS
	hSRvJNY9XyOMPssJxN2bWsAG3M5QV3Mo9ybSqfB56MCR9Gvl4jcHa4oZ5CftGMW4
	vzKklfqahmA7YyvrecFKafFk/s+yDkTrZhvYlOk+YO+p/UX0Lwcnjpu9UeCDwQPj
	VAE1xx8G3frBAyWWVkaZ9qhkmBdv0L7ye/k+4iHmsz3U0kLITNPElieRfQVAJLTf
	IVbCfW/CDlXcdVNCj0rEuogCOHzRPWD2XTjz6KffviY66ir/FXJry7sgis8RnXvk
	9NYXWmso4AmHZoKPeB0cbleLnfp3F302T6DhK3FdldgdcHLyquf3Tx4gJ9eJMKow
	3nzbww==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com [209.85.217.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hq3uy2uag-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 12:29:47 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-7bf45382794so3493065137.1
        for <linux-pm@vger.kernel.org>; Tue, 03 Nov 2026 04:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793708986; x=1794313786; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=IDI+igDoc6QkC7pgWT8Wprn1keJKc8oLjyvAr5GbucA=;
        b=gugOoYN2/WM/kDivAuJBtXpihzzVU/JUJS14+FC7Uhqwdzb0ooMCyd7j2rBSgjpJo2
         L89FbR1PoSRMS6cqxm8NK5ZipdUOkd/ku3vUUsR6O6LM/+nBnMfmdE9Ms/YTti0kjO1d
         6Mv+HKKwzKc/21lG0ENyZQ5I5AKSzW3t1Tv7Y6z1kSggyzhETO+IcImhdmCuPcWF4ocl
         SAvtUnqKl1dpH1deZ7Tm302bganlXr1ayJYSo3GoOzXGIOtboF8lrMQEhkZgqA/Uu6rB
         LfJgEjGsfgCcd39P8fqs8aKLI7nNrLpgC1gIPEI7cY2kNwR7Fd4TGKJb6KM+0rUsSC2q
         V7Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793708986; x=1794313786;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IDI+igDoc6QkC7pgWT8Wprn1keJKc8oLjyvAr5GbucA=;
        b=oP8m/58KIDYyNP8NJhDCjrHelBlX1Q9tIp32FxbyGmQ7f7DkWjoVhbicExPLqLsY84
         J0cEQAX25lNx2Fo0RiJV2v2Xk3EsjOvippzoXnKvzx9WsAL1Re2ETheJlsLyxCXkWJTm
         CQLjd1h/m1RLhPmY7AM36xhMjSNvi+C/PvbCYeUYH9qdRZ+rf6Qy8LMh9vB+gcXIYkzz
         +2Ci8+wZiMVysCyGtJ7vI0QPX7pZCGN5OUaqOJLoCv8DwI5IVE5rOM+e+vCRiNxMGcYo
         LK75KD7xTzwSThmdH5/uioSj17dGUdO/PHZEJPGZ+aSWSzuWazs/DtyPpAB0TQqRP2cT
         xXbA==
X-Forwarded-Encrypted: i=1; AKwUvBxNCx8EbvW7MhT4Yr19HUdOjvpZDlunrr0jsckhcnjjB49njXgM6NHWOZmjAECKaTmUqL5jXT9f7Q==@vger.kernel.org
X-Gm-Message-State: APuU4Z/Lm0hoWYilaahqbtURBWgDO6YmpVssJr3PwZ7qdsSEVbKFDBzh
	dbB1VRIzoRE8jkORTRE/anqt87YRKr/lcxTEBDl086Rt4z1r/stLfe67NTNFnRhJOutycoi0Gkq
	TsZWz5lbHJchVqQ2VSkNKkIdCUWIV9esKPzsS2YNfHgYH7wJtVdyHjRasDLEbRQ==
X-Gm-Gg: AYBFou0r/2lYQvm97kZDHDze4JgAzpXJBRjnt0zirzxDnzcnHMJwwFSHC5QV3Cn+4VT
	ro1W+HHjb7uZpb6pHH8Mc6bt7he+Gfs3r6xHmRS5gh7TSml8Yb1zlWM8qAokC10J8wn/eGG5ReA
	hIzs/rr/Vm4/X8r2HK7FaW47Yfie4hd3En5x7j++3sGkGsE8Cbqu9Ltz+vMRoc3SkMAoSaNijgL
	E15NHYwm9YoFXPEjym5hzjrZ57FBeEqIE98WrkyOMbn9cGCYETMFfrMD/sZ/pvz78YdTxOjnsq/
	v+4f93N09377jqjL8fNJ0GKnG5wNn33mnB7cz5WtWYQ5n6Cjnc7oIMCDyOuaSPTYFYOyXRPUL4e
	2Tv4N00tP3Xs6dv6xkwJWaODBQishD8FD1rjmgPepWWjdxdYvZiOO+E3Ml/CU0xaTfMTlCAbPh+
	ft
X-Received: by 2002:a05:6102:6881:b0:7a8:1837:9eb9 with SMTP id ada2fe7eead31-7d07273b428mr4586997137.27.1793708986046;
        Tue, 03 Nov 2026 04:29:46 -0800 (PST)
X-Received: by 2002:a05:6102:6881:b0:7a8:1837:9eb9 with SMTP id ada2fe7eead31-7d07273b428mr4586987137.27.1793708985574;
        Tue, 03 Nov 2026 04:29:45 -0800 (PST)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:8916:7b9b:97a2:6c96])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e71a4d5dfsm28910586f8f.3.2026.11.03.04.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 04:29:44 -0800 (PST)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>,
        Shuai Zhang <shuai.zhang@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        chejiang@qti.qualcomm.com, quic_chezhou@quicinc.com,
        wei.deng@oss.qualcomm.com, jinwang.li@oss.qualcomm.com,
        mengshi.wu@oss.qualcomm.com, stable@vger.kernel.org,
        Cheng Jiang <cheng.jiang@oss.qualcomm.com>
Subject: Re: [PATCH v1] power: sequencing: qcom-wcn: increase WCN7850 power-up delay
Date: Tue,  3 Nov 2026 13:29:42 +0100
Message-ID: <179370897915.27908.8240780682152468371.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261102094800.3225454-1-shuai.zhang@oss.qualcomm.com>
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: NgtXlHde9Y_b8Yyoff3XfSqY4JB784sH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0OSBTYWx0ZWRfX/9qw20lR6w4p
 9ZppnJyayMvovgOkoeykQxOpsK08W8U8tzyFxpyNagNj1Pn8KQx9P5gibMOz0hR8mEfrFjMr+Fw
 jUVFogyiJSCV2rg++luiGL1x8GiVkaWSAtWrcewvILL1fzhZq5/II8/H9/nQdMDVTqN6pGSz7zW
 B3T+8dHMp/jgAEUuKjg9coR9NyplxWSN67oFJ9TawRA/ZkkSia1aw+zbnoMJg5pVW/u2P9Btr0M
 8pqpb6LvPNqGZU0DeisqIWV60wyKzvnwTTSYokGMdGo4gWCD1i3rRWbDV15M6Up7yeqJxOWT7NU
 wRpTpaBGDN8qv3n82IV5rvura1ASagni1z8gwmQ6kzF7W/sQ8UuEwXWOCXgijna/nk66m5aldNH
 nUIZArW7sHBhKj1tsPJWl4IT8R+LumFwMt/ofL/hNPAMP1jTM0kqAs5cjbdhhdaP31wBtjJre5N
 6PwY9v4NDI7/d4PXZ6w==
X-Authority-Analysis: v=2.4 cv=VoG2kO2n c=1 sm=1 tr=0 ts=6ae9d3bb cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=KLQxzaQ-LYvYA5eWPjEA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-GUID: NgtXlHde9Y_b8Yyoff3XfSqY4JB784sH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0OSBTYWx0ZWRfXzV6NoLiyE/Ig
 m4EA/dJU7wwYz6UmQHXUNO7efnkj8uWTYSuYDRhcaWxWMYqISBmmlUs78YeHCcc5+tKokGh+8mU
 EzXNDvO7kQCALsWlye6lCDooyi587xk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 lowpriorityscore=0 suspectscore=0 impostorscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030049


On Mon, 02 Nov 2026 17:48:00 +0800, Shuai Zhang wrote:
> When the WCN7850 is powered up from the Bluetooth side first, i.e.
> BT_EN is asserted while WLAN_EN is still low, the chip starts from a
> cold state and is not ready to accept the first HCI command 50 ms after
> BT_EN goes high. The first command (0xfc00, read QCA version) is lost,
> hci_qca does not resend it and fails after the 2 s command timeout:
> 
>   Bluetooth: hci0: Reading QCA version information failed (-110)
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: qcom-wcn: increase WCN7850 power-up delay
      https://git.kernel.org/brgl/c/bd60a639b621453fe37b780df4b6d3a13f981f13

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
