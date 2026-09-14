Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA3413F54C4
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 07:46:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789372017; cv=none; b=M8dgrBIn9FREVPfC6Fe3UtdgwoENbVglXDz6C4c0Y/l7w7MXrg5Ro2mwx8LyvZHqV+eSUmt58ocVod6AYL6FQtpFPPfjuPKd6xHZtNz82EZcr1DpREzEAhU6g0nYH0PZiDOiTOZMW/RwhltBsEPS68s6HguFtfZGN34g7qAOo/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789372017; c=relaxed/simple;
	bh=fpyZ+wO5t6i+lqmqsTg8eqnqZWMjQOVGVNPTv1ziKP4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FYwx0M8lxRM+qld5k3KSkkec32XkqoKH8IriFbPc5FEzcTNK9jpFEq/3tRx6irGHXYeUP1t6f0Oncv8YUnJIS578J0+K9xh2W9N7maxG0C/TtCa285mJ5F1fp6ksI0pEGUiYWj5mQgp4yKfGsyxgpOZE4dlXa43nAaFJPN+459w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KKl83eIz; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Rz2d8OVp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KKl83eIz";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Rz2d8OVp"
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68E5jY1W237713
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 07:46:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=nwYpgflsInUUYK4VL8amNhk+
	D/quGcQ98duZ4xjrjTk=; b=KKl83eIzRltCkPZFiyYmI7YU1hfSgBdKpYEdtjza
	VtPwAm9lnBH74olln+D5xlWhg1toP7sqIO9RZDPRX7mcK3n8ddtqlFbIpTOXn/OL
	nNtQq8lNLZ0F3RYu9T7yZzofTvjJryR9bnWr7ktGEhsI1+6uhmev5yH1n6Er3ubL
	1YupiKTHf9SF0cQgiL8PLGyDGq5xerqj6EbjPy91EAxCzUtbSiM1UFDlT/j9qrmv
	cggbMAQOmFOkSJgaUNB1TF4p3APn0/KbBa6Ijq8yz8Gh2JtyRK/X1CI9F8/uxSji
	t+T3eqGF5mE06eo5oBnvW1swEydqI7WqXnHzNCTBbUtDAA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gmy9dnm8g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 07:46:54 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-93a05d645acso390688685a.2
        for <linux-pm@vger.kernel.org>; Mon, 14 Sep 2026 00:46:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789372014; x=1789976814; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=nwYpgflsInUUYK4VL8amNhk+D/quGcQ98duZ4xjrjTk=;
        b=Rz2d8OVpIU6QWgsOB9LEh1MfvUgFDoS5TPXnHt7qcbDAD6OQzebFgyLr5c11zaDUaB
         fla9OmeedxDnFYGyISxQnC9c61o2OMwg3j2DSDPt4Wb28NPvQXejYSNvaXKyzL+hHFhF
         7PS0qAOCziB7owHuzvzR/7LUaDQmm+k/ldI26jJJsfCHegbsyYkvfaIhBDTUbWbJaTSI
         3pxFkJMd1s3EItUnOjUj131IK5wbkWT5X6aPTpsg3ZnZG59NR+5YM3RyhR77ktS7KEQ3
         bPvMkBfwC0wYDNLvzWGOyo2owGLbsIgY7Z4PEekMh0g5wZnpToHkX3co7gjRqP2cx2Hx
         1iXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789372014; x=1789976814;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=nwYpgflsInUUYK4VL8amNhk+D/quGcQ98duZ4xjrjTk=;
        b=HXdFUBYUw9cXs7Hz1TafyQY/y129cRX2Cjs4Woj/LY5y14S9rw2kSFQghgDNPkTjTK
         j2FQ/rEVFeCygu316xxt9nhSJnVQC/nBaV2LcljpM2KW5hwjB5d4K+fxfpQQ4yXfPWYz
         92THRDZZUA6r5JUtR6G+Q+WkzyIrAD3JfNHK5+QxF3+QE7AIZstz8in46suom5RbLhXP
         n9xFZc2yU/sa0hueikeIEprfV0bZcVo8FitNQaslV/M1loLhFmv5sxAEW6udYumiSNS5
         DIfML6oKg7OpKEkQcoQF0zuD1Vch44tApL3ndUJpnOQlBJpWnqf54hlnDAZhWxropmMW
         JrAg==
X-Forwarded-Encrypted: i=1; AKwUvBzIbXgXOgrA0dH/hNFoiLKldO+i7RH6GmbkbyY8q5HTNg7dDR6BaJOB9fxZxI4XNFXclzo0Qxex0Q==@vger.kernel.org
X-Gm-Message-State: AFuF++n1KIBZU8i7vG2GweI2bvjbh1Hvz3hcu/zU/umP4rEi50zKBegr
	SgyNZI52J+aVAbl52E2Jk/nDzoPhe5g2vFxeMP34IR7yxGAFmuB/SzIMIyUawA6AXcaYjQZpZ3G
	j4gkdYCRdIIyzx6EwcT82STO6mbFosxcvNI7Bm0w3feuLvfCINjqcW+9wYK99dg==
