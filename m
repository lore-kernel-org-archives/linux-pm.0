Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AD654446E9
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 10:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788344912; cv=none; b=ocGqxMpvX5LPdKF32jD5oYyF8szNKOEQjzshdff4s9TcbWtCXctFSNHPHcDMQpzQDjb31mYxWQh4HBMC8aMGtxEmAGLhmeqIYU6aSjcWsREojrUnb8hwgYVSlSI06sOYxOrwpVxOzEPdt1BYydjhQLFviLcrRam8lAqgGHkLAas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788344912; c=relaxed/simple;
	bh=pD72Y1Gd5KDdelVx2ox+ICyyydV8QNZgHYJuoes44AU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jekARtlrvhcjUuVA21/c3mPWBhNdpWpGBcYi1hihVYnoWOX4zTZHyXiF5MuCe2CcWxaLSsnhXp3BNmh98hvhTQdd8jYvMMuTsE7rC0P/ezuuWsHZEDAqUJ0FMvFSAbk7/mJMzO5kKkkm/mHskMiACCxTfEgY2lovLB0ZJcW9dRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=fgIObG4I; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JVCfbSEO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="fgIObG4I";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JVCfbSEO"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829NHAm1239409
	for <linux-pm@vger.kernel.org>; Wed, 2 Sep 2026 10:28:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4sS/8auj7XVVOCiV9ipoVmQuGPplhEaUoIns8k/ZjJE=; b=fgIObG4IJ1k7QrEU
	cP74toYep4HOEcUyq/X3sRPm5E5t8BC5srdwxYeufvGKj+oGDKG0Drz9yihHXglU
	tn9+NpBvNcupikKBGNB0Xl5CrsVKbsjdAbAd1uSdI61gr04hycB2nlzuIwoI3IS9
	ngw1+ZW1Bn5gQDLl4rrd44GhsQtz/Bng8/1iuv7byRIxqQKwWtBi9GrPCLz5sVn1
	FZetGGtmYn2HixLNJ8C8wfRKHgtbBuahn4RTTQ5g2x3blVWDvqx/ONFcZPysH+pa
	Teqh+rh9ndeVmNOy1cyBPwT1zyd63mQ5ymV6qA0umK1ut7eai6p1WTqnhyYIXVZh
	AAS4VQ==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ge38w3cmp-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 10:28:28 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-53000c06184so23556261cf.3
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 03:28:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788344908; x=1788949708; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=4sS/8auj7XVVOCiV9ipoVmQuGPplhEaUoIns8k/ZjJE=;
        b=JVCfbSEOupSJqIFrPVsJYcU+Qxa65g+PAV3Y2/KqB4yqaqRH1kk2msm/1blnK9g4JA
         C56gb7sp6TKgp0kJk6kzpXnNVFLdqBmJmfzAiCX9qU8dXw7HJ9C8l+p3cuS9ctRdkkSX
         SboO9zKhXAkXOq6u2zg17m07lsl7ebhu1oypSjwrBsyCLvx50UOWPlkE2WpFzkbuAiZH
         x6jD6TuAEKGjuv2H32EBnFJVh9ys6gLaEH7LEizLxlajjncMa/721Acevza+7a6ZzDSS
         Szn7fvDeIVdV3bIarOx3OPfvnJ9PnpZgeX3I3b6lvdzqtJtvIFBFUEn603nYHTZOeBmI
         +dQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788344908; x=1788949708;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4sS/8auj7XVVOCiV9ipoVmQuGPplhEaUoIns8k/ZjJE=;
        b=BUivm+x5uFwaj7IzrEAOKra+b+u0AFU5xIP2kLhzbfK8/M/+XQIjkZLzqSPyuNgROV
         v0/Bu6olJfeohYMy3K/6VCo+AMuUO/B3A6Xg4ocRn8e7m81Yw41gMFCPTZJjKp6Xcwyi
         iTTpuW0S9IvXuYJWyYW4lHZkwKYq+4fmRdxAxfdqvVVgUaqebB5Jl7CprUoZL6z+rYJS
         vQLxJbux5pGC1qHDRScrA7AonFvrXf3hXQIs42uvZpjkEef2jmxb7hVBuiJ5IKMoBKAR
         qmhhIk08qRNfJejIY05CNoOh49zX2Ty+sScWJ/TzhOMFWmMKoT19nQeGm/JL3mgMI30r
         y58w==
X-Forwarded-Encrypted: i=1; AHgh+RqXmhSCr4XunbnGjDuJ8znfyTjiN2QHG6+qKj1ccH4LvDe5CQUIbhc74smKRIj0kwwRMF0i9i5qcQ==@vger.kernel.org
X-Gm-Message-State: AFuF++nOdNlQSfB9VyqsB6sCWcyAcYFBQb3TENTgY1rRDP0KrjxVWNak
	wSrqTQ189OKxRnDHGivvUpvZ5BJrO8SZbkpOqPkihZTl4d5yWnxP0aWcwqT5Nl+LYMRTJnhNJr7
	LfoGEcBRUYwiCnFX0Fgc8MPtuu0Qo0t6RlFVeee6ig4zO5aVM8wseV8Us214Flw==
