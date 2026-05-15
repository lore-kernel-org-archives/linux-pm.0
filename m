Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24CB53A3E8B
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778840190; cv=none; b=Lzk2S7qGOdDu3iWGKavwDq/5LLzzQRUGhCYDUiULGV2dZn3pRGefzUcEjvmmgp9fYQB4USQkIOna+sMfgEbfwYXKy2VGM2daxtfqveZAsH0YmI5uqj1nhQqYWmIDgnxrxaqeu6l997ECqCgnPLlTN06krYC38jAkuHDCqnEuVfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778840190; c=relaxed/simple;
	bh=5RNLJN8AJzw6fjVfWgwivKLRztqBGW/eZA9V93wHR3k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i4PBpwjCUHZvLQDUjI7LDmLXogE0C41bUa0HwdJbjS8v/o081aSAA92Ac1AVhrSfWXRsrBVsDkgWv6c114qiVIrvrHCm/AFRYmfDuM/QCVtzkZb0taexksGtwpCpQlnM6kt9NXXkuR4sruggPKgSNWA/jDZmUS7WGl3C5qqLDpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cthiAe9H; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=J6uanPE7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cthiAe9H";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="J6uanPE7"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64F9HdEt1714936
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0TiXhLV4sh1qI46Qb5IcN4GJDJ3oGJtOcbBibb9xI8c=; b=cthiAe9Hc3MuezbM
	bMIx762YbUKazFo0bRNHi6I6NeSASHsLqced0RpNxre2eqACHlTFUGUplrXDX4AT
	yA2UR5fUTJV+Lty+/nuKqEumJQ0iHyiERlDlqWu3/ktDAZfLDrwyTF5ZJMJR6VDt
	na89+kK94py/ncnUsREcYp1FT2ufe7Pj2j9qpVbVyf8S2OteWRY3SExGFYk0sTyp
	hLi9iYdaeXGyK90oN1e+o3BHKAUyJ1SQlTuOMXBVUGxCF962qbladMJEyLA1spLW
	0XlJPHQ0gZzsxJ5OrcImgTfEIGwphVsciGNbIMVY7/1SLJLm7kYxHWEiwXr4x0+x
	B0S6vA==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5tyxsk3v-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 10:16:28 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-94de248f59eso389505241.2
        for <linux-pm@vger.kernel.org>; Fri, 15 May 2026 03:16:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778840187; x=1779444987; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0TiXhLV4sh1qI46Qb5IcN4GJDJ3oGJtOcbBibb9xI8c=;
        b=J6uanPE7kyPzE7FSAPSDm0ySZ4rTIV8K7iS1sIwO8PMy/lYMebId2OAjlPfLxIkgBB
         U9uZnkSJlMU3A0k2/tsHaILXGX3mhCXVFyDwTIgD/LeA+MHsY7KZwgJiTSsSG5sPnKFC
         7EP2NUmhcGeALbdGGDrOFnMWXjkyGaeMDwFrgZB3c5IfcmJy5uwTapqABjZYzSHhpx4k
         dl4R/PJa5hcbpFnIsE129eidnlUa+ZbBcsgnKw0heRUHlnmEFO2uhY4biazcUTdsCgpw
         hY/D6mqTlEkwglpOfdRJcYtw7JOGWbGf99grfjZmGdIcH5ZvlfpBYnnjSZCyAK4WeF+e
         Qvrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778840187; x=1779444987;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0TiXhLV4sh1qI46Qb5IcN4GJDJ3oGJtOcbBibb9xI8c=;
        b=CQUssLm+ppxgpESAGEexSYDnr+UlN3q6qYcGATnjRQR9ovQPUMFAqvJsi6uw2djE7Y
         Sv2bsfmeRRp5xCz8TQMOiAz5J70bQh4OtdORVNyXf/XBDOYEZFFv4KEPhv9+4x2lHkl6
         66Dx/GGbjSJ28Rycg5hVe7eUHryQUkJaZ1NVaE24JupUYK/u/P3jI2Wb2ST4wnzbQTTY
         qGa2qeECkD5eXykj0Ytx/giwzSv4cnpktOjgtd2L9NQydbr9jgndjR2zrNuCZ0Rjldeb
         Z6UClTx6OVWLQs5korvOASvX/0OP9Qx7fr1TjlAs44G1ORDsDY9PT0+xsPL5HHrZvAzf
         o+6g==
X-Forwarded-Encrypted: i=1; AFNElJ8mdhd4ivkLrtw4CDotQjszhvUzw9GkUiDlHxb/pnmL78iwV//HWPzF//DhDzCfhe/SgIxGKTmJUA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyN3GA4mIGb6MESEiHAExh6f+wh20aFHyOailH7c1e7RCtPXnOZ
	KPclzwwXfN/4Gy6ywilsA64wk5/dugtsPQeKNNpRxdz6nKurPYSMxqzltFoWLBvorSZl7Sxmdwj
	daarZs0YQUd6hM45TSqI7RBtYl4Awg8w4tvjEB5cxZ+BBFm7DXlLEsGOxfUccyw==
