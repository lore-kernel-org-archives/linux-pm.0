Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC9D4D7D36
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 13:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157706; cv=none; b=CPZ+PChtmCMtxC0nSziMQxyckzFscnYgFbOd4DisHSAd0J3+FgNiQ3tgE68oRhZK/Vv4sDMi+j2epoPs6/p+U1SgN1pRiBsknYzOdcPxkwr53stahwvc+Ufxk1T0qO3i7M8Kq1HOHTBDp3KHXhVNQTEzfEc8bJGPHfKabYWqaFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157706; c=relaxed/simple;
	bh=dRZedsXewJ7k0dyhzhYnHamgKjexRp9Kdmjv0oGUStA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dcoIZDnMA3EZSDxaXZHA8chmRL0+SPuMMsLNgjri4pazz2L7oOBnKFRDZSbeSZbHQv1NQg7kDplqDKYQuXTlzaf3MA7ebE72/nfPsH02dcxyvXv1DZ4U+XZV8f1boDR8iGP71RC/fnmaA9Nd8UEZwHpS7/UWQ6eKQ7uwwQn4h4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nKIsq1Yt; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KFb5WlY3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nKIsq1Yt";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KFb5WlY3"
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69GBUiwj1281439
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 13:35:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	njwMX125nYX7Y7esAb3jpSpeXBBuKrFsO53FPtwpfrk=; b=nKIsq1Ytw8tE6UbQ
	rxgaLGfpqwjy8DGVazmvj4GzP7oq4Lz7JoePkCzfJ16uoPx5TSGQ/b2gPuXOU69O
	M5CQRRknKY479QI3FXU6TOAVecZkAtsJnuqoPdzX4DYc2JerXeHheLe18/P4iM3A
	fwCJATRY0sC9QBLNbHLBvSdEX6K9qGUtGnKfLQIEu9u6z9Atl0USZiwhHox4xzhy
	Io2T2cDn8OdCKMjdvbgT80iw570HRmI1NHXLu/5HKTxRKCiUIDAqyJlTJ2jaIzEa
	htUOlkbWbeexhENDXlGSFsl8UsHCMSrnxH9ohSc/kKrZ16dEKlHMp6yaZV5r2eBr
	HmGhDg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hbk3v0ddg-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 13:35:01 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-5362ce9df1eso1544791cf.2
        for <linux-pm@vger.kernel.org>; Fri, 16 Oct 2026 06:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792157701; x=1792762501; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=njwMX125nYX7Y7esAb3jpSpeXBBuKrFsO53FPtwpfrk=;
        b=KFb5WlY3UjzpDXOgsWFmoNZfiXHN/fz9/C92jS27oqt4v2PF32kIUIJMx0V7D6mROd
         WmqT9rsXOcGiHe1CAIKMx2cVBbESq9SWXIfbS7MH2+TS9pwsV0n9kHjkXKEnlHDweWJ5
         mSY113bpHB7oulB3mcA/yxyH5rA61SVpd+ujlyiZTECf9geSfiTZghllB7BrMN2wjXl0
         hG7KiYijdVUaP+R1zcxSe7ksU7EWoAWCoSjv5yxTRF2mIc74Nbl4QNL7NouOsXKhU22k
         SzdSHMXQVRne3CuULk/iETGIaf00ETc4SsaNSM3e+7nZFWqRmkvEQE/jRRTGzp+NyVPr
         iwvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792157701; x=1792762501;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=njwMX125nYX7Y7esAb3jpSpeXBBuKrFsO53FPtwpfrk=;
        b=w5yGiBYzYg91kQJplOzegrtVtcw9fvN40rESF8LFqRmOxtSHYuLhbTsVOoHmZRSddL
         fDw9T8MzLQran6+EVmI+xecou5c2SDwU7qOXweZz+KPCXD9AzMcXF612IHQd0j/0RvMa
         FbOi2pqAkW1J0AZGU12ul5JoX757N7JKWf1O/fpzWHYx1/2UihnWQAcEiimQ9AdZtd4u
         k0aBqp4GyXUNmycakvyEa/w9CTa1rO1yzSGDi7/dXJBXArnpXDQ0fHHIsGq/EVPES8+w
         +EvMCc15GvTQGSMNeNVqEnTLpI3S5S/d4UujTbKcCkPjFCxhW8O7E8pIcanY1Rp2BHXe
         Cpcg==
