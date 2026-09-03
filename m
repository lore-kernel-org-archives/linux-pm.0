Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3328476CD8
	for <linux-pm@vger.kernel.org>; Thu,  3 Sep 2026 10:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788430967; cv=none; b=axvExrDa7NVLn+q2DvPA7XeqG2ic1Wwg0xIoYDisNo5gF7Ny3rTajhBkIpHNGeCDQPzzts85ZaftR4MTV0JAs7pfAQGULJ91x7Q73c/3vh/4kYMtv/vNlnNi9lUXtaHJTzRJbCsDSI828Hmitp7tLwDm04wGalbppDapgD4ayLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788430967; c=relaxed/simple;
	bh=IMVVshXwxDDSJzE0l8MvT/fRHMRPsXvntd5GyUh3aFM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhxtBNdk+77n70+5CWlTfLr5gar1YqCpNlPgCKbIzwhUUwyrE4EJuVTPtnaKhIa82+lbPw7eRtfoRw9qChGFMkhzijJyQxHvFzdkCQCnMCgNJofUOyPlVHUaxVWkah0UiPFp0ZhOa5HIaWi66p7axYeMPonirOa3Uoz2dMfzTBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=E/t0/AIQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=HmkO9j9h; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="E/t0/AIQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="HmkO9j9h"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 683AHDlC3204096
	for <linux-pm@vger.kernel.org>; Thu, 3 Sep 2026 10:22:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=MWzDrNxzthWPdsVZldsnWvMx
	9IcczP+HYo1LJtEAQps=; b=E/t0/AIQJNXxavIvF4DSXyZj0XFMxzjyKFoBboju
	8R6N1Darux0BmyjgQfyvsnYAbW88jDZ7/pMCxRBwQq73SRc0dKaeRXwoRvx4oU69
	xYnX4LRp+pFaJqQJ/hXZWq7B7/KqK4Haa6o6ClZv4ZzJbrgzFYLuzG86M4ivfKzz
	XR466xDjYKLFSGmrfvDG21XyL4wP9hQxCmouI8W7tvI6qYo6XovD8cD9inVfgmqg
	Nio5fA/LHms+iuYTVX9x1HgmlOcKicjFFZhW8nA70nFniMJ5/CFchnI3w7vE1sUW
	3To+/4/ZTDrHbDajvLFfE0A2Tc1w10AR+/bJy76HS7MFVA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com [209.85.222.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf5d10fea-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 10:22:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-933023a5980so483762685a.3
        for <linux-pm@vger.kernel.org>; Thu, 03 Sep 2026 03:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788430964; x=1789035764; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MWzDrNxzthWPdsVZldsnWvMx9IcczP+HYo1LJtEAQps=;
        b=HmkO9j9hRNhxxm4eGlMXcEOtDIQ4sSr7bGemOOOcjjF6TwO/2nrzFyB3oL2j380RWh
         h7/XHZ/tPG8ZFXQasnDH+Gd9o2Y1w366QImNcWcUgRwIeaOld/gVdk5+Mwpl6O9JrkqB
         axF4fWUm3s0XzqyjJ5RCqF1Cicwk6kTmHUjc8CiILqNLEkmDV23Ur5wu6ectCQjL2v3A
         PTCYb3aQ75hancJs9Dih+9UCyTUHrSIT1v5lx++UWxVl/QSRn/J70se0rvElcB6+As9r
         reSPKIRcfaudDRyZkpxeZTWdikHAYizBy4nnM0xBw8Ks4tJh/ipjcvtzAJSG1OPAPshj
         mflA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788430964; x=1789035764;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MWzDrNxzthWPdsVZldsnWvMx9IcczP+HYo1LJtEAQps=;
        b=Ez3pmhNQWLPQmjxDm8JngEbztNy6Hzhfw6BInSO7tl6T6mRYWaNYOeSzmmV8lzWhWf
         KNCuD9fCHVT1kWfa/KhqJ5VZTGjpU1bQezGbHj6aQTsl1QTTayNKiSRVnsRwISvSfWvy
         5rKERY4++x7aXUWCKLr1AlePF2QkCgKMnv/zInWHXnB9jyCPNwdE8udnydbU3jhOSkKW
         +Jffn64UxLBKJEFwHBUGzSn9usEej0Phs9RlKtKPvCu/HqB1ua+KVp83IatD2AwnRtvb
         uo2tXPDx+O71NaKPnG3DKZ+VqHxoTPBaFvRsxaCcEvBNDGhR0zF6ehbURJVOsPPIH1Rb
         KGYg==
X-Forwarded-Encrypted: i=1; AKwUvBx8YXVlTdR/Lm0iEE5mZlVspNHiLEEDnBtVrfR95d+zRMPbD88VoWePvuoOb4L7N/yiGpDSmjKFvA==@vger.kernel.org
X-Gm-Message-State: AFuF++n4Psq4/85cKVTbo0jWjETaLwNEGVeQfJQfrByCclonW0IU/8XT
	pqQDBZRnEXQvu8R7WNTmeKYDMTWUc43msbxrkQDHx3sMylpuMc8/VHHxmqZtjCFJLFzPsSZ1VjI
	FYTwvFWOWGZqF84zAqBfFgNMiMxwZx1fwKPyyMqEvZvKRUB6v1syoVbmZ5uakfg==
X-Gm-Gg: AYBFou2y25+6rd1jajFV2HiB3y1zz+CvRfqfPHpQ9+oL/cYhmKbDKKV5HKpZ32RnZ0p
	cWb4VI3xbjIYpwpMPZ6Eb+T+KDPGsDRD+OnmKLCCOelyNF0MuH1JR/db7lEF1N5EDVTXmbYxJyv
	OSBUG/rIBqC/1H6uEJndRFP6x8NHD08FZ99x9MASvo8gFeiENkRJvgM27N9wUcNz+BpQIoZyDEb
	+BkHmLYXqaNsId//8i+D2CJQMynvYWzbQE7RUcocWd00EFeIjEAO3QuMT7usP37Oj+N2aZDMhI3
	K7FMrtzRxZxcLevteZb0OQDHQ62LE1IjU3cZeBJ6BgyL1FJjl5ucaxPKKZAmHpbQryTrQ/W5Fh0
	UdZVhdp6NSPgthw==
X-Received: by 2002:a05:620a:6010:b0:939:6132:62cc with SMTP id af79cd13be357-93961326388mr1435826985a.27.1788430963429;
        Thu, 03 Sep 2026 03:22:43 -0700 (PDT)
X-Received: by 2002:a05:620a:6010:b0:939:6132:62cc with SMTP id af79cd13be357-93961326388mr1435820785a.27.1788430962820;
        Thu, 03 Sep 2026 03:22:42 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49cee5e589bsm55667075e9.13.2026.09.03.03.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 03:22:40 -0700 (PDT)
Date: Thu, 3 Sep 2026 13:22:37 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, Brian Masney <bmasney@redhat.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>,
        Taniya Das <taniya.das@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH v5 07/15] interconnect: qcom: Add Kuno interconnect
 provider driver
