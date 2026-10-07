Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A67A3BB664
	for <linux-pm@vger.kernel.org>; Wed,  7 Oct 2026 14:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791383794; cv=none; b=Ee+q9c9DVciyeRfszgFip2citjHBikQhzlJCN89/c7Ec0gXBGLf7BZ8oOvrPBRrhouAPLthkjx3ZRa5U8E7k+0NSGbiWCcsR/a9/trhoHkedmHLA8ppzzLFA5SxsQAtL1asjRC5KtqA2t0GP4WpkQP1lK+yMpuMNZjvCjZ6RWKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791383794; c=relaxed/simple;
	bh=m8BwqGpGaN5NyW0o3YS7MAF/UiHjObuWTcpN8dzIZkE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=htRIKTyxpCRBMMcMVu3dwPNf/cI2btwLV/ead7yAJ2FP/KJCapIVGESdE6HHJPSz925JWArlAAMzHdYIXmtTsx+g7KFH77yBSq1MyIxVvCDRr7E8zDHEFFvbSDlEKp5sOoWb0i6L5hpLemrXAt4M1TOrSigOtIGXDUBOy/FS0i8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=V9uBFNoI; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=YWgvetCK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="V9uBFNoI";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="YWgvetCK"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 697BVIW32802530
	for <linux-pm@vger.kernel.org>; Wed, 7 Oct 2026 14:36:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	2eSGGmhPnLXMyz0ttXDRLcWTAD1FLKpx4rLl3gYv1Bw=; b=V9uBFNoIIsGfBCyr
	IFLJ5olOiamecqFnaLTts2GOhTpHEymNOai/gCB0hvfnx5X1eH3dyD3O5XSMDqX4
	rj8xP7SSbIOMMjizZBTLGREznScKUA+oY5DUvUk0Rf05jSw1fDZ6MhRC66BY4uDn
	xmWluEYrhkXsMZwDFtv6PBxoB/aEUbhGkH09CAqUdX4KRN3Q0COgzo7dq6hXvOyy
	snYta1slspHwZownxgV0I8NzS/dma/XU2bMZXNzMhJ8qm71OaRliuC8KG/sea2XO
	QpguKd69sA6YzE2r3dNiLN8QpQOLxNWCsZrA8eRvkT3DueXlEIBAfpGYyfcYiKWW
	rOjhcA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5mge0vfh-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 14:36:29 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-91961374299so116338706d6.0
        for <linux-pm@vger.kernel.org>; Wed, 07 Oct 2026 07:36:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1791383788; x=1791988588; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2eSGGmhPnLXMyz0ttXDRLcWTAD1FLKpx4rLl3gYv1Bw=;
        b=YWgvetCKPditUIJhZhzsIC3dV0lo8AIWk/BHIQi2LEKnbn5BjAqtoKd8ld97HIM5WY
         yGynqJTmCA/Lx/YoONBnUgzz7VZ1sWVoQCmmWdoHHEN7jNiqwEVacSn9rYiw3uoZ7QRU
         jNrxN4uf86zgDds9UpBLgfkB+JHUNl+RLntoEaFVUrMUaxUVF3N8ShYOgrIY5BD53gNm
         zRZvxssky9saliyXnhDdzqtqhRKeck9UCoKAnCAOfxozG1AgyZ9BsP1F0sLm8ZvlblWw
         4yxa0wb30BU5lr+DPZB1YHQn4aLPARcnq+FEg8h0dMJ+2MTufd1SjIo0B6PnUfnfqgp1
         338A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791383788; x=1791988588;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2eSGGmhPnLXMyz0ttXDRLcWTAD1FLKpx4rLl3gYv1Bw=;
        b=h34sE6yO6Ejczcdo5rXZIdJG1arNtBpkQObvkpf5c48fbFeouvi0Crs/femudSGtvQ
         oXO49GXi8WmC2irw6ZRRX3SafX2f8ZL46MCCQwNFvp35bzVda/yZTwYN/Oy478OGzvvg
         hMlpCQRIXvIAd+9lolHzTggskG/DZqzeAFMBU5GL2morW2fw/JryKb7T7gRHYCuK/Lzq
         re8uUii9n6FhLnNQu6as6LdaZ0ZElkirrCyd4NXqThy0xJuy5A8A0wh/kRL83wd26SRw
         oZRXYwTnClxkCL5CfZBPv3Qgdfhl5yFPF4Ri3witn3kzqHQ+6xJmib+Wu+oPn9yfCayy
         8l4w==
X-Forwarded-Encrypted: i=1; AKwUvBxtm9SStkaLH0H5OigD4JZUeL7a3apW1E3lM9O7FkrDP1ORb9FHJsGNTI7t4RhzFuiy3/bcbjJUcQ==@vger.kernel.org
X-Gm-Message-State: AFuF++kdjLMkahZYO0hrbHb8Z/F0cs1SI112aPLbyImQN5RdkMYB5D19
	bj9nTrNNyV7bCHpc2ardmlElqj9J2Q+b5+PRgQmSocnYyICqN+bqeEJr8TmPzpXb64dUNsZFxBF
	QI7Xl5dGd3/focv7GLs4lVQSYx6pmZAKiYv9e4ss1QXXOyb9u6qeoPJ0PumdKzw==
