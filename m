Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF58835C682
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 23:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784675589; cv=none; b=pEhHK0E0QfGoaek5XEl9mAaDxCBm9OYlnoxPTzOzuZWh1PMJ1nFTiFeZ59OWfq+KK29dknMg3IX1j2sL3CqyYxFbOOZWDOTIrreZ8asPXkEo6dh28lbwiS5l3vlVOu2HDabBf5oTLyd5+Zqbxk6XraR+5hUuUDG4amzVamzwssk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784675589; c=relaxed/simple;
	bh=KT1c1OAV9hEPRs7FDQcUUYsNQA8f+0N/BkDtmtYHSi4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=R2ES/gOy3fzw4HB39LcMiASQGKgtousoL3V23Fc+cfbz5rpRhE+fzQaiAIQFckPL6cyaGhLjcAVqVanH7EjMrOSzr0xER0t1GUT2z0cxk0MlzbyPxF4JXLRWCS+S5t41pw275/0QLkXGdE/bLG9Sj3R6lRpFgyGur5etRaj86zE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=B6MO45X9; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=BoWygCq+; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="B6MO45X9";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="BoWygCq+"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66LMZTX13311611
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 23:13:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	3bwtoUeYIX4CQ5hBjVs0pHHQlacY1zcuJn2ZoJQM/Vs=; b=B6MO45X9aDbulSWW
	7/q+ylGeihUTzwBF8CN2C4+63wxaPWBizhjoE5sSH48ezWpil4Camqt+WO9dGXJe
	5uU/urb9sEMPKOh9T4Cz9xMLegVKTb3Vv8FuxdOvZJDzSbLE2mtPQ9T9mfbdK5q6
	W9W8QQTaMqx+sjPTJ+9XbYcHkmhhXVuicC5tjo0TUTvUh7JRm88T79U7lg318+2i
	Hzw/7rruMrTvR+3a5FpcLLpf9yNx7/Lr8sp+hV2M/9CuNTZTLEyACItzCXncWSw7
	m6uTkikgitoMxlDc+tgvdCceUkuntVz9TX9aOF4D4QaPzg0a367qUGFwoclEeKuM
	XMq05Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fj6r3kbqu-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 23:13:03 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-52769fc3f2eso15298761cf.0
        for <linux-pm@vger.kernel.org>; Tue, 21 Jul 2026 16:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1784675583; x=1785280383; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=3bwtoUeYIX4CQ5hBjVs0pHHQlacY1zcuJn2ZoJQM/Vs=;
        b=BoWygCq+qu2doOODZaRFCC4kF9dGYp/xRGArkGKUtXtqESHsO4wAkCz+JLl8hG8GoS
         6grxViJNSGFrg2vcRBaiNqPS5OaAO/5op42QFQh9VyIgvwp/yl5JTAFyNBT150C7vPuZ
         H01xuaVMufdM/m49zKsiQeek1HWIKXpNW+/d0OR3AfpjDju8VQMMVEYKV3ERgsEaOQ5I
         xxFhM33Fuf5m3qfWE9p+FC8EIhP9IypKOUph4KKIyF+MS8ZHjEdR8RI3Ki/bWlPAuW1s
         TEbEMihW4yH4qhSfy9nYzjju8w5YGv001d0UZReJTe9HralNVESPkEFw1XM4AhG19XNZ
         cv4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784675583; x=1785280383;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=3bwtoUeYIX4CQ5hBjVs0pHHQlacY1zcuJn2ZoJQM/Vs=;
        b=ciJGLILRoOPcHaz+3X7ts920SnDyVEmbU9QK9JwlTFdQRFbCbWPZMeg9bUNT4Ftz0D
         aSW23RTAwDjPnoF4Pd1N/b9W+rEO+mi8n97WuzkGXV/fC+P2DbKHOeL2MbZthTJTuDVw
         i0E69RrUneOek6tqpf0IovyvMZqFbU+m0jKkFrkIi2CE8ghQu9WkgE+cjAwujHORmAGP
         dsNtqpYl5sJ8rpR5RyXqLWPOAw/FVxg2j3f3i4nAVHszrrj+8Yz52jnpFVPFFLoBukmU
         Bk/S2dCsjSWy88mOKPVK3e10WtdotQwK0EksgfCdKGI54bxT3ie77NJ6pLdWEuB87BOL
         dhIQ==
X-Forwarded-Encrypted: i=1; AHgh+RoNZADn28j20rxRkntjrfA9PvOn9l00qUSJNFKYz+zPqPTpb05vIMK4cJMP9urN2oEJVKFvivDuLg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwIqSXlvoFhZq2kvDJ/qh+GgQZzidbP8mKADvUXSyRJu5d+clSq
	plLnUINZs3T//80IhMiHShXY4pXicbB7PIXuLHyjRiuAhJIZfrCJKh8tbW2qmqC02oReFqbWmpF
	36y3eHAc6BzBDmdAB5F+qdyNtYtKx3T+33yq2OqpGZfqajWpUdddRRUebaNaFdA==