X-Gm-Gg: AYBFou3Si8bbpIRUeFYkB7B/RCnwnowHTqRLQp9OvGMvdWl3jq33Ed6/rM4XyuZ6rZM
	9NEk95h52zcIF838x2Z2qdeRugsUVTEG9ROxloj+eZZrqsxOf6s/rIC7lyR63UIQeKqoH3hp1gg
	Qy9fJ4PoaS0q7tGUVlBu2yKbA6rQXqoO9WWp0DudoSoVzt7oaFUwCq8fdQr1mmXlTIgV3WXHYPr
	sJPlSerFb8Hupb+MLFs5FgueD3VKyRieX+4rpq8xxAsxIkT2FVBbWtGz7cf20XHzTkOXcobpvbQ
	/6SheakXm0Oo91mD6cXJ5hAADl++jSo+nwzzRSQcarWlkJ7c7vnZdOdaIC5mK4qTa+P9inAp95a
	kCfgmNFF8GhUhQg==
X-Received: by 2002:a05:620a:170b:b0:939:d38:3ab8 with SMTP id af79cd13be357-93a297e8fadmr185031385a.12.1789372008639;
        Mon, 14 Sep 2026 00:46:48 -0700 (PDT)
X-Received: by 2002:a05:620a:170b:b0:939:d38:3ab8 with SMTP id af79cd13be357-93a297e8fadmr185028285a.12.1789372008058;
        Mon, 14 Sep 2026 00:46:48 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49d26be3e0asm429923155e9.1.2026.09.14.00.46.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 00:46:47 -0700 (PDT)
Date: Mon, 14 Sep 2026 10:46:45 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v4 2/2] interconnect: qcom: Add missing depends to Hawi,
 Maili, Nord and Shikra
Message-ID: <4kwnvr6azz2hvnel4ti5epqd7tyj6lzxgbkqobltdthdpmxkym@k6cymd6tah2u>
References: <20260914-interconnect-qcom-clean-arm64-v4-0-5b2c0e6a929a@oss.qualcomm.com>
 <20260914-interconnect-qcom-clean-arm64-v4-2-5b2c0e6a929a@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260914-interconnect-qcom-clean-arm64-v4-2-5b2c0e6a929a@oss.qualcomm.com>
X-Proofpoint-GUID: XGL1AzjrxMbpj7tlyg2LFYp2PfVamnO-
X-Proofpoint-ORIG-GUID: XGL1AzjrxMbpj7tlyg2LFYp2PfVamnO-
X-Authority-Analysis: v=2.4 cv=NelzRGD4 c=1 sm=1 tr=0 ts=6aa7a66e cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=bOu3b-dmFffoK3qT8M0A:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDEwOSBTYWx0ZWRfX4Zs6yrPouNZA
 MWdqc3ZVkO0nSZjbhu5CENbfw1vMXD7iHOaq9Wrdowxynbcu8wi9M8ii3PsmduCiJAkSOqS/P2C
 IZJA231c/+goy+uRiQFMq2BSIEYwrO0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDEwOSBTYWx0ZWRfXwA4sh2LZQ5Qn
 hZGayTAmnobepBAY1QB98QecRYi7hux0a9lswRQWLeJ4C+VU/0VeovorE381D73nSjSQB6a4OEi
 vIVqJYCKf4iGvy//GueKlHDRdnGNfDaLa634NVYUTq8Hzf/tEBxejywG2SDzNQHVi5BRappSGtv
 2EHuM1R8hmW2tcPslIjrxEaTOaTf4O0d6FKbRsutNzp0hK1OlgD31wH2CHqQNNDGgPQGuzA3KGL
 np+BozG9Eilqovan6NksHEmLpoKCRzfvzDGD83oYIMQp6GSSM8h2wt17QlH6cpljoFfuxpRmMC/
 KURKIdglZSuPKTyht29zfj+WiggLi9QoUOLjMzc0Zzxrg/yVTRolRuZvHmjVXzebX3QxhcRgp2r
 xiTN5yjfnnzVN/cOfJfKieccFOTKJdBItjNj0/7QY8GfmkqblyT1xI2O5vAVbHoxrsEexkM16oA
 UUIGsXd134ybWuqZ/hQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_02,2026-09-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501 clxscore=1015
 spamscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609140109

On 26-09-14 08:44:05, Krzysztof Kozlowski wrote:
> Hawi, Maili, Nord and Shikra were added in parallel or after
> commit 5b696f065843 ("interconnect: qcom: Restrict drivers per
> ARM/ARM64"), thus they missed the update restricting them per
> architecture (with the same rationale).
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
