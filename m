Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0BE3C3F44
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 20:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790108590; cv=none; b=ulqxVFjj+rJtezuaEVDV/bKlMnnEXbHb3b/OoVuF7dmFqRUfm33KYqq5++SnCstu3cMqCVm4VFGNt+b+sasJKkaMGV1yXL6ETJHnHtCtVMdO8y34Kmn/IXf6yGnpp1x/8Xv8smZnc9Y92+ylFS2DtQeendffryYuSAvEvjOwtfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790108590; c=relaxed/simple;
	bh=riYamvsVX2oKQRx/xBDLH39QziKxI0EWYK7OjNxVRDc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eYztEL3vrsd7JJ2302OQDeHCfM6Hp9PKos1LAQnR0dsAqzyomVSReKF9ccLjhjAB8GYe/CWce2rgJ7lKVD9SL5vL7VB+PAViM+Sev2NoRKwAwi6e0jYM7LBcm8QQL+iYxhLyse9JqxHGI9SKRjq/3aEdbh5ss1uLMWeVA/3xu0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bqxcTDE0; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kl3hFeC6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bqxcTDE0";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kl3hFeC6"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68MI81M8767932
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 20:22:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=8htKgBaDIdBPsyrAeJXC/gbT
	CTAoJcyryDOr9QBMzvk=; b=bqxcTDE0j/q1DK4LnyB/VLFYvXXdTuMOY0MjQ7kq
	y1Hg5NAV4XO6jXLDNYtZ+lBJlqxd0DO4uxLNvy4vYbKYuHcxss5KCJAmevvC9pzv
	500sDSIX8D8TgdcVCYEEkOIV2oJ8ma26HmSCH+b0ix4ck9w8zxQkrGOkOZgMzE0w
	ldSkuH3pvcNPafWJ0F+8sXl1CfdAmKXdh4RnTNYBKGlUcpPgJFpduG1TzLNkewAC
	wzlO6/6q3Ee6ZRKIH9btk7WVHCA6Yh55+M+Jp2nVGZk4F+xNHwdB5QVqtB0zqmrI
	vMlaAOO0IPA0Jl8vhXwPlDQkp4ussLGcO9UOWMb/4FqgtQ==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gupbqkd57-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 20:22:51 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5c830ea02d3so289479e0c.3
        for <linux-pm@vger.kernel.org>; Tue, 22 Sep 2026 13:22:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1790108571; x=1790713371; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=8htKgBaDIdBPsyrAeJXC/gbTCTAoJcyryDOr9QBMzvk=;
        b=kl3hFeC61t3BuaJc6wEu0fOtsMnFirmKYvw6zV2QE+WdKVdEjmNJ1avd7tStbydUPI
         zeVOreaVXbiDH0z2qvu9OzFrxpjazYCVTuShOOh2ocO4Kw22kVmkNZlqRl62f2H2ERbh
         zUBZ0N/npi/1umFzLlQWjXO5pGXBfJckzHuol1yvLL1Ul+gM9GWWoCD4GbRRtZqscorM
         oHV1Zx9IzCtLglWeEWXeJ7UycX4ZaMeVgN9FtCQZVDqoBMI51N8T2tCjlOAR/0fOQk3k
         tHfoXwVnCBxoFMFt/Iey0QdIzDGY/hawy5BBwOZRfqJWZjsz7QYPMeP3FF/0R9aK5GAr
         X88g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790108571; x=1790713371;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=8htKgBaDIdBPsyrAeJXC/gbTCTAoJcyryDOr9QBMzvk=;
        b=ODvY/iFDP0oRjeVvRdhHFlTAFgA2DSGAFCGwyaEO/7YoY+PX+wNe+xUD8NsuP4ad6p
         YDRzgFhQtzNPE+3CIxNMqOdEkYdgLA7QZ3vCOwCWq9a/IabCmQ3ArUEl9FkGePv5cOiv
         qbU4wINcktMNOr+LlXKwJGhbJQygyg2tVErh/Moc7YXS+T3AfzBE0A+ISaVVBpLmDMlx
         XJptgYd/EmQh2FtugEtjkEpPBJyDjDEPj7kxjpyi7o7kqQLr7rOODp33DdfjQ6370+e6
         a4U30X68vfCZmkW9kmlQGAD3QOxdWFGFWbzCfAOe7Da124MlIhnRaMcenJhf/SAZGZ4f
         WLLw==
X-Forwarded-Encrypted: i=1; AKwUvBw8qlwGnutJyw1X1qJsWo/cUho8u6s7cyJ0C47O1gyHB+Z4DIJKNn+0UoPC+2ej3TCbHLs9BkL/gA==@vger.kernel.org
X-Gm-Message-State: AFuF++lIiqvwIgX4w/pAtghbFzkYpa54tiCfRfZrTJSV0VZScXf5258m
	5Ublo4YkCTSOUKfQEtjR1sLTF4HkMb4RpdELCVukZMO/aE0lwnGhQFKRif8hlcwyue0yK/Hxg2s
	eQK5QCIQUefr4aASCjaY/jBkovpJ488ORnuAElGlybzohxD3+dyZy2WUqXRNzag==