X-Gm-Gg: AYBFou3/GxQXvKYdJECVQyiUaGa/m6m//KD3BVMYryO8mb+nnJ9TyGE4XtX2Mcc0uJO
	NQ8wLyHihuZRAXoNVG4TSq8FDqpEhhADXIr3tc9UNewgi1zyUmqFSPD/K3Lh7mSXBtJpvXGakwV
	N7gyflClCyXnHNktS7Yozu7XyCpfW4wHkhzq5BWcuImRpuzGFIMDi+8hEUK3xqDhHBO/U5BfDtk
	6/cjIqkq2aXUBTYVY4YVYyqtm63KHIoy7kNmV4HA45Gwq2lzYhIgOleJS1CMiqz4J3X5xETNBGS
	2OF8sOQ8b3lgQOb/MJx760stL1BhaHwg6bI3ZiuOd7kFk8LlQz7qrFWOxTEpnkUDSqCPI+A3frB
	zYOuOpxo/3bix5ZrvXFF27TR3cLByugePq3iY0RTgfRf8
X-Received: by 2002:a05:620a:454f:b0:93e:9809:270 with SMTP id af79cd13be357-93e9b87478cmr487222785a.72.1791383788433;
        Wed, 07 Oct 2026 07:36:28 -0700 (PDT)
X-Received: by 2002:a05:620a:454f:b0:93e:9809:270 with SMTP id af79cd13be357-93e9b87478cmr487218385a.72.1791383787932;
        Wed, 07 Oct 2026 07:36:27 -0700 (PDT)
Received: from [192.168.2.1] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48c71c0b60fsm5679687f8f.8.2026.10.07.07.36.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Oct 2026 07:36:26 -0700 (PDT)
Message-ID: <5439d103-cfcf-4fa0-ae8b-32417e30ae95@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 16:36:10 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird Beta
Subject: Re: [PATCH v2 0/2] Add bus clock for t7-thermal sensor
To: linux-kernel-dev@aliel.fr, Guillaume La Roque <glaroque@baylibre.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>
Cc: Conor Dooley <conor.dooley@microchip.com>, linux-pm@vger.kernel.org,
        linux-amlogic@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
References: <20260923-fix-t7-thermal-clock-v2-0-bff7a09eb487@aliel.fr>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260923-fix-t7-thermal-clock-v2-0-bff7a09eb487@aliel.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA1OCBTYWx0ZWRfX3tjuyIAUWCdE
 mWunZnR3Y1n/eToinhJ5HaULaA7Dubn5V73NTgffatQyZ0YZ7r8En86M/8qNJ4rnMdCtmt7Hzzf
 0irqfFHJ9Lae9lM3uIrxrpCAhGuPvJE=
X-Proofpoint-GUID: GetJ6gRgZq--6YzSh2MHKHfPHm9QxojC
X-Authority-Analysis: v=2.4 cv=PdJqFShd c=1 sm=1 tr=0 ts=6ac658ed cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=z_e_Sa1Ot6aGCMGJufgA:9 a=QEXdDO2ut3YA:10 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: GetJ6gRgZq--6YzSh2MHKHfPHm9QxojC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA1OCBTYWx0ZWRfXxgslijgE9ZwQ
 JSB8jDtpqffmYlqu1PICyJgzZTFmKWEyBIbf+JgUm8V6GBEPbXGbF8q/6HR0TGWypSLeYA/25hu
 YqhYwASzpepSYDGQMwhkXIkdKdh0PVCdDeq4TXBnxqHkSMDQDUSTx1tolYgaiqYosL2qshnBE+Q
 OmA3SW0/EK5LZrSiUap/s1dCP4/bMFogaxXM7I4/qziK4KOJ4lqYVLprvMuw0BX2PsnC9CAG/V0
 uS3vYpD1MdvCWzsGo07Qy4ZUghbVMDs5JB4QGVM19f0+R+4TavZRXSicoIeUH/TSIW96sf5slHe
 jaExppyQWHe2VunRzgB58BwQdtnsJv0+ja/T9+oEOx+7OsvQzfyqRLJOxg4jX4wJWa/xtLnwgc4
 gEXsLYxM8Z3BlzNAB/NDSIE7J2WyDjQVnwAkl8RlgE9mu1ZHfUjFX4CaGT57mb35uC0fgwVK+qx
 UgjCQ78XSWoJdngN1SQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_04,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 phishscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610070058

On 9/23/26 16:37, Ronald Claveau via B4 Relay wrote:
> The t7 thermal sensor requires a bus clock, gating register access to
> the sensor, in addition to the functional clock that is already
> described and shared between sensors on other Amlogic SoCs.
> 
> This series first extends the devicetree binding to describe this
> second clock, making it mandatory only for the t7-thermal compatible
> so other SoCs are unaffected, then updates the driver to use the
> clk_bulk API instead of a single struct clk, so it can transparently
> handle however many clocks a given compatible declares.
> 
> `dt_binding_check DT_SCHEMA_FILES=amlogic,thermal.yaml` is ok
> 
>    CHKDT   ./Documentation/devicetree/bindings
> warning: python package 'yamllint' not installed, skipping
>    STYLE   ./Documentation/devicetree/bindings
>    DTEX    Documentation/devicetree/bindings/thermal/amlogic,thermal.example.dts
>    DTC [C] Documentation/devicetree/bindings/thermal/amlogic,thermal.example.dtb
> 
> Signed-off-by: Ronald Claveau <linux-kernel-dev@aliel.fr>
> ---
Applied, thanks
