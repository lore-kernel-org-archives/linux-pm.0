Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5770234DB4A
	for <linux-pm@vger.kernel.org>; Mon,  8 Jun 2026 05:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780895765; cv=none; b=ZKFp20x5UXJcEkBSFFxk05lbb0zLYyofwuFhrW32WC2cISm1TWd1J02VB6C9+thUSnE/rIYAmnwBqXZFVI9P7pp6KUiDx1roGKg2/c6/o0TKNk2UeNTiKCSB9ECIDLj5p2vOo/rnG6RCC0G7ElU8+QqOmWW9Cb/6sttD6Sfuxzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780895765; c=relaxed/simple;
	bh=/w00nBA8qrayGXsmTYiOFmmxgnCYNEMS22WHFw2LLw4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=krsAWj/xhoJ7X8oTl3PoEMNEdQO3Q7+LT+Db/0ItXGxwx8T0CMl6ojXurex/R0vxFJwmTXaP5gnG6zURg671Az66yIhkF5wXR2MPkET75mt4jm5Uw6SkxIwvkSQO7ZOMp+iLBmRfNWG8W7nAzoZbEMiKDdTepoN2srh263Cm1fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=AMo7IOXQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=keL4JS/J; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="AMo7IOXQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="keL4JS/J"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6580EVBN1572480
	for <linux-pm@vger.kernel.org>; Mon, 8 Jun 2026 05:16:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Vy7CK2A8o0j2tMymlbC3Gk+F
	6Ihxe9D6CqgtXPc5aKY=; b=AMo7IOXQHbDioi2eyFYHiLGgsryazsgw2lr0p7kq
	kMPQl42qaEWBBycY7XffTacNDhCPwpXAvu7cdFGy/nNzKT7CLWgbU6vJOEiY4Hgv
	AQkbyWIrskuPtsrubkbSN6qM82hLn6k82A7/IovHlDrN/0r/qXryXpaeFq+jLrUo
	6Fld45i+ANWEJJGz/jO9OBh/KWDq3BYhi+45z6tMy9UHjtmEyrZPSxcpqX+zB+a5
	cfO9+ezcVxuq1aH3OvWIsq8T/tT3WCYcaAvLK7RQJAGYG8CJujEJ27mPRE0TuXsE
	mHrUvh+kAQCoagGQF6WiB0yCwgafkhoV3Fv7m8Jn/kvZig==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com [209.85.222.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcu8wpcy-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 08 Jun 2026 05:16:03 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-963bc9a24f0so3967894241.3
        for <linux-pm@vger.kernel.org>; Sun, 07 Jun 2026 22:16:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780895762; x=1781500562; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Vy7CK2A8o0j2tMymlbC3Gk+F6Ihxe9D6CqgtXPc5aKY=;
        b=keL4JS/JNvKHP03DewPqHdOrDuQivnBJG0mQj10MhwG37XRihSta2UTsW8k7/7uDmS
         7+RIZjsNhTaeUKHPo8rtuA9P3lwj0gCfmz5XjEwduGzJ5Rxtk1PtkPPC1x12wIE+DjZe
         GAKEUodDfPkabdekOYhaB6XrnRs0zj1LwHQpVaeU6DfSNE+CvIXueneWJeXnmx5XMk/m
         5esoMBheXFaiLeJUCZ0/qTuqs7+qPxhbTjHnEz73AIeuxtnmv7V5wzQ22EpCH047BYTP
         xO57rlmiEkRX4Aw72cl+npg0ZfkNSs6N6QtKFKO+89UWEgkFKC2THKI1PGO6eeXDbLSB
         fwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780895762; x=1781500562;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vy7CK2A8o0j2tMymlbC3Gk+F6Ihxe9D6CqgtXPc5aKY=;
        b=Q/8GppEFYey97W9m8mj79VBLiNKwXyONGB0G+C/pSk5/k1PT+5O1QYPcyrRZwktLkL
         qOLZAI7jlN72dP853lSsT5TxkBg+2/xZ2sF6ZbvItWut0W/Iy7xsC+e4L73V974rjVX9
         uiGaT4D3Gjg0eBvPKubrYPKYsceEtdgfb6TLrdN29OL24tsiTV3ML+nJz8VBdmr01ygD
         eZXGBAezuTW7blZvVw1TnPT01vG/Rh3MOvf7IvnHi/bU55kt0cOGCBY9/joA7KAGxOTj
         IQ2zklF+8cmmcT5anGh2RBx3wrl/Tk6zOygB96DxVtJpb7aR4OteHtWE0eXoTxaVo0Go
         EHnA==
X-Gm-Message-State: AOJu0Ywt6SJIqooqc5ZOELWHAzyIO57kNjQLuNctpITK6/Pq26w+NR42
	Q487zQXetAox48aNUoJbZTsspaeoIBDtUvFet4x+p1rK8ZaDq20yENtQy5idfXhrHj4YJc+AxaV
	rVNIw0DDbrDP4xl5MFbk8g0i7exdy6MpJXdFJl24xmqDL0sw9OMUWQiUghLJwSw==
X-Gm-Gg: Acq92OErHext2Y9dpBwZ4KctEShatLtHELtZr2yaNjfVUO7xPDdzlf5iHJSWmYse0hI
	8e8cGSkEenU2njYQAlO63ZirjcFYATJrV7q9ibX9vZfYI0YCsF6/oBzEvfhrf0j6odqCiwU/klr
	q31bc6FSx4tgITSCOQYGjg4hf8nU3Q/bR+6xnvbMV861EH6CmBAUdWds83drHU91wl2P2vbggd0
	x3nLjw23Ml1X7wr/PaR3pjKuDR0lDoIbN9BpKs+4+QRypXWYWIZM8IVKeNxqO+h7zykab2SGaxQ
	qiTshjrz1HNeJNX/fii9P23CMK+eus0gls5UwxbuZ/VEl784nUjgA2xkYF1Bpp+PsquqsfHZHIM
	aVjZqYod9kYFVNJ+lsk5Tjxnyi/T8yHHgAukth3M0Lq6WLOBdf+OT9mSf/VqZWf6kqh5Nc1D9Mq
	VP4RElW2IH5PbILk9trnu8fbKOu/KamMBOga6byIHLRe+E6g==
X-Received: by 2002:a05:6102:1489:b0:6d9:5eaa:6d9c with SMTP id ada2fe7eead31-6fef0bb1d06mr6883171137.12.1780895762631;
        Sun, 07 Jun 2026 22:16:02 -0700 (PDT)
X-Received: by 2002:a05:6102:1489:b0:6d9:5eaa:6d9c with SMTP id ada2fe7eead31-6fef0bb1d06mr6883162137.12.1780895762206;
        Sun, 07 Jun 2026 22:16:02 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b97b0e5sm3533394e87.49.2026.06.07.22.16.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 22:16:00 -0700 (PDT)
Date: Mon, 8 Jun 2026 08:15:59 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-pm@vger.kernel.org, Georgi Djakov <djakov@kernel.org>,
        "open list:ARM/QUALCOMM MAILING LIST" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] interconnect: qcom: add COMPILE_TEST
