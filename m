Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBA0A3BE16E
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 13:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787750073; cv=none; b=tb2dkOq3iYK/p+OCoQiTmq2yxD6Qq1xgUzqdnkrGg9GcYDVZhSLk/Nwcj7dg3SqHOMcnbnjfuDG1aadkq0GeXoXSgInmOC9LJpldHc3eKqYZaoDl3h8I7HvEhecTkBfRSCcffdezn7zyxd3m8nllEVHbgxUEXhG0/+Z1PIHL92E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787750073; c=relaxed/simple;
	bh=TONygGSLK9eRUQeUSACVoCsHZVIfM7GHGYxKbUihzRg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ELF0nfhpQAN3cdB6s2CRsqfwtAG2T23DLDM4PSszvyFIhGlrgKou/8txqT2mUKdljwcwQJXogBCFYIItrCy0vDaSJl0Gx1jEbTx2ratOYevF9I6DocWrFXqi9KxEzIuF/5NsKct5WgM2gwG7oHsyCku+qmwLUdxb3vV1/X26H4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mGyuCiGG; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=h/BFi3c2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mGyuCiGG";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="h/BFi3c2"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QCBkLM3983105
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 13:14:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=9b65bGNzy50Pq14wclGP/2PS
	9e7oVjr2Cl6312ucGxg=; b=mGyuCiGG+vlg2M5GqPw79eoVKBFrxAOoWmHjz32h
	BLhsTETjNIsn3j3JMf8GZpYSM3sonU4I5sXSjAQ/XYsZJlooQUA0zos6VpR3cUAR
	y674nCmmb/Nl6SXgvq4mmtaHTgkRMtb7Fgiy4NqjQWqzf2m7Xr7fBS0vRA9MF6L9
	CswdFbefabXFGRxMnvLmFbytZyVVKdAE/fv0koUh+g5Gf79LffkEbBofjYgLTS/W
	ttkSYmx/TY5I/BzOavnXys5p5w0uhKMc9pnE6SfSzxzK5BHj3E4EA6puRD/72iUl
	zy7EaNLIZcVRS91JKHH8H9XUBCFICAwhv9rO0bsrukkFAg==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9wmqru05-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 13:14:31 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-38ea32e57e2so2296257a91.1
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 06:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787750070; x=1788354870; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=9b65bGNzy50Pq14wclGP/2PS9e7oVjr2Cl6312ucGxg=;
        b=h/BFi3c2wyG6KEiXNiMMSwnlL3bYtpFkzo+5ZxfuJg6cEemWwwWDV5EnnnHEPGtQVA
         vzlC91kRwN9NefUUw2iKbtJ6AenYwTKNzwGDCIwnCDL4g1ojJJTX/3E8ELxxiuhleYD/
         5praHztxTq6H/qdndMAsvoL1mp+zJW06sOlz44Z+qnR628xNyP9iSgns5ztWSNrhq0fV
         ZSUSuympFn/U/2bQWNxStqgHmuKVj7iWgQCdBj5SHTCQPQI8b1BgVDj9teCEmMD70OtJ
         h2uU85wOovNs4jPRM3MhO742rWek2oCE2C1VOponnOZowxLy+yWNQErEBmsgJMErkBFT
         suDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787750070; x=1788354870;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=9b65bGNzy50Pq14wclGP/2PS9e7oVjr2Cl6312ucGxg=;
        b=d1BOpj7inuiJ3IRy201glVXzc+j+nbuXNLkmV8BwRZ6aqT9HkYaWXZLfEWpObbJwkF
         ZBf+OHkLNuq/cPMUcIhhCSbhbbprduUVNtU0Zlj9cLvrCSExUkK9lgXFb3SBg5R80GxV
         0QwxvMWuCs5LBMjkDuqlXTizOUURByghALU14MXMEKEQmGpa5zV3azpIKDLbbeWSBlrj
         7m1vB8I2BwFWirKaQ9IoNx8tC+g3m0jZz/kEmfoJIpPLmfeklZ9klbbV5qfoLrJ+Bg0B
         U0Q4hCCadjo/FE3zQrvjOORs9uHS8xtFuefNMdC/0Uf77CoP70aBoeArsGvnIPdL6+mk
         rkkA==
