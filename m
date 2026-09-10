Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5092F3C19
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025466; cv=none; b=MflueGyzk9IPMirMdVedh7ipqb9A+MFBsinqMkXhPDkugJ7okFWv9rbWMK30WdLMAoRUK61RRsVqH5bcL/Y4EJyzWqvgvuDA4pzzsKXcadZ4GPP57XpPkE68W6VSBQ4atLAZmXwc1KuDn+9fbrLFoSfUleMbhUTfFRIWT1CqdHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025466; c=relaxed/simple;
	bh=AyVcerJHylSNAM2SKa21XKFVG9gJYJzCjHvH/GGyVzQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bcV214tm8pxXRAa7NEkuRdATWAvZ1241bggBDiFc59WbYgU4aWJFPylXN1jxdhYG542iEeB5+0ed5n8gLUNwo7uR37FbtnQM2kjxmWoGzpN+KjIiiNRgmSn5Nt0BIdvn/so1fdn4vxbndeEK7CYiKCVYfa4QZY4MA2WpOuAhXW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KnZWzuz4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PbRhZMgl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KnZWzuz4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PbRhZMgl"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5GvW3319279
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:31:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=1zYEZTvqNgq2Wlrbj8LO7oYe
	IOOP1BRgRUxnk+w7h7A=; b=KnZWzuz4INn0Z5ha0Dn1qoEOhlmjLOGSGoFy0mk7
	fAFy1PasPV4rldzbJ8wtupC3fLb/1dK5o9v7q1U/OG60YMzkI0jqyAaw5A/dK13b
	qGPwpo4poKJvj/i4sn14KGuChASFiNRphh+kxpmS+KfMX0drTrnwMk6hx4To5Raq
	CgR6P59fuoR9yLkVxq3W4jDPm2s5Yfm7Wzwejvx2RFDsccwLy1+mY3GiVdNjaCUu
	Ev+Z7mCeB6T4jA+n9wcViKwoTi/By+B+THv9clK3QCYASPF3qYDkiyefxlseGytl
	tv6EJ2vZvvPGwN+oGIreFrnrwkV1cKEaASsbt6H+WmEJ4g==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyg2n4h-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:31:00 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-93771aa0379so1354396385a.1
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 00:31:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789025460; x=1789630260; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=1zYEZTvqNgq2Wlrbj8LO7oYeIOOP1BRgRUxnk+w7h7A=;
        b=PbRhZMglKa/L1drANVYin28G/prfF45E62L2GCz+2CAv5KCiYtYknDFNXDCHYPNBsp
         oAypZ9HfkbqNNKGLMA+ECYZ2BkWNVtl75TqUtkXqjIp1m2Ss7JAvMKirVTZ7O+WpMM9Q
         2GyoohOoJoWVhHbz9mg/fB9Pd1RnxNK8BDFZRTN4KgahjQGNEmbpzk71CVg41GxXUB+T
         MmJ3+eDqiqXMtVeRoIGW4F4Lp5hE0AyjxduQhL0LiJJuveU/lpFK+xKecqvA2l0P8iS5
         Rk6REejulLue4njSgBbqS9dV/Kg0sF2uY/Fttv3m+stPejiWpt1EVzkj9zVqz5UnFoJR
         FGCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789025460; x=1789630260;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=1zYEZTvqNgq2Wlrbj8LO7oYeIOOP1BRgRUxnk+w7h7A=;
        b=keTFQHlE77N/arEmB5uVadby9PkM5YXI/qF1YgIV4oiRB/lsuGo7RH3wSGg7w0idUv
         evypJTa8WB+Kff5nr88SO7LnO/OYP4ZFu7G/3yC0TirGeX7aB5S0QlSNTVvv2ijlhgDi
         nBScz7UnYsrx/KV5ykwT0fRl6oUPKO48dAjArhI7vhn2uVv6g4qB3Gj0bAaTIy1Dav8c
         cQ0AUm9meAculSLwDFToUWl+ua+nCgN5lF9aQswVx4E1X8ETAttwJhQ7VsFiPcee83Da
         oxSU1XM73nBwriZ5nnJay4SNvAJdtceNiJoAZge0PLqg87imMx3HoCa9Jamh1ZhsO22J
         5XDA==
