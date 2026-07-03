Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A2C35E1B0
	for <linux-pm@vger.kernel.org>; Fri,  3 Jul 2026 08:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783068095; cv=pass; b=oCa+2/7u0M0dvObhxTO7tiFpzPxCos3PxlRmEg3tzEbugywdmYTwDa9L3OXUISbGbN00zd238kvyBbP7m4glPy/vj7wH9TLmk8o06z/iFFGPNXHWY8opxkMEN7vtBIC8HdYjgEAQEW/63FdcNjbvfuAXkcOqUQrDRrtcpTazbvI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783068095; c=relaxed/simple;
	bh=A24/IDMt0yFcSCd3f2pMjBY2SE2mBp+L+hitnBhNtNg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mGg/2CBLKyzJYnbad7MIaoYQOfm2Ej3n45EDmK5t1XLuIhNkAXFS0ZnLPTdx6hw2rtcx+gcODuyeZEzboeaoYIBvsABjRkvmp/NDEalBoVTGENKlsjpSln5Q181E9iMuv5/mWLTwHeD7tNPXDYRx1ayDXpIUc2n4UuwPKA6R6GM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cdcfxvmx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=PXAuTFe4; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cdcfxvmx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="PXAuTFe4"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6635rfnt2994864
	for <linux-pm@vger.kernel.org>; Fri, 3 Jul 2026 08:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	JgfgskfFOJItCCV398c0ggLI02qLuHDQzMpOZ/nUiLQ=; b=cdcfxvmxsBih+A/j
	fvtwurcdg/gJYSyu5Uig5Gq8wCquo8jNytqD0uu9juFEOtQSfXwjZjtxdQrrTK+s
	M1rWwC22btRXLZcoCOv6/JNy7ImMEvu6mU7onpE62ujvdfACdBmudXFKzXSKk0H3
	SRGOYvTginR0FO2EcdZBohFlBq0WCl7hXURvzCfC05PT+3yBMkMSZ1ylo6orLhcJ
	58m2OMcgctIMwGlXT68/VUkLd9dYqAk7+52jct0dOMaEj7SLsyVye4xcu8vTLW4U
	lCFoR5+AaxXvqlXDqntxmIUnNPAiC8eByWfbz3AwQmww8JOSrqIxfs+yMHpQLRlu
	hpuaWA==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f648n1gb1-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 08:41:30 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e53b8a302so31863085a.1
        for <linux-pm@vger.kernel.org>; Fri, 03 Jul 2026 01:41:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783068090; cv=none;
        d=google.com; s=arc-20260327;
        b=BZGu/HOFJ6UonX1w51pd1owJMAVhrwmS5hWfTlwK+PrST0bjAjKx9acvAe2qOh15xn
         EZeUy80ioi5uFfQlFY+1jfUdDxS9SUmT8neGeKNA/I/nlANBA2vZIkbVUqA5D7aEh0rZ
         KTi4Lg6Bc7nb5snd/rqP81rh4CEUpzCWT/vy+zT8jmnMomYsW7SgR75uA0qMvsMTFW/s
         JbIzRy3bifYpGCiIqz/kGhi0eM9mYkzmnMeqE5ozHNHE06j9x/NpC+tzlxz4aET8k3j7
         J1RF2ojlY63BGCrz4L6t/Z672qmqu/+frfMBALvVHqcZjznjmr2uCdy290oB704fKMG0
         P8uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=JgfgskfFOJItCCV398c0ggLI02qLuHDQzMpOZ/nUiLQ=;
        fh=lQZ78sxjPbnA8XT+8dQuTmwYjyEPb/COf7BnGtBiGJY=;
        b=bp+hKP52CFKU7zPTmzBa0m5RSCS61uHcsThVriVM6lhmCLG74kK6oKrSx0m2+VAU3D
         DYOKO723Ltu4u0GQWTXylecoemrlc+Rqm1lSdjymRb2HP4YoJWmnUQ66TblPq0Ox29IB
         puYhIAYCjw3GGSgW+E6YG/Js9X9bcQO1FpDh3vPqHFrzUB2rjYVAXTOeqSmRaTBJK2Bf
         ysrvaFyI6pstVF6ouZqbwpFpQgBpZ+0MsC+aUe+5bg3IV6t37YgKU9yNvh+Kjlg8g2Fj
         nnGgAqT5t8m3MHhBXjYgSDlTENcDHCE8O/hhs0pEqQdHGpDYJECBYicD4B1XZnZANtxw
         r3jA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783068090; x=1783672890; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JgfgskfFOJItCCV398c0ggLI02qLuHDQzMpOZ/nUiLQ=;
        b=PXAuTFe4Ojw62j6tAUNP9wnN5lQXZDTel/ZAAICYjrRowiZ5eEmVWyayjZMGqtxl8+
         atLp5BsxEKfO7vxs72gziDQC1lz9G8yVkpKHBUAr/GbDu+tVZmDLNCGV0zrXH/oOq9OG
         jyip9EUMelvPSLjC7CrDNIn3mDEkHKapHvEqiHzzt8nsZeCNURY0CynBJguhLpiveQAP
         Iia7zmCqcD8H9uM1yISwaQLUmWjM+YXk5tnYNqPtb9HiR4hv45//C+ZUdvE3GyUwDleK
         709raCFVUcVRCv8v+l75ETeQ/lBce8WfzSoORZDomGpatyxkXOn7k0g93bzH/8MxKXEb
         dwug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783068090; x=1783672890;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JgfgskfFOJItCCV398c0ggLI02qLuHDQzMpOZ/nUiLQ=;
        b=Rs8R0J9w1oyrCePDvXMm0yjIGfF3tTJ9qo539IoMCmB9Dhd/WfYfNiKLrEd6i9ezgu
         k1TAcOZhnRRDHP/RDloo+VhbR8NFo/3Lq/CAGxc9z8jK5rzcxginUPkjHgCZccp9KN7A
         IqXf1gLvjpdVOg84zdB3nW15+1QFhAYy97b7sKKjdn60qe0LUAktNs+jZaJd/KgbLYxi
         3hq3iOVJKQgpgGqRhrlB37FKWqFsAAdJyhQEg5zwSvlJOs2xUu+tovE4EIKT0WV0YuuA
         +98fmqpdGv2K0bAdq2DxcyhszDwdtbR0dFlZLmzUCPgRuuDT8ox7XVdH93Wyk50eBpZ/
         l4/Q==