Message-ID: <de6yvclessu7m6kjmnrfrky44vjtrhwsac25zerxiqvtsfhr6f@vw2geiyybhnz>
References: <20260608050542.6167-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260608050542.6167-1-rosenp@gmail.com>
X-Proofpoint-ORIG-GUID: nvitA3U884WolD7-SDO0B40tj6-5roOc
X-Authority-Analysis: v=2.4 cv=deGwG3Xe c=1 sm=1 tr=0 ts=6a265013 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22 a=pGLkceISAAAA:8
 a=EUspDBNiAAAA:8 a=QvphVWULri5qmBRDuI0A:9 a=CjuIK1q_8ugA:10
 a=o1xkdb1NAhiiM49bd1HK:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA4MDA0NSBTYWx0ZWRfXyMqs6+UpzqQm
 H3scbKNB+aYMjIuwCEtG6Es5GGVTBLuxLd5cpB6509E1cRDU8594ApmJGI5QZw6lKYOjCjekUAa
 viiaglLFzZNJZlKVMSojWg9edUcIT4GOM2KGdEuqfGYrh73RVpx6qcDWJX1MOvaPSd8uYgRTZ2F
 qoNrXg84N38uodDs8zenZw14b26O5zovQbhBXG2Lwv5zsh52PeNB6qEv8u6nbmYi8eu3uNINi+I
 ln0YQ9nxJL8XPjI5QS4o3r54QeTpmfgqMw2zjR1Af6oUnZjaNIclZbRJjJI2Us/5KwBCmZ1PJsX
 GQLPgXuppreDnHVmgLXXwQCJK1hB85ZEGdp3+XrDoMfdj4XUPuEwQ/OHWnNtaRXxmmc3uK+wbnF
 RXQTFbGGRai4WYfAvNKvLLnOXVRndvH4xK0pVNqmSXXQKeYQ8vfY/WlfTIJrJovplWpKY90bSqP
 VzcjLcI1b1DBfA/sPqQ==
X-Proofpoint-GUID: nvitA3U884WolD7-SDO0B40tj6-5roOc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-08_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501
 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606080045

On Sun, Jun 07, 2026 at 10:05:42PM -0700, Rosen Penev wrote:
> Allow non-ARM to build this.
> 
> Signed-off-by: Rosen Penev <rosenp@gmail.com>
> ---
>  drivers/interconnect/qcom/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
