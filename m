Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF01A40A927
	for <linux-pm@vger.kernel.org>; Wed,  2 Sep 2026 10:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788346125; cv=none; b=Rngq2IeERNRfEIX0MCwUe0sYh4Gcx7JYFhZG56uMHLPMFJjDeuVNTa1NeQqO7Z3VtxwpgAKR7+XKCHeF0FdyRLUBTGUQgYNv9hCzQZGo0TJoPG0k3lH3Sd7uZD/3kTAmlYwDtq38uy5NcxmkyBcQaOY+JN8CesbJKzqqlsf+Lww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788346125; c=relaxed/simple;
	bh=y0jCAG6BlkDtftWNp8Pykh0uKWwmdqdFoov+BYFffCY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hi1lO08xujBl/e3X6vnegwTxg6PAQ0ZJU+Fvht8YAD2J5DvxVF/VNz6o1koGV5ROqx6jVEwQe+CM1zN0ObiOFLv6Hx3yuCPCiGQ6GzxMyl3rivwMVBgjbZnv8sxtfElEQAE4Z1jRrNHL6tePip+xlohpDmCUb+YjyNSo5+1CBGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=mgIyHqRh; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JyjQIAYh; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="mgIyHqRh";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JyjQIAYh"
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6829NP1s1839239
	for <linux-pm@vger.kernel.org>; Wed, 2 Sep 2026 10:48:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	DVZQyoqDvaTn7mOywuRGqmToqms6HdyP/g5jqzvv/sg=; b=mgIyHqRhNmaHhNaX
	vjjaTqhnEiFr9C9YUY2hiahD+hJlYNQ+eWcPifk53PL6eLFpPNzppGpIpV5phaeP
	hPaRX1D27TpzlhhkrsoeUTlmeS0trCuDazTYIWzjLlRGRmz/wCcravA3lOseLasP
	ejjhpRJVCCFLiPosUVr6Q5o/6mUK+6my9Nh5yf4zaStyZ3Lyrkretat51KYmqQVw
	N9epMWO6Ue6FzDecqLbSVz8rIpckWKn3A9AUQ9Smxqp+W26bBusMdg2UDy8Cmacp
	WmMLx8P5TMLbMiRKkIReL9uDPEiH7vSnMA7g30JP3j5vgPu85aZQIj5+BwBFYg89
	l6vQ/w==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gebsx1k3y-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 10:48:39 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92e82060977so163713985a.1
        for <linux-pm@vger.kernel.org>; Wed, 02 Sep 2026 03:48:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788346118; x=1788950918; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=DVZQyoqDvaTn7mOywuRGqmToqms6HdyP/g5jqzvv/sg=;
        b=JyjQIAYhRcqY5No+Uwt2NH+S0YN5wSNzUKbmoz85cjc/wNAmik0VOxY9xR6ES8SbSp
         XYlntLLabnReCoPs92fUJxSEmA7mVsSGHHAyEgeDSxIcf/cyGWI0dKhiZUlGjkruVj2v
         hgDZP0KwS/TlZgI8bHY7Abhm5iHXGaAuhSWnJFg/ysns5DIOBhBZRPLbx+fzUivf6kt8
         JZljReMhIRDK8kbYcYf3NjABwl5/SpyRMCNm9WZKTMTwrm2LvbMdPV6Jo7cUj0oC36Cs
         WmfjjZE/MgcuHiBZU9TtWMx/LpI75m2IBwv5rbkKCwrMbDV4jolBSf0saR296GNA2ONY
         F9LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788346118; x=1788950918;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=DVZQyoqDvaTn7mOywuRGqmToqms6HdyP/g5jqzvv/sg=;
        b=Hj77ltQHM2wPbu1Ana6eeUf0II2OZK7hEFB0aCdzFZjGv28TcOgoLwtP3Pua9pe16s
         gDhshCVrGAJbB8GI2HTx1gItIBR3WQMpHzQxirGTx2hUBXBBu7Ea3Sl3tfvi+U8JIZHo
         W/uYJfjfdBlKUzp2EfQXDsr69QxZ3rBEijI/8FxjSU30ZVf1+DKwg4iLcOPen7AfxJGn
         iRmVBBSiSS9vXqFT7dPS4nmyc9oRA/6Fv/IEZaBDHrLCJxXCSwdedJ+Qsc4YLLZgGzRP
         /XLg9nBJw36GiXzh/aCo+Kto5Nt7oK0U/cEkKV72v0/q79lJQL+IUZwm+9Ga9dbSI2Zx
         by9g==
X-Forwarded-Encrypted: i=1; AHgh+RrD4qI34imdLCZOOcQyjlv4f1/4dOBTVoIZ78PNoburVUAJ6KpAPVPYVqq8uyWsIwOKa8hYx9HLvQ==@vger.kernel.org
X-Gm-Message-State: AFuF++lXN23LGzxOjkq6E9gcDWOSQJid7G+QG0vXFfm4DeW1V0Nqfm9Y
	x8VHAP2zy0igVCcvicNJThvYdBPUdUlLzGr4GxX5s08JiEeGrr5LfVUMwBNt+2QlelC7dMATIUU
	B1Eks8sykHzljytG4OFE1XT25kvY/IB0EVGmlZ5jW05+qqpWXmu1ONBvvpfG5QQ==
