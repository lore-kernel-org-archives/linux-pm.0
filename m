Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792601773;
	b=E6Gr4Fo7X4dkF76zlZMNA5ck6mqfwomi+IoKR+MiS37YwCDkY43/yEVWhyvorsqFB7T7
	 fv+ssn1fkedKQ5XfkuhRZgK4dybFd9HFUI0Gn/wXyoSCsOu01NHxAwZndEccFWFg5sRH5
	 3Y3Fc75A9tkC5nKVyDVgF9QM4LAWBaZPVRqiu3eZ7kVymXb5r9ct4cu77nqsf9auOXC7C
	 RckGekLu82nQQyDL/UhdGXlciDkLrvQwwICqxPYJjJnqX/xgVDVokGHM61PNmSsTozN+R
	 2BXhnxZs3uRGRZwEU48DngJtr5QBKQbVOktgLekBCvYI26nVtitiTxR1NNw9e3vwJtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792601773;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-GUID:X-Authority-Analysis:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=U1odT0h545fjjEeb0UTVDvE0Tg7Aw5T2oDxzlxF0X4Q=;
	b=C/R4GLZywWI7az9unahuKFcc1/dlOUAdaXsDqQ82Nhkz35PAz6YtnQmmCGfb9walxHhv
	 7Gn4PovwJJHczXeqxbxOYii4snkzAq21t1VfOyxlmrCQAoKVN0v2v7vlIvXBddo2VkqLO
	 n+Xx9n5Sm33y7igYEtb0qcUp/bbKZnC688B9x+jvHf3i/fsA5ueDduJUuCgXRmbLVXncm
	 bx0EMdqtwkikOw951sv0g3frGhC0jYt2wtMwGb8SKuAkfTxWFdu0S/QgoG2fHDkqoYH8a
	 CapirJ6gwUC6QVnJWo1X2jKCJX27ODHGxJznx1+2EOQFMgrPV49Swu3BnAocsnCRWoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dbfgYAmU;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cYuRoPmf;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2323260A4AC9
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2323260A4AC9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dbfgYAmU;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=cYuRoPmf
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFU0qA682124
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:56:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=U1odT0h545fjjEeb0UTVDvE0
	Tg7Aw5T2oDxzlxF0X4Q=; b=dbfgYAmUPR83D3MquXGFpWnp/Wrxo0tk3rIRxDpS
	ORZg7yNiKLtu40ncUtPzayfksX2qdpSYPEbC7mAtRvt6V1NguSsQD1kLwjH/54OH
	gXxeTx3s9cIzc1PVS2iED6SR2b7VyhNoc7Db1XjQde5WmmfCpFiNTdzTmHMwge45
	UDNUHFy13zGTOYJdadWx2R/o122ddPVokeWQYByBbJqzvFyVB1MxHrO3xIZ3qw+Z
	rxIFrMV00H5uz/KfE63V6Iomz2AFOvoTVhccJGK2V+EO8ZX6LyUv2o+J/wpxP4vV
	vR8uZ/PASeh2aQyYlX+1wOP4HgcX7oBIU75bgQM0EvY9+A==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hex7vrypv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:56:11 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93f13c143c8so174877685a.3
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 09:56:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792601771; x=1793206571; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=U1odT0h545fjjEeb0UTVDvE0Tg7Aw5T2oDxzlxF0X4Q=;
        b=cYuRoPmf0X9XqOhph4XOfPKDZySeuyRhOCMvZ6glNlMBVeqd+eamYW8FTjVNSOYFC5
         lptHqWdprO7FvoiHgOvgTCAHVrpMQR480LdxEf6fr4JFdr+ze7DDccketXdvxhXTHeu9
         tpJ+VOKJ06uZTCmd2vVx+guEjwXiMLEFUttASnHlVUEhgiVsbqWEdFJjCjN7rslJZtH/
         jomUv3a+JIp98mdvJFHCilcWp1yy9ID65YRqlHiGMhIr6NXgLORXKgpFTH1fVqSLBkFA
         NKUjTtCTY24KNq1/tNfmM6U/zOTeZdz/HAt6/t8yhxmcE3/43tKGuD+X0NIdJ+cWRnrN
         w4gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792601771; x=1793206571;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=U1odT0h545fjjEeb0UTVDvE0Tg7Aw5T2oDxzlxF0X4Q=;
        b=bpITd01oNKb6u8b788lLw75rmWlYqmeixkY6oV34UtVL4mFNhlHrXofA49vU1KSfUu
         umBYDNSk5jFGT3X8yHjO+Y42yqio/5qWxQ2jGDKkw/fEj2R65lF7xExTMjSJ69a6dhwr
         +2Bl6+avaQZzEbxOKsABEw74BBajmRBigWy2ch70Mx5gU2kIVNR07MnpKC4KiSVSOqqw
         p0aF8UKW7hkFry3q0FGYhbh9q5qx6DRZQIlvfmklIZpbSezRPJzSSk0XWIXoto2oSKNU
         WPWAQSGpUejK5MbFiS4QfvqbuvqmeFF4oKzpdRWX0NUEnz4/z6ElwM7aMOWOhjyWJvaE
         oJ6Q==
X-Forwarded-Encrypted: i=1; AKwUvBx8ndBtG1ypmEuePRhVbdvQ4HmyDdXajQCy/So1cjsv6uQhQu1e1kEwMlxvqLP5WO6vss75pL9i0g==@vger.kernel.org
X-Gm-Message-State: AFq9FYLPQ9Ryphw6Svf6HhwjG+62IPpzas81E/kiMuZgpjZvDNEU6yqT
	SqUYzBNVMK+zgmAnxYXydeL0D21j6PRl/UaVD5op/11myTMgOYVeFPx2lH4wARhVYlNa9tgLFSR
	n/6oP3TgPofeQNJqyhGR61SLX8ttSPVzLWCEt6Uq9EpUyw0eUB9yMQp06cyJU/g==
