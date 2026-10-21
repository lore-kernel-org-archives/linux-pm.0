Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601690;
	b=lUS7AXRgkselEW6qwOTyxwyIx5mZ0sz1c/PPycFEYJagdHGZPsHV2Nm9SBKiStf66zM5
	 sTzAqgeHNgM/dXTw6IwLS+VHcZeca93JLxmFL96RukekHAedPFBYC8LQWbEMa7OvlkDVE
	 gBBz0qvEYA6YmTRaTaD98PmYZit39N+/R+QAZzW/CDh6ExBRS7Gh0+yZRkW455OaqG/Ih
	 EFd43T/MQzz/J2M1Z5KZRrCaYl2MvABBKPv8aIqPgQZYHnKwLaQK4TepYzmkecmhvGfDu
	 qp16LcaAWgLP2hv2JYwzGxun1tc9hTtmRIpgrb2lJWQhJ2aJx1vHyGY0o++KNCHuqjw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601690;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=jW94fUrEEV4vE96KzZHOt/ckZsK/1E1HYZRarmoNLtw=;
	b=wv5fGGc8++MT+d5EU20H3MSYNFUHpsSr9gOfLkTRfhXalqSRj2+MMGJ0obiSg13OjykF
	 pDixbcHmwp99L3mQOGNhGlxaq4cDf06mB4HLQMH0mXwkiTLpPEqzBpP19ofej/rUsQf+L
	 Uu4LI0xvtJOnscAMRbl0qW8QczEnm1WB+72Z61K3y+ecfiSG5U2cDymhXRuYuqiQ0/ihv
	 51oJ9T/PgZDdoeucMc3Sx2uo7HVKN2WF/51f/ZScsJhPhPA3fIqmebg/poAtBCGyZDkFd
	 K9u/Khs8+GomGrArYgXI6Stcs1C2GkIWe38wTjEXPza7yrAJF/92WRHrgHt41aa5/rQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nb5Sjr7f;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L9LncZzT;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA78C606A31B
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:54:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EA78C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=Nb5Sjr7f;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=L9LncZzT
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFU9H63727462
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:54:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=jW94fUrEEV4vE96KzZHOt/ck
	ZsK/1E1HYZRarmoNLtw=; b=Nb5Sjr7fQsdtlMvWGadhbbx3FfICmiY3qZWMQ1LR
	rPC6Nx0aPLTss4+KcMfC18xcR27AjWgk02LiIJzH/fJrNqHSEsfL82yBDe2k4t5l
	Y+wO/oUPaiQiAM1Wd/tU9F9NcwO1iTrOva8UJGlyUPIIqcZnLJIc3vdTBumNBFk+
	IyTrLskYn+Uh+yKv27V+235pxslX3uLVkBB3AQoY6NLW0WLzFMKmzQyOSdR+XLDV
	BOPF0foGU9/rfSc1TkeBaWUx/LjUeMHBZB7PRM0or3Ker6wvujp+z6hYDwLnWeaQ
	X0cUfmdQyhAl9t3WQGG3iDbF72jkEUWbihRHNZ6r5kkr4A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy7a6je-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:54:49 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93cb71b1443so193197285a.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 09:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792601688; x=1793206488; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jW94fUrEEV4vE96KzZHOt/ckZsK/1E1HYZRarmoNLtw=;
        b=L9LncZzT6NA68yXFmbG3QtWg8G7dbfTxZT8nhdjnRUeSqSmCcUkLqQS8g1sMZ1ATS0
         nBFc4auF4YORLBoomGt1unfu1m3rOdD1f7xLlWpN1x6nG393P3JTmx+M5xU2ZIFdq9F2
         OfwG5gun2frbrIm9CxfUKtoguJq3NAZ7TM28YeUzh/gBX5qA4WovBjM2GViDgNb67uN+
         tcw/beAuZ7QuR1hF9A54sDv2SaTOYiqPn3j1bp+iMXv8ZUs/xP9lNkBCO+pLezqmZNo/
         HW6gd1BeoXur1oQx+qXDPDDLDgGw64EftZMHfLCYp1uef92pDcSAgiQA4vhZpHLcibBI
         cMQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601688; x=1793206488;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jW94fUrEEV4vE96KzZHOt/ckZsK/1E1HYZRarmoNLtw=;
        b=zNnHE1NypD6BLvsw6tmOiPLNSwuGRUsC9akzXLsv0ijjMakkRf/fC+AkFxzCpBtBoc
         YLBkgwrwLKaZPYTiEnmejannaBet70gLgqTCq2AOUgGD8lHYLsFnKlB3cSr++uV+W/+q
         X8QPxTpEk28ahqlzziFOe99zXskKBY3eX4MhGpM6/APuufoGskJuZbj/n1EKZK2diDbj
         5e1oTymP8Xt/Gq+Rk/S7b85IXFP8Ey8yRjQ9DF6Kqpscb9YOFn1rf85uDSwnAxm0j3uS
         SFD/yQR/G65g2tuaarF+3N1uJkXEIm02uztv893UqYAAbz6uUsuCC7+7iYaU/XMj8OST
         dAiQ==