X-Gm-Gg: AYBFou3wq/auGiVCJcUhcdbBeg9LgaC3jZcz0W8y5x/cmCHAhuTv0o0xD6hcPedos/V
	vonb3rU5tluGJuS14XjKxI/bSRB8cX7Ao+BAbeAHkJQo3kvk10Gy8ad70qn3ti0qQ66GDD8goBY
	+CnV0vE3UTDrWu2aN4QWxQbXn5034GCLej2qVrp8P9SkLPpmLTjkkXsRxwv63AcFij8145BYQQJ
	11JSWa2J0oNWD4fwbHHiK5W+0O8HdhHk0xc9K3I9YWqKKujAk1Aio+XGbu3YLPdKOb/v4mXSEsB
	PVilZS7g/CfW8pL5BDjcPGTChXft0JzRGJuz07fYzzI9pZRCMrMI6GECMlcM65deILYFJWCHRtJ
	WHt/Op5ZsUxMGJtc=
X-Received: by 2002:a05:6122:179e:b0:5c9:c60e:5cf4 with SMTP id 71dfb90a1353d-5c9f1684ca7mr1189846e0c.18.1790108570681;
        Tue, 22 Sep 2026 13:22:50 -0700 (PDT)
X-Received: by 2002:a05:6122:179e:b0:5c9:c60e:5cf4 with SMTP id 71dfb90a1353d-5c9f1684ca7mr1189793e0c.18.1790108570226;
        Tue, 22 Sep 2026 13:22:50 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.232])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48868486461sm885650f8f.8.2026.09.22.13.22.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 13:22:49 -0700 (PDT)
Date: Tue, 22 Sep 2026 23:22:48 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Luca Weiss <luca.weiss@fairphone.com>,
        Bartosz Golaszewski <brgl@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] interconnect: qcom: Skip get_bw on QoS programming
 providers
Message-ID: <r5oa7d7rrdcenoiks5efex73huxr6mzpqkqjt5jlgu7y3rdb2m@uqak7vhuucf5>
References: <20260922020623.398913-1-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260922020623.398913-1-shengchao.guo@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIyMDI5NCBTYWx0ZWRfXzkXNZH4SCqEd
 MRObqq2gL6VWuvJI5YFAgoOqOkJUFF5cpBgtwE6bbwlNjBihugdY2Im9aIqwIWxdJy1tDToydWm
 uQpwuTU8S8cECFtop2rji1otKpmgU/wm1F+PWDcZ7/gP5c5nxhx8qwbbklpLt1Ue/RmPKdpJavW
 D62RBl2BaDW6OSUTK5qZLcxqEg50Y3RTql8hKMqcKibF9SmLhm9Z3nxhcon92qtGmqmqHkJPXeO
 l4noL4g+cOfLnd6+a9k9R0DgHTPt7d3ELWpv4Le5WIyEnQKDNN9swo46uVpsH5uIB1L5Yaw4V1G
 Ko/9YBqx2u4NNP93Rz2KfKKTD1az2hLEubNyxulnH5oxQPGkw/Of/qBwdTvNP+KXghmxQRW/JZc
 7oF8E/VVDHNH8JIT/D7QNNefxBfZyAaYeyvg21N0BOsX5Ot1pxa3NOt8S5ghVcj01CQU1WNGVIZ
 imMzLQ1xJX2Q7FJpPNg==
X-Authority-Analysis: v=2.4 cv=FdaiV5+6 c=1 sm=1 tr=0 ts=6ab2e39b cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=po8fGBi+ks8MzcVQGuqtFQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=bdokXQhzV7AcA4co5KEA:9 a=CjuIK1q_8ugA:10
 a=tNoRWFLymzeba-QzToBc:22
X-Proofpoint-ORIG-GUID: xSfuelDXehMCfR8lNbP0dNTJ4yDORZ83
X-Proofpoint-GUID: xSfuelDXehMCfR8lNbP0dNTJ4yDORZ83
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIyMDI5NCBTYWx0ZWRfXxgKkknHUv+j0
 2bpsWV6yEXqg72uDXcAcfNr3lKDedIzyEU4bYctsN+/qoFpAaAua00do2vRMs44/OaM3MyaThyX
 /ElFSJu1JiU5Dhg0feaHRPP+3S9o0kY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-22_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609220294

On 26-09-22 10:06:23, Shawn Guo wrote:
> Programming the static QoS configuration in qcom_icc_rpmh_probe()
> touches NoC registers directly, and nothing in that path clocks or
> powers the NoC first.  It has been working only because the
> interconnect core used to vote every node to INT_MAX while adding it,
> and that vote stays in hardware until sync_state.
> 
> Reading the boot-time AMC votes back from RPMh removed that implicit
> guarantee: a NoC whose BCMs come out of the bootloader unvoted is now
> left unclocked, and the first QoS register access aborts.  On Qualcomm
> Nord SoC, the MMSS NoC dies while programming qnm_camnoc_hf, taking the
> board down before rootfs:
> 
>   Internal error: synchronous external abort: 0000000096001610
>     regmap_mmio_read32le+0xc/0xa4
>     regmap_update_bits_base+0x64/0x98
>     qcom_icc_rpmh_probe+0x44c/0x540
> 
> Only install the get_bw() callback for providers that do not program
> QoS, i.e. those without a regmap config.  Providers that do program
> QoS keep the previous INT_MAX initial votes, so their register
> accesses stay safe, and the rest keep the benefit of honouring the
> boot-time votes.
> 
> Reported-by: Bartosz Golaszewski <brgl@kernel.org>
> Fixes: 11a44c6087c6 ("interconnect: qcom: implement get_bw with rpmh_read")
> Assisted-by: LLM
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
