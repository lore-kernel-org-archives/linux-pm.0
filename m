Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDE513793AC
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789025388; cv=none; b=SUxEBZRt+ahfpP8yu8PNB8waIcOAOosc2h71ym0GPMMh85U38qnNe044fxyoPxVmS0cb9Sr6qiA4dxOpVof2UGNPuVbBw04c/dJT+Y4UrhJmw+NntGk/UjsgYgdPUEhoa9fFMN39Rum9jGKth+U2PbkJBcomgPdOfd3wmvSeKew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789025388; c=relaxed/simple;
	bh=MVyliNQ17fPY/yNqehZqBB/HewQdBtDDGcKoK+pcHZY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OusJOgo9a3y+6eMqMnZVCnOuAz7Guf5H7KQBCkABHtND6MTH/rCvBNsJgv7XXR1qvd3aGcwGH6FNRDBpF5kJRoEsYBP0a8cXCjIA9fejVUp2Op4j22wldd+h62V4phJMcbSH5LLRQjUUcZsLMuyMkqtftAUbkQBIzYfpoYJvZ88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l8eKzICL; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=ZRvMRjE8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l8eKzICL";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="ZRvMRjE8"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68A5GreH3520293
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:29:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=L6/u/dIaghjJjICKdREvgg0V
	54dkEaFF3T83sruoD7w=; b=l8eKzICLsmop4Ag3liyNTdS5IwHxadMK6ZLTzjUE
	AXGH2h8dE9MzI7cKsY8PPPfNwEV/fEVSb/4B1r0q/hXU4j/mTLJvYtQ7j1N8vvuZ
	YbmtQttr1+GdjkTY4VDYgU+eAJvMZsULlXcuUC31VIvrWC2MZcHO/cv5M3R6NTsp
	Opw8wspMSC90tYj8F4Tyhk6IHkbo9KIKCyVqf6eqMCKhO/yME64WZtDYlIcs4H7G
	CeLFoT86Th6VqJgEYPVBqfn9CgiHJV8SoLzeOVqHUlp7D5WXJXftEmX8cIGabxgP
	jC3VctcTtGBGzsMKMxnMfoi2WGkm27edO5Zl7pmdr+HcZw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyfjqeu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 07:29:44 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93903622880so141218285a.0
        for <linux-pm@vger.kernel.org>; Thu, 10 Sep 2026 00:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789025384; x=1789630184; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=L6/u/dIaghjJjICKdREvgg0V54dkEaFF3T83sruoD7w=;
        b=ZRvMRjE8/6KV8ffu2S8B3rP6IDzfrYqjPpeQYy6kNVO81rWC3gJ9X0xBsqfEhgZTd3
         tgAHtLYeVS+sxhuXsxl69SFR+OX1yhiFOma0uT+bLAgsKAZ6hdcFJa5+KSMSBHT5uDen
         Xen4HK3F2O5BK20R3VpESOnG65dP3o1aahB0i2qmfV9qhRWZwKjIKuK/I4HKpvQeYBCo
         478vUWm35IoD/Cp1dqHuw5vVJKauLlsut4T+uHSiypYTehWG3Dq4TieSOWqUsizVf8o0
         kmuQhO1vJp83jY9ixYm+33b0Ll3rEt/tsFFB0iH/bKO/8/iypkjZFmFziawkCiSSFT/m
         LabA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789025384; x=1789630184;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=L6/u/dIaghjJjICKdREvgg0V54dkEaFF3T83sruoD7w=;
        b=UrqQlSRyO9k6Jjz1RdTYX3rOzcTx7JG0hnc6LHKV4niw3mLY0DC9V5Qv/2FrYAlQqU
         3PWNjse0Kcohp2dENVpyLFp8MmHHWX/LPpVqpuF3Udz/JXJSweSPuKOK9W+jrqpAjFg1
         ofz0shReqdodkdBNGEZF+HNoTtfFvWta59C+2MXQaxBVBsyFPk1WURgnAsb4i+xNWS6M
         iT5EbhXJ4luF7gz5TpBWyTVKBIt0qyIimMrSaPO3Ybo93ZdWc2zgP4xWSOTdoGNCW3ra
         BD6ielV04aO4wQnSUuCzPBKuE7e5Yp8OJEsb4IWfE/knt6lysuburPh2z3W+WZCyUGqP
         C5KA==
