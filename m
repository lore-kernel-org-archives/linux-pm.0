Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792599070;
	b=vZy0fBvN27/8OPmY2PaJeVy5LbLE66KfKyC0xp/DnXaopBBvHNSAjY6mpdT4dqHH1F4E
	 P1VDFV9qeA6KyC5QjXul+dpDtTFxzH+v9Uqd8pIn0SiowYTW9z+a4HwrPWWkn8DDvPr61
	 5avOvCmrc0N0njej0awD1FgiCNaCbVp/J5K1j3ToTP5GWse+qQVwNwxXL2klDaVpVOlVA
	 fnt2D8pKjFKDyi/nN1CYu/DHdhWwHl9c201PjK4j7xBd9d9hmqzgJ43w8Ya8G4oZ7yvWA
	 YnaXTSXiygqUhH85zhGKH7crbhk17E0Jzprf8bvo0OJgYMFHTYM9tcW+ob0WdmNQWxg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792599070;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Proofpoint-ORIG-GUID:X-Authority-Analysis:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=rJfPE0GpFpxw/va8n23Mh9Q3M+SZXvOdoCpzTeiresg=;
	b=U61zSUAWgENAWWGD6/u0nI5q+xe2KkZvi1HPt/DwRJiJqy2WFvJM0EgqKvte8LkxgFcS
	 SsPRlnKaXf1RnqTH3//X/WDeiAi6ZGYulXf3trS4gUTzP5rxu3QXfwzZwC4FXvbnKe1z1
	 gL6MTLiMl9s2d+Xf0L9k/X+GTWFO/R9T4FxhUO51Fs1a9UHB302BJxs545GLhJHFWnGXz
	 qwfic8J2aM0SjXYSKp+pOeFbkSsqTZZT8SjThE5OUVIiUzv0im4g1ITbqBT3sn2x1iNKR
	 c/sD1ewGGpGC4yQLCzh6RCWsnFDUGg+3jTDzYHrdr/w/ln2QFLlMUzDh3/WW4O/3cbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V0ihCasm;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F1l9lRz+;
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD4B606A323
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:11:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1DD4B606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=V0ihCasm;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=F1l9lRz+
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69LFU00v3726130
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:11:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rJfPE0GpFpxw/va8n23Mh9Q3M+SZXvOdoCpzTeiresg=; b=V0ihCasmkW/aMZhU
	sJcKm5nYfBNgtmimC6O7UbcbXBSTyusSedqc2yEm3bxa7yo4kC/bwTzn6LtAiUmu
	AeT1V8nos2qZSefaZ407+Xb57Cqu4fP1LhYtXy0jzYOOiDnTFYP64nFLSJJbZ30f
	gvGmQLRMS8Tu/KcL7unDk5qS76Xgpv4KRncYh6RxVaJLdZ7lmUqxvMp31bI1OCfS
	JZSEOprQ+ZWwAPZFP2PXPW8nvdtSxzSK76NM3OKetaWL4LvJimIjkmk0Z0uSTdfr
	FFAyJzzOm0e7Czj5+SBx9B1KD7CHqZI1VgsqiECI9iEK1vRTB9EWwnjk1gpHNyPt
	CtddPQ==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hesy79yw6-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 16:11:09 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-8a08e315b5cso237133b3a.2
        for <linux-pm@vger.kernel.org>; Wed, 21 Oct 2026 09:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792599069; x=1793203869; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rJfPE0GpFpxw/va8n23Mh9Q3M+SZXvOdoCpzTeiresg=;
        b=F1l9lRz+st+JFp1wukMvXHgwN6aZd/ZBZdwdPeP9xFepSh7WUVfwWv0LH9N7FuiKqN
         zR0p51614FH6rkClZrCyaSSuZHfNQ0oOPrqAzaJq5ouZVRXA2Myoe83fTIe26jEmZzYU
         f5BBfWvzArScGXlfoduJEgUm4kKDK5Er8DjRs5XVBlePR3olBVrJbYMmS/Ak1+h/2K+m
         NzTeycTF6RE6jr6jmYa+Y2zHCIeIB25xpeGplHJfX/wT/UIQxytGG+RA3O36Ub/Fx6PI
         +c09xZZhtSOoWej9srmOmCeUrx+7zfYQJ3fcnvblJCDtmbPcDWNq7aNmWkhX+Pb2huY1
         b/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792599069; x=1793203869;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rJfPE0GpFpxw/va8n23Mh9Q3M+SZXvOdoCpzTeiresg=;
        b=kIRm9YLdhSZIQaZ8CH8PO5IT19StSbSjAeWrmQmO+lGM+oE9gljMTsJ4tQmGs6WDbn
         5Vo2Pvx4NdkFKAsxCTXKGSpo3rK2IWhFO6PAgNEf/5JvMRhw9Vhg/6FL5Hi90DWRjvuV
         DQ2Q8/KcZIYgbdCGXbw18uC9Rvxyn26ZLUmhg2VWaD157F8fqUqAEkf0kfCuMKancUF7
         fTo7iBK6ydEZ87mOh4qMIJW8UnkQOOWPU2rFxU8SuC1ZQn3kB6ZUtLSoB7kEEBHXHwux
         vvEOEHJUZgqynNIqGUadL6+bdHAp7ie+oeTaFMeL9ztfdwo0KHOctZddBsUYCUc+eL+E
         Lcmg==
