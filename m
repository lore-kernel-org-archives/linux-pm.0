Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C7547F793
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 10:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789468041; cv=none; b=B56LZ2DQ5EYjCSvZ52SsBFn2g2PSN59j4C3REDkFXPcZXkTD+MwBXMULmaLIMYBk/8q1EPCgR/ymQUlSJvtNw5+6vGu7IyVzqWcqtq1Yh60CPC+YNrI8k+n37vkyWlv9WoKe8XgWlrFNastUhYirNHD8UVcpvJM+YJ7f+QOYJ5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789468041; c=relaxed/simple;
	bh=ckBmQCsGl4i0H5swMQltGNEvLAQ4QNaTpkBEqzAPUS8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eoqJs9vOxPKKZGEX2SKlLTq8YEFily4RshXt7L3MoaqNqwVogkSLYd9VOkrm38t1rQC3GczgjnY1WuG41IjN7nvrcgfSWDKUKklTo71obx7Wgz5Xyt/IkvZ+CAPuzP2pM5yWOP+OXjA92DTK18nHF/HhnpmAIocxJkYQ6xkCgPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=bIwOYd+J; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=Dgr8ZzV9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="bIwOYd+J";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="Dgr8ZzV9"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68F9hMIR2675157
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 10:27:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	4B5u4XhHsQDHFwAeN8RPYZsJq7AgzxHPXAAIftTImPI=; b=bIwOYd+JYKFSCYrP
	nCi/eAq75tXkFs1ZYz/8MAhCy2Nx5mfuB+SFhJqYWAdqO5Ki8XFzECuVfSnWzAuL
	4thiNLSTzeKsrQH8W8M7dEv7sk3jh/6jCBbsThaG7649O4nEo4YKTFQMFhfbymVa
	5/Ra+rKB114Ves5BkmJ3Yct/+R9zfzlYATVK366v4VWegslqrg2Cxj3wA/GeutJ+
	ZWlEWlB1EpGpqgJqPR2SIE7wQw3G1l8luRBwF010kkya2wbCAhYUVOKD4FWDU7b6
	TfjVDwIpn5KdQCHsae/OHIlHaGMvkewseomzIlAx7Aykto9YgL2jjaR+TswQDBU6
	VQ6W7A==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gpye71apr-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 10:27:18 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-939f27c80a3so852440385a.1
        for <linux-pm@vger.kernel.org>; Tue, 15 Sep 2026 03:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1789468038; x=1790072838; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=4B5u4XhHsQDHFwAeN8RPYZsJq7AgzxHPXAAIftTImPI=;
        b=Dgr8ZzV9IetsU7R6a0WNXXHJDLFPNuXUf56hqinufKd7Fj4bQVaUqhkxKqaKeeDwm8
         D7s7zM36Md/1AicCh5XM8rMd/9T5Te7bEaZ+Alyt+q78jXxzoB7acYu3mbdHsS7C2afO
         ru5P9Cv83lFl/6rSk5ARQhX53sUt7XUURFPgKHuwcu81g4hyp0aOgmS5ynw4h3fKRSTq
         zE7VGBu6crmGGIioOfhQj0fYuhb/737VEBgxke+fDqzpxfvtrPt1eokvCsB3GyfJKKwo
         E2p5iT7VY2KjNqP42umKhYHIKBp3CAsWGHZbJZ0BVwWwSd974eVZaS4hOFiElzqcoc+g
         900A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789468038; x=1790072838;
        h=content-transfer-encoding:content-type:in-reply-to:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4B5u4XhHsQDHFwAeN8RPYZsJq7AgzxHPXAAIftTImPI=;
        b=xJuQj28K8ZWh5ULRPityi0TP8jLUyTIFYjI2KlGNtWcygjE9rxSmEUKHPd845mG+o1
         X3c+vZ43pGoZJv35ToQgKjBsxRW+bBKv4SbP1jIkiDWO9vDu47e94daCGCTTYP+rz/nB
         gVB+Aeqs2EO2H5BSTeTbtc00TVF/NPw+UuQf14f4iuNqxoqZQ4Jl+d4Wv0b61OoDKnYE
         brbsj0xHJZw3kHu75SBGuiK52ykLQJWwS4k72A8XQW4YpJi0r1bP6p0MLJIX/9ndLuxg
         5+yqFjf71yx4B0Gk2aIPwLbZvjeaykmr9IUtCLOle8u649RDTcgbKZ3G1B3SaQ5HnZjw
         +vdg==
X-Forwarded-Encrypted: i=1; AKwUvBwiTwCTWEJi5maGV79iZtIiUTZUuO2Ff7GCf30OjoUnJgsuzfwAyb3cURh1GUOLvSPgXetuWmO3Uw==@vger.kernel.org
X-Gm-Message-State: AFuF++n3hSRilZpRI6i8gyP6VwAEoPbm+M5F7Zun/gQnKDonxbu+L2mu
	jwh3c/i3dCGGhVGAPDpVlb9CanIQIYmKwVi247DUyvyFwVUBm02oq8fzW194GQXOzn7cmqtl5ul
	kJy3t5wUWwXJs7e66zBMJhlhtdQOTcbCKoW84+PFcJd+YrpuYnm62SLPgHXSLQQ==