X-Gm-Gg: AfdE7cmVlnzUM7gz/lm3Z3Um1Z+AQBtIdNthDPNsy8VGWOlcmJ9UrBKxg6iED7yp20v
	hMDlu1/srogpMlIwpvvIjdQmLjgVdqg2/30Vh/vA1uiiSE9LiWaigxzmMdhA4rXg4oPGzMxOnVs
	z486clKCutPsVlii+mwq44iiiarkn2KqOJWIRYugC3ihcYnN5mOrd98quTV+NIqPk9373Xk1+GY
	008w/90JyXTwLoLx7kjR8UliyBHXJjxc11Wi0xFN+k5w3qZGQlM2ViQI/DQQ65GQYL9UJXH7dGH
	RGgYiweoNT1Brbk5h+5qKvj52mO9J4nkTWwmGJKVh0uGPUL5ckEO7jwOIV2d0D1aiOCNm63aBsn
	XjOzRiL9eHdZa6AZBMpQBAPjrYJXar+xBEE9LT5OTWWRrOGjqEqrv5UOriML1+2OzUszO+wUnlR
	XIS+5xKAy0ipEi5A==
X-Received: by 2002:a05:622a:4d90:b0:519:e91a:f4bb with SMTP id d75a77b69052e-5213c9dfbf3mr195128861cf.31.1784675582872;
        Tue, 21 Jul 2026 16:13:02 -0700 (PDT)
X-Received: by 2002:a05:622a:4d90:b0:519:e91a:f4bb with SMTP id d75a77b69052e-5213c9dfbf3mr195128411cf.31.1784675582389;
        Tue, 21 Jul 2026 16:13:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b2a9b8bfa3sm157071e87.12.2026.07.21.16.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jul 2026 16:13:00 -0700 (PDT)
Date: Wed, 22 Jul 2026 02:12:57 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
Subject: Re: [PATCH v5 8/9] arm64: dts: qcom: monaco: Enable CDSP cooling
Message-ID: <bp3rrxycikefsoxeve7gzrattjpbzlzxfiw7vacr26e4kf2z2s@gto4byj5sxcs>
References: <20260721-b4-qmi-tmd-v5-0-99620e07f505@oss.qualcomm.com>
 <20260721-b4-qmi-tmd-v5-8-99620e07f505@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260721-b4-qmi-tmd-v5-8-99620e07f505@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDIzOSBTYWx0ZWRfX1CeCyW2B6DYn
 G9DZYXCgmcf8R86ExI7M8n/UIirpkCs+Aw8E3MWI+Q4XjDpsMsaFxq1akDn3cIvUjXT7nffVc2l
 foSh48qFIbLNv1gnOfxLOvYEQvVmwYqcbBz2O/xyW7w3g1IXZlIJjYhXdn7jBhJX2XJEsbhQZ6B
 Z8zSFJk6hE2QPdBR85S4pmjYWrg+Y/DjNPlYT34Garn/sbbhcrGJqqnKSGDw9cz9CmQEvBZ/VSk
 1eJj+jG+cU14xn+c9sOEnH+/ictFgn2ctsEJNJ7qaEZ4GV1In0rnZXhjYcmYO+S6KCP0wDWX0Hq
 2PL5nGM+AhvOOuvh2TiPw7SLykBaXGTZcMtTeh8l+otF/p2/fEv8KZ4xkq/9zTbXpCmSMKcki7N
 S5KGkIBQvuK3dTe2Pq29hfeyxO9GuENv/ZsSb0lo1JVOfTS/khvlr4fiRYiRTucetQL1vSRQD9u
 fR0h48sTFDsRDbIJJHQ==
X-Proofpoint-ORIG-GUID: nbQyhL7KFh9gWK7-CHTbYzuSRycfeLmp
X-Proofpoint-GUID: nbQyhL7KFh9gWK7-CHTbYzuSRycfeLmp
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDIzOSBTYWx0ZWRfX+WUAqvNQNYm4
 3nJk62xnz40dyxdUZBQ4oNFC/7G+6kO5EwzUSyn5NYWBFb/n2KnSzzRgGwTtzUleghqZhoKFz4d
 6swK4hc98c2YAgeXg/bT1CCzaimjuLk=
X-Authority-Analysis: v=2.4 cv=SIRykuvH c=1 sm=1 tr=0 ts=6a5ffcff cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=EUspDBNiAAAA:8
 a=_nN_CDt7C_a4776dohAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-21_04,2026-07-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0 clxscore=1015
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210239

On Tue, Jul 21, 2026 at 11:59:05AM +0530, Gaurav Kohli wrote:
> Unlike the CPU, the CDSP does not throttle its speed automatically
> when it reaches high temperatures in monaco.
> 
> Set up CDSP cooling for both instances by throttling the cdsp, when
> it reaches 115°C.
> 
> Add polling-delay-passive so the governor periodically evaluates
> the zone during passive cooling and steps up cooling levels when
> temperature stabilizes below the next trip.
> 
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/monaco.dtsi | 99 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 99 insertions(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
