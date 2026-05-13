Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28DB8386574
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 14:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778683765; cv=none; b=nUjSupQj3WrVuvwP9y/ywT6MTrWHIBARKaKUya1tHzNbCdWav71UvklgoV1Y5FIEGVW4v3oyJ4AbEqCI7MUuAQlWdzeq77/DnhLVJ+21hSzIke47A+qsyXlDVpoccGUwtMmfWFpFMnj4yfGPdn7bKnjaORpu0kJrxNRHX0z3c28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778683765; c=relaxed/simple;
	bh=i70C4aRZh+kIEBITMBuj4aQpXlGiwrUm5uQdOMwzqew=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e+rTDIzxt92RNap6ArD+ALzkBa4+TDROh6rBcSX8x1zwLwhOn+fv6QwWcFRYZoTIMZA3Y+q65/rvNuyseXubsDtCIx+vb1wvnZrK9ujPuYTM+QPkEMVSZQ3ecpuyHF4ZapaC0ECQyZKEHGaz0bf4Hsz4O/LoJtOZ3yyaxJ7DvFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=eDibc9RI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=QYxInNtU; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="eDibc9RI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="QYxInNtU"
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DAQJKh2321254
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 14:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9/T7hxv19XiV1Jl5lUrqjqNhW3gg50rO24lB9xj5+Eo=; b=eDibc9RIBkzz+Z9/
	P/PeSzDNM43QtDVcqJ+Ghsd0lV82ZlqEOSte9xKjnHYuWO/MwvrRCtOkrUts2XOL
	coKbbKe/1pg4xOVj8Kv0qMYAO18yv0dNwX+ZhO+4uOiBooWyGqW+7PfStLaWzmLk
	k/sBvk9J31lBNprOoVqgsh9wYoa1qbkaR+Cm+Pj5pGfyWM+Xfml6sVLH9LxuwU+6
	DvvEYX0I+Y7aME/666TBSbwERU8pPlAKxrRs/eFdG+6NqIgHl1m1SmPvgUH/kbEU
	bosooiWhDpjfN1MJgYingQ1qd3sZfpUvmJqc/ZnXvNY0xaBsNZCdsP4rPF7ZJISC
	RKcGQg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4hguahg9-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 14:49:19 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50e429ba4dfso15624621cf.3
        for <linux-pm@vger.kernel.org>; Wed, 13 May 2026 07:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1778683759; x=1779288559; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9/T7hxv19XiV1Jl5lUrqjqNhW3gg50rO24lB9xj5+Eo=;
        b=QYxInNtU1jKvCHDyucA7ecK47ISlItH9dJnUpP9nvy4Nt3OiQQmmuuJyABOctIEUJ+
         18cHncBBS/iycWUUsxZk7RE2rbQFo0WEjx6NpE+RnFLhezGHw7x7pcCwt5nsHLKo9Dg5
         cc9C/SPquNdN/xW8NwbQryDPOiwpPvTkGK+YeMykuy2R8OE4chRjetKFZLsbCWn6/ROi
         Y/ADHAhscLRBXE4/hKy2cX9GMb7WX3jRU7e/ZVX145E4vsFrItGHZ2yCX/J1bzemVr34
         OCcB0pIN0W5o17s6DMHKFChFlht+NpYpbIOu/bQSIacb4YGI8/WBaPKNTgdpfxMCn/I8
         Glzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778683759; x=1779288559;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9/T7hxv19XiV1Jl5lUrqjqNhW3gg50rO24lB9xj5+Eo=;
        b=X77ksGNEJ2liJxKf7O1+VJOn6Bh6aOHi27XYljcmiu38y48F9nZ83wqZYn/s6YRiPD
         cbDcRSJk5yG8meEcoqKDrbfoJTnWDSa29BTQaxT0xdbGTXxjpP4LIVnx7eScMUa38glw
         VpJ1BIlTJDxh1e4uEWztiYgo5iZeaNi2lx9MiPE81w+3guRCikkovDsj/5I1wbQV9rMU
         16abzz7dkY064c7GaOte3crFd/MCrCkTXpekuoiZ9lMss4/F7uZ00t/aOfYU5zvGwh3f
         szzKiKeY6F3983Np/Q96e2Jw+rg9bDwPrRCrJdFomhQi+g/9M17ftOyCzFPErxJA1d8j
         5CDA==