X-Forwarded-Encrypted: i=1; AKwUvBwKM7B91oa255KlrJUd+xLZsWYtw41zvYu61DpbUEH9N7UDjwk47ZPhbs6xEws8Q322OwYQ3i4NuA==@vger.kernel.org
X-Gm-Message-State: AFuF++nJl+tGR1Nf5q48bKUaf05hMGjfHm3jkCX3MyZoKiCh1PV4cykK
	nwOxarZIewjU6BqYiEpEcmlZ25BEX/v5IEUhZ0ia7SolnL2Zu8xhGDj2PY9znQnTzyNiEtd9aRQ
	GsLlYxL0tE1KyXjc7GNcdNjV3woqUmTJxj0DPFUbiqCsBOSNTk9BPe2nWJUT93Q==
X-Gm-Gg: AYBFou3aRjZquYvhjLe28jmyJe4cxlRZYoPmCmdtQmgqSmOSb/bxcnW/UfHTYH3DZW6
	zNdO0GTp3WvGYXQbemSbWAvgSz00HFp1QDld2FJS+feC+TTrDh4BbkE8HngYKFYMqYAdpSscPwb
	30SxVv+LzpjJsVnjolQY8o058uYDyGaPcz6AYES235mgVF3lssbYgfzOr5C437WjGLnfTLrGCAv
	uvhaJuIjuTI3OK3Qk7rgIKT/2TW+UHqOCWvEi+iW43OGThzfgEPxyyvQlU1vTLyLgpvbqhDo0Qc
	8AV8XrBZfyRV5AT/clUOe8tCz6h/rmiNEQb/DjDMVDzKaWIRoS8msBli53GosqjhhPlR3xIIVHN
	gA3DfNprXSOru
X-Received: by 2002:a05:620a:454c:b0:937:27fb:96f3 with SMTP id af79cd13be357-939d4972f56mr731156485a.17.1789025455349;
        Thu, 10 Sep 2026 00:30:55 -0700 (PDT)
X-Received: by 2002:a05:620a:454c:b0:937:27fb:96f3 with SMTP id af79cd13be357-939d4972f56mr731150485a.17.1789025454831;
        Thu, 10 Sep 2026 00:30:54 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.7.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48588392b3esm55293034f8f.12.2026.09.10.00.30.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:30:53 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:30:52 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 3/6] interconnect: qcom: icc-rpm: Handle
 icc_link_create() failures
Message-ID: <squplyvzsl743rhov266cdvtc2wkahxfnem35gcfus4pnn6d53@r6ofvrmh473j>
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
 <20260909-topic-icc_rpm_smd_qol-v1-3-6dc5b5e97626@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-topic-icc_rpm_smd_qol-v1-3-6dc5b5e97626@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=YZYodARf c=1 sm=1 tr=0 ts=6aa25cb4 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=dePp4Gl7O00gmbwhyVsZwA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=sWVvvRLjqkiOkWxATgUA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4MCBTYWx0ZWRfX+9k7w1SUF28E
 4Yu13RbADdWoVJj1akY0z1R1Xw4yATD53i8aa3ySS/mSM2QL9JuPejBbu7iqHbQXjHnCwggFrmy
 GA+3ggcQpCzZkM3z15uDtYjirMzF0uo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4MCBTYWx0ZWRfXwbIEOkpKyhmW
 n/OhXB5DugfvGNeXtASS4u76aOecHN1/jXznyPzXAOmre5gWNNSKK3b5bApWSWFclDbPHJ6qDgp
 vRlX3bVdKFxUnjJv/a2L4UeheaGlKUiF0W9kTXihvDwKPUsiHee5VNHjtu9DvcupZcGHfKUxLRr
 NQlr7mu/I9d9V44a0IIsBD5yMkysrOuTtpsQTN2OVdOQC1c4GZL25wGTb14WmD0z6HMrQ+3XDy7
 2kbhBfY0lbiYHSYRKumHzCoCp1ptY3qCPpgkP9FB/E1mHba3lgZVmB0TLo6rfir6CZ+ShJSpXGf
 6iK4/OIa9SKm5OqWE1CEPJ0G4ZomZJpI9CDsOjF5Z3Tx37Wac6kHEvLcP0wXv8bgih2gI8hW0ib
 BlIKMOkiuKI2jvtjz0MKjWrqZFZeD/fbOYh5SWZQ91xtnhF4qz2TCSsAp1wN+l+OJWGISM/FOZK
 n5C+43u18QefIlCkiOg==
X-Proofpoint-GUID: MDtjK3wfiuOxhQYOMfRXlsdOBvFsZllF
X-Proofpoint-ORIG-GUID: MDtjK3wfiuOxhQYOMfRXlsdOBvFsZllF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 adultscore=0
 bulkscore=0 phishscore=0 spamscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100080

On 26-09-09 18:41:56, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> icc_link_create() can return errors. Don't ignore them.
> 
> Assisted-by: LLM
> Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provider driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
