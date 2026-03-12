Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E6E3A6B64
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 12:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773319330; cv=none; b=WYqXIakMNyYDylVFbBp1AVF8eDicsxurgjmWu6FR4aSPnXU5ukqvFcA+TDOqZvZ4kbbCosM0lnAKC+ilLaxrXfU0M6+KbPe4AZOAW1KE8bWtS6/vbCpgUzZop8Y9drO59S2klayQJTv5sHJ14JjGpSsJhnbwaMk4mPJvI9xSrHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773319330; c=relaxed/simple;
	bh=0PQ0/XQ73v/0WqhYsb+N961/91xmQqZgb7S9127C+RU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xx5hKrFEscIYGoHiPnas6zxghnn6W+XEA/UV/crsKbCOxgaW5q9x4E6cpt2R+HAmZXPz3SQ/AP2dLE5MpzCWXAvBoSN826yq+4797XzyaeNRsu7+TJveRnMvf9pov2Nh6loYbv6rFb95eWylkiiNfWfg6IXvAk2/8yfqgCC2GhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=peV06Vot; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=j8M32FgJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="peV06Vot";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="j8M32FgJ"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62C9Xale1922655
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 12:42:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=dxYbGWS7A2uPAt1u3WZ8zGH8
	nQnJB+uBws4EFBR68HY=; b=peV06VotM2L0IZMJSxFN5DLWvkmiscSfzNL+XaRy
	ciAKk51Cbu8JLm8zZr0g5YB51+U6pfeSYsNpz8K7YJhjTckxRhGqL0jfhsxZaoGs
	1onHkVYtFYeOxSqQRRGU7ixtMS8F4LZHBUj6NqXIat74bWZsY+4aBQPuZ76Penno
	I2tk0UYrEOMtIxUAXZRRrbDD+gBWH7NzTSAjDehlyNPN5V7H6FaPekjE+sj7pRpC
	Cj2ZIw2+B4rTQ5LCttseu9gehKm/qZIbZt0iQUdxFY2K/NGnxB4OjONti9yBlFPP
	WKKaWADziL3fiPjKqcAl1aboMMjzPMbAcw4p++aKAiztmA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cuh4wt3mc-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 12:42:08 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-8cd7ea0bb20so550834185a.3
        for <linux-pm@vger.kernel.org>; Thu, 12 Mar 2026 05:42:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1773319327; x=1773924127; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=dxYbGWS7A2uPAt1u3WZ8zGH8nQnJB+uBws4EFBR68HY=;
        b=j8M32FgJouGnd/bEOtHmn06KoCwq7jcsLAEp6zbAi0d7os2a+kFE4r2Hkue5ab4vdx
         jb9bOX8f4S4EqG2UPcrCQ+xD3dGaxcg9+0+xqy9TPLaIYrR8sMHaXgImibPLaZhhSilF
         cnB4gIlPwYqL7nAkDZigVkzOAENTLJzNWGYw88Y3qbdAxBnBSb9bTZKsn/knJiaWEvDG
         QjMAlVsR0u1z7/9rMpoCZWYCmyxEI/JsLjTXvm19GQJj4vw8DcKea22fR78GTChRzrX2
         VtYSYH7Rpwi3dSpPt6vMZMKhX8AAluc+4hERnjmfGy1wh4v+o4LRFf9PC8ERq7XUpXFh
         n5cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773319327; x=1773924127;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dxYbGWS7A2uPAt1u3WZ8zGH8nQnJB+uBws4EFBR68HY=;
        b=SKnnt+ltaBLd+nAh5IvAZfAK9d9bWS3DLiBneIrR7yK3CKpYcjFJUN4kB0guqUv5Vs
         EsN+2ERiHOd5d42IOsYd7Mpv/2kYWZ/x5b8yRTfDspJde9Yc0Nqq1ld43BGacSCMGS77
         f0CbJ9aTIsNUIMa4K/gQ0E2eJGShNcmB+nAukC28tWQ8R72Hj32NN394nfKf2Z5cP5pT
         N6myeq/qPtJ/64YhGv2jd/X/+2qnIEEIXJTg2tPit5LtyRumORZtXtXEqRLwUSwj112n
         srHrvSOWdB1NYPZL3vADEV4cr+myZ8lqzfLQq3xvmNRKgSYK7iLH3LHgEI5A1OQdsI00
         DM8Q==