X-Gm-Message-State: AOJu0Yxba4jICd8V5OAjph4tg/P7l8ALQ7TvO+AAkNn+qhTJPdouI05j
	tIdhlyjm3D99OKSzuliUTbrifoq6Xd3eTwEFUo6rVzR3Jca0tDy3xCLKHKhcMuosS9AqKEjATS6
	qbzAfzI6CiuJfT/4/Cj92MDOurhuHFiUtryYt6eNABz4LAcUnLlgxft9XtNtyUA==
X-Gm-Gg: Acq92OFCZUC8CA4At7TD/y7/DdjUI+h5wPOIQZeNglKfvhQpCCY5onwm6iSo4aH/pjm
	kA7/U1q7W6y8Ys/A1l1E8wEkiLpcQw3YiU5pZApR8ivdH+brmeQJyLE8p3oQR71u71bFGuXcyLv
	L+C1BT0oVvYLn/9EMnztHLwd/l9F/fgOSJMAdFjMTwLNi9OVMO8ycYT7eLmEAQfavKBoVruDzR2
	QMCbN78h9czk4Sb11ZPCupf68h7rTie/Tv9GQx8zhocQhk/SYEDYxd/fg5HGsYRdRQ+B/+mZw3k
	U3vcvM6eXaFFm6NqvP4GA4nN2/m3vArtKdQeqnbpiBgmYj6uY/ycoFgI4xxYaZkh3EGXxp2nRqB
	YiYb/BICxGHLF2pFBECMyJPJs6T69ST2Dimt08KLytWCBV9Tya8KQjIMQOLtJme7arEIA+XVNOS
	gSKbw=
X-Received: by 2002:a05:622a:230d:b0:509:2a92:8088 with SMTP id d75a77b69052e-5162f438383mr35299781cf.1.1778683758883;
        Wed, 13 May 2026 07:49:18 -0700 (PDT)
X-Received: by 2002:a05:622a:230d:b0:509:2a92:8088 with SMTP id d75a77b69052e-5162f438383mr35299271cf.1.1778683758392;
        Wed, 13 May 2026 07:49:18 -0700 (PDT)
Received: from [192.168.119.254] (078088045245.garwolin.vectranet.pl. [78.88.45.245])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-67ef0dfcfdasm6326090a12.18.2026.05.13.07.49.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 May 2026 07:49:17 -0700 (PDT)
Message-ID: <3345c399-1fb4-4590-8c08-51f0f5396c68@oss.qualcomm.com>
Date: Wed, 13 May 2026 16:49:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] thermal: qcom: tsens: atomic temperature read with
 hardware-guided retries
To: Priyansh Jain <priyansh.jain@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, manaf.pallikunhi@oss.qualcomm.com
References: <20260513054412.911048-1-priyansh.jain@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260513054412.911048-1-priyansh.jain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=X4di7mTe c=1 sm=1 tr=0 ts=6a048f6f cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=FpWmc02/iXfjRdCD7H54yg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=n9LmjtgyrI0DaRnITSYA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-GUID: BxT-rD1Vs4BmpkByznLso3WHxn_xzBDR
X-Proofpoint-ORIG-GUID: BxT-rD1Vs4BmpkByznLso3WHxn_xzBDR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE1MiBTYWx0ZWRfX5Bmx8AaBP7Am
 gF8wH9e1GQEaC/da07ANB4E9wTWNk2DB5NWChsMmbZpNRXMVIFP3sxVLR6IU2wxJEel7RMYCsCA
 C+LpxdlgZX8gVa/2m4m66sXYwSvXg5A9qInfxjTnSop+OX++eGWQaOLJBoaG5r67174uI6N2zLU
 dIguMFH21zPaHzoZi/Gg8esUTr2lYWxfhXpqO8ZaHKJILweUDGedukYY/qZKYI5FWRfNEY3p/Pl
 tLIW4qVpy7/lw92VoOVbTJuSyAiShHyzpyxYKyf8MTWIqS5Imt/lk6P/AkJpj6LuOhuA33CuwWx
 lGcbQH3t1t/LM/BnmWy8jjnmgu49fG5Y9qlWuWiGxGHQl5dY9wdC8W9u6WvtajkFua7tZbsAq09
 z+GO/YCCKBZoem45aBaLlxIA5Ls9vaqVATnoLFzK6lQ9VMd76D1aYZvg3Mrq+phsivyssHphfSS
 6g/7f4cG7cXpsV6GX1w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 phishscore=0 malwarescore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130152

