Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52A8639EF0C
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787558356; cv=none; b=hjND8xwhU8JQGVt1PwUn1ZHxkItTnNKHCetAnW6bUv2/ujcSBIUwKKo8HonG30qHt2w1AM0sB/UjT2PHhtplEf4CIvK1s/eV5XDb/ajDArTj2MxTAu3E1YJThRUAxfE/sIQ+C/5K0fCH07mJ+ZCkajdXtvzXPNTbv5iZi6FY7Uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787558356; c=relaxed/simple;
	bh=2hqvxIZr5FydskzcmkSZz+91CJz7nOks/IGm0b03hfM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EVSoNkgGlObhRO+WzeBPh2NeSylCszT2LlFICiuzO7uTvCvB1AAjJp6OT3j3gyafJASSOlzr9ZtU+gtIyxYewONfk8up/ss2v3L1DJiPCRdSEt700JRpUULcnTlUTcSQI6guoe4CTu8PJwV4AotCBfoCijuIR1Mi+kyqINI1Jxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KNZTul51; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=SaYSpt1e; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KNZTul51";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="SaYSpt1e"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67O7j2rf1184461
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:59:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Hwy34XbCewo0bCBjlQRatKiE
	GjO+3FoHbts9Y4GEKpE=; b=KNZTul51kgfQ8Bu/0L8pJkthUJ7iFr0jUmkKrkis
	g6sq9Q44BeBeAuCJ2E1GUymNhl6LJzTSU2COMFs+9ybR0c5g5yKYBacxIb1q0+MP
	iYIC42PrRoFxw7Le7DYJxv4mI3/yGDTthrJnhnl5Exr9eA4l1yf+bY01pY7nlqQ7
	tPboVXzfVwSMn944Jzrod4fBlVOFNCnmIOC0vZsKww+AfYO2hKknJrEFS8nO/p0e
	DOhi3F+9eY3zvOwTt9L30RoKBZ/ghi/UmEmqrW7zGRvseFyaHjyfHba7zsprbZU8
	pKSuMDAPmkdazz7DVccXd8u0AfwvQnTy78QFQU5za8ewsg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g8huf01rs-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 07:59:10 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c26012cd0so31442601cf.0
        for <linux-pm@vger.kernel.org>; Mon, 24 Aug 2026 00:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787558350; x=1788163150; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Hwy34XbCewo0bCBjlQRatKiEGjO+3FoHbts9Y4GEKpE=;
        b=SaYSpt1eG+X29qfzZi7egLPChSqRxlNy033iyd3qdyHBrrBFzOxJ/eKWWiu+gd5rt8
         nNS0wR+5io3XJ7wu60D5AN0ixQe4dEpccm3JR+0Uzpi3Ajl3Z5arDsFAkW0+pHWySfma
         giVe7tmzGjkur5KSRgodQXo3v9orQGa6wgaG0TSMUqo+FFyqRqoqbdXRMwCW+9EkGb5k
         swB3uoqJAu2iPsymaWKJ3ZIPXB5HG5v7OoscSF17X+Pynx3PxK//BlepLWWMG7iWXklG
         uzpVJXQusWAZCmm2r+u4XfaTGYjJRQvQ98RBFNDXf+j7N4zzDXsPDfmlRqOxtDAHX5SD
         gN8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787558350; x=1788163150;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Hwy34XbCewo0bCBjlQRatKiEGjO+3FoHbts9Y4GEKpE=;
        b=jPLBwAzg7g/c+T97sjxf1j1Mo2Wkh2PcByvoNYrOCYM5E9HkTFTgngdI1qDcrvx7ep
         GDndbz57EatFHZlVIRm1bcFfMRPKh1CGPsrR0oPm7uxXia96Vb9v5X1qgXZlgWM0kQ6N
         Ln5GmwlpUfagH+HiDe1xiwm8252+4sXaPo5v0d6htOe6RkJh9Rl/Q5F0MT65RwSKk5fd
         PS3bHLB5MHBBpl7S+udHr14Bcn3PACkAOr7njo9oVs/GxbPnVH/KAFQ9RkzwnMUS3KG2
         aaV14YHlI5OvIeSGrven/NcxmRg1AtCyV/RcYTbddeoQnYsapRy0pSt4U2wFDs6aphrj
         DN7g==
X-Forwarded-Encrypted: i=1; AHgh+Ro2nMlqe+ZB2L4xSztZ6+ohwrrJEoj645qTeRBnBU+rpbErYk2VcAxiez8Ea6bhVp0YXypCWfjJEA==@vger.kernel.org
X-Gm-Message-State: AFuF++maAWIWqWR+gJzm0aARu7goCEFDJj5d9HH8xfFs1jcot7xJqyqz
	1LP/Qa+cTqtKiwhbfqtIYOUBej5cgyS7SI5CiC8MmuIlYK2G0O7tfi80fIg/qSUTxvfHWD5rxV7
	2U7d/P3X330TMziE7obSPPsMMYPkfMZFnTXWe9/CUh8r8zIriEABXYK2WAmfh1A==
