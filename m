Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F249E3ED3D8
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787561217; cv=none; b=CgEjaAuZ4KliJSDF8Iw+kx5BIRs66K8AHeHMqWomdrWSxVAiKeFJ4JvxrlVtcTdlPbl+9IZ9cfJxKE2Jm8+EiHxT9PLF6Ba1w0akziHO0zE+98wcecOye5Ss1eQDasOCx2YNdYuivvB2EiH8cUCRqZVzU4TcXevmPk+NcUCYs1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787561217; c=relaxed/simple;
	bh=sX+wuwD+X+HIlWFprK9YR6qFkyX+Zt/RSmNQEjo/qt0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F1tg8sVszk4KXKwCBqXKbN0MRhnOXGRRw41hcholvgJtB14ST56iTr3/6UOshDdXPTkKHD9kJA/MhsIKlEAFwUWTFWUV+lxzgpKnzs4obqmONcfkmqrM4cPar5NItpun1a+eOlK0aj01GkQiBKSsSzNgPJQyEVcDar30WM6tGDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=dPKL53zE; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=gvThDcyu; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="dPKL53zE";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gvThDcyu"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O7j2sm1184612
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:46:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	sX+wuwD+X+HIlWFprK9YR6qFkyX+Zt/RSmNQEjo/qt0=; b=dPKL53zEuu5ZF8CQ
	5CCiIp3559gmOEziRf4UOGRZbtRpvIpoeIruOPCIMXg/heU4g89dncrAvOwJNu5E
	cB4ShB110c/23eAtBa81qTjxoL74p228Evhx7jsaFjIqQUuWzon+WZZvrKRrPaWT
	IkwmT2m8eSpXGpCh+DFA7mC/CP857vd2RozHJtOJbrg5ggM5HYaBnUOj8pzSwpeL
	VoWCeaSS4IJjnV0pqCcB1PIZmfByLLIXellQWslJXu0FPz4+jibEmfVtGNDIH7Yt
	WSc/mwvGqhgfRG/7vtJNM7Nf5yJANtGF3FiZhRSTeLHznmAUAytchz9mACH3ZVqK
	9zc6qQ==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8huf07ve-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 08:46:50 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-97c4f47fa57so34339241.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 01:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787561210; x=1788166010; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sX+wuwD+X+HIlWFprK9YR6qFkyX+Zt/RSmNQEjo/qt0=;
        b=gvThDcyuZYewjKTFP0cM5qu0rEoz+pfAuBUuUJi3XhPGSOg0FNNn1VSPGZWzQD4sW9
         b5GDE0mImEPzeXi4gUXXrpw9QYN1LlSFcMP7JS3UfmxnjDhFOc40WZx0HdHrhUmzfbBA
         HxVQbhaU5UXENjzfatthC7trAG5QOJLOzfXIy4KLOF7STAq82/t/RAUbT5oAZdfnXJGY
         scA5Pr+L6vCjC0xwQZfXbB03EBh95GCjJMfLIHx4RmRAJrjdKkyOXuc9MJnBjZqngWgB
         WGrUCgP0h+janz2Wv/yp3V700E+pIWnDagE/mOUiKFtV83dUgiAnFxr260YiMiwRI2GW
         M/qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787561210; x=1788166010;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sX+wuwD+X+HIlWFprK9YR6qFkyX+Zt/RSmNQEjo/qt0=;
        b=sqrjurxCVm3hCMj6uOfCJSxyk+Ag4bZsroJUo65hvHS9TYPXcF71/yyQ5WIE2NHeGR
         JEXBL0VJefcsynQPb/lJtk3zP0H9YluJ/iw1uorlRrtMCfBRkbBNOfRgOJpaolLlDkKz
         Zw3b7B6pHBJu/DzD7DKgMzYpHBXlMfvEZ0bAJko3zgx4z73UJcScX7Tvp1F/C3N2q01a
         IB4bYLqxmWm4CMKr5onRZ8CoZ+7d+B0MJMbt5bp06ALqm3V1jJmx4XAeXMxPRN9x8Ial
         xdGS+DE77iQGLBiCEyxCzEZeE4Zu9aAuNV+a4YVAeqwyY1xY46Qm+sjpJFH6Ga3jwTuK
         Sphw==
X-Forwarded-Encrypted: i=1; AHgh+Rog9WiVecX8U8z1fIF25qkc+s5f5D3+D58mtvCJ3iBwnHBxA7xBsn1BiD0POK5c3bNMdJNer9zsJw==@vger.kernel.org
X-Gm-Message-State: AFuF++mbF0qvRgua+9MuJsOABOI8h5hWP4CrLE2vTRuADqWugYp17hye
	d/IIAjMZdt2y6Atl3WG1nWjHCfJockLOw63lJCaJxOURHK1UmElqDYdbK0JtNUwOJgJ3BG+Jakx
	OfKOAJNaBqLXLjMTAMBM03saYlX2e8CmfqhIcbgN9zo3I0RT1CoiBcRitSQs0cg==
