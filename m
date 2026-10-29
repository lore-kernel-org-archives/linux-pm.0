Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=205.220.180.131
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793269471;
	b=whkJiAfHSgW8LMgZ4zJXiCOZnNSQIADlYV+/Morziio/OTkgYgfJldnyFJyppfj+xuE7
	 XUOkgeojzQ/9zzD1XxEq/lF6WQOkNkAkXx/bEIWa+BqyV2A5/TRnb4jSB7CwiW8ZQbkQC
	 J55vByZu1/ZNPWh9iR14h28mE/CNmV6c1yyjT346T8iHGoedOnO05p/pTxq5RtJN2sjZ7
	 eL+yBDIigIhRIVVe2YZ2bhJG0zoztTJTXea9WyUrRTceKo51/nPzgrijNaFoBLLF5yyTn
	 08XuPtv/KcXotC0kV7Ol9GJ46zF0vl5oLVgL+N4phrc22RTtrHjSlW6guN/i0Nd/oFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793269471;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:
	 DKIM-Signature:X-Google-DKIM-Signature:X-Forwarded-Encrypted:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:X-Received:Received:Date:From:
	 To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:X-Proofpoint-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=GcPKgaoCuNaXXKfK7YHbVbvTQ8K5JkvfLVdxqmyckTc=;
	b=rt1fheF070zMZSUMWcotDsV33wRJwbVIaytoQenqdKoPZymLYJk6TxgmdQ3VCeKQbOIT
	 4YDJ9gi4/yVFZV4sKmr9oXRT52KTFzWrhCMxnhSeR1OEFPSXQlRvHWWe98BFOKSVqa41y
	 8zMh5I8gTIU6KexfslV0lVND45byv5jOKVTK5M7fmUedVahLoAcKGowPTdj88/xjNMcxK
	 RF5h891AlgL1feVStEsxzuyKeqt5kKWzTP668tLm1czRUKEfY9Z2ZAXkUMFwxujWSwplf
	 jkCe5sKN1qVPMY7MlSKl/EJ6A10ajv/Q02JUQeKDo95l3bNxyY2Qpn1ebr+PW0vO4IA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=oss.qualcomm.com;
	spf=pass smtp.mailfrom=oss.qualcomm.com;
	dkim=pass header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OhntgV04;
	dkim=pass header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fFTZJg6g;
	arc=none smtp.remote-ip=205.220.180.131
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6DFE606A337
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 10:24:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D6DFE606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=OhntgV04;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=fFTZJg6g
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69T8vEAR3765947
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 10:24:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=GcPKgaoCuNaXXKfK7YHbVbvT
	Q8K5JkvfLVdxqmyckTc=; b=OhntgV04JxTQ40rWyj5d2xZa7/6KHd5OJ6xHoU6H
	q3j5Z9X+YprB6mNk4SZ67s0eBct7rQJBF1geRSaXc/73dkP9z+SzEy6t8KOAhuH1
	r79VMzerhOJ/uJw4sI9xav+XuYdzAZi5NiwPch5lm8aDee8ghX90uYGxrgR8Ozy5
	1hjOMjEgP5deK2FIFH8OQjNOxvl5LlvrvKoO7z4IllkQ6bgQ/VIMKMdUrd11hPbo
	orkQuQs/1phdJYmIuW5GC19SUfQYaWZTb3jjfsUtXQyEwync+LIXT69OORa6UYX9
	mbn4kDS39NMOY//FSnO/4359DWFRkBnk2E9RmInl7JgSNQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com [209.85.222.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hkpgpu4gk-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 10:24:29 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-934963b2bc0so347096285a.3
        for <linux-pm@vger.kernel.org>; Thu, 29 Oct 2026 03:24:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1793269469; x=1793874269; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=GcPKgaoCuNaXXKfK7YHbVbvTQ8K5JkvfLVdxqmyckTc=;
        b=fFTZJg6ga2GolbRvVDAuBD2jVBZK1wPFgk3JnbYjG9FUbzxtnIolUNLqDH7uTokc11
         Xvx8MoS3XyNmJZoP315S31fDQy3P/flmXbABWf8HOYJpKrexFUd98D/8w4rJ0O5wAFgi
         2q9siXuBzU0CVnXwTW4CwQZGg2Yud0dAET8cU0li9ucDAbSH8c0eP+oRWXEBprWfdEho
         W2lZXXskfGEmLYYBaHP+S6WdWDCCo644X5iBdB2TKv2kkz/fkXUbmsOhq91v2hkKvX0z
         JAt2XMrLASHQBzE4lzH/CltW2dGx/HfeyyxpN5wzn+hybZIVkiwbn95q12IFsy8q7Cvo
         IuwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793269469; x=1793874269;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=GcPKgaoCuNaXXKfK7YHbVbvTQ8K5JkvfLVdxqmyckTc=;
        b=GLjKOJOa7xtOEwh41ss89rzk+k7tpQo2XRv20sDdNOFa1IIC7g42bN/Bv1FEL6D+NW
         LwT9Z7o9nZwqfAB3hp6nQivt4EWygt2rkMNSvPJh9ezbLw0/nPEjoqxrzbpMEoLbPiei
         dkS7QjtPSVc3kBi63rOxocTkhdc1l0MYfnoi3R8o1nvgK3swOiJin2sWd3zDR8tRTEP1
         X5I9seKcIPpdep0ssV2N0GNzIz31WcOnTetmMMHwFccQWgpx8i+lc6dYQDH+i7IEelKc
         uAay30rW86D1PAmXsTsqXhtewu0nSlo2UfH47qBKdfErol4WbURLxQpfblK32gccWrZl
         0zfA==