X-Gm-Message-State: AFq9FYKpK4oWNHmNinO7OBo1QnKhIFcxyBZ/yxqG5x6k8i2KTE5knGk6
	Ritt14pYDuUSr7PgnXqm8skrowOVbKLEzw1XTuXf4KQ7wCma2KLXkE2+/sH8C+zfnAt5bELZv1d
	NY25W2kg3LwJd3H/WFApz2nQaCRG2Sy3Rvo0g5gtTlwNtcioinEd2MaUffkYoOA==
X-Gm-Gg: AYBFou1Zd7XSONL+S597M408p1SHzrgFgF5iVt2q2P4Nyj7yLrFxP9RX4Z1MGqWqq7o
	BLkcWZNMz0vQwmACV8Bzu1Nhts+8zGrscffzrLEwyNgvL+uRolcXQwP8NN1/IC6CgJfLLnEtv/L
	Z3w1+TZkm9cQI/KHu6nHkXKaM/m6seONckTvO5NErTAwPXD2GYac4Fln2rsZf9lk9UgTslYwg2I
	1uuheJnfzXGjoN9QWOy6KlAVp6oZfbtXVPeG+B/K+11SwLjsZrcHN6xXzu/eAUzWMYJRa3E6H/O
	tyVZuD91wbrivP+ryNXx5lATmqEu6SGBbO66d7RU+HAHfyWA4NKjXbWH9fES+iswZCVP0ZsYNBY
	3IgOqy9bTCyBVPxYg2FdWYKUTihO1CEwF8lbNxdPAdCzW
X-Received: by 2002:a05:6a00:1905:b0:8a0:1dab:fd50 with SMTP id d2e1a72fcca58-8a089e1f4dfmr1918096b3a.20.1792599068631;
        Wed, 21 Oct 2026 09:11:08 -0700 (PDT)
X-Received: by 2002:a05:6a00:1905:b0:8a0:1dab:fd50 with SMTP id d2e1a72fcca58-8a089e1f4dfmr1918081b3a.20.1792599068148;
        Wed, 21 Oct 2026 09:11:08 -0700 (PDT)
Received: from [192.168.1.10] ([122.164.81.208])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a0894b484esm1095569b3a.13.2026.10.21.09.11.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Oct 2026 09:11:06 -0700 (PDT)
Message-ID: <a9900595-eed5-4e5b-ae8b-212597601aeb@oss.qualcomm.com>
Date: Wed, 21 Oct 2026 21:41:00 +0530
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] clk: qcom: apss-ipq9650: Add IPQ9650 APSS clock
 controller driver
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Georgi Djakov <djakov@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
        Brian Masney <bmasney+clk@redhat.com>,
        Jerome Brunet <jbrunet+clk@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20261007-ipq9650_apss_clk-v1-0-fd4c2b3cbdea@oss.qualcomm.com>
 <20261007-ipq9650_apss_clk-v1-4-fd4c2b3cbdea@oss.qualcomm.com>
 <fefaa398-7542-486e-8cba-7f875ab021a0@oss.qualcomm.com>