X-Gm-Gg: Acq92OGYvKen68JVWxd6yu85wB6BtgKZe9oBP3uCrB6T2C+09EPyiFfk8HpBA3Rha6J
	/QZQU2jeJhQbAoM1IiO0LNPO47DdA3+8peDzYv+0HhY/RRJVELvoTGzjlkgmRnGnOZum0Yt6Swa
	COIOwiI7IaDszfXX58H62xyaSZLe6SBzP1apgQzGHMQuOQDOEhk76Q2Ke21tQgTKM+RpzwMmJep
	hEWjFTMLJW65Od1q5FvPrrut8dd5DOkMwrPC6sQwChxlewA1GMESVQfYEWpTJRizR+DeVDIzs/N
	86EGrNZRrlU/Zmi8hphafXAGWceh3XGtqwiDxXQ+Tm8tDrT6/p+4lw0tKvqlWiELP9A7xeQuKvI
	e+Y4t/cRtiZmk5OMO0zB6wYhDyzX0Fa5LETPN/lnddDMaHgFtnLGoSEc5SD9dV+3cbOZQTbEIMp
	DxdIwohV8/4TM/vg==
X-Received: by 2002:a67:ef86:0:b0:602:b87a:3524 with SMTP id ada2fe7eead31-63a3ffa8809mr406953137.8.1778840187280;
        Fri, 15 May 2026 03:16:27 -0700 (PDT)
X-Received: by 2002:a67:ef86:0:b0:602:b87a:3524 with SMTP id ada2fe7eead31-63a3ffa8809mr406951137.8.1778840186863;
        Fri, 15 May 2026 03:16:26 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-bd4f4ebfd40sm203360666b.61.2026.05.15.03.16.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2026 03:16:26 -0700 (PDT)
Message-ID: <39b2311b-b3e3-42a7-a97c-fa190c9dabfb@oss.qualcomm.com>
Date: Fri, 15 May 2026 12:16:23 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sc8280xp: Add reg and clocks for
 QoS configuration
To: Xilin Wu <sophon@radxa.com>, Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Cc: linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20260507-sc8280xp-qos-v1-0-15135858cd98@radxa.com>
 <20260507-sc8280xp-qos-v1-3-15135858cd98@radxa.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260507-sc8280xp-qos-v1-3-15135858cd98@radxa.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=dMWWXuZb c=1 sm=1 tr=0 ts=6a06f27c cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=ksxQWNrZAAAA:8 a=EUspDBNiAAAA:8 a=7vROA1eCcShV3ZceFmgA:9 a=QEXdDO2ut3YA:10
 a=1WsBpfsz9X-RYQiigVTh:22 a=l7WU34MJF0Z5EO9KEJC3:22
X-Proofpoint-ORIG-GUID: yq-WT2aTKnKG17WN1KV6ayqg0DMaPvE9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDEwMyBTYWx0ZWRfX3D38FOdFbhk9
 4j7b5KbIxQZgVPhprmIMWl+br8LY2m72Fgj+wuDOOh1bv1/UKZCXrl+rkwk+KnBzY3Nu7c07W1F
 tD7wEuVppBdEofeOxNNRgEQky3iqdQGTFEMJm+oAceGihuVRAaWlN81fBw4MJtA+DxrjbcQc8tt
 +qR68Qwd2jG4x+9YM2PZ7AABSBOp+VGJVytrBqd+RV0G9GZruJIjg2PdiSOw7rXcYm/rELIoeZ1
 7I5dlLzrhdH3npWhxdND1acnjPx6V1A87MeKtQg4Aej9GAY71Pm0gJfeJ9Mm0yf226XNwWy6HLB
 w6rrocmH1pgIK/rNRKIjvvW6aGo9xPW3vF3bmxP1kcS+N7YPVoc8VNT+2FfiujQuBcFg2mGrp2Q
 0YIpUPec2LgSfSTyaVd+IKMm8xwU4QdeFBzgrUuAWdBEC/sguumeoxqbdWFhFJ8SsM9Cfq+D9DV
 Q0lOkq6BdQsXjlb5aMA==
X-Proofpoint-GUID: yq-WT2aTKnKG17WN1KV6ayqg0DMaPvE9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_02,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 phishscore=0
 suspectscore=0 malwarescore=0 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150103

On 5/7/26 4:25 PM, Xilin Wu wrote:
> Add register ranges for the SC8280XP interconnect providers so the driver
> can program the NoC QoS registers.
> 
> Move the real NoC providers under soc@0, keep clk_virt and mc_virt as
> virtual top-level providers, and add the clocks required for QoS
> programming on aggre1_noc and aggre2_noc.
> 
> Signed-off-by: Xilin Wu <sophon@radxa.com>
> ---

This looks good to me

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

+Odelu please check if the clocks are correct

Konrad