X-Forwarded-Encrypted: i=1; AJvYcCV3eyMXLhQdnsMZ/T78uvZ0/0lGf2g9m/z7Y6Eq+LEVPkKzPB78IBIBpk4zmU1yq6Q8zkKhJcxziw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7Fc0YgS7WeqotqlP3M3nuTpgTAmYRpHuF1te/83nHQxkSObus
	4cTCxWlfzCCkf3Hia9GzMP3Zky4CB/VPWZQP0IvCW5lGwmR1gJNfH2XxagwEXj6sKMXs4/BKGAg
	KUhsLaRR/fzcwb/H2Z7q1D1HPHviwbFdKzJHQYq/28JyYH/Qli/6/JWuZTMajZQ==
X-Gm-Gg: ATEYQzzpZD8IOBPiJbynWqr1JebV3Y3skZqeikmEGqpBRoI9Yfs8X662Nu+MDsJ4wdH
	h0UPYsOB7LMizYYUvLDv56P8bqGqguRBK+945bp9pRQfj0Fl/+j0flnZD7QLDWv9KYLR/ICwYyc
	C0urWE3QTBD0iwhR3QIJmMaz7Slig8D6Q1O/qL/z/f9ToWblPKZA1IrssRUdMVD7brjKpSAqOUn
	eA2TOICk4VnNQMkDaEC64qTeLTAUdWjZeyWrp4DF0pSPX0mEmSsDoOXfh6ddy9DUNTFncPUFeNL
	GB63HH/1j/GO/1la37AzrXCwzg+mBShbWLvJbm090TETMMIRKU9otXIxhd5gjkCyn3YDnWfESHx
	VQpzO6oMnDBO3iqQxr9J9poegTo9I63KrFA==
X-Received: by 2002:a05:620a:2906:b0:8cd:98c1:7640 with SMTP id af79cd13be357-8cda1936d56mr772680485a.8.1773319327193;
        Thu, 12 Mar 2026 05:42:07 -0700 (PDT)
X-Received: by 2002:a05:620a:2906:b0:8cd:98c1:7640 with SMTP id af79cd13be357-8cda1936d56mr772675685a.8.1773319326614;
        Thu, 12 Mar 2026 05:42:06 -0700 (PDT)
Received: from oss.qualcomm.com ([82.79.95.133])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4854a18ddedsm114132685e9.0.2026.03.12.05.41.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 05:41:45 -0700 (PDT)
Date: Thu, 12 Mar 2026 14:41:37 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: [PATCH v4 0/2] pmdomain: qcom: Add support for Eliza SoC
Message-ID: <7jsbcdkszog5gimte2gobdemasp3hkf6dxcag3bbaq2rhkb43v@skyla2nujuz2>
References: <20260302-eliza-pmdomain-v4-0-e61ae2bac805@oss.qualcomm.com>
 <CAPDyKFrvMieutLjHkL_dvfm6X9OpLsuGn_SPp1-FeBO5oe-zhg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAPDyKFrvMieutLjHkL_dvfm6X9OpLsuGn_SPp1-FeBO5oe-zhg@mail.gmail.com>