X-Forwarded-Encrypted: i=1; AKwUvBxeX7v11maWYFmjik6HaHRhq7ocxef/EbXmyzeJWlyJ3fVFL2RMV9oKOmqWDpTRtseNeyE+yJXJrQ==@vger.kernel.org
X-Gm-Message-State: AFq9FYLMId0xKrRT0VW5qHUBx2KuDElXEGpsidKT1KUa9N3F9K35DsOg
	O5/rHNzTl0iEeZwkdiy/UWsxrkBPtJ7jER4RoFkFGDOglAJ0ad7NM+SmbUGLxW+ByMuWKoTJp4H
	+MOlRcrW2UJ4ESRfyzPemD9BWR+awQEQTqbWixD25WM2ri1IFgRBA03kM/DnTIg==
X-Gm-Gg: AYBFou2KwWL5YLEvuWhdxDi1gzfwXC6fnbHUoiMWGXBe21Ujtd35pePc8NFRnkjzgEl
	DXjUR2ryT/2ESV/AtuGgB+zaXmGsyWNrQ+WGR6Td8sKucETFd+cnQLZBCZ/ssJs05dqroNL6e/o
	JxqisNNjQbSsn8BcBE1oh9wv4Rj2vxgqadnuLpZ6LmwULPgcQPvjCfrhCxtfK+QouLnZbdUs3fM
	YBB8g1ySlK+0Jn0VHzglgyz32KRe+LUB2RgXxwMT/0c7mkWFPzlOi5M039dq82ZKfVCCxiA3vq8
	8ZijcqZ0iHv66yKvbOZvGHAE+NX7iT6CmBozxLneDg8Hd+eVnzUP+miqJNxhrFENOTWdZy0W4Ak
	tKPYIbSgY08sHCXcyATYT7MvQB0vOtbZP73cgj5IcFFAmYPIgTz6BeBO70A+K9CHQlfpJP4swhA
	d4K2lLVk4NH/zM
X-Received: by 2002:a05:620a:4143:b0:93e:6723:9de8 with SMTP id af79cd13be357-93f57fafdcamr558947085a.59.1792601688100;
        Wed, 21 Oct 2026 09:54:48 -0700 (PDT)
X-Received: by 2002:a05:620a:4143:b0:93e:6723:9de8 with SMTP id af79cd13be357-93f57fafdcamr558939885a.59.1792601687400;
        Wed, 21 Oct 2026 09:54:47 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3ac4f68f1a5sm1127421fa.40.2026.10.21.09.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:54:46 -0700 (PDT)
Date: Wed, 21 Oct 2026 19:54:44 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/4] interconnect: icc-clk: support N:1 master-to-slave
 topology