X-Forwarded-Encrypted: i=1; AHgh+RpdrcDOEf9DyvQq1Mr60Mzt0FIyhD6B4ujijoqDVah6bAi0G/uhrs7PxTIn0JmDJh1GvFmZlgortg==@vger.kernel.org
X-Gm-Message-State: AFuF++l9Nka45c2a5DUTJEntABVg4a+GGwRoyq34pcZRALfP+MyqeKlR
	56AWTw26KRinhq6M74lfXKhTDXdN49HnTdaypOmXbhdu149VfSwgnca0iz8B5MCwiCLQTODE/Sm
	nMGA2jLEeaRMuiHVuyi8UA0PuYeDZDoOqHqgQNPpPT3B2F223BDHxsGzbMzcBnA==
X-Gm-Gg: AR+sD10T3iDCRg1mTidhSn81oScoaOYCe2uV+G8pwLVkfC8f7azlm8Gy6GThVmq2SCf
	oSvaIs4t/lrxgu4vNR4Q/NUH8J3id3z821YTk/t5su0dRS+UgRZRLDco4Tx7X0k+EJlt+QHlALD
	6frWeSz6dpJHNCxWMj8h7Foq2Cnm5iTtpiC72VpWhckAryVS85zCIPqpzJrSR2FZq3tdKGGkQHp
	lU1eSfHezHH6Gva0NKMSSnaxvWCJ/UAWHNwdO23+WbpntgN+rjM1HOqVYCCjjmxL4pRVmjOnU43
	eUkvxDwsb1ZulNctCbC2L0kM8dfWQ6oeGSeoIar4lEXtXpca8xOuz9zYvXGFg9C7Wwsjxp6J7KA
	BnB78tSEVe4GDYqcg09dRBZ2SYk4iAoSeuCDoGHBA6ac=
X-Received: by 2002:a17:90b:4c4a:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-3966d00a01amr13595732a91.0.1787750070277;
        Wed, 26 Aug 2026 06:14:30 -0700 (PDT)
X-Received: by 2002:a17:90b:4c4a:b0:38e:ad9d:1161 with SMTP id 98e67ed59e1d1-3966d00a01amr13595579a91.0.1787750069721;
        Wed, 26 Aug 2026 06:14:29 -0700 (PDT)
Received: from QCOM-aGQu4IUr3Y (i-global052.qualcomm.com. [199.106.103.52])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39645b07394sm8149417a91.4.2026.08.26.06.14.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 06:14:29 -0700 (PDT)
Date: Wed, 26 Aug 2026 21:14:22 +0800
From: Shawn Guo <shengchao.guo@oss.qualcomm.com>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] pmdomain: qcom: rpmhpd: Add NMXC power domain for
 Nord
Message-ID: <ao7mrrW_ob77EAIp@QCOM-aGQu4IUr3Y>
References: <20260826102746.633076-1-shengchao.guo@oss.qualcomm.com>
 <20260826102746.633076-3-shengchao.guo@oss.qualcomm.com>
 <6b2f4411-9c38-4b82-b605-6b9a047ab973@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6b2f4411-9c38-4b82-b605-6b9a047ab973@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwOSBTYWx0ZWRfX6iYsYG21mzmB
 QB/g7coFjERCy5D8ERMAIeV9rcsloPC3mYbB8Zqmo1nyKMYVsbh1HuPFIQsLSigywEDDNnApIPm
 cfnuLVY7930CBhtXb5POtz4M/IK7FRI=