X-Forwarded-Encrypted: i=1; AKwUvBw1pWmn2loY6TtyMcQCcyZQo/7cyoA/zY3sN2mQYwztJeU3HIDXPAR/knR6EPGA2W2N+LDw0Qxu+A==@vger.kernel.org
X-Gm-Message-State: AFq9FYIbxHybD0NiP2OoTM/DQzGZgAQvwLIWfR9ffmnNH0I0ippCOGKh
	glOVcGftmfoOVdexINnagDL9nlbzO2sU2B5jp4oNQpvEyjLx5oI/1sG/h4SUMmaUlO28zX7Bmwz
	33Raw7sm+iCtvyjfeC4GNZBAmKklyjaEKHHJ9MzX3oTDYM6+EFsz8HLdNPipE/A==
X-Gm-Gg: AYBFou0+BeZ0UoZugyXq/r6UvqS8fSd2qas2H8LAVY1nqCCvHaMLGLfaZ8ilz7lEWyl
	jg9xAVbbVhfESWZCizQ6YfyO/OCNiRkfem/Zuithw0yYEsRSaNBfWcwSdyxi26oIh8C3vg9dQ2W
	KHYwlTkXgCjqVZk+nHMjF+dXnXQxvZ5+hlUr87MHJz8tK0nz0MNd2JxDbt1dhZf2kBmHU+rUJH4
	n9BgOyryOuml5DqNaXrZ2HmECfAXgb1ZMYJJXJJHph3JoQUZyinP0aCt0OI7TmaqphwZUY8ce5p
	CM257mDk/qWGQBpWhSoCOpUnAA3mNXoBYC434tcdoiF4sGYRhsU6a+G/7Sxhm8LRS/q/9He8L9k
	ekYA5JTJ4z7WIL68vCw4LPNEeYV6CjsW1XrFwcz01a4600ffdD6rvEBZWntAn4481
X-Received: by 2002:a05:620a:400e:b0:942:a42a:78a2 with SMTP id af79cd13be357-94408a8cae4mr713124685a.31.1793269469037;
        Thu, 29 Oct 2026 03:24:29 -0700 (PDT)
X-Received: by 2002:a05:620a:400e:b0:942:a42a:78a2 with SMTP id af79cd13be357-94408a8cae4mr713118085a.31.1793269468363;
        Thu, 29 Oct 2026 03:24:28 -0700 (PDT)
