Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588373A5454
	for <linux-pm@vger.kernel.org>; Tue,  7 Apr 2026 16:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775578731; cv=none; b=qfiZeh4wKx6BZQfGXYE9/em8/16UMhAB2u4tRfJ9zrslg9dhTdmQz7PrW7GJxdd5GM0yYojbaHOKv9btHj6gQy0oqHzFGGOzF59dVf5fDzMT4YjC5UKAvQqdt4B2oOBcwb5w/O8HYG8s4csXjl7bUx/+X5eoH2PjB5QeInrbjoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775578731; c=relaxed/simple;
	bh=RAtJyF66DhDwL+sw/f/kcnSJ32b5ywZ3vaEShno/lgE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8Q9Zs7+rZUZ87MtL87GZnggD4ZOS6UYDuQ++sr2x3q/dOk5oIV9J2sIYPdGyX9ekstuSHzF+oVgNOce3mniwYuMJw3lemuUynw+67Azm913WWtrvj8LPWsQFCTwq2jC+4K/6UfC6GkoxIQq4pInt+zDLyQdp79GQK4A4Cze7o4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YBbbzXQT; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QmNLSa5x; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YBbbzXQT";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QmNLSa5x"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 637FwBPV1796076
	for <linux-pm@vger.kernel.org>; Tue, 7 Apr 2026 16:18:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=6jK8XeAJDMVoLv4UiVwoG8oc
	0Pxfohm6+YSS7sOvVz4=; b=YBbbzXQT1/foTsk4PrQGIVEEtm+zaDQ6yLZafME2
	tf5h0EPNIjmEgweLUwkPJaCpu1hTcEi18kl28lk+GuJPGv2p9SWuyD2tpAc8eRGO
	mScubiMg0xUBrn4YyoNLaUMKDZM6ufhEapFsBxPexf7BCmUAJhuxWP2ad1UC/f0a
	hMlMiaZBRgMs7q6xOLE5H6ouUs0vqcWClcE7MJjTxO5S557cyTWfcoioeoGgulOe
	2T0DEjNqdbQIvcMlLbxv4KUPIiQTWThXDDNhFd0pD8GHTtoonOU3by4z9e/uZ52o
	1MFf9Y2/iobTzlofv839oYQQGOqJP41wqpPWoVtbbyPPXQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dd51d83pf-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 16:18:48 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id a92af1059eb24-12bf9974587so23585069c88.0
        for <linux-pm@vger.kernel.org>; Tue, 07 Apr 2026 09:18:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1775578728; x=1776183528; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6jK8XeAJDMVoLv4UiVwoG8oc0Pxfohm6+YSS7sOvVz4=;
        b=QmNLSa5xEfrm4PKRnUvxXKmRhZRcnte7rMUGD/UOK1lG1Ly2yYJNia0Da6dcegsnH2
         F6fRUlR6CsDjrgQTEJbStATJbtrum+do/Q97PN0j5xho0JKAQpek+skqx6mJPKIfQqIp
         CADN51PGcP3XjS+E1F30q6uGdyVygkgYnkWD73K8NJ1gHceD/uUf4i/i0ejENgEV4oZh
         KdqwXonDgYWpnrw5mh0fbinN0biznXdr89+1z5YY79q6LBiUQ0e7/YIXPOClWmb/IR18
         iNmfjhfG7Yj4sZYNs6LQ3D3or1Qy4k9jfyemYscalm9pmFxKuOkd/FFHl8wmPfRWAsQG
         Jj3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775578728; x=1776183528;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jK8XeAJDMVoLv4UiVwoG8oc0Pxfohm6+YSS7sOvVz4=;
        b=cWfhpE3ei/0bJVgPUzXUddgh2UTkFv+4CJNbUAsDWm2jNO6EPggxu/Trw0APmp9NQE
         0Oa6QlIxg45V87ATMOIhNHDeJWcLL0LIzPd00TdcSmz/io+CTxnVQbnnnORqc8b7Lxks
         JGGrcgGC2WJi+uqrfRFPAWwgasVOTxfEXEqP/STTkzhw6wsXCnOoXYK5Q3KVpXCggK8N
         TppD3UHh3KYMyiUH7Ai/f4kwi2LRmL64unrXU80Fy2JUhvpkcKCSpx/2Y19azPrtMScv
         Ji3WmE26fMGBoruW6f9USgx0PF1y5CxcMrR3/cvj0DObzY0bvBKj51ZfiX5IHnT06YKK
         zfMA==
X-Forwarded-Encrypted: i=1; AJvYcCVtdS5038DNegGJNFrMbnB6xrGVQ6adez2uopwfANOyKGijkk+Qw1lntnh5eLzjOu15U5eUYDz+zA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzfNS4CBkMqa6K6RYg21uywtdLk5Wok8bCgshtW2W9LnIdjYK7Y
	/wQ5P6DA1Y2H1/ECKLoD3HcWOyVrHaAgmP2cD7vh0DT8BCyYAm8AONJxBdhYcHQDvfJZVUDLgpP
	NrgG3Cxf6hGArEMDujRbwoG9s3sWsIuBGzydZuM0FAHcSxYfV6KUqNizbDiq+Ig==