X-Gm-Gg: AR+sD1240LWTDAJG73CShbvvz23C79zAl7yUm+RTGZUt9tPVdX/GorwdlAeGdI2w1Pz
	0bzFuG1MaZwC9RrpWR7FuBGbdoeX+HjNuv5Ctcm+EAxiWubFOplnLsF7OAilqKWHYe0do/pwhmC
	J8N/Kt5nHlHLuPWzLPakQoIutqWlrh3NO51MFSeIuTq4j63uMgC14kJ3Vy6mmHfL2FudTaNiaY3
	s31lpdEt6Yjv+hAWfJF1DIQRnHw87d8iybFtnwpLZW6woNhPux2TO2GpipB4Qi1BBDMvxLRI3t9
	BluZiWUs+Nth9WtI4iRQZKgccY5+C1f8ZG3nLVutiQjBeRFILUQAsGLJzX+l3cVhE3nTgbt3+cv
	cWbsEV1TuNwYxgvYqGxEydtDy8EE=
X-Received: by 2002:a05:620a:6082:b0:934:a0b2:9bde with SMTP id af79cd13be357-93965cad113mr198109285a.23.1788346118193;
        Wed, 02 Sep 2026 03:48:38 -0700 (PDT)
X-Received: by 2002:a05:620a:6082:b0:934:a0b2:9bde with SMTP id af79cd13be357-93965cad113mr198105085a.23.1788346117728;
        Wed, 02 Sep 2026 03:48:37 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:b759:bed7:f8b6:ccad])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49ce4780f0dsm56543255e9.12.2026.09.02.03.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 03:48:36 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>, Biju <biju.das.au@gmail.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: Re: (subset) [PATCH v5 0/4] Add RZ/G3L PWRRDY power sequencing support
Date: Wed,  2 Sep 2026 12:48:34 +0200
Message-ID: <178834610100.25291.2104164353458457127.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260826122742.153643-1-biju.das.jz@bp.renesas.com>
References: <20260826122742.153643-1-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: gCBij5Uy1Lg0GiGBeUSUpR3XolETGlN6
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDA5NSBTYWx0ZWRfX/Zr4Pm8gXGWa
 bnzoSulwvSSUrDrVPhfY3xG3JZ5TKj7eeURJP5wQ9YbGR+u8yX90cpqTZ7eqc2LgzrEAUopGCXQ
 yPN3mfNglWv5pp4X8LFPevYpgsa1TEDDUz4xZ+OwQ6UwyOiAbjFX9PaXhd6ufAkxkkb3k5PXdAE
 EwIyN4sW/ePus96ZF4n9HxAeNROVGg4X5Y13W1F2FlcpQbuiJ/FFKCR4n4VHwxyEgkZ1m9IRJ/Z
 TJ5oLOp+gNOuNyzRxvxIQ/zLWLJB8fHlhkEACMvDXezXOZmw+Qa83qPVd/DujZtOsODeGnKVkb5
 5O+YK5Cu0IwkhlxHHunFB8Pt6s+Azk7GwY6AI5Dxx14dPsF0PEVtWPc0yh/6bZyv3b9Xog5KfOl
 1umYc8iuOG7mWtfqNpUFdH8rSCQa2Q2PiQeEwZqrqOix3R5V+dPyqWsotA/8a3b+db0hh8YsYN8
 TYs41+1nS9DQYXcls0Q==
X-Proofpoint-GUID: gCBij5Uy1Lg0GiGBeUSUpR3XolETGlN6
X-Authority-Analysis: v=2.4 cv=AufeGu9P c=1 sm=1 tr=0 ts=6a97ff07 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=2Ww_MoSDT8ibEw9cI9gA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDA5NSBTYWx0ZWRfX9y9MQO6pkzoU
 ovHcNIsrJU2Q5ZKw9dcNeUbsMp85uwuDK5VQXiEhEWZaY4jwTnXmPRcDG7u4x0/hsOlcdSSr6Ck
 xxSxYU+4NgXyp0bf8MP4bjVpmsrwU4I=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_02,2026-09-01_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609020095


On Wed, 26 Aug 2026 13:27:22 +0100, Biju wrote:
> Some RZ SoCs (e.g. RZ/G3L) have a PWRRDY register that signals power
> readiness for various IPs (USB, DSI, CSI, etc.) to their respective
> controllers. This register is part of the SYSC IP. Add a dedicated
> power sequencing driver to handle these signals.
> 
> This series is based on proposal for power sequence driver [1]
> for USB PWRRDY signal and DSI PWRRDY signal[2].
> 
> [...]

Applied, thanks!

[3/4] power: sequencing: Add Renesas RZ/G3L Power Ready driver
      https://git.kernel.org/brgl/c/3b04e9b8056e868c3e9a04cc74168c7c9a18746a

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
