Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80C913F1662
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 09:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787562692; cv=none; b=d3tG28D/A+HxvWwI1mmD5ehxFQ95hSVl7oyNDInr/bFKfzFl0fxMMwOhmoQMdEr+YvQnT2NFML9HIAICluQ0q4CdlCTwUK9TL+6Wx/9BxRrY/66alMRXnLu919+KvXvdA+1mobxe3xJY/M5wSH9BbLvA5aYIGZKFzwrzSvZToVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787562692; c=relaxed/simple;
	bh=ASDYRbcO3fDIINFD1FxD/tfq02EHISmLiz2DBh3Tn8g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dFqP6Re3IIS5ImEa2rUHLF14HhMy4QO4v1PIa7be/d9FYUZCuh7gdqdTvyv0q+IIeO7pf8wwjcM85m13xbBES499KAXHthX3pDt56VI0a20zBebN3PnZde2m//Er6SUD/7iWVlSjsdaijWxzOV4jMyrDEYWGcQJ7vdVEQ+S4Kys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Q1V906Ey; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZTcxeZtx; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Q1V906Ey";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZTcxeZtx"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O99wxk1509291
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 09:11:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4CSP+u1YiO6b9Hgg5N9ovP9d+PWS5gNJELTe6vB7hag=; b=Q1V906Ey/iZ7xOK/
	IZtK1Rpr1FoRFyFAZgv8NoH+9eplv0h3V+D1J3TVkVQd7+jVXR4LH6O5TsIvleWC
	q/xL5ITJRtv9SwplxpLqZCXxMJUsnF47liTRN7KF4akVwOz/IaHJXgbCVuK2UPPn
	vKFQUxPx7rF6y5G6Gjp/QlbhMZb7JpRo9HVm+K/rXvwqdehBsQoGWYkUlz8DuUfH
	MXG03s3ddleY/ELjyTDR0zpTsAlGlRxveXGhYVBVI7W7K/hAgH/FKge6F4Le+T+U
	AWlaGiJtB43lN1IfkZjRVlG5NCoANhOSC2MQ4fmhYEXf4DBSvoIpfxcwCgIy2Erl
	jysEcw==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g74xhe5xp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 09:11:29 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51c1e777a15so7667531cf.2
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 02:11:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787562689; x=1788167489; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4CSP+u1YiO6b9Hgg5N9ovP9d+PWS5gNJELTe6vB7hag=;
        b=ZTcxeZtxYIcx2LWDgwPRTL9zZeFSy2o1AU4/x7abFaOeE81zPH0eHXzKirX5He6rf6
         FK8emuM47v1AhvuV0Qp4gK/kjvHDVOxzgDyNtPruGH3/VFqdK6bklYLdECl5JU1vTNR2
         nsMp5tUweMsJAFMFdR1Vlyuq5mWo8rsWVaejLILZPOpemtKX9EKN1+xtM2uxLxZvTy6z
         7EtaFsJsRaiFZf4h3pgKVst/ijTlUA/QTH4R/1O3XhYwjCUSbJRf+3Z2qnWb9F4POva5
         /oumkUuKHFF5HkKKyG5Aq4B8D7HZmCceT4LWYWTBq8Gi6D16kSFqRdqAFwx7SqLfFpsQ
         /2ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787562689; x=1788167489;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4CSP+u1YiO6b9Hgg5N9ovP9d+PWS5gNJELTe6vB7hag=;
        b=RfgQxZI5qhIhUYULD8wrprPBrulcww6OWmvSJDM6eTVQrYejpIZAfpZ2sm3V7M+4Tp
         bJz7AS29d9biSdVwFq+2rT+7fAGHo6CXf2qZZcrkC2d16VsRIh6gKIJloS6Mo9zFP6d3
         54p7zjrr4hzZeAEaremoYhA9LQgynSG1sklwZ7qtjMz66VITWxKEZeBjyl2J8/uulqYQ
         dy+osTuah6enwTL1FVk2VnpZnJj/cgjOtT7akeYy/9MTXvVcMeEnPRwW+Ic9xVkIvpco
         25RMGDtPHvIcZW/EckrCrScSfKiqYLuZVel0PAdjY1RYxu6xqGdFknj4ZNS40EOuzOT/
         LrCw==
X-Forwarded-Encrypted: i=1; AHgh+RosFiibkHt81V9yDdBvS7+jb6yoCbj/XONuOo7YhGKAQ0rpUgVbdXLz1GiyYhPPdWg2Yl4a63xfSA==@vger.kernel.org
X-Gm-Message-State: AFuF++mftkdQZfMsfjVojJfGYzsoGTmN3xhSPX4IkYKzCbesxMEyKWph
	v3bQE5xTkuaYbgMcTeDXA8lGILtyzyWXbLvbnTdvHG61ng3crSknkL4w4q1WOHKjYAe3/6gXcqL
	h3jPshI87cP2hsYcMuQimMyvyIcOPPXcVE6g+wYZjDljsxq1SSUfMDPD+aD0XeA==