X-Forwarded-Encrypted: i=1; AFNElJ+K7JsfZbRMHmWkIOxzTJQJQcWDwk5Vao6udjrknJGl9xEWrYg0EzabdISuZ9mVdoiirgnk/bRjOQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzx+La7mDeqbIZ6MZYhdmMABMZzY36yqX6FnlaRGb3XFTBsSZTW
	mlczszdvzc6xePzDlW7UuWRfaPqnG9hyzyEIXPArgEgIQAkrhD9+kZaNFncNhkwW+Knmpdnfewy
	7MfxJCWtL4pzvl2ow64jdgtJn63rtBqrpprc/wAxpkdBHXkgi9cGGjklUSlIWLNp0JSpxetjlsi
	Mo+2bcqHbbUtyqvqNVM+sdBeMBMCf282IbbCpM
X-Gm-Gg: AfdE7cnNv6kw/KhRimScuePNisOL3FRlMyo2KQUFawcTa+XrZPPlHhVjiGxEp7u9rHR
	oWsVZTpbQQbAxy6Rj5qZNW8ebCh+4TKg0GA4F2tbOwus01KKK+XpYbtfIKRoXJbUQn7MWl4cl73
	DU/buFoR7x8bjQJs4pJYw+5ul9VbdCeQAx53nGvV0QzDNSeBTNjRn17c4swq0cFw3IVaTdYDV9W
	0qv1zF/3jOqu6uqkbn6feYv4KXAAPTYEmSIn4lU2srjmgC7kG+G5IAY7pdOVzx7bG1SFJuRXghg
	3ZyQiZquEw==
X-Received: by 2002:a05:620a:2915:b0:92e:4927:1fff with SMTP id af79cd13be357-92e782c94ddmr1287062485a.36.1783068090245;
        Fri, 03 Jul 2026 01:41:30 -0700 (PDT)
X-Received: by 2002:a05:620a:2915:b0:92e:4927:1fff with SMTP id
 af79cd13be357-92e782c94ddmr1287058985a.36.1783068089796; Fri, 03 Jul 2026
 01:41:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
 <20260702-monza-wireless-v2-1-7b56e2a6a6d4@oss.qualcomm.com> <20260703-tricky-hospitable-avocet-dc3fcd@quoll>