X-Forwarded-Encrypted: i=1; AKwUvBwIxmJ+GlJfLGaTVCjjjM3WLe4AmDjFdi69XL/Jx3SHjgDiHvXoijZh8qXW29SEiZBNdIBcXWXVDg==@vger.kernel.org
X-Gm-Message-State: AFq9FYK9DG8BKqgcumMiPPno1JAd/BPBv4EYBjTB1GwBsl9rs54WOWEW
	A3Ay5CyA0G/nt9xKyNyny5RQmSL0NZV93v9bk/APO9I0tduVpPP7TX51iVV7vPlxIcMutE9uyMv
	LUt7BUq2eG7zzdf6A9JTsyAV701KlucnySlx2jEoVa1ZkiOvZ+140iFwb3S6RhQ==
X-Gm-Gg: AYBFou1+erlsMNB/+BqVjwqfTH8+sSSpwKPw1u8J7dAT1GREWQdVzrz8J80Hbm+vMAN
	PPS/5v1kOG5BenFW5xNDhDLyoMMozfbHhsU03VX9Cho85UZpmWdVbr2MWY3h74da1/wJZ4QbonK
	Id4xymEUL7SOe29Z33TUZwepJlMmPjHzT2+Ww8BFbFXRPpGiQAy1JUvtddjlEJrzvBzWkQTmXpc
	EvpZ0jgWQoMEIftJ448ef7jDmtGvbxW+WA4zSp8FBdDVPdsAT+X2+gjrzBoEM+wY6bjb6wS/ut3
	NGtLvDP1uXN7pd4UH24hbCDjkkOXDVBaa/nUH7M29knJOvrKfjRr014rLTK5IPREmGNMZaVape3
	7VRiwpLZNeGXH9yUhSUr0WQ==
X-Received: by 2002:a05:622a:1791:b0:535:162c:2e81 with SMTP id d75a77b69052e-535a014c6c7mr430286081cf.5.1792157700707;
        Fri, 16 Oct 2026 06:35:00 -0700 (PDT)
X-Received: by 2002:a05:622a:1791:b0:535:162c:2e81 with SMTP id d75a77b69052e-535a014c6c7mr430285181cf.5.1792157700035;
        Fri, 16 Oct 2026 06:35:00 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c4091eb14a7sm73711666b.76.2026.10.16.06.34.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Oct 2026 06:34:59 -0700 (PDT)
Message-ID: <0e5b7d2e-e141-4ce4-a873-b65bd9ef3c4a@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 15:34:57 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] power: supply: qcom_battmgr: fix the battery current
 sign on Kaanapali
To: Joonhoe Kim <26rote@gmail.com>, sre@kernel.org,
        Jingyi Wang <jingyi.wang@oss.qualcomm.com>
Cc: kamal.wadhwa@oss.qualcomm.com, anjelique.melendez@oss.qualcomm.com,
        dhruvin.rajpura@oss.qualcomm.com, andersson@kernel.org,
        dmitry.baryshkov@oss.qualcomm.com, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20261016124806.1789-1-26rote@gmail.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261016124806.1789-1-26rote@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: 3Y0oEWx31KW2NHz-LeGqSqyAnfbbDIrG
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA1NCBTYWx0ZWRfXxmTHRDqBDlD2
 d1fkFuclpbOjGwhXyYHaXU5keN+ei225l8v60otuv0q3V8geD0NoKSqyMxgQ2OV/wNE4kna9Mmf
 1nAoHCKlEVgPwvuokaq3ubuaaW8Vse0=
