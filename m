Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B50AD38F649
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 08:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782115560; cv=none; b=bnKMNW769++QfLgZPYLUis6y1zhD2Nqm276qtGUMXDF279/XO6d7VQh+UZFCP4wT+X5zqJavslUErAYFsJTjMbaRfC2iuZw6T0VFFaC1PaHPv5LB2i3TG8FFjSTN+TzY4fopaxIMvpAwpLnQ/jUrTqrmFTI/cbI3/r1eB5Y0KTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782115560; c=relaxed/simple;
	bh=fBC2FjtHPQiNi6KEdw4yhTb//mXaSxK/CHifyBukroY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ncrSxCQaPoqBpMdTKVFldQOhg0NbE3qBXzP/F313EgTLidrHdWy10JNN213+H2iSroCm4hlXrWZhBhxSuzXn9QF0f3RQLj5CwAeLKgsQYWKZcfYC85yJ9Mmwdzwmm/ksfRnrKlVkcinXYE/4qJy6zwfiDj0XOuk45dAFtQs9LIw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Th+q/5K4; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=iwOqUQpz; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Th+q/5K4";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="iwOqUQpz"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65M59ADY3786554
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 08:05:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	5zCvq7HJL8DT6hLG7M3sYgy5vi4M3CE5hIX4Z+OeHjc=; b=Th+q/5K4nfq59SUT
	/Ak84svzDL6X1nGasei5kS8mySc1YAPA7W9tRVWIrMjOUDstfwwPcdX5djlbp+6S
	Z9Zn9gqc3nINUy/xAumS0aUQP0k7qk0nJ5RvdOUs24eoCSAr/u+JfcxIdMU5vJ9L
	nffJg3Xcb8NQDLhvLoF2SCzYoSW57DpKEL/cBlJ/3Mfa+NdXadRfoo6tPEzyYobj
	oPyfwaylvPoPjfN6OBK7put1puoWNqk9Gem0e8nNNX9M8fY3jrIY+GbCzV56jl7M
	ZJJn2ZZmzNhtClOAmY5Pp0NUKkXJf2k1Yk+23Af8kM+0TWuN9XGbtMheqk5hRIli
	JmrAtg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ewkmed9vx-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 08:05:56 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92045e86763so722763385a.1
        for <linux-pm@vger.kernel.org>; Mon, 22 Jun 2026 01:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782115556; x=1782720356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5zCvq7HJL8DT6hLG7M3sYgy5vi4M3CE5hIX4Z+OeHjc=;
        b=iwOqUQpzMpri+c7DfrA2AEXCHxH7Kij/zhwcBK4UE2cUwl2JuzAbG1EHxToiAJzgyr
         ccmVKChwnwAa15dc6CjrBX8RTheAwYZ97oJFysna/16HquMvE1+78ksRON3ptW7E3v1x
         QYIAFSqDKzaQydMYPMXml6ZNxBWZ7Gy/8Zs7N0b952C7da4fMiRNNim4IXnxstb52CEs
         DOc8lBZdFgV33CHnKbY8WCYRGD2cqRKcWjV0a9DGa/N4LhxljBprY4NHLRIe9CBH30iF
         ypvi9bVIobdS3R6dag4r3Xpg720TPocFKYY5+vK581e8ffGABkLQZfvG720KR1oMqVSh
         zJ2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782115556; x=1782720356;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=5zCvq7HJL8DT6hLG7M3sYgy5vi4M3CE5hIX4Z+OeHjc=;
        b=UOZil02/O9VLTxcVeemnxgMiOZEDG2XklCatT9AxSl6vNqTAVbhB2LDSrhuOZKzMXG
         QJc1cOb5/2c2nLtbErmq9pLnMsKHu2YvfE62IJFA3ndDkim6bV/Gx0gBoxawA3YxmPie
         wDzzizaLDAWT/orQyRFPKUSwelf5Y9l05ljVlvEPNvmnp/WLt6IRpJl4zrYIe0XDkIg+
         63ldBEg9LYJotUQtasUktnwUORJasgvOvMlCdIAUVF8UHoaMJqXZCO63sCmLTRfXQSef
         hYGkViM+u4veVXwH/bNCKUFX58YEmMLXsYlC2/5wZlLClI1zbHBSZEpYucheH2kUOErr
         bmIg==
X-Gm-Message-State: AOJu0Yzy6npk5RuOqrqhqrovzXGp4MQYX6DkSxxwO5UfCHcnqONwpMgJ
	/sSD8gNtQazxUFJDDjMfVlJqP06i+HllNUBPqeOaycxfPT8nfRZHG6AY1H6GlIObzMsNNW5G5Iz
	wJIdCdvIYvojoHnmtPI8cpbvU/lOG/C/kWdwNcR1LrRHUPJlHbhAnPHEB6HEu9A==