X-Gm-Gg: AYBFou0ykA7w+Y2Outl0AJk/Q/2brcywc9heVJUzFI4RLibERso7a0pOR48CcFZnSWE
	5oYxUyhzEA5ToHinjG/EuIu3aaAAzXT0M4bEKXJMc3UIYolMrR2x0EBFSNi6Gj0bHjjV8Ic6Tv5
	Fzv+RI0p88p6Z1AugEiR1a3dODcrGMXVfFl7//5BEf9k8wpY9IYGfmw8UsuEUtzTc5+5WmtPIQP
	mxR6DRzYGV76Tq3WT1nzo1MUUuAW8agS52koJMVW2+cw0X+JWvLpKlONalga1ReE0HK9Cm/4tSK
	fQqXZWyojWQH9t8D3PCfIgl2GxDUz/04UcAdvBTvd+dbVAiq0ZZYeBv+em7KaseSe04cdslaUL3
	HMDzO9rRCMT1dcJ33K/YzrnerM88nQJvLJB4ikoM1bFq93lKvuIPu9fSM1/cYtpo=
X-Received: by 2002:a05:620a:2955:b0:939:8bfc:471a with SMTP id af79cd13be357-93a29bb4ca4mr921801985a.49.1789468037815;
        Tue, 15 Sep 2026 03:27:17 -0700 (PDT)
X-Received: by 2002:a05:620a:2955:b0:939:8bfc:471a with SMTP id af79cd13be357-93a29bb4ca4mr921797285a.49.1789468037445;
        Tue, 15 Sep 2026 03:27:17 -0700 (PDT)
Received: from [192.168.10.107] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e7d6b6261sm71836915e9.14.2026.09.15.03.27.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Sep 2026 03:27:16 -0700 (PDT)
Message-ID: <0bef7837-9fd7-4401-b6cf-ba744f5beb58@oss.qualcomm.com>
Date: Tue, 15 Sep 2026 12:27:15 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 2/9] soc: qcom: Add QMI TMD support for remote thermal
 mitigation
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
 <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Konrad Dybcio <konradybcio@kernel.org>,
        "Rafael J. Wysocki"
 <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        Manivannan Sadhasivam <mani@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-hardening@vger.kernel.org,
        manaf.pallikunhi@oss.qualcomm.com,
        Casey Connolly <casey.connolly@linaro.org>
References: <20260809-b4-qmi-tmd-v8-0-b15d47adc379@oss.qualcomm.com>
 <20260809-b4-qmi-tmd-v8-2-b15d47adc379@oss.qualcomm.com>
Content-Language: en-US
From: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
In-Reply-To: <20260809-b4-qmi-tmd-v8-2-b15d47adc379@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE1MDE1MCBTYWx0ZWRfX6+faa1qTlNzZ
 b0JjsKpRxhubUse4SJorU0gz6Q/6ZWLuHnmJnYRgslwIUw2a7hErogrlmjUJ463rlL+n9ZeJI3o
 1iVnfqUenumW5en3QPUWb9siSYMOVpLuYlGXREj0aqFoK1tX4IHOGbSLLHLvfmIlW5c/PhUDmrV
 AueG3Loyp8U02dNYEjcLfM+VULDMQG6okJ4mpm2ldgo1a5D0/vgDkYVeLjQVe2o4XkudKVGUTe3
 AuP+KhU/KXPj1lwtnKVkshzQrtgf0vPN3hh5bvpK2zYNgDB1nCq5B6/D185g/8V4dasrQaLmdZ0
 M8qs6G76fHz8o0lu06AsnMOef6VJw23DfIG5l0DP31ETQe0sMkKb6DEUAZkWd/8yzwcswKTYXqj
 bRiy7KD+NSZTRM5LtbWGiypZxwyf3/dXGnyn7KImt99itk5CGvNraq8eSdRchuEpYWLfmI1+nbk
 EJPs4a0+bfdHwO3OL3g==
X-Proofpoint-GUID: Z7H59OGGQkVxoxN7VTIgquNGWi2DKga_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE1MDE1MCBTYWx0ZWRfX4wgyHAhEY1Qh
 7MzbfpCBgSdeUdjwDCj+PnEx06gr+iJ97pQIs+9vGwyEzCEtq3Osz9CxxR8ZQnCiItOZDSug/GA
 3rUzjW5+Q14oc0BK69bfm3Q0hK1mrqk=
X-Authority-Analysis: v=2.4 cv=fck4WEQF c=1 sm=1 tr=0 ts=6aa91d86 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=uw/3876vWhRnNVL35W6mqQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=Zce52TE6RWQhZkoPOn4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Z7H59OGGQkVxoxN7VTIgquNGWi2DKga_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-15_03,2026-09-14_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 bulkscore=0 malwarescore=0 phishscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609150150



Le 09/08/2026 à 14:28, Gaurav Kohli a écrit :
> From: Casey Connolly <casey.connolly@linaro.org>
> 
> Add support for Qualcomm Messaging Interface (QMI) based Thermal Mitigation
> Device (TMD) cooling devices provided by remote subsystems.
> 
> On Qualcomm platforms where remote processors expose mitigation controls
> through the TMD QMI service, client drivers need support to discover the
> service, register cooling devices for available mitigation endpoints,
> and forward cooling state updates to remote subsystems.
> 
> Signed-off-by: Casey Connolly <casey.connolly@linaro.org>
> Co-developed-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Co-developed-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Just to clarify I deeply reviewed this patch and made some changes to 
improve the code. That is the reason why there is a co-dev-b tag but not 
a r-b tag

[ ... ]