X-Forwarded-Encrypted: i=1; AKwUvByUL44kDFyCCr+YDBWDIllfriDP7pzAXBkdkS9qTEYgIQQkgXPd0ns+uB21/xecMP0ixcB3X5lopg==@vger.kernel.org
X-Gm-Message-State: AFuF++nK/GvC4kesI8zgl7kSWH2FtoXiLIjsmXU9KcgCmrl4dtTqUaFG
	VoCF4/wwHDCFwzyInjf0smPuS7KYY2qv6n2ky3aEv5sOL+XOsByzIE14/9U8A//rWxyIYNbNMGZ
	R5Pd/xNXrtxlFmRjGRqWfBYWISteAIbCRx6Wt4w3F8Dh9USyY3+cGeVnSvOqNog==
X-Gm-Gg: AYBFou2r3Gmc1yBPJYDG3tJkP4bNXrdc7ZTZggrUoQ5cczULEN8OAvNu6vQOlqw3sev
	UWVpOJhgyffvvxUUQzsdTxQxdrSx4MJwODP7vd0V9MVMHFb3tgjI8n6YP1FwQMi24af8/M2GKBO
	sz25J9UwpwPUFK1bt/Z0eTbo++vnkmSXlml2oV+SY85B7T72QNa4t7/Jd1DxwIg6LMSrmAS9jDm
	LUKLgcPE4Ax27JFy+6W4nXqubmYXO7qEUHVdHx5whVNybu5CnW2FTqMLIkKxdAEhcT2JO/hmP7f
	BxzzppuYfOKeCMYsp+a8VotJMvC+cNyx2tSjTb87OFgqlLElMnRRMC8/0Zn8ssrfhXOvsCD7nFB
	qFE+QXxtn62vU
X-Received: by 2002:a05:620a:4623:b0:937:17f9:da2 with SMTP id af79cd13be357-939d7e3fca5mr418218885a.6.1789025384110;
        Thu, 10 Sep 2026 00:29:44 -0700 (PDT)
X-Received: by 2002:a05:620a:4623:b0:937:17f9:da2 with SMTP id af79cd13be357-939d7e3fca5mr418216285a.6.1789025383602;
        Thu, 10 Sep 2026 00:29:43 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.7.210])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d20fce7a7sm248806275e9.4.2026.09.10.00.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Sep 2026 00:29:42 -0700 (PDT)
Date: Thu, 10 Sep 2026 10:29:40 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 1/6] interconnect: qcom: Move bcm_div() to common code
Message-ID: <yk355uolomdjhwamb2gco2misljktbc7vooxv7onxdayjm7aty@aw2latbupfza>
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
 <20260909-topic-icc_rpm_smd_qol-v1-1-6dc5b5e97626@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-topic-icc_rpm_smd_qol-v1-1-6dc5b5e97626@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTEwMDA4MCBTYWx0ZWRfX1PW05JHsZqIE
 CztzSq+03dApeLbdbyIB+HAxrKtdE8iRkES5uakZWMC4Jya2xT2lVfk/9msDo6KOrk0YrXcIT2w
 5d9zX3a9gEFgtTM2SWWiTf9GtyD6JIs=
X-Proofpoint-ORIG-GUID: SCneLInfmhqRwOErid-UsZa-P1OAmkR1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTEwMDA4MCBTYWx0ZWRfX3xmCS/3cUalg
 4pe/FQZD3heBRNiKQpz+3zpTbhr7BbJfTSJf4OYaHNuL27AK0wYCy6u+fqGH8AbCqG5+lhP10WX
 vcrW3RTs53v0Q96Xkdu5tAShOUVRrCzga2TMDJ9g9BPhOY8aD1iR+UbtQEtyuP4p/X1Ly1j5N/5
 zSxYfCpcl7qyrjToLoFkQNJsHKkEjmMltk2qGgVZAAcs1XV9okzL8XIv0ow3Tw9Xne9AALLibV8
 K5ryNcyEeUz3VsL1jO+UMAL6Qgg7kLOV+2G4KJGTxDV/x1+efVt/ZEEAqCW1l6rf4HNSvTeHCNa
 8xZKKco4ZhSd360YhwsxypaYEv1lPA8AQuJYb2Sn5ZDy/BIB4duz9SS+pgyg0EPQWPM+8AX5aIP
 KRfFKdriC4FB/QeJaDNqPWOlXvGXUFEV6XHAfPxl/DYBG+Vx7VshzyHzfhE+qqw4ILS6aUbwtCs
 9Vd+rI9Y8BSvos2h2TQ==
X-Authority-Analysis: v=2.4 cv=H5pOUOYi c=1 sm=1 tr=0 ts=6aa25c68 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=dePp4Gl7O00gmbwhyVsZwA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=wiZ877acDUlgFteYXlMA:9 a=CjuIK1q_8ugA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: SCneLInfmhqRwOErid-UsZa-P1OAmkR1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-10_02,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609100080

On 26-09-09 18:41:54, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> This helper is useful for both SMD_RPM and RPMH code, extract it.
> 
> Assisted-by: LLM
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