X-Authority-Analysis: v=2.4 cv=GcoaXAXL c=1 sm=1 tr=0 ts=69b2b4a0 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=iKs3dpp2RB4k51ZqCjcyjQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=bC-a23v3AAAA:8 a=EUspDBNiAAAA:8 a=qLcI9j9LDp0L4sTmIaAA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-GUID: uJaEjz5u1UqvhyvEh0tvAXkObZrdRJm2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEyMDEwMCBTYWx0ZWRfX9hdEHKJ7JV2h
 Y5Vai2Q+8CmFzbIXvqVllBGsspZLKpYWCQcWan3mAEY2YQNQ5pWQep3ct5gAUqiK2meJfbgNmmQ
 noPsDt7iRkgatEV0X2BGXWs6aE4Q2P9IVuAuCYZxE8t7Gc8rk9VmkOLGMoNBkGaPm4aStIIrPnf
 pzfp5wYKPy5J5TQ78QwZtF9ifljjYusVH/hng/+SCMP7uOR7Gd1hFzhxCSelNsABgDsdoUaoc3q
 HXm9eNok6aKwtqZ9KN8JMddzI55Fv4ibdoEJScZDMEAKaEm/tLuOmIp/1J2kXluXRk7Ez9HePD/
 6jQJpnIEa1PhYO4fnek4/fU6GLIr5elgWjz8uEosgGCluVDrrIRSWnGJwGGu3yrYuR7f2ckkFVj
 XSyQyQ1QmdaqguCFjrLF1tRvrthrfnuYLG4Yx1eMnNPR/F5G2ceoqFbaUhIK96F85qnXvEvfv15
 xttp45CRwtrh6p/Af/Q==
X-Proofpoint-ORIG-GUID: uJaEjz5u1UqvhyvEh0tvAXkObZrdRJm2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-12_01,2026-03-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 suspectscore=0 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 priorityscore=1501 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603120100

On 26-03-04 12:25:10, Ulf Hansson wrote:
> On Mon, 2 Mar 2026 at 14:29, Abel Vesa <abel.vesa@oss.qualcomm.com> wrote:
> >
> > Document the SoC specific compatible in the devicetree bindings
> > and add the driver support for this SoC.
> >
> > Signed-off-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> > ---
> > Changes in v4:
> > - Dropped the GMXC and NXP2, as suggested by Kornad.
> > - Link to v3: https://patch.msgid.link/20260224-eliza-pmdomain-v3-0-6e13d3aa70a1@oss.qualcomm.com
> >
> > Changes in v3:
> > - Picked up Dmitry's R-b tag for the driver patch.
> > - Re-worded the commit messages with better explanations.
> > - Dropped the MMCX and MXC entries as they are not described
> >   in downstream and not used. Consensus reached off-list.
> > - Link to v2: https://patch.msgid.link/20260223-eliza-pmdomain-v2-0-23fb87eb70ef@oss.qualcomm.com
> >
> > Changes in v2:
> > - Changed the MMCX and MMCX_AO to the PDs with CX parent.
> > - Picked up Krzysztof's R-b tag for the bindings.
> > - Picked up Konrad's and Taniya's R-b tags for the driver patch.
> > - Link to v1: https://patch.msgid.link/20260216-eliza-pmdomain-v1-0-c51260a47d6d@oss.qualcomm.com
> >
> > ---
> > Abel Vesa (2):
> >       dt-bindings: power: qcom,rpmpd: document the Eliza RPMh Power Domains
> >       pmdomain: qcom: rpmhpd: Add Eliza RPMh Power Domains
> >
> >  .../devicetree/bindings/power/qcom,rpmpd.yaml        |  1 +
> >  drivers/pmdomain/qcom/rpmhpd.c                       | 20 ++++++++++++++++++++
> >  2 files changed, 21 insertions(+)
> > ---
> > base-commit: 6de23f81a5e08be8fbf5e8d7e9febc72a5b5f27f
> > change-id: 20260216-eliza-pmdomain-dd10911bd4e4
> >
> > Best regards,
> > --
> > Abel Vesa <abel.vesa@oss.qualcomm.com>
> >
> 
> Applied for next, thanks! Note, the DT patch is available on the
> immutable dt branch too.

Thanks!

> 
> BTW, in regards to the immutable dt branch, is that something that you
> guys are using or should we consider to drop it?

Bjorn ?