Message-ID: <xkyj7x2chonmrovnwaosd7sci2txi7bsbpvv522uzxdonkke7y@5kpqjal3i6nm>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
 <20260827-kuno-soc-support-v5-7-6d47636a8f09@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260827-kuno-soc-support-v5-7-6d47636a8f09@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDA4OSBTYWx0ZWRfXxak4JegBKS06
 X9Zm3NUh9brY06zppI3vEx3rKI+m/Z9FFU25lgfh8ZKrxWx5ADePN/E9XVslnia6xUM/KXnE37+
 bO0/HAyAMx08V5B3MDA1NQyy/Pmiii3+eA/BdqSpuwkSiPqYeiUKkm9aywZJH6inyXnHE4QcHNM
 ovHfdtwpsHVIdpl7FUqViCG4azKYdfTBxjkzBF0AMY7C9GxH6ye/tifskz2ZcdrrHVg8spUjb6/
 lmiFlaFXF95OcpU8LJR0ouHfQ71wK7Nbe00K1B3+Gv6/T0/KIKVc12qZLxY7WfoRSBnUh8MLgvO
 9yp3kz0Q0am2nw5RqHTWXwg2BdPKewCHItax1mah7sfxDfRPQKIFEDo56XoqcjfGZ0/MyIZBvea
 J7f70WTxDKy+qq42PZ+7DgM0L7CR1pUn7jqa620UwvEDCbVlTYqLMggpc/oVk+gTgg/PIuCWt+V
 dGDYVM8aHUGwwJbQppw==
X-Proofpoint-ORIG-GUID: xXIdC1CcYQ45j-sQ0c8qWyLG63UNpPdR
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDA4OSBTYWx0ZWRfX56ot1LOzpwPL
 XtZolc9ldPil5bqT3my1MuvuRxaWh+SJCvFxLEJdEyfMUwipPk9PGQxMbDlsfKu1aWHyKmifbni
 YJEtAbintPjP+8X/fgjyoX2dRqUuXSk=
X-Proofpoint-GUID: xXIdC1CcYQ45j-sQ0c8qWyLG63UNpPdR
X-Authority-Analysis: v=2.4 cv=J4GaKgnS c=1 sm=1 tr=0 ts=6a994a74 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=q7XEBjOi5DRkXzmV0jSBjQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=pe0felBmJweB1gBNqhwA:9 a=CjuIK1q_8ugA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_03,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 bulkscore=0 suspectscore=0 phishscore=0 clxscore=1015
 spamscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030089

On 26-08-27 23:21:10, Hardeep Sharma wrote:
> Add the interconnect provider driver for the Qualcomm Kuno SoC to
> enable bus bandwidth voting on the platform. This includes the
> aggre-noc and cnoc-main NoC instances with their associated BCM
> nodes.
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>

Looks OK now, so:

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