X-Proofpoint-ORIG-GUID: aeRPQgokhDvyraQXA5jnbBP9xeAy_Jzy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwOSBTYWx0ZWRfX+M/JjNyfU9FP
 TRGVsRiFzOsce0oM5GZt1moH0Qg0zGse3v75zEXAAK6qaHK8N7zN/Pe/e0MlsBW86Cf/dN3begM
 nLqSKWFBC/HsEN6KVdCL1cqpU/VXBPAnafcMV3t7Q1XehR+AK/A0y4v4STyv8P/gQEI4gZDuFl6
 NiwDiAkvPX35LQaklFLQY2/nYleGrKHnctqDeiiTMiiAPFYhcfGFb2KlCFcYTmQdAgrN9kBxkFE
 v7d6S0o63HXxcjmuB7bu9Y3ElbXGvCfdA/+rIUv16jfhUbM4amkkgR3v/1ZCcJgP6pJcrKK7eop
 FGU+XaXTMMk+XawBzzJCpdShHReGPardxyesHj7o+T91/+VtX4BwSGvAamsNHezV6aCeEtsaZSg
 UCIaxFHZG5YFqNb+26hTN5SjflywVRsVwBD21+hVg+E7BkLB8CtTbQ+TTxw77msvwV47CfKXri2
 ROWTID8Jj8NlWhPHP1g==
X-Authority-Analysis: v=2.4 cv=T9S8ifKQ c=1 sm=1 tr=0 ts=6a8ee6b7 cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=b9+bayejhc3NMeqCNyeLQQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=3Qi1WCIwDasdfMXOsCAA:9 a=CjuIK1q_8ugA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-GUID: aeRPQgokhDvyraQXA5jnbBP9xeAy_Jzy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260109