In-Reply-To: <20260703-tricky-hospitable-avocet-dc3fcd@quoll>
From: Loic Poulain <loic.poulain@oss.qualcomm.com>
Date: Fri, 3 Jul 2026 10:41:17 +0200
X-Gm-Features: AVVi8CcGrmUi3s72gNEg9Nxjar9xvqGK0gTiAF8t-61zW6VTlFRO9OOYGSuluUs
Message-ID: <CAFEp6-3BptG=S+NutQpvuS2oe+kjJW6N4u0YjVP=T+tbX8PBPg@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] dt-bindings: connector: pcie-m2-e: Add vendor LGA
 connector compatible
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAzMDA4MSBTYWx0ZWRfX/QzgSEHXOEJ7
 f8isjvKDBz3MCBuKvDwD1yypm2qApZVdPCH20BXYhIFHWr5jFWeW2/PNrdjjUGDXpjRrj27bQQh
 2TaBAg42HhJ/wSrJ8VdJJy7pRd7PHLA=
X-Proofpoint-ORIG-GUID: O5-ZxvDt1JaJLdZLlNukPTgt_qh-BWT8
X-Authority-Analysis: v=2.4 cv=O4wJeh9W c=1 sm=1 tr=0 ts=6a4775ba cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=yx91gb_oNiZeI1HMLzn7:22 a=VwQbUJbxAAAA:8 a=qB6sUIZWhqFJcRNk-TYA:9
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-GUID: O5-ZxvDt1JaJLdZLlNukPTgt_qh-BWT8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAzMDA4MSBTYWx0ZWRfX81XWkXMjk3gy
 KwwKAZGIDdH7TGGXVHuTQ1vCv9x9X8FhG3giOoLfzg8A9DcQfU8Pxm9yDUaX+ea4iiU69JPRbm6
 /51NkmfpqYqv2rveCWXqbKKwSPcUr8wyJWpMSzRxbOstZ+H31vaaASQasWjhywFkH7pAmXBBQbS
 yq6FMeBXO4hwxc7bryVQmaq4ibvKgfAzxnVgcftUW+c/O/BIAKCuJmt07XgnELYDch6UuOUe3kC
 /3ZZQewmtg19jyVTOz5pAooXZzJ96U2MccOjyycCaw+l4cr4fEM46AAeCwf0SODhqsobsyCgAUj
 nUekCM08GtrYSevPqYF9NhBYAucSRXCKo1JMXSiJqEHuHk1Vo9/b2cGcRUCjrPURjstUa6miIeB
 5Ar2bNj4Qv73nbN0Se0/rylGB1r+pMZKNe3pBwRAJvHZOi+ctkCP7euwBBhd9yFThoavkJpT9gU
 nJuO9nV4NKwktNyRgDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-03_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 clxscore=1015 phishscore=0
 suspectscore=0 malwarescore=0 spamscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607030081

On Fri, Jul 3, 2026 at 9:11=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On Thu, Jul 02, 2026 at 12:46:13PM +0200, Loic Poulain wrote:
> > Some modules (e.g. the Qualcomm QCA2066/QCNFA765) expose the same M.2
> > Key E interface signals but are physically soldered as an LGA package
>
> Why do we need device nodes for soldered connectors? Soldered stuff is
> afixed one, not connectable connector, thus it has no point in DT
> representation.

The LGA module is soldered, yes, but the node here isn't really
modeling a mateable/removable connector, it's the DT description of
the M.2 Key E electrical interface that the module exposes: the
W_DISABLE1 and #/W_DISABLE2# enable signals, the shared PCIe/UART
regulators, and the graph routing PCIe->WiFi and UART->BT. The
pwrseq-pcie-m2 driver and the graph binding rely on exactly this
description to sequence PCIe and UART bring-up, and that's independent
of whether the module is socketed or soldered.

Electrically the QCA2066 LGA on that  part is an M.2 Key E design,
only the physical attachment differs. That's what the vendor-specific
qcom,pcie-m2-1418-lga-connector compatible is meant to capture, the
soldered/LGA variant of that interface. So reusing the connector
binding is a pragmatic way to model and drive it.

It also keeps the enumerable-slot semantics: since M.2 devices are
discovered via PCIe IDs, a board variant with a different chipset
soldered to the same LGA grid would be handled automatically, without
DT changes, exactly as it would be for a physical M.2 slot.

If the concern is purely the "connector" naming for a soldered part, I
can reframe the binding.

Regards,
Loic