Received: from oss.qualcomm.com ([188.27.161.77])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebd48e0sm33998692f8f.38.2026.10.29.03.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 03:24:27 -0700 (PDT)
Date: Thu, 29 Oct 2026 12:24:25 +0200
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Bjorn Andersson <andersson@kernel.org>,
        Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Souvik Chakravarty <Souvik.Chakravarty@arm.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        John Stultz <john.stultz@linaro.org>,
        Moritz Fischer <moritz.fischer@ettus.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>,
        Christian Loehle <christian.loehle@arm.com>,
        Lee Jones <lee@kernel.org>, Ulf Hansson <ulfh@kernel.org>,
        Pavan Kondeti <pavan.kondeti@oss.qualcomm.com>,
        Abel Vesa <abelvesa@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
        Sudeep Holla <sudeep.holla@kernel.org>, Andy Yan <andyshrk@163.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Mukesh Ojha <mukesh.ojha@oss.qualcomm.com>,
        Andre Draszik <andre.draszik@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kathiravan Thirumoorthy <kathiravan.thirumoorthy@oss.qualcomm.com>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, Srinivas Kandagatla <srini@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Song Xue <quic_songxue@quicinc.com>
Subject: Re: [PATCH v27 10/10] arm64: dts: qcom: Add psci reboot-modes for
 talos boards
Message-ID: <25q4hk2nu5nd4udoof4tsslyktdned4bygrgyzuknhvvvh2stt@a67p3qh6ddch>
References: <20261029-arm-psci-system_reset2-vendor-reboots-v27-0-fa4b3ff1359b@oss.qualcomm.com>
 <20261029-arm-psci-system_reset2-vendor-reboots-v27-10-fa4b3ff1359b@oss.qualcomm.com>
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261029-arm-psci-system_reset2-vendor-reboots-v27-10-fa4b3ff1359b@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX2fJdcBYgq78w
 yexOxdSbnw2H4Op07f/ThOxpM/UpX9vBBSgzzbzfw4C3kJkLz2Ie3cSF3CgAYum6jKKzo+txT1F
 t4zct+A6C0C2V+jOvsy7w5bH+pl/yDnwAZQCE8e8ScirMwRj58wEQM/mcU0Axzdpg+EjXKWt7A7
 KxmEOt0MS851zYPpa1zIieroiLPS+vUqjy25btZW1owVdARPMXp2MYHaK2lfLvrIl+VUZa3vtng
 4/3QOoxKDVudepL8vqP8RyQ6APHtzg1HUy6Gou5luNZGwsOTiNZgDoQ13OxkqS2NQLI3A4tv9Xu
 o7rsvL1+nXyH96gBQiurZ39csMlGoVRTGDUEVrqwRIfcIGBhI6Y2zeuAIPLDG9Pmnpl0ilRGVYv
 FaIG5KLTFMAWAbwAhxjx1BKXFl2FDDo+StVQqnLHL5PgReofU83NLlw+gcTFSptY1V2ok9e3zkW
 5XcO5AOyjhoIotQoTHQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI5MDA0MCBTYWx0ZWRfX4x8GaOwT5jhS
 biMEmQWwD+BYjIj2WXlZb6Re3Uoefc/wp1ftAStXmDUF51yj0/rwNWcyvtwZFKDStwBatc4cts5
 87AN7qTnqLCH+Efpq9FewoJfBJDw3I4=
X-Proofpoint-ORIG-GUID: areWTz0AckhVMJGabhVGN2-wYNwPVXju
X-Proofpoint-GUID: areWTz0AckhVMJGabhVGN2-wYNwPVXju
X-Authority-Analysis: v=2.4 cv=T4oZ3PKQ c=1 sm=1 tr=0 ts=6ae31edd cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=asF+/XNaGoxFafzDDLC1GQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=1QY0aOnFgCSDOgRkrtMA:9 a=CjuIK1q_8ugA:10
 a=PEH46H7Ffwr30OY-TuGO:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-29_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 bulkscore=0 priorityscore=1501 spamscore=0
 clxscore=1015 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610290040

On 26-10-29 14:31:04, Shivendra Pratap wrote:
> Add PSCI SYSTEM_RESET2 reboot-modes for qcs615-ride, for use by the
> psci-reboot-mode driver.
> 
> The following modes are defined:
> - bootloader: reboot into fastboot mode for fastboot flashing.
> - edl: reboot into emergency download mode for image loading via the
>   Firehose protocol.
> 
>   Support for these modes is firmware dependent.
> 
> Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> Signed-off-by: Song Xue <quic_songxue@quicinc.com>
> Signed-off-by: Shivendra Pratap <shivendra.pratap@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