Content-Language: en-US
From: Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>
In-Reply-To: <fefaa398-7542-486e-8cba-7f875ab021a0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: GbzWMGxo7swArppznoneFig2R-5Sb683
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX1ZEbqJj4l4bZ
 /t03AfZ4Syza98ECg8hF82KzX1Gv+nsmjHxD3L8+EMxHy2GAdf8ghcm3wIC6bH6pNBfDFiyG3mm
 7Xyun5ciO45ejz/8qFGaHMy7foZrUvnXsbXFcdthsaiXOQ6KAiCGPlt9orIRo/Z8Ur5goU/W4yj
 3uKqkVzxkCRhqnL8704QF3KoCgIInyOiUp4g62k4pMxCVZyQlkrItENIH2Labc49ZuW7gmBXhda
 FMsGFDwarSNl24rWGzPZ5mx+R6nBw5wedOe+HVktl61093Ah3dILbNpjb8biFYm+6vtWyVfa9r7
 4Zg5l2mHMgKhXWo5x/QAqWemNPg7NjzMoj5HELlzW2LEUl8oz1gKlmZ3/infP2PxUYfs364ZpFF
 k9fvnen7HiVmN2xEFWbxpJVXTwPiYrUGj87YgmJB+3knattIWC1vmpDycTGB+HkvYCFc9ErGYCo
 Tq3vgnjDZt6evtQpx4g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDA2NCBTYWx0ZWRfX1WiXy3Zp/o1B
 S63yfp9R4MC5H/wbgooCchD3GJ+EO8EELHh4Ym9X+iaXsvaf2k8ZQSsVGuq7KeuEXru0/qMJBnk
 R+yA5LXY3adz+V3id+um/+jyLYQmsGU=
X-Proofpoint-ORIG-GUID: GbzWMGxo7swArppznoneFig2R-5Sb683
X-Authority-Analysis: v=2.4 cv=IPaXmQvG c=1 sm=1 tr=0 ts=6ad8e41d cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=rZLzW5DhxuwyX7/NBrPT8g==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=OgLFbhcrQp8kNKIItaQA:9 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-21_04,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 phishscore=0 lowpriorityscore=0 suspectscore=0
 impostorscore=0 spamscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610210064


On 10/16/2026 7:22 PM, Konrad Dybcio wrote:
> On 10/7/26 8:50 AM, Kathiravan Thirumoorthy wrote:
>> The APSS clock controller on IPQ9650 provides the CPU and L3 clocks.
>> The four Cortex-A55 cores (silver), the Cortex-A78 core (gold) and the
>> L3 are each clocked by their own Zonda PLL. Each clock is selected
>> through a glitch-free mux (GFM) whose parents are XO, GPLL0 and the
>> corresponding PLL. The gold mux can also select the PLL's post-divider
> [...]
>
>> +static struct clk_branch apss_silver_core_clk = {
>> +	.halt_reg = 0x8c,
>> +	.clkr = {
>> +		.enable_reg = 0x8c,
>> +		.enable_mask = BIT(0),
>> +		.hw.init = &(struct clk_init_data) {
>> +			.name = "apss_silver_clk",
>> +			.parent_hws = (const struct clk_hw*[]) {
>> +				&silver_apss_pll_gfmux.hw,
>> +			},
>> +			.num_parents = 1,
>> +			.flags = CLK_SET_RATE_PARENT | CLK_IS_CRITICAL,
> Do the clocks have to be enabled even if the CPUs are offline?

Yes. The bootloader leaves these clocks enabled. Marking them with 
CLK_IS_CRITICAL prevents clk_disable_unused() from gating the CPU and L3 
clocks and hanging the system during boot.

>
> Konrad