X-Gm-Gg: AR+sD11Upi8OC6GPBFbiPbMzd/d2io+YEo4MYMUufkEX9iJysNdV1rf2sM4dChVmjbZ
	cswNARx2TUCsp6Bx0IzuZ23a9O361dUX3JL4/9JiiSwMck+nI1V0ik9c8jrRfUfxmv++RoXIpBR
	PTQ2LZ6T4osaJSo+X6bOWfv5wdnOWQZZ+fq8ZozQieZJ7VORLkic6LN5PZe+kkDaqbcuSw/gl2O
	dryXO/FhCciYFRipaotwScpfAvnBIUg1WTnVl7cdCnkAsK4LDiaV0zk6RT6A9+b261hjugdCSNl
	okwIBCzbFSsQQ7benotDe+Cp29O4htLu3OTntcPp9YCQvTM0DNu92bNpSanv95B4fgLJK/6LV2H
	L4EBZ4JWBAJJg46DBKIVaeZYr
X-Received: by 2002:a05:6102:d8e:b0:778:1bcd:ddc0 with SMTP id ada2fe7eead31-77a5f8ee1f7mr3580143137.0.1787561210051;
        Mon, 24 Aug 2026 01:46:50 -0700 (PDT)
X-Received: by 2002:a05:6102:d8e:b0:778:1bcd:ddc0 with SMTP id ada2fe7eead31-77a5f8ee1f7mr3580128137.0.1787561209638;
        Mon, 24 Aug 2026 01:46:49 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6a59e2da49bsm8665454a12.29.2026.08.24.01.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 01:46:48 -0700 (PDT)
Message-ID: <578542bf-36a3-4cc6-91e5-fc5881c60432@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 10:46:44 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/13] pmdomain: qcom: rpmhpd: Add RMPh power domains
 for SM7250
To: Sreeshankar K <sreeshankar0910@gmail.com>, robh@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, andersson@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, konradybcio@kernel.org, tglx@kernel.org,
        ulfh@kernel.org
Cc: bmasney@redhat.com, radu@rendec.net, abel.vesa@oss.qualcomm.com,
        lpieralisi@kernel.org, quic_tdas@quicinc.com, danila@mainlining.org,
        davidwronek@gmail.com, mani@kernel.org, robimarko@gmail.com,
        linux@gurudas.dev, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260821154030.2514-1-sreeshankar0910@gmail.com>
 <20260821154030.2514-9-sreeshankar0910@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260821154030.2514-9-sreeshankar0910@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3NyBTYWx0ZWRfXwzbwhQ3l4Sqk
 lB7VmsFJNu3le5DC31IC/9tKfpCUSxqadP+NmUPol9yk9LbfsBqkb5IUMq4sBtEMnf4qB2YJ6yf
 +OyBPCwq/syXlVxk7cLuRgPcAY6XtxY=
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a8c04fa cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=0Fz9-S7UgyL-nH97HSEA:9 a=QEXdDO2ut3YA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-ORIG-GUID: JJwCjpA7m4aKugfAKBDIf_9nfJXuSZH4
X-Proofpoint-GUID: JJwCjpA7m4aKugfAKBDIf_9nfJXuSZH4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3NyBTYWx0ZWRfX/dDd5UAIDKcS
 xYSiJLbEfAOTofKVQYxQ6W/R+RP46FJhtUwZ3JEENYnA34oYmaEOWVVECNSPVQPU0+9vZX4ygWA
 bLzy5ILet5goEdu40X96jq2WlZK+zJyjp37q3K4XHXRuvTo3BP/EXdXm+aGDH8x6jnAtW7CZyOe
 E0iX40k0KB2ZBTnRXoqYN+MZMwf1LzT+zzWqJvPFJE4bON23j5X7gF42iROjucc+ppxy4vljnaa
 svHoC+TFT7p/z6l1kNCKoZ/Sobb4zQfTGArq1Irx4LRdVkitH84iM2DwpeF4R9UmN13/AJOmztZ
 qkL+ZeEj+VW+22EL/+ANZuAx/CpGjgj0eIjX1TfyEPzbbPW3ioBZ5sgH5ICxVvbb2naW2H/zKEL
 GMCoOZxA5fWSuKwuJTcenvdb1J1L4yyC+BDMh/X/GVhgeEH/x/s96S0D/i0+oKDaUHKQ84+gaov
 /OKRYNAi1SdRXpvCl2w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240077

On 8/21/26 5:40 PM, Sreeshankar K wrote:
> Add RMPh power domains for SM7250 SoC.

nit: typo here and in the subject

Konrad