X-Gm-Gg: AR+sD10O/Dr2vy9caSzVhvi3OpJ0hkVfFfNgs3ieKiJDdHup1sqFmlVXls3D0UUdkGb
	/Eyqc6ftq4n1aK4xYZuhweXwhuN6gS9bMfSyysjkei3oB/nVSAhGOdEB+2PI44fbB7vqTd9eR1w
	RsAJdxGlP5QaOrysN9PdHGdWgElNV5wwzfKNCzAyQ/nwLTLHOfQ6ThUnmofr1X604oGtQraMUtB
	+bfdFHxkc3ZgaZv0GB+vWq/rWUMYpY1vO4GPcLwwj8Wm/OmHIOpOeyQSITX6Vc3jfz7BLhuHLAw
	FJGk6VqF9k1MlIPF8MQhfZ6HfWMm7s5wNhQJqk5uwj/xcrtsHTArmKMm6R2AQmWiEiMk9XosYOJ
	8LaBFTwE/VwbqPNQ=
X-Received: by 2002:ac8:7d4a:0:b0:51b:f40b:2fb3 with SMTP id d75a77b69052e-52e09b80e3cmr154416901cf.9.1787558350291;
        Mon, 24 Aug 2026 00:59:10 -0700 (PDT)
X-Received: by 2002:ac8:7d4a:0:b0:51b:f40b:2fb3 with SMTP id d75a77b69052e-52e09b80e3cmr154416551cf.9.1787558349816;
        Mon, 24 Aug 2026 00:59:09 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.240])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c249689fa97sm978725366b.57.2026.08.24.00.59.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 00:59:08 -0700 (PDT)
Date: Mon, 24 Aug 2026 10:59:06 +0300
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
        Taniya Das <quic_tdas@quicinc.com>, Georgi Djakov <djakov@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Linus Walleij <linusw@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        Radu Rendec <radu@rendec.net>, Robert Marko <robimarko@gmail.com>,
        Guru Das Srinagesh <linux@gurudas.dev>, linux-arm-msm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-gpio@vger.kernel.org,
        Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
Subject: Re: [PATCH v3 01/15] soc: qcom: geni-se: allow selection on 32-bit
 ARM Qualcomm SoCs
Message-ID: <ssts4xmgxvfy5rctjskpva6aq5imxi7b4q3jerbnfyfn5sfehx@hbrk3pbfc6sb>
References: <20260821-kuno-soc-support-v3-0-196e2b306368@oss.qualcomm.com>
 <20260821-kuno-soc-support-v3-1-196e2b306368@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260821-kuno-soc-support-v3-1-196e2b306368@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDA2OSBTYWx0ZWRfXwyEmo3me0HXT
 V7ZqosARIuBczMGahBYLdQeY6SYd+UcSi9Ylta/CWKhHDBE/z+ng6no0CMszxQwa3Nutdj7ie3M
 UQkWJId2fN/KtQZEiUKm3LYquxs5qv0=
X-Authority-Analysis: v=2.4 cv=Wac8rUhX c=1 sm=1 tr=0 ts=6a8bf9ce cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=wUpz7uCjLrEXi01cjX+DLw==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=rpqCqEIPHYpObKgDwZ4A:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22
X-Proofpoint-ORIG-GUID: 2Ejx7Ksy4sa1OZEL8YGL1yI4_pcfDnsH
X-Proofpoint-GUID: 2Ejx7Ksy4sa1OZEL8YGL1yI4_pcfDnsH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDA2OSBTYWx0ZWRfX9IMLzQnLXvCi
 yx/jpcouVbYuyhKHbj9MrNPAvVSI88wn4dwGcnqxMJbJJKr62JYZ/YyAqcJG6CPeMV3DPOtWihw
 YmemtvtHO/KC206bCdHDMMpOSV4lshC5xu6rp73/QyIzazZTTFfefmaajKzdZE9tU8XMEcV3ZtN
 9oDoItc14FZnTFSg7ypk+f+jwlqQOLfPQlUVhuJ2FHvySkJe3N2sjZyWE3kVZiLnMorARYymD31
 1gJ/eeYboPE/o/OsthZ8VQ2lf5lcz6LCEI0Cfewg8CKOsQ8i09CTqFsnGBscdXQXU03/xJBc++Q
 ApWRMz8zUpnAgdyqg1NvZ/iY7tpzdN/5MF9ScyDlBKwEzcEApndvuoZn75ue3MvcO7HJzhPgyz4
 EyJwqkxBUcP1uj9UNLBx634wKVxq26XvUK0ndhDtA3TpDRVn14aQ7G8FiXlgJcQ8ekQLrM7GMaB
 PKpIPrdbDaLVg7rhKrw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_02,2026-08-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 adultscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 phishscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240069

On 26-08-21 21:38:54, Hardeep Sharma wrote:
> Kuno, a 32-bit ARM Cortex-A7 Qualcomm SoC, uses the GENI-based QUP
> wrapper for its debug UART. Drop the explicit ARM64 dependency so the
> driver can be selected on 32-bit ARM as well; QCOM_GENI_SE already sits
> under the QCOM_SOC menuconfig, which is gated by ARCH_QCOM ||
> COMPILE_TEST, so no replacement dependency is needed.
> 
> Acked-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
> Signed-off-by: Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
