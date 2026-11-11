Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794407406;
	b=nLBd5PANxjNmr5Y912llKhxMncW5Hz4jcXLN4pAiF17jNtmQucb6Hg0bhFbCvOFibA4o
	 7ZLe44EMNAhQKEFBf6J63FqhGE6ive5/Hk7GC7foyyi1QURMUq4tDSiKuuF+RgMG1cr10
	 X8mBs4dfTqO+o/wEwDQ4PAWDDDKP1FPiGd05g/xNix0ozAWCXcLmiKzxGXM0qROSjMpoM
	 4oT5s03CRBiim6sYnvF3bjE1vdBfNNpBkH+dgOQwlnMblgdww0gXJS7xOYv+tqZKATC/E
	 rkEBsHpY/yDGWHim43wlAxb+Mq5KjEzXpvofbQI7UMZaJlMq9pcmJk+dTi8vSgaVIhQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794407406;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Authority-Analysis:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=vGEIt+0d09kkbPmVgRK9KARCj2NgxxPeIMDPZW+376o=;
	b=dqADgAsG5VwYUrMa6afvMP/CA6ApLT+MrXFG3Dgj0LBBu6iSGUngrVXQra16Y+wXmUiD
	 PFdMK4VrwhUqf7PnRT6QxcbVHt33hbcIIlBBdu/dKCK20MmMaSLs/kI9BRtR7GyCM/X+s
	 pksSPwri83tqjJJpbEUCbUiFW5oD0crtPfzrjmoettgmrv02w2bXBdY3Vj7Sk++riT9Sq
	 FrAg+z3VVVZsc4OW50EF4lA/Qg5wuondkBuIOU3wfPNqb+0cS8ixeg3+zO+sWArSqpZ1U
	 cAiXhJsOMdgpOF8g0gPQUx3KDBfu9GYJS9g875Nk46AcnA/9NTO9ydkvP2QWM2ZMhsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nxEl6DAq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X4AscMPx;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D17606A32D
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 14:30:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 82D17606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=nxEl6DAq;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=X4AscMPx
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6ABEJFsa2576876
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 14:30:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=vGEIt+0d09kkbPmVgRK9KARC
	j2NgxxPeIMDPZW+376o=; b=nxEl6DAqnVqU3uwhbW4/zp6ad3IRaesYmmV+nVZ1
	3ja+Jh5Nbo36D09D/fHZ2XN1w66Un7liWFyq95iL+h7LcoDsolwfjsvhgQ7D4cfS
	aK6VqcvLEk7jkHcxLCfmRhU8LTHnot3vg1uXgeL3zpc0NivLqrXI8f73QLWG2sw8
	xT6PGbCJ4x4CgEjO0ikVzhy3FohBc73bl0NogIQTgJrpNy7nfVB7QFpsXtXIv3ZV
	9L+cUvjSMRzvR1RbmDvF4sD09aduZClRpci/pE84CF0KLuYzYj8GD3qYSiXcjeLn
	ySPyLhX72ralf5SsOIjVNdgkkEVneHZMBYwNW76JJI1Qxw==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hvgjdj6sr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 14:30:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-93cb98809caso544633885a.1
        for <linux-pm@vger.kernel.org>; Wed, 11 Nov 2026 06:30:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1794407405; x=1795012205; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=vGEIt+0d09kkbPmVgRK9KARCj2NgxxPeIMDPZW+376o=;
        b=X4AscMPxrdED3fsmj1XunppdOq1XIsB9mno9fLW0GY5i+Dr5HYodA5su1Yq7ETub2e
         S7ASDcQD8hwhZX9GsSu2yNAlzBU05RC7wBELly5GZ/NoH5LcSqxxmSU8VwEZMnKv2UIZ
         ZpIGQD+h+iNMof+vhgWq7pgIvo3Kmay1kKi47zUzhe4LCrTxGEoh73VFfVz3uXU22hxj
         QmoGr57dR0FrfldhNrY7xcHVvfVGZvdWGwj6HGGUvtKb1vCZDItEdCpe6K7A7QQdmpQ2
         8yKLVu8LyEIt5HNCRIGSazPFXaIj60JBGyYdrePNQIzyCv3hls97dl+JHcWYUH/Qb8UW
         K7Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794407405; x=1795012205;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=vGEIt+0d09kkbPmVgRK9KARCj2NgxxPeIMDPZW+376o=;
        b=WE6KXL6Jzz2aTfeySbutWIpiL/RHmKCCo+7TKXT+aR1NHmDFdv2kE7VToAAPt6AmG2
         apA2+roH+IkM23lTgNCkx0eKoVgGswl76q1xgoce5yzlT4VuZSI6Piq8WFceHgaGXWnc
         7KIXqA6UeIt4Z3zozqRb0K+kKkwLbOsBWZWE650JitWAQi4phJt79+rnrXffiJQBnNr1
         QOprt7EtW/AIXJXjh1o2Em6+G93WNGC//iZwwcRSeVznJchFPn0GM+/lPAeMafzpUvtK
         871k9vk0h2B7Deh77mLG6vh7+9sK4kwPb4fgPCGOUBzZeB/jRy+0Fqi8MZEKCNM45c8V
         92Ig==
X-Forwarded-Encrypted: i=1; AL+hErEAySlyeaGfMfIDziIa/MZOnTEHFLEYt+y4q7CnWSOy/FQcBOY9ODHWrnfMiPV1p4NrT+I66+jgVg==@vger.kernel.org
X-Gm-Message-State: APuU4Z8h+NwIV/FawjZdF6feq0sc3PJvvhEZ8ey112pTpNKgGPK9CTqW
	lPVwIeEe3Nb0WFlHz8x5x0sgSAiBVG0xEmtGf0lJ/aDMLkU7/iVgXxWogFfi86SlFgq8gPJt2vO
	RSyS/vQ5a2jHllqu2ev7lRgLLDubeY+mgFW690r1/DOoGCjzRr/+5ywzRcUNW3g==