Message-ID: <i6etkqkc4zqoex54v42b3m53eqa2fvphyxglhcljk3wjr5mvit@qeuvxlksfeh3>
References: <20261007-ipq9650_apss_clk-v1-0-fd4c2b3cbdea@oss.qualcomm.com>
 <20261007-ipq9650_apss_clk-v1-1-fd4c2b3cbdea@oss.qualcomm.com>
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
In-Reply-To: <20261007-ipq9650_apss_clk-v1-1-fd4c2b3cbdea@oss.qualcomm.com>
X-Proofpoint-GUID: rTpHskvlffwRqKicHJjDOrU0Oshh3G81
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NyBTYWx0ZWRfXzFxkUPoHieO4
 tfUDKcwf1JMdMHLURZNOGH+Z4jlrKstTaeIFfBf5DxppD/UhL2G06d3HkF5ngC7WhBBTYSaoVYE
 V0DA91mCPzvk9Kcc9GQVi0G9vda9ONeoeJCpbZjaYk4pIWV18rKF5Z3AbI/MeBeft/XlRsu0nbO
 3MvRrDp75q9DOxbKGOZf70IARF0Zo1F0ThRiHFIYSAYy+QpDXNuRJcXQQWYVWqNnDMGhPdNzsab
 TP69o5F/L9EXXhZk9HsW/673aNVwLAHowbnpJR7O73WQOlJUuIpjUPPvtx6QmwmRJ9O05DU3uEI
 fYvIxxaxlAoStHJIFxI4/ICmAtnkgA7iHNhlPDn0+lBzY1WW9vOf6x7WjcJxUzPRmUTSfYPK2Ke
 cX44LSsiqEvdX17ZG7dhY1Lutr4PXgKgikjhppktxSGxthYdz/tBxJ0qCl5HeFpYI4e9RzQA+VX
 GVIVW+iBOL3QZTMsbww==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NyBTYWx0ZWRfX4NLU3QlRBMXO
 fyEGjDumuAWFtma3tkr7jY3LpF2hMJoWcb2s5JNKhdepuyT8SGn1I05YSoQPZ/Q6ywXsoDHrntD
 Ew4YzhnadkEbNx1slCQx7tmkv17lJo8=
X-Proofpoint-ORIG-GUID: rTpHskvlffwRqKicHJjDOrU0Oshh3G81
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad8ee59 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=EUspDBNiAAAA:8
 a=nKfPptvIfco8BJigVBwA:9 a=CjuIK1q_8ugA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210067

On Wed, Oct 07, 2026 at 12:20:44PM +0530, Kathiravan Thirumoorthy wrote:
> icc_clk_register() assumes each icc_clk_data entry describes a unique
> master/slave pair and creates both nodes for every entry. When several
> masters share the same slave_id, the shared slave node is created and
> added again on each later entry. icc_node_create() returns the existing
> node, so icc_node_add() hits WARN_ON(node->provider):
> 
>   WARNING: drivers/interconnect/core.c:1103 at icc_node_add+0x10c/0x120
>   Call trace:
>    icc_node_add+0x10c/0x120 (P)
>    icc_clk_register+0x1a4/0x214
>    devm_icc_clk_register+0x18/0x80
>    qcom_cc_really_probe+0x4c8/0x514
>    apss_ipq9650_probe+0xc0/0x108
> 
> This topology is needed on IPQ9650, where the silver and gold CPU
> clusters both vote on the single L3 clock through a shared SLAVE_L3
> node.

If you have a single L3 clock, why do you need multiple masters? Can't
each cluster get its own handle of same path and let icc core aggregate
those? You might need to have a different voting mechanism (i.e. vote on
the sum of bandwidths instead of voting on the max).

> The onecell table is also filled in registration order, so xlate only
> works when the node IDs happen to match that order. Size the table by
> the highest node ID, index it by ID, and skip slave creation when the
> node is already registered.
> 
> icc_clk_set() also passes only the requesting node's bandwidth to
> clk_set_rate(), so the last writer wins. A low vote from one master can
> then lower the clock below what another master asked for. Before setting
> the rate, take the highest peak bandwidth across all nodes that share
> the clock.
> 
> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
>  drivers/interconnect/icc-clk.c | 45 +++++++++++++++++++++++++++++++++++-------
>  1 file changed, 38 insertions(+), 7 deletions(-)

-- 
With best wishes
Dmitry