X-Authority-Analysis: v=2.4 cv=BZdNQbt2 c=1 sm=1 tr=0 ts=6ad22805 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=gZfuR-GZJQvasSKj:21 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=VwQbUJbxAAAA:8 a=DYa_1O34AAAA:8 a=pGLkceISAAAA:8 a=nbsK_V1Wq9JmJ-PpB0gA:9
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=piCpHeHFVjWJlYWd443B:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA1NCBTYWx0ZWRfX95+cKvEZgN2R
 9vGJUuxWS0kEFb20ldPHIOP02eh0ijnvgOvAwQ75I1PcPi1ATrDAoIvlDbjIa7sAx1a754DZndo
 qN/Lv4XvmdRPjNsZxSeBWqhGhw/xk4WQD9c1vkahopzAwFywAMLx3T7vBbm7WRmi8vULad5i0K0
 FUlYdV9eWnP3S4q8M6KDu2TdkXcmcwnbCucYtyCnFrQ0/51JnrVW70pfpMYLeuBX1O4oGXZYtFd
 +2dNPTsQJRn307i+c/8hMfDfwWVv5vO2XheGKbtQ1vnv2NRDBw0fwxmRi4kVMV8Zx+R7d1sSwsx
 ZkJbuECnYZq4yB/tIqPyBKN0+oCVSPgR16/wCnt0JyP0Bky3w6LbSB2Ae61LDwbHeFXow9umv9d
 BhQN/oGyu9v6oV1m2ka79kqKdiH1u6oQOis+B+YjigOyuaPat035XBK1vtiPcKk8CBt76nntsD3
 jrXym0inIcySI+rmzPw==
X-Proofpoint-ORIG-GUID: 3Y0oEWx31KW2NHz-LeGqSqyAnfbbDIrG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 adultscore=0 bulkscore=0 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160054

On 10/16/26 2:48 PM, Joonhoe Kim wrote:
> The Kaanapali battery firmware reports the battery current with
> discharge positive: on a Lenovo Legion Tab Y700 Gen 5 current_now reads
> -9.1 A while charging and +0.57 A on battery. The power_supply ABI has
> charging positive, and upower reports such a charging battery as
> discharging.
> 
> Other firmware behind the same callback uses the ABI sign [1], so
> negate the value only for qcom,kaanapali-pmic-glink.
> 
> Fixes: 16a7c32e586e ("power: supply: qcom_battmgr: Add support for Glymur and Kaanapali")
> Link: https://lore.kernel.org/all/20260829054546.86210-1-jan.brummer@tabos.org/ [1]
> Signed-off-by: Joonhoe Kim <26rote@gmail.com>
> ---
> I could only check this on one device, not on MTP or QRD firmware.
> Anjelique, could you confirm the sign there?
> 
> Both patches apply before or after my two battmgr patches still under
> review (USB_ADAP_TYPE v2 and the USB input current limit).

+Jingyi could you please check if this applies to QRD/MTP?

Konrad

> 
>  drivers/power/supply/qcom_battmgr.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/power/supply/qcom_battmgr.c b/drivers/power/supply/qcom_battmgr.c
> index a7237ba09be1..0d55458b2881 100644
> --- a/drivers/power/supply/qcom_battmgr.c
> +++ b/drivers/power/supply/qcom_battmgr.c
> @@ -313,6 +313,7 @@ struct qcom_battmgr {
>  	struct pmic_glink_client *client;
>  
>  	enum qcom_battmgr_variant variant;
> +	bool current_inverted;
>  
>  	struct power_supply *ac_psy;
>  	struct power_supply *bat_psy;
> @@ -1435,6 +1436,8 @@ static void qcom_battmgr_sm8350_callback(struct qcom_battmgr *battmgr,
>  			break;
>  		case BATT_CURR_NOW:
>  			battmgr->status.current_now = le32_to_cpu(resp->intval.value);
> +			if (battmgr->current_inverted)
> +				battmgr->status.current_now = -battmgr->status.current_now;
>  			break;
>  		case BATT_TEMP:
>  			val = le32_to_cpu(resp->intval.value);
> @@ -1659,6 +1662,9 @@ static int qcom_battmgr_probe(struct auxiliary_device *adev,
>  	else
>  		battmgr->variant = QCOM_BATTMGR_SM8350;
>  
> +	battmgr->current_inverted = device_is_compatible(dev->parent,
> +							 "qcom,kaanapali-pmic-glink");
> +
>  	ret = qcom_battmgr_charge_control_thresholds_init(battmgr);
>  	if (ret < 0)
>  		return dev_err_probe(dev, ret,
> 
> base-commit: b810335a0699d1810683796b0e3ffe8827ddfe6c