X-Gm-Gg: AR+sD10oVnWAXd6Rfy0fzmYp5u6f6JZrmr0spZfV/jeiZM+eQAlJ6MobZEYlWTPXvGB
	rJRnZOYdHezrEdtnS4EQ9ydiVTaaou5t1GcUxL3bvbAGJekou1PIUvvd5PQxGEVe1A90+4qmiZN
	MuNwWz0csSECzUkIS7BEalOWz28fxnot+u6JH/1rfczuS35+Nwp9oPemR1NRl4p6Pp2NahgLzx3
	0ts6L1+iexCqJAVHmPeNOto65K8zw3cpgMPBxUQdvMNP1rAM4fNc9eUOyLhfiBijJlI891gFVME
	SbX9FBgDOgN53EHK0jriH3gdC/XdOAg5oHcL4QTQ0D2EVAUNDEkZIv1Ww3yzSEXixL2sTq+T5Tp
	W2Y8IX+cAiWBSwIhPhx3KiKjy7xA=
X-Received: by 2002:a05:620a:4014:b0:915:e9c3:f1a0 with SMTP id af79cd13be357-93960e2b771mr416386585a.12.1788344907974;
        Wed, 02 Sep 2026 03:28:27 -0700 (PDT)
X-Received: by 2002:a05:620a:4014:b0:915:e9c3:f1a0 with SMTP id af79cd13be357-93960e2b771mr416381585a.12.1788344907613;
        Wed, 02 Sep 2026 03:28:27 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:b759:bed7:f8b6:ccad])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48448eeabbfsm5202660f8f.31.2026.09.02.03.28.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 03:28:26 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bjorn Andersson <andersson@kernel.org>,
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
        Hardeep Sharma <hardeep.sharma@oss.qualcomm.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>,
        Abel Vesa <abel.vesa@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: Re: (subset) [PATCH v5 00/15] Add initial support for Qualcomm Kuno SoC
Date: Wed,  2 Sep 2026 12:28:24 +0200
Message-ID: <178834482169.13446.5654514434501289508.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
References: <20260827-kuno-soc-support-v5-0-6d47636a8f09@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: 5bWiAZ7o5kXTA1BTekWb1Ck2-s3i4h-M
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA5MiBTYWx0ZWRfXz2H7dVBC27mP
 Czt3CwrXMkBEjz0WE/P/OpAIQlXMlaDUoK/h8Kf0D5fGORw6Nk2Dk/dvvDLbtwDgEogjt+IGZ8I
 YAJePVRvtvj2SMOBZ+/7lTXDeh7O48g=
X-Authority-Analysis: v=2.4 cv=LOpWhpW9 c=1 sm=1 tr=0 ts=6a97fa4c cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=dNNRhoiiR9TqZAOi20EA:9 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-GUID: 5bWiAZ7o5kXTA1BTekWb1Ck2-s3i4h-M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA5MiBTYWx0ZWRfX9xJY/CJrO1Zn
 z2WqLEik2KxDIo1OdM+yoCkHclYp1kke7hxIqDnwGty7dGnHdRgqftqClyamopBv98VvBhATK52
 nfj793sNm50LZpzG+WWeFRAZNQV3OX5bG4kPqai1phEOa9M2v4N5CUZBmM6slWorMqN6D6E3Pe1
 1lvhv/oivIzXyg6hQecCitG87jSQyi2pvThG5g6tgancUJ1GOggiEzJUa6cbc5rbWGnhLKNwyKV
 5gxfopePp7vvWEQTyTeX0M2k5kKQOVgJZCIVzCJHhJdj7hKiDf1+dtn6YdaHEwcnxN67CiQQTyJ
 gnyDqQuTpoiAECSb7xi6Xzih0UwRoCYouwuEcw0WdEIt+PKiMZVuACjt1ho61aD7S/Meb30vcXr
 snX+ZKXMnGT3nWnznwy+YtkZbNSm6qO/aMp+LdgQLoW1dAEAWdrpkSL7ZH/cqmkPkJuJdmF4X7u
 3Jpmr6OcmN9uoXcDpSA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 clxscore=1015 impostorscore=0 bulkscore=0 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020092


On Thu, 27 Aug 2026 23:21:03 +0530, Hardeep Sharma wrote:
> This series adds initial support for the Qualcomm Kuno SoC and the Kuno
> IDP reference board.
> 
> Kuno is a 32-bit ARM (Cortex-A7) Qualcomm platform. This series brings up
> the essential SoC infrastructure required to boot to a serial console:
> 
>   - Global Clock Controller (GCC) and RPMh clock controller
>   - RPMh power domains
>   - Interconnect (NoC) provider
>   - TLMM pin controller
>   - PDC interrupt controller and SCM firmware interface
>   - Devicetree for the SoC and the Kuno IDP board
> 
> [...]

Applied, thanks!

[08/15] dt-bindings: pinctrl: qcom: Add Kuno TLMM
        https://git.kernel.org/brgl/c/7d65a9c8fa31e04f41bec15fc4a4f51e207d2aba
[09/15] pinctrl: qcom: Add Kuno pinctrl driver
        https://git.kernel.org/brgl/c/d0344c6510d050ee79c6aa3997f2c641168ebf08

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