X-Gm-Gg: AR+sD11ZYgMyK2lSR6Bw1xTM9HBysqhxmscCfYjrrU+rDHuHnkn374uKFvn/LHDTgE6
	PMzQW+GVJiMmz3aG9ei5wbMUjML+nqTXMDXR5dGG6Zk4QZUiykx8UD5LbiQDNC5IPSrYetCCorm
	CNNU4Ir2UET10Du60XK7rMJrS7b0luNJssYlab12AxSvKMoe0U2IaN9DVypwr+3zoHVpVyya24I
	Gb1yR50kUXnyofdkZXR1mi6SPZmumf1IN6ynEQ99GqJYK0dEnvvu3ettGed6BWFScXE00Q4/iUT
	2pKfiyeX1Qrxp/CNqT579nVfyZpy9nPXI31yfJu7HLo9HFl0patOQ9qpRw0X33CtbR3XK+h6c6E
	I+V7my7dwUYav/8IMp/m6riUG
X-Received: by 2002:a05:622a:1489:b0:517:5d21:9899 with SMTP id d75a77b69052e-52df5c7b11bmr183849681cf.5.1787562688529;
        Mon, 24 Aug 2026 02:11:28 -0700 (PDT)
X-Received: by 2002:a05:622a:1489:b0:517:5d21:9899 with SMTP id d75a77b69052e-52df5c7b11bmr183849151cf.5.1787562688123;
        Mon, 24 Aug 2026 02:11:28 -0700 (PDT)
Received: from [192.168.120.193] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c24967459aesm1117153366b.48.2026.08.24.02.11.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 02:11:27 -0700 (PDT)
Message-ID: <c8710669-0952-4c4f-a04b-50a2e83e0e9e@oss.qualcomm.com>
Date: Mon, 24 Aug 2026 11:11:25 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/13] pmdomain: qcom: rpmhpd: Add RMPh power domains
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
References: <20260819152545.3934-1-sreeshankar0910@gmail.com>
 <20260819152545.3934-9-sreeshankar0910@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260819152545.3934-9-sreeshankar0910@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: -DZpv8wynimwiHN3CImjkneVQ3IZljEn
X-Authority-Analysis: v=2.4 cv=GdQnWwXL c=1 sm=1 tr=0 ts=6a8c0ac1 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=T3cQ91Bvcxg1os4lQNMA:9 a=QEXdDO2ut3YA:10
 a=Z0LeWUw4VpMA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA3OSBTYWx0ZWRfX/5Zo1DG3Oxy4
 USYx24C9drvM3MM7qBptEzzHor9RtYdHdL/i802Us/QWJaDyQLCMNDjLGh/2x4XAJi39KDU0SuQ
 A/LP2LlUJW+RUyrEtBnHVC6IVjPhuMdPG/FvS+pHx4LCOnqrg9NWf4LzKkT6L0RFFY6jK5Ue1Xp
 NH6WfT2ZAqev2tN2r78D9NkVbwtbVpXyK+y2GDHDU2cXZoLmo0TdUFSFS6vrXkJV7avo8vx1L/v
 e5BaUWtd07o/71OXs9gDafSWYgQ/zSpXOWbnq0dqonuGLwq8M+LPGbSJfpj+8ibJEn/MfKHtMQG
 5V9BgtRofOHvoiEw0lnovDrq8o+I/XLaPXxiHvb4HqxBkFbKnMkGuXgKa3y1hKfSNT7nN3Y8A2N
 CHDkO0/1rvzA65v7dS+JPb6fcxk8C+ihuy0Sv2claO+xPy95eS6bubF8CVJ0oMhSaRdvtKtccaW
 6w2gG6GgB/Fp+nLtUKQ==
X-Proofpoint-GUID: -DZpv8wynimwiHN3CImjkneVQ3IZljEn
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA3OSBTYWx0ZWRfX7WodSwiqsPYP
 mES4OVVYINCyZj+ciT1ZnKsbJP7XMhl6KDDInI1M99AIgTVD5eXDWfYKKA1dvKppOsdxjfGKjVu
 eDWQeIEdnxMwREnhyKOdGcEOZt0vvcY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608240079

On 8/19/26 5:25 PM, Sreeshankar K wrote:
> Add RMPh power domains for SM7250 SoC.
> 
> Signed-off-by: Sreeshankar K <sreeshankar0910@gmail.com>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad
