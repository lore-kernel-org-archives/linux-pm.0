Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.168.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792660200;
	b=kGdRqaJcYTYY4PCnyQ+P5fAuMYuF90WKiOTxM2QRl27wptsC/nFXQfcKJvy5Tom8M+GC
	 5v0kBZ2rEXsXQx+GFHOzcKIYy9ISYTmDAyYmbqRgULUZZUIK0mNKiJY3qM8hqIjLlpZBk
	 vE3sCCHn29XB9N3WMAOd78NzDNXZp9aK8S2FC6UDC5eAVVs0fF7/g5C+N5ZcFXsqyitu+
	 psiVmJwzQXVEANX1eQqO5SUMldTelsrFMHfBJ6TNq+H9CN+/hBFscMOepZrhR1H91pk2o
	 r/zE/zovoMx1+ToQ6IfM6MFU7HFpKZoFiLgUNDVyF6bmDzIEhbdIrSza2sLFp9NXUzg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792660200;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Gm-Message-State:X-Gm-Gg:
	 X-Received:X-Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-GUID:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=MuprgGBEIk8/OmsFZVmehe89ddAzvU7HKkgdbnCsQyI=;
	b=Ec4Nb7fF2WYTnBroiM10Z3rd8kPTKFAKEWEmyRDdwYQ6cczOjbDYfWViW7WkQqV00aL8
	 PPqHL30QxQlDLB9XaawGpZUlen1L7zhTKjdiMCPVbJ0AhGSoCEl3NxpMrVIqisCVARNZl
	 ac0o8U6rnqHR7O5PHc82MSEebzGUH7N8h9G18LpckYlgI4CU05xbdcNlb43SfiNdtAxgT
	 bWNsRdA6G3aL/dUzy8w7bGNo7m8wh5NFPCkmpJeqA6De2mzI6y/d1hTELlJj9E9vvLKqx
	 Byv7guMsWhyUhJOmtcm91DsMN0U0lvfwP+0kIWTqYxPfRduWEgGK9f/xxv2y42XmcbQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cokJDPuq;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b="RJCm/ytu";
	arc=none smtp.remote-ip=205.220.168.131
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8D5E606A32F
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 09:09:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B8D5E606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=cokJDPuq;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RJCm/ytu
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69M708Yk1561484
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 09:09:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	MuprgGBEIk8/OmsFZVmehe89ddAzvU7HKkgdbnCsQyI=; b=cokJDPuqF+Vy0B54
	oofPLXV1SNCp2af/gPNdNs16tsHZSPlzLzk5vR7WPz6H9IFjTpTID3B+LBfPvt01
	YB+iCNeeQYoywYV1hO08RgGendxYh698aDt3sXVqlOZhfcKx+TclNwxLk4GRY38L
	4bOvopEKuswG00Gm3ayQ8MIp8/si5626dbbV+dASRCQrPzPegiyKymUXKeiYb9wI
	hiN0SPAoojQo8BZk0tAsl3YVsMWMxxIRIxbHiC8vJci80SYPC9g7UKQ5N79gz73b
	qQdR3SIOS0oL4W7zbueaR9ArbM06lBh5dMEerFjQlyWMHzJQNwtcAVLa82L29A0I
	/jc80Q==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93ahn73-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 09:09:58 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-93df7a9466bso18272885a.2
        for <linux-pm@vger.kernel.org>; Thu, 22 Oct 2026 02:09:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1792660198; x=1793264998; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MuprgGBEIk8/OmsFZVmehe89ddAzvU7HKkgdbnCsQyI=;
        b=RJCm/ytuCwgsjLgToibkZVvgT5eseFiQ9DtpCotzXIWhu0av5GyvP9yTE+ggQ7XL0D
         cX4pLiABHInNMJ3s1g/clL8ZfttxKURkTVoobzFieCeG9n9jNGd3tkweWSJ15ozCpcrV
         EaVZ/e+a8Zl+UWtg+ZXquAbNAHv+mF06f/x2LclgHHtIircb2oraiy2B2QTRjjkf0VNu
         KDgV2/Mdo5eVkMpa8fZuQLfImv0EeD/SWS6H8RxqApDR5EJIGgvLaGKy/EjA+dN8/oXx
         T3dGOZJyDHHJKdlznnaYn0YrxO9HCQrtt0rkdVJ4u538ulwVMs9WQ/xnel4EUOuOkI61
         7yqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792660198; x=1793264998;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MuprgGBEIk8/OmsFZVmehe89ddAzvU7HKkgdbnCsQyI=;
        b=2Itr3Cycf5Zh8t2msZhpKYI22eb6aITdVn/OeysLAeUdXlGVIAwFwsosWiCWpA/SzP
         ZhT510jAR5AAbCwqTOOZ8/cTKjLDtXwdQURvB3fK+5yz8zmGc5gQ/VDozphj8D9fGD8K
         zSj04PRNIOoclB+H5NykDrWueMjHEpVi+eInLn2Ow4+lwhQOzXBztmvIt1g1WThThNsz
         Uy+b/MVTSoNoySwfvFl2eIU2gNhsGDYJANwZDZahIdCR7aW1m5AyNxq5nfwMLTIDp9aO
         dQD9sjahjfLg5owvuYLYggiiuWWY7cVxuHEv+JLB6uSJ3CyNNhycV0OUnDeq+AyEz5f9
         SkzQ==
X-Gm-Message-State: AFq9FYLZzzBQTYMwAiN0Sr0biXe0DgFZRyR8PyGG3wcEnE37eBUZL9Rr
	ZEb9SseLOZ2tYquizwEMcpYp3KWO2WXz4nqAv+oPWDixTL5MVUQagDLfxpSIEx0ZAFbu05MK8Ej
	IoFgyf5NWvKS5qFvhN10LUXRDD5ikN5gHT+6dU0sfNzwnq0vkoPH8f4B0+l9NTA==
X-Gm-Gg: AYBFou1NT7nPt0xSz967CQFHC0H/UT14EcUQAjLlBU3xP8Bmpa915cmqtjszcK+pxAa
	cUpOo76sxRAhBkX9TVi5L2P5bndRZ1B2HSwhSkNm6SA56VijpsMrm++FajIqlY2r/Yl+FyO5dLd
	JTEUzX2vDjEX3dbD1ntjx5r5c6UdshfAdJF3RReOlNik6DFlIR8ajz9dA/diyTR7B2grzCFUGL5
	6dU1T6VNN9h7gcHmUDZaWP31WATChxagnpie0S98W6wJi28uu+nmn8/KiReIQGJr4GGXCY6JwTu
	erBhS/y+0KUu2YkRf8NjDa4eWQRMSA/89tlm1tI3+qVQrXLatnB+6nlbK1wd3Bui3C2ZP/8+1tt
	mStAtX51aVeNx5wZfng+Fdw==
X-Received: by 2002:a05:620a:4511:b0:93e:6d87:4f69 with SMTP id af79cd13be357-93f57f3bf10mr985406185a.3.1792660198002;
        Thu, 22 Oct 2026 02:09:58 -0700 (PDT)
X-Received: by 2002:a05:620a:4511:b0:93e:6d87:4f69 with SMTP id af79cd13be357-93f57f3bf10mr985403385a.3.1792660197581;
        Thu, 22 Oct 2026 02:09:57 -0700 (PDT)
Received: from [192.168.226.26] ([178.235.128.140])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c468a55ccabsm82839466b.33.2026.10.22.02.09.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Oct 2026 02:09:56 -0700 (PDT)
Message-ID: <9800eb77-0188-4b16-a672-adb7ee1a603c@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 11:09:53 +0200
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
Subject: Re: [PATCH 5/6] arm64: dts: qcom: kodiak: use thermal hw-bin trips
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Randy Dunlap
 <rdunlap@infradead.org>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Abel Vesa <abelvesa@kernel.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>