X-Gm-Gg: AYBFou3o44VocsHpBSQNtjuTDyKUDTbRgfjdcTV8zv4jqU2ZpmuXSW2flmyhZGp2elQ
	wQyCyv4WIGfLLBYLKW9z//orn+sbqXBaP9jQ6rZpmOKJ6rY+a4MTreU/B7kqg/KRTFyQAKSbWet
	6FFrTeLTmwMNPaC+JiHeoI1xaJc1RjOICzwmYZsD0iPqraFUuZBnzOL5cqYvI9/AgN4z69Rnd8F
	RnGa2qWp+9ZEGFaBiyEkrVV0GCXheXdQck5upVezJ4ELg5ZaoJuJYUuhPxSu7zuqXmVTn/If4/B
	uAdysVC/bky85QCZu78RPmel/JSnPtdKMiA1gSignqvELYFiSi0lWo0GSylTYlFiLCNmpDZj33G
	aZQd5GZqVSHpjI4FK1Skt1JVrP0/QiRtvL15TOmK1leGrsZwT13z3OuJFgpJ5Nhm6
X-Received: by 2002:a05:620a:199b:b0:93f:1823:308f with SMTP id af79cd13be357-947b00cd286mr387697885a.81.1794407404604;
        Wed, 11 Nov 2026 06:30:04 -0800 (PST)
X-Received: by 2002:a05:620a:199b:b0:93f:1823:308f with SMTP id af79cd13be357-947b00cd286mr387688385a.81.1794407403677;
        Wed, 11 Nov 2026 06:30:03 -0800 (PST)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-498369a3fd2sm12095367f8f.52.2026.11.11.06.30.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 06:30:02 -0800 (PST)
Date: Wed, 11 Nov 2026 16:30:00 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Luo Jie <jie.luo@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Abel Vesa <abelvesa@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Georgi Djakov <djakov@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Richard Cochran <richardcochran@gmail.com>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        netdev@vger.kernel.org, quic_kkumarcs@quicinc.com,
        quic_linchen@quicinc.com, quic_leiwei@quicinc.com
Subject: Re: [PATCH v2 2/3] clk: qcom: Add NSS clock controller driver for
 IPQ5210 SoC
Message-ID: <zx5rw567pockk65r2joresyzjvytukupcrshtovnnyovmrmhba@tbrrnvlrebn3>
References: <20261111-qcom_ipq5210_nsscc-v2-0-7e2c1dda3ed2@oss.qualcomm.com>
 <20261111-qcom_ipq5210_nsscc-v2-2-7e2c1dda3ed2@oss.qualcomm.com>
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
In-Reply-To: <20261111-qcom_ipq5210_nsscc-v2-2-7e2c1dda3ed2@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=E7tYNqdl c=1 sm=1 tr=0 ts=6af47bed cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=XlM99vnl-FaGDs3XFu8A:9 a=CjuIK1q_8ugA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-ORIG-GUID: gFfOpKtEKtAXH5He5SHZVoKKSowFDDFl
X-Proofpoint-GUID: gFfOpKtEKtAXH5He5SHZVoKKSowFDDFl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX6P3FGDIikeNg
 xT9KIH97UyrkDCTHPIZPNrRVfQJg4Vg1nFE+p/vq+gxr4jLWvvBRPl6nC5Fg4MOuc3r7/Vj4YVA
 UVvSLAMIXWnVbAcTgm1zSMOxb7WHrFsqhZShr+xKC7iYbmytwSc60F/+qxP99C2UL5wzgQeb+6c
 3SB4jDzaFxmGk7tSVd3a3igVFw6veCn6v2/1wenUtv7bCb4a6DG0Zt1IxJGxsD7KcdHnI47diP2
 4kdAEbuD7aDpqTYUIyjTm5Po/LgyE0Kgyu+fA988FV1jHErpUIhsqtgn2hL7luVaPCP8G2qdzQ8
 zOwhkzMqPQx1AqlDJ/EGOBZdtGFPaOwzsPRlJnIx+UOz5UzzJsCzKeUTnmqywW+tIL4gRPBix6f
 JHxUSda+JynMXT1T4HUu+w7m0QM0hEN6PH2EP6WStXfgxHsHUUtrXnBwXUovj4E0mavd0ILvOdv
 q3P/o2X4cquZ5fuU1Tw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTExMDA1NiBTYWx0ZWRfX/m3zyABd3No4
 KqM65q93cTro6ynYWIZU0KxhUbREQUzXb8suvUbrYqNQZh4Os548HVE5FYfn6XYUuJqMneSXsPG
 pzI+9s48xG6p426BpQHPrp1OMsOPACI=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-11_03,2026-11-11_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0 adultscore=0
 malwarescore=0 clxscore=1015 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611110056

On 26-11-11 02:00:56, Luo Jie wrote:
> The NSS (Network SubSystem) clock controller provides the clocks and resets
> to the networking blocks such as PPE (Packet Process Engine), UNIPHY (PCS)
> and the integrated Ethernet PHY on IPQ5210 devices.
> 
> The icc-clk framework is used to enable NoC related clocks to create paths
> so that the networking blocks such as PPE can connect to these NoCs.
> 
> Signed-off-by: Luo Jie <jie.luo@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