X-Gm-Gg: AYBFou1Jtn+vIkR/Qpl610fPbG5MHpr+G4NuWS+/OZF0Bfotx2uHIljZqbtRo3XSVgz
	4cTrG47xbPf35qrmPFZFcpjNnaM8//eVcphB0KM0/h18Y3QPWCd0Q11JLwZ1pfNacjXY3nowPH+
	GF40yivYuoMIb3oyv3a/eRF6yfmEwGWTzsaWnwIQJjdzY2RwEeK7LLoeajw+Qmn+vIj8Z0E5aDY
	tvQw7Z9uf3YOOD6lGM8+StUt7Jb19PL54ZL5aa/c3XBI8FhrwqFGwEYAnKzKMw0Z6696I9Jw3ks
	emRvuHH+wD2kWnZbtkyjfEN6xhsN1CWhXjdmC39Vz+boTn2dUCnYIM97cznmy2asmfUx+7sULDZ
	5zXN4BVc0O3c0gJ1mKPKbrNBkat8rQ6+BBrFsLbsCJlO0nvghpyYGXQGLCU7Nrn8B2w8rKgqbon
	s6rkdovZx29y7i
X-Received: by 2002:a05:620a:31a9:b0:93f:1445:82a5 with SMTP id af79cd13be357-93f57f7a432mr536574185a.79.1792601771326;
        Wed, 21 Oct 2026 09:56:11 -0700 (PDT)
X-Received: by 2002:a05:620a:31a9:b0:93f:1445:82a5 with SMTP id af79cd13be357-93f57f7a432mr536568985a.79.1792601770867;
        Wed, 21 Oct 2026 09:56:10 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5bfa124187fsm640279e87.78.2026.10.21.09.56.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 09:56:09 -0700 (PDT)
Date: Wed, 21 Oct 2026 19:56:07 +0300
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
Subject: Re: [PATCH 0/4] Add Qualcomm's IPQ9650 APSS Clock Driver Support
Message-ID: <3v5ul4b2qddghhwdyzbjh5uqwo6bvghrabr4nzs3ttvxpcwfne@tyepx5pz3tqv>
References: <20261007-ipq9650_apss_clk-v1-0-fd4c2b3cbdea@oss.qualcomm.com>
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
In-Reply-To: <20261007-ipq9650_apss_clk-v1-0-fd4c2b3cbdea@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: YR8nLjfpc6JdOC8IRV1k6fM0-mY-38Gu
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NyBTYWx0ZWRfX/ZqKGPccE1zI
 BmGok0X9l1c14vDhiXGm1AOWxTut6pKmRKtriTG6YcjhIzjJBTclstwkHNa44/9ihGMNLngu7QB
 JxUwUX5muxH6pZ40Fbk2rdUw3epNQ3E=
X-Proofpoint-GUID: YR8nLjfpc6JdOC8IRV1k6fM0-mY-38Gu
X-Authority-Analysis: v=2.4 cv=e4uT2qp/ c=1 sm=1 tr=0 ts=6ad8eeab cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=slmPpXlptjOQBmdJfhgA:9 a=CjuIK1q_8ugA:10 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NyBTYWx0ZWRfX5YcCLZNvRlBu
 IPQwpgAKVJmuFVnVAbB/Td/kGG+hvHuPvQMHw8K/kQbRYsZitDgdupyW0OEE99kIlJTN1xoY3zx
 sRiW4EtcR8xJbou8g78CxcVqzXho0qv22bTK9rsTEdZFlPR/gHMiw5LQ7otgxbXm1qfiDYHLNJa
 LImyNGhUVIJ2KJ9CSf44jgyN/lt7wwpc142fwscKtA7JkjuPRX9/nUIWXvTQme5O/xO+a1f4peF
 8LFbDSiDZMLBGk7CMmQG+Rz5V7feP0deVbj29VVan22WDiedLNxCEpMUMa2AKyIcS3eLSWpcXVs
 lq1HHGcQfY/CF2dNQhQ7nfZQtV+c38JyCmwRboOQ+p0qZoE52tsRZEaDLZthDjGLEEG5LwoInXA
 AO/dOQLCUYeKag5q7JZwSZBSpneKPB2x1UfgUS1AV2XNdQP/MQ9UD/nGd5l6IUv3JidHaJxo+gd
 Sq4GCSRh5HtPIRv3DQg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210067

On Wed, Oct 07, 2026 at 12:20:43PM +0530, Kathiravan Thirumoorthy wrote:
> The APSS clock controller on IPQ9650 provides the CPU and L3 clocks. The
> four Cortex-A55 cores (silver), the Cortex-A78 core (gold) and the L3
> are each clocked by their own Zonda PLL, selected through a glitch-free mux
> whose parents are XO, GPLL0 and the corresponding PLL. Since the L3 has
> to scale along with the CPUs, the controller also registers an icc-clk
> provider in which both CPU clusters vote on the L3 clock.

Is there a complete picture somewhere? Do you have a DT implementing
CPUfreq somewhere? It might be worth including it in the next iteration
of the series.

> Signed-off-by: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
> ---
> Kathiravan Thirumoorthy (4):
>       interconnect: icc-clk: support N:1 master-to-slave topology
>       clk: qcom: clk-alpha-pll: Skip Zonda PLL configuration if already enabled
>       dt-bindings: clock: ipq9650-apss-clk: Add IPQ9650 apss clock controller
>       clk: qcom: apss-ipq9650: Add IPQ9650 APSS clock controller driver
> 

-- 
With best wishes
Dmitry