On 5/13/26 7:44 AM, Priyansh Jain wrote:
> The existing TSENS temperature read logic polls the valid bit and then
> reads the temperature register. When temperature reads are triggered
> at very short intervals, this can race with hardware updates and allow
> the temperature field to be read while it is still being updated.
> 
> In this case, the valid bit may already be asserted even though the
> temperature value is transitioning, resulting in an incorrect reading.
> 
> Hardware programming guidelines require the temperature value and the
> valid bit to be sampled atomically in the same read transaction. A
> reading is considered valid only if the valid bit is observed set in
> that same sample.
> 
> The guidelines further specify that software should attempt the
> temperature read up to three times to account for transient update
> windows. If none of the attempts yields a valid sample, a stable fallback
> value must be returned: if the first and second samples match, the second
> value is returned; otherwise, if the second and third samples match, the
> third value is returned; if neither pair matches, -EAGAIN is returned.
> 
> Update the TSENS sensor read logic to implement atomic sampling along
> with the recommended retry-and-compare fallback behavior. This removes
> the race window and ensures deterministic temperature values in
> accordance with hardware requirements.
> 
> Signed-off-by: Priyansh Jain <priyansh.jain@oss.qualcomm.com>
> 
> ---

Leaving a couple nits below, feel free to apply my tag with or
without them:

Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>

Konrad


diff --git a/drivers/thermal/qcom/tsens.c b/drivers/thermal/qcom/tsens.c
index b1b938312723..96c1ff9e3133 100644
--- a/drivers/thermal/qcom/tsens.c
+++ b/drivers/thermal/qcom/tsens.c
@@ -330,7 +330,7 @@ static int tsens_read_temp(const struct tsens_sensor *s, int field, int *temp)
 {
        struct tsens_priv *priv = s->priv;
        int temp_val[MAX_READ_RETRY] = {0};
-       u32 status = 0;
+       u32 status;
        int ret;
        u32 last_temp_mask = GENMASK(priv->fields[LAST_TEMP_0].msb,
                                        priv->fields[LAST_TEMP_0].lsb);
@@ -341,7 +341,7 @@ static int tsens_read_temp(const struct tsens_sensor *s, int field, int *temp)
                if (ret)
                        return ret;
 
-               /* VER_0 doesn't have VALID bit */
+               /* VER_0 doesn't have a VALID bit */
                if (!valid_bit) {
                        *temp = status & last_temp_mask;
                        return 0;
@@ -355,7 +355,8 @@ static int tsens_read_temp(const struct tsens_sensor *s, int field, int *temp)
                }
        }
 
-       /* As per the HW guidelines, if none of the attempts observe a
+       /*
+        * As per the HW guidelines, if none of the attempts observe a
         * valid sample, a stable fallback value must be returned. If the
         * first and second samples match, the second value is returned;
         * otherwise, if the second and third samples match, the third
@@ -576,13 +577,17 @@ static int tsens_read_irq_state(struct tsens_priv *priv, u32 hw_id,
                d->crit_irq_mask = 0;
                d->crit_thresh = 0;
        }
+
        ret = regmap_field_read(priv->rf[UP_THRESH_0 + hw_id], &d->up_thresh);
        if (ret)
                return ret;
+
        d->up_thresh = tsens_hw_to_mC(s, d->up_thresh);
+
        ret = regmap_field_read(priv->rf[LOW_THRESH_0 + hw_id], &d->low_thresh);
        if (ret)
                return ret;
+
        d->low_thresh = tsens_hw_to_mC(s, d->low_thresh);
 
        dev_dbg(priv->dev, "[%u] %s%s: status(%u|%u|%u) | clr(%u|%u|%u) | mask(%u|%u|%u)\n",
@@ -807,12 +812,11 @@ static void tsens_disable_irq(struct tsens_priv *priv)
 
 int get_temp_tsens_valid(const struct tsens_sensor *s, int *temp)
 {
-       int ret;
        int hw_id = s->hw_id;
        u32 temp_idx = LAST_TEMP_0 + hw_id;
+       int ret;
 
        ret = tsens_read_temp(s, temp_idx, temp);
-
        if (!ret)
                *temp = tsens_hw_to_mC(s, *temp);