On Wed, Aug 26, 2026 at 03:04:33PM +0200, Konrad Dybcio wrote:
> On 8/26/26 12:27 PM, Shawn Guo wrote:
> > From: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>
> > 
> > Add the nmxc.lvl RPMh resource and register it in the Nord power domain
> > table. Nord supplies the NSP memory rail from this dedicated resource
> > rather than from the shared MX rail, so consumers need it exposed as its
> > own power domain.
> > 
> > Signed-off-by: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>
> > Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>
> > ---
> >  drivers/pmdomain/qcom/rpmhpd.c | 6 ++++++
> >  1 file changed, 6 insertions(+)
> > 
> > diff --git a/drivers/pmdomain/qcom/rpmhpd.c b/drivers/pmdomain/qcom/rpmhpd.c
> > index 96e4bd2f5a14..717c44d1c39a 100644
> > --- a/drivers/pmdomain/qcom/rpmhpd.c
> > +++ b/drivers/pmdomain/qcom/rpmhpd.c
> > @@ -198,6 +198,11 @@ static struct rpmhpd mxc_ao = {
> >  	.res_name = "mxc.lvl",
> >  };
> >  
> > +static struct rpmhpd nmxc = {
> > +	.pd = { .name = "nmxc", },
> > +	.res_name = "nmxc.lvl",
> 
> The commandDB sources suggest this shouls be nspmxc.lvl instead..
> 
> Can you dump /sys/kernel/debug/cmd-db?

root@qcom-armv8a:~# cat /sys/kernel/debug/cmd-db
Command DB DUMP
Slave ARC (v16.0)
-------------------------
0x30000: cx.lvl [00 00 10 00 10 00 c0 00 00 01 80 01 a0 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]
0x30004: cx.tmr
0x30010: mx.lvl [00 00 10 00 c0 00 00 01 80 01 a0 01 b0 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]
0x30014: mx.tmr
0x30020: ebi.lvl [00 00 10 00 c0 00 00 01 80 01 a0 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]
0x30024: ebi.tmr
0x30030: gfx.lvl [00 00 01 00 c0 00 00 01 80 01 a0 01 b0 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]
0x30034: gfx.tmr
0x30040: ddr.lvl [00 00 20 00 80 00 a0 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]
0x30044: ddr.tmr
0x30050: mmcx.lvl [00 00 01 00 c0 00 00 01 80 01 a0 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]
0x30054: mmcx.tmr
0x30060: nsp0.lvl [00 00 01 00 c0 00 00 01 80 01 a0 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]
0x30064: nsp0.tmr
0x30070: mxc.lvl [00 00 10 00 c0 00 00 01 80 01 a0 01 b0 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]
0x30074: mxc.tmr
0x30080: nsp1.lvl [00 00 01 00 c0 00 00 01 80 01 a0 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]
0x30084: nsp1.tmr
0x30090: nsp2.lvl [00 00 01 00 c0 00 00 01 80 01 a0 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]
0x30094: nsp2.tmr
0x300a0: nsp3.lvl [00 00 01 00 c0 00 00 01 80 01 a0 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]
0x300a4: nsp3.tmr
0x300b0: nmxc.lvl [00 00 10 00 c0 00 00 01 80 01 a0 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]
0x300b4: nmxc.tmr
0x300c0: gic.lvl [00 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]
0x300c4: gic.tmr
0x300d0: ds.lvl [00 00 20 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]
0x300d4: ds.tmr
0x300e0: gfx1.lvl [00 00 01 00 c0 00 00 01 80 01 a0 01 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]
0x300e4: gfx1.tmr
0x300f0: xo.lvl [00 00 20 00 50 00 80 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00]
0x300f4: xo.tmr
Slave ARC (v16.0)
-------------------------
0x00000: cx.mol [80 00]
0x00000: mx.mol [c0 00]
0x00000: ebi.mol [c0 00]
0x00000: gfx.mol [80 00]
0x00000: ddr.mol [a0 00]
0x00000: mmcx.mol [80 00]
0x00000: nsp0.mol [80 00]
0x00000: mxc.mol [c0 00]
0x00000: nsp1.mol [80 00]
0x00000: nsp2.mol [80 00]
0x00000: nsp3.mol [80 00]
0x00000: nmxc.mol [c0 00]
0x00000: gic.mol [20 00]
0x00000: ds.mol [20 00]
0x00000: gfx1.mol [80 00]
0x00000: xo.mol [80 00]
Slave BCM (v16.0)
-------------------------
0x50000: MC0 [40 d0 1b 01 40 00 00 00]
0x50094: MC1 [40 d0 1b 01 40 00 00 00]
0x5009c: MC2 [40 d0 1b 01 40 00 00 00]
0x50080: MC3 [40 d0 1b 01 40 00 00 00]
0x50004: SH0 [c0 ea 21 01 00 01 01 00]
0x50008: SH1 [c0 ea 21 01 00 01 01 00]
0x50098: SH2 [c0 ea 21 01 00 01 01 00]
0x50084: SH3 [c0 ea 21 01 00 01 01 00]
0x50010: SN0 [10 e4 1f 00 40 00 03 00]
0x50014: SN1 [10 e4 1f 00 40 00 03 00]
0x50018: SN2 [10 e4 1f 00 10 00 03 00]
0x5001c: SN3 [10 e4 1f 00 10 00 03 00]
0x50024: SN4 [10 e4 1f 00 10 00 03 00]
0x50028: MM0 [b0 db 23 00 40 00 04 00]
0x5002c: MM1 [b0 db 23 00 40 00 04 00]
0x50030: CN0 [e0 22 02 00 04 00 05 00]
0x50034: CN1 [e0 22 02 00 04 00 05 00]
0x50038: CE0 [fc 5c 00 00 08 00 06 00]
0x50070: CE1 [fc 5c 00 00 08 00 06 00]
0x50074: CE2 [fc 5c 00 00 08 00 06 00]
0x5003c: IP0 [28 00 00 00 08 00 07 00]
0x50040: QUP0 [14 00 00 00 04 00 08 00]
0x50044: QUP1 [14 00 00 00 04 00 08 00]
0x50048: QUP2 [14 00 00 00 04 00 08 00]
0x50068: QUP3 [14 00 00 00 04 00 08 00]
0x5004c: C0N0 [60 b7 47 00 40 00 09 00]
0x50050: C1N0 [60 b7 47 00 40 00 0a 00]
0x50054: C2N0 [60 b7 47 00 40 00 0b 00]
0x50058: C3N0 [60 b7 47 00 40 00 0c 00]
0x5005c: CP0 [30 75 00 00 04 00 0d 00]
0x50060: DCP0 [30 75 00 00 04 00 0e 00]
0x50064: DTP0 [80 38 01 00 04 00 0f 00]
0x5006c: ALC [01 00 00 00 00 00 11 00]
0x50088: ACV [01 00 00 00 00 00 12 00]
Slave VRM (v1.0)
-------------------------
0x4d000: vrm.aoss [03 da 00 00]
0x4d004: vrm.ds [03 da 00 00]
0x40200: S1A_E0 [01 0b 00 00]
0x40300: S3A_E0 [01 0d 00 00]
0x40000: S5A_E0 [01 11 00 00]
0x40400: S6A_E0 [01 13 00 00]
0x40500: S8A_E0 [01 17 00 00]
0x40500: vrm.ebi [01 17 00 00]
0x40600: L4A_E0 [01 49 00 00]
0x40700: L6A_E0 [01 4b 00 00]
0x40800: L7A_E0 [01 4c 00 00]
0x40b00: L8A_E0 [01 4d 00 00]
0x4a000: C1A_E0 [02 69 00 00]
0x4a000: vrm.xob [02 69 00 00]
0x4a100: C2A_E0 [02 6a 00 00]
0x4a100: lnbclka2 [02 6a 00 00]
0x4a200: C3A_E0 [02 6b 00 00]
0x4a200: lnbclka3 [02 6b 00 00]
0x4a300: C4A_E0 [02 6c 00 00]
0x4a300: divclka1 [02 6c 00 00]
0x40c00: S1E_E0 [01 1b 00 00]
0x40c00: vrm.nsp3 [01 1b 00 00]
0x40d00: S7E_E0 [01 1d 00 00]
0x40d00: vrm.mx [01 1d 00 00]
0x40e00: L1E_E0 [01 4f 00 00]
0x40f00: L2E_E0 [01 50 00 00]
0x41600: L3E_E0 [01 51 00 00]
0x41700: S1F_E0 [01 1f 00 00]
0x41700: vrm.nsp1 [01 1f 00 00]
0x40100: S7F_E0 [01 21 00 00]
0x41800: S8F_E0 [01 23 00 00]
0x41000: L1F_E0 [01 52 00 00]
0x41900: L3F_E0 [01 54 00 00]
0x41a00: S1G_E0 [01 25 00 00]
0x41a00: vrm.nsp0 [01 25 00 00]
0x41b00: S5G_E0 [01 27 00 00]
0x41100: L2G_E0 [01 56 00 00]
0x41c00: S1H_E0 [01 2b 00 00]
0x41c00: vrm.nsp2 [01 2b 00 00]
0x41d00: S5H_E0 [01 2d 00 00]
0x41d00: vrm.mxc [01 2d 00 00]
0x41200: L1H_E0 [01 58 00 00]
0x40900: L2H_E0 [01 59 00 00]
0x41e00: S2I_E0 [01 31 00 00]
0x41e00: vrm.gfx [01 31 00 00]
0x41f00: S7I_E0 [01 00 00 00]
0x41f00: vrm.mmcx [01 00 00 00]
0x41300: L1I_E0 [01 5b 00 00]
0x40a00: L2I_E0 [01 5c 00 00]
0x42000: L3I_E0 [01 5d 00 00]
0x42100: S7J_E0 [01 00 00 00]
0x42100: vrm.gfx1 [01 00 00 00]
0x41400: L1K_E0 [01 61 00 00]
0x41500: L2K_E0 [01 62 00 00]
0x42200: L3K_E0 [01 63 00 00]
0x42300: S1L_E0 [01 00 00 00]
0x42300: vrm.nmxc [01 00 00 00]
0x42400: S2L_E0 [01 45 00 00]
0x42400: vrm.cx [01 45 00 00]
0x42500: L3L_E0 [01 66 00 00]
0x4a400: vrm.sail [02 67 00 00]

Shawn