X-Gm-Gg: AfdE7cmX0DU0r3XSNVyquIYx9r1wzylITgFtEuPztP7hrJMB/IaCf11tg/yp4TqsKlD
	X8eJHoYi3JjVmD5MTV4gnkuN2989nQbl0QE0wrz1TpvJ6DY7SHN7MTfzosDhlUtVIxdVy+6h/ow
	/q3Xyrd0U2meXIRVhg/JYZeQ3w/rEBuSNVsqfbFmCNCRLKimLabrmWT2Z0HuU+TL2bfc83sZwDQ
	XWvN9nRzcJf8iGrAR+hWwYkjEt9l1CIRov0jqh2ta1YUNj6tZAwSdPK9yaHrrVEgKWIP+QtiSHP
	JCcXRcF2tCobuPmU+i55pPCPIUtCDKtHcObbGif/b+mf2RSeODJkKhjXDGHgcXmQe8SITrOwNeI
	GAhY1ZyodyMH2HbSY+RrzptaYqFkgtt09ZYXycOo=
X-Received: by 2002:a05:620a:390c:b0:914:b497:c5f0 with SMTP id af79cd13be357-9208c813417mr1765143685a.26.1782115555957;
        Mon, 22 Jun 2026 01:05:55 -0700 (PDT)
X-Received: by 2002:a05:620a:390c:b0:914:b497:c5f0 with SMTP id af79cd13be357-9208c813417mr1765140985a.26.1782115555575;
        Mon, 22 Jun 2026 01:05:55 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:dea2:c31b:2872:1bd1])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46666788226sm24040371f8f.23.2026.06.22.01.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2026 01:05:54 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Chen-Yu Tsai <wens@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Wentao Liang <vulab@iscas.ac.cn>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] power: sequencing: fix ABBA deadlock in pwrseq_device_unregister()
Date: Mon, 22 Jun 2026 10:05:49 +0200
Message-ID: <178211554554.11059.13173986317698840.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260618-pwrseq-abba-deadlock-v1-1-943a3fd81c06@oss.qualcomm.com>
References: <20260618-pwrseq-abba-deadlock-v1-1-943a3fd81c06@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDA3OCBTYWx0ZWRfX3Ce1C4JD5kgz
 Q1YmpyoysJKP5/z4ArpxRSHDcerTsH+CAfqALOvQBozm6zYy4d7bV23zEtWTYmR9PqGLgrYSn6t
 34xg8924zaiJ0bUlku/u2dUR7XdVL0KWnkQBfk1QOzTJUv+T/dlkEcMQpfdkOkqFFjos7/Ub1Js
 Tdml6dxep8OBXb/C6NY+QgWVo+bTL7VaSLgG0NVBmh2NLpgcdgbYHgU0sG1vat+A7gK0koz+eUN
 1j2hr4olqtV5oyNQCugrDWKCrW3pi6YkqlC2xL8D+MU18edvUzi8izEcqbPBC7XSzLyIlXiYPIQ
 ntZ0I9ncWV4cnowOKag3gopQKXLItNLJDGgYCEAVDvavsmg+b9QLb1o3RsCd+nli2ctf65PhpiY
 kgLN/xpBSihwhGsXMLtK5ShsOAtDWUijlE07z9amZFmrdwSwWMCGiJPvqOsaQxEIh5OFjOThfzI
 uzZHqCwqHivrS90SBPQ==
X-Authority-Analysis: v=2.4 cv=MtFiLWae c=1 sm=1 tr=0 ts=6a38ece4 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=tNAVBU3kEoXJic8O6A4A:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: aoKhojseaU4V6BOT0AZaSbAolm0FGaA3
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDA3OCBTYWx0ZWRfX2SmgqC/Hhwrf
 +n5jSQ07UxSs52Z71fD90q+4OYg+iX/o9P9inTHKdMujaCFoSlW+4Lce4pJ3AQSzKjUEBYhenYf
 eVh0l2E3H4Ana2bZPdXqhWeSoscOsg4=
X-Proofpoint-ORIG-GUID: aoKhojseaU4V6BOT0AZaSbAolm0FGaA3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_01,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0
 adultscore=0 spamscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220078


On Thu, 18 Jun 2026 10:45:12 +0200, Bartosz Golaszewski wrote:
> The pwrseq core takes three locks in consistent order everywhere:
> 
>   pwrseq_sem -> pwrseq->rw_lock -> pwrseq->state_lock
> 
> pwrseq_get() -> pwrseq_match_device() takes pwrseq_sem for reading, then
> rw_lock for reading. pwrseq_power_on()/pwrseq_power_off() take rw_lock
> for reading and then state_lock.
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: fix ABBA deadlock in pwrseq_device_unregister()
      https://git.kernel.org/brgl/c/2d5a7d406ecece5837af1e278ffbbf6c0315560a

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