X-Gm-Gg: AeBDiescFUJgecGbJPLw2bnzIv71x0wgFChF6sKK+jBVDiZ0sIRbCz2xwWHqF6zxONC
	ApJ4UMBEVO4GOjILybrsds2SZrlR+nCeJ33wX+s9n0S5hsBwuPQizf6Jd34VAtxZsa3/4Tz5Blp
	sWzzn4+EtkNyghYd9/41w/yQVgWb+/QzcyHe09zmkz9QUSfSSo1GEIXZX6ea1qcvEktiiENgUfO
	6j7rEVviApwREnePn+Q/C0GL/Jyxpg4QHFvOxSAm3+5UiqpiE6FNP7vjuhIL3v6ocn2s7fvW/8m
	4bYHpIwzc/7SzzLUqNc4nOkUmVC/FI5gborg03IXjAAmGcklhhTX5TG7/jUHwlTzRdEQDZmpkxU
	jVU1iB8il2G1J103lGCQpreK0xaEUMxA/DBGqiJyes7vwPCC9jjEvmO88NaAOOHgibaBbIIXU4/
	Q=
X-Received: by 2002:a05:7022:43a8:b0:12b:ee7b:51e9 with SMTP id a92af1059eb24-12bfb6eb3aamr9511965c88.4.1775578727882;
        Tue, 07 Apr 2026 09:18:47 -0700 (PDT)
X-Received: by 2002:a05:7022:43a8:b0:12b:ee7b:51e9 with SMTP id a92af1059eb24-12bfb6eb3aamr9511943c88.4.1775578727292;
        Tue, 07 Apr 2026 09:18:47 -0700 (PDT)
Received: from hu-mdtipton-lv.qualcomm.com (Global_NAT1.qualcomm.com. [129.46.96.20])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-12c14a371b1sm4339123c88.13.2026.04.07.09.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 09:18:46 -0700 (PDT)
Date: Tue, 7 Apr 2026 09:18:45 -0700
From: Mike Tipton <mike.tipton@oss.qualcomm.com>
To: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Subject: Re: [PATCH v2 2/2] interconnect: qcom: add Hawi interconnect
 provider driver
Message-ID: <adUuZYmI/avXdsPJ@hu-mdtipton-lv.qualcomm.com>
References: <20260406-icc-hawi-v2-0-6cfee87a1d25@oss.qualcomm.com>
 <20260406-icc-hawi-v2-2-6cfee87a1d25@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260406-icc-hawi-v2-2-6cfee87a1d25@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: 1iN_OWBEoVDhc7s_EijMZHfI9c8JJxb3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDE0NiBTYWx0ZWRfX3JEJNGGuT+zt
 o7rgTQ8Ps1DGBHypRUYuv2+q+hBS37p0ptxrSnVW+gCE/VJRF2VKEKxNHYCVFUuCeO1TwLca3eQ
 YQx8wvVRcNQ4ov2WNLY1ImaTsLwLFh9/NPsOL74LeeN8DZPUHbL8Du3Lhf64pIi2a/xwxfPoQjI
 ti8OL0vYAh9VTVz3GGWIB4XKBe/gp7CPDn22QBgYKzWhROpewEmpSLKDVUWXccukbpLa4LO0qah
 zlw2egWbO7Z+84gQp9SH1nJnX9/4ePZRiBfzwGmhv19uW4ZadVHjllmDaOVj+NIhS5+kqAuCYYQ
 rKTIXZzYVyslacJdvWo2fWQXJLvj4bcYadm+MsAqyrFOHYziKoAXCpS5zKzCS6I3AarZ0luv9I3
 TRh7jXCguDuKOty7tA6bbsvge8+uCceZ9mQWZfxd7ig7HH6Sg1cTSFB7O+JNj3Ooz2aq7fgcRal
 hskl5FwXyIdT1b1x7xQ==
X-Authority-Analysis: v=2.4 cv=AcaB2XXG c=1 sm=1 tr=0 ts=69d52e68 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=ouPCqIW2jiPt+lZRy3xVPw==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=X2bA-DTC1ecWuKQBpGMA:9 a=CjuIK1q_8ugA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-GUID: 1iN_OWBEoVDhc7s_EijMZHfI9c8JJxb3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_03,2026-04-07_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 priorityscore=1501 bulkscore=0 malwarescore=0
 phishscore=0 impostorscore=0 spamscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070146

On Mon, Apr 06, 2026 at 04:04:42PM -0700, Vivek Aknurwar wrote:
> Add driver for the Qualcomm interconnect buses found in Hawi
> based platforms. The topology consists of several NoCs that are
> controlled by a remote processor that collects the aggregated
> bandwidth for each master-slave pair.
> 
> Signed-off-by: Vivek Aknurwar <vivek.aknurwar@oss.qualcomm.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> ---

Reviewed-by: Mike Tipton <mike.tipton@oss.qualcomm.com>

Thanks,
Mike