References: <20261002-thermal_bin-v1-0-5a29be7e8ec5@oss.qualcomm.com>
 <20261002-thermal_bin-v1-5-5a29be7e8ec5@oss.qualcomm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20261002-thermal_bin-v1-5-5a29be7e8ec5@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfXwwA12ScCs4Ao
 y+Xa4pnxEwfjUwohZh6D5gLEFfwiARp1JvGLq2ELmcz4wnAJVZPGU+hXA3JsGqkx7eUMsXiJ9XE
 CBsYOFRaX1oNrWZwMjDzJPbDbSus8orEzf1Fizt6QUGae9XrsqY4cwTaOa1OeMPcQz24X9tLAVz
 aCzKnCVAcF+ez4rJU2IE5UfnIR8nSsUVeJfndP573yvEqqc64FcvgGbsUyjJxWgVUeLgwdEDfG+
 NtR34sidvGVnGzQkzNO1xYsW99VllR60uUgtaM/ksG13XSWUvETaGduwJ09zExe4PYXphjYdwom
 XgaEzsuIN+jWAcVgO+pELqHF/qNa6xTlOZE04cQ6R9ljc2yjIfimeVfakFpN5J4e9rTY7/n1WJu
 yHTxPnv6hd5qdov9knfPnZqlYv37qbNEjroI7dAB1bY7KS4PqfelhNhIrP5DXxJ7vMMQJ/1K0WC
 NZ09xRl++wahjlpVYXQ==
X-Proofpoint-GUID: Mw8J75oPD4IpBOwvylZ_4gSF5i41zlwK
X-Authority-Analysis: v=2.4 cv=feg4WEQF c=1 sm=1 tr=0 ts=6ad9d2e7 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=PRfkaYvzSr8QmIIGAkY2Sg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=pjWewQ9WiOT9jlYbxO0A:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: Mw8J75oPD4IpBOwvylZ_4gSF5i41zlwK
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDAzNiBTYWx0ZWRfX0r9Z3YbRADbF
 TcQtAPo8dTROmBmUhjGZfaOyk6vVk+UChWY1NVMjPLXKM/K/tsNh9hgch5TQZWDdUlHjFKV59dN
 pVLriQVcXeaGrWtxsms727ilGPk2HkY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0 suspectscore=0
 spamscore=0 adultscore=0 priorityscore=1501 malwarescore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220036

On 10/2/26 12:47 PM, Gaurav Kohli wrote:
> From: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
> 
> kodiak-based SoCs are binned at manufacturing time, with the bin
> computed from the jtag-id and feat-id qfprom fuses.  The tsens driver
> now reads these and feeds the resulting bin to the thermal core, which
> selects per-bin trip temperatures.
> 
> Add the jtag-id and feat-id nvmem cells to the tsens nodes and convert
> the passive mitigation trip points from a fixed 95C to per-bin values
> (95C for bin 0x1, 105C for bin 0x2) using the new
> temperature-bin/thermal-hw-bin properties.
> 
> Signed-off-by: Amit Kucheria <amit.kucheria@oss.qualcomm.com>
> Co-developed-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> ---
>  arch/arm64/boot/dts/qcom/kodiak.dtsi | 56 +++++++++++++++++++++++++++---------
>  1 file changed, 42 insertions(+), 14 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> index 347815e5983e..f3bb9cd8f393 100644
> --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> @@ -1019,6 +1019,16 @@ gpu_speed_bin: gpu-speed-bin@1e9 {
>  				reg = <0x1e9 0x2>;
>  				bits = <5 8>;
>  			};
> +			jtag_id: jtag-id@180 {
> +				reg = <0x180 0x4>;
> +				/* bits = <offset width>: 20 bits at offset 0 */
> +				bits = <0 20>;
> +			};
> +			feat_id: feat-id@180 {
> +				reg = <0x180 0x4>;
> +				/* bits = <offset width>: 8 bits at offset 20 */
> +				bits = <20 8>;
> +			};

Couple nits: please keep a \n between each subnode


[...]

>  				cpu0_alert1: trip-point1 {
> -					temperature = <95000>;
> +					temperature-bin = <95000 105000>;

Please do <foo>, <bar> instead of <foo bar>

Konrad
