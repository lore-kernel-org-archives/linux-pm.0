Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AEDE3F485C
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 15:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781536457; cv=none; b=pmuG6sSLA0dTCsRw00y//ghZT+gjiyg/xkTYyBV4JeMqJElGU8z2z6Ge3+xg63O3EldpISYHM6yg7zXOVO6NEzpKYbkraRVMR6J8WNygivepbWOHsW4TTNbZQE/p4oryIzIw0zl7W67aopQU94o0wLrDj7ax+C2Aulq5AFC5K6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781536457; c=relaxed/simple;
	bh=ceAeLyIDJYOguDmkvX65mUK6e6DXqKLNriS8rNcODTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hkpYC7J71BGIz2G9DQl4w/Z1I28IVnwl37Gg1Q7Tc2T2yw6HyjQvmMjzaB/7OxXhCDBr+J7Gd3DIStk/BByutlhO1TGpA9SMxMNyuojjJ2NXDygSVgoq85UDiFDdZZKs30fLv1XVgZhXq+eMiTYe899jna7cOw2E5IpwF+Ui9HY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=KP0rGV4b; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=DNP0danC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="KP0rGV4b";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="DNP0danC"
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FEZabv630480
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 15:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Riw4YPuER1iLXIAKKpOzIbIKBwrcerQOtjn9fV51aAA=; b=KP0rGV4bNDUfRPhH
	VZpf0Z/EilIBd5L3CL9ajcpJqn0HXQ9ZzB1C6NycfdA7p3WRvn1gfb/RUbJZtGd7
	XXvXyk+AVORBaPDce8M38M/SfGq5PBIAE2r8udSZveiboP2zYC5nS2tqpUDHuX1q
	HUTaHa8DLbevGYcTREH0Gs8iPpzjtzvQyXDx9WhJj2DUHUeaPdIx7wUq21TUkiPH
	qmSYGvjKcB9h+BZ06SVfv77rtfpXcQRKecJk56LCiy8gNIZP5D3IgrAhu3Sz8fAu
	D8aAZS2KNJXcPUrYcsbs9yXPuTH/fy73QfRDXw9SdX1jBqLovxouYWyxVa8xFHwX
	tE+m1g==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com [209.85.222.69])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etevx1bem-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 15:14:14 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id a1e0cc1a2514c-963d7e5ac77so1158333241.2
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 08:14:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781536454; x=1782141254; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Riw4YPuER1iLXIAKKpOzIbIKBwrcerQOtjn9fV51aAA=;
        b=DNP0danCyCNzXXdJxyKKNvcpDYG/LT2k7ejgz5uXj5CsRiyjfu3TeJv29l4U1s/a8n
         yZ64tUR8d1CIMCjiU359Ht0XUolknXBlUBh+Ex2zLNyLNwXGg4b48gMAFBGG46FfQH6B
         P5ymAmD/V+2bberbrcXW4VCiAZiYgqPPacwuhrdNe5wF5pT7LoKREwt/ON9QqXmC414w
         JtPNHGs8a4LKHcLYDz79Z8xNGBUL2DnRcCZMg+rxYT7jjik4kVBcapsAN4OEhvx4Pq2n
         XDKvL155QXJkUu0JqSreWYMHf0QS3hAFPT2oOAsQSEwdUJj1F6DIF2Eupez/RfEliBTR
         N4Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781536454; x=1782141254;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Riw4YPuER1iLXIAKKpOzIbIKBwrcerQOtjn9fV51aAA=;
        b=fdbx/3dZ0pX623WjkNFBmPXOYwblJSGKbf3OmhsHFuZyZfhQ+dFnbWkc+K9jEMKW9m
         XE/ATki/Oi9XSgZjXcZOdZpD4SOOXx3bwi/3kUPDzobr0c5wxOa+F9TbZT2MhXL4W/wu
         KHySA+l6cEig2bJLWMUaM7igJLYxan4DXj3ZKvAHDm8hDQBq4xkiMhHRoWZp82aBlyM9
         7ard//BrqwnfbBtWcl0q1Jcs87jgGmNTJldYz/KbNunbhZx6NAfVCHNaHmrvCVgi2QSC
         OIvyxYD6c2osCGqRWksG7bTP+cwVFN6szPzgDKI9SrYVPSgav7tRjqfqmK+tSCxwKi4h
         3UMQ==
X-Forwarded-Encrypted: i=1; AFNElJ/DY6gMg4edlv4nZJ9Wfm12EVVUcvohUIO9GR/GtwaMeOWMRDHfYSorDYvRCParm/oNxKWGgXLxiQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+px84OtzKVNaO9wzur17Yv5XprCBuP5AqSTW8eaOI9TwvSrsQ
	ZWRz/zIpv7e7tc0yt0c+vjA8+/ulKINY/lnwDJI0nZ+A9D7U/ONm4xiLkm9WI8b4L+FKVdbSQ7R
	Hjer7J/KmgGli8JbGYNnk72uI5S1wb/knlD0/pDOsurxnJz9EoadBoUGZUPF0rw==
X-Gm-Gg: Acq92OH1Y+hc1qlGUJx2ydIX32MKF5qxqHmuGHvkt6CQA/tYp+kFjEEXpykZQrkaKF+
	ooBJlZxbAidOxNxdwbOXMiQCZYNyUsb07SqeV2eX/WRFCiipj2EFpeRsNp8D7PZrd0ddg9Fpvtu
	9oiL5/yWD1OUxKpJo1tWbJW4OmXqocIQtOSHhlJxvZ6a/d27UZVZ0qNUC2VHz1nmzqsy1Goaj1p
	N6kSud8sMInINAFFnJas+/+0UbqX0MS5ec9YudDyiZiZOm6JYdSKRZBU4lzxiJ7dW6GsiVRt69X
	2eoy/EinuHVjSnl3oRUjDh06Ju8slKS9ygMIVZ3GlrQ0SUTOYeKE97DMkiyPZ0OSEs0yO15eKvb
	wxfGiq6kRL6fU1IFl2U3BjSMA294RNwKcZoB6gUpCq9XcuIm06e63ktnqDGgoju1bpDLIcD3Coh
	stoZpn7j39ZO812r7kW1NMlJZJi1uFl8sKI9o=
X-Received: by 2002:a05:6102:2909:b0:6d3:aad5:6d17 with SMTP id ada2fe7eead31-71e88c95d52mr6726598137.19.1781536453882;
        Mon, 15 Jun 2026 08:14:13 -0700 (PDT)
X-Received: by 2002:a05:6102:2909:b0:6d3:aad5:6d17 with SMTP id ada2fe7eead31-71e88c95d52mr6726509137.19.1781536453275;
        Mon, 15 Jun 2026 08:14:13 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e16a063sm2823502e87.26.2026.06.15.08.14.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:14:12 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:14:10 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Subject: Re: [PATCH v3 1/8] dt-bindings: remoteproc: qcom,pas: add thermal
 mitigation properties
Message-ID: <mp2hl67rupxrssa43dcy36m3dwatlxsu7n27l7qdqsguo5i3bp@bo6sdzxglxt2>
References: <03d863ee-2caa-41f2-94b5-7332fc930b42@oss.qualcomm.com>
 <d81bc78e-2c1d-45fd-90c9-f7ec462183a0@kernel.org>
 <7f1e46fb-15e3-4638-9930-8abc1dd5a778@oss.qualcomm.com>
 <fcf93e0f-a2f0-4070-86ec-8a34e9344b76@kernel.org>
 <ec65893d-873a-4a62-b0e2-5008b2130545@oss.qualcomm.com>
 <3cbcaf8c-357e-42d2-91c1-9d1a32c55ed0@oss.qualcomm.com>
 <ae43a691-4879-4bfa-8c7c-1be16945480c@oss.qualcomm.com>
 <9a31bb29-75d7-42fa-b8a8-4155cf85cadf@oss.qualcomm.com>
 <hebyboondtxyyetwuwggoiysurz335xzn7asf6yit3qrexap3x@kngk2m5xum3x>
 <93e7251c-c75d-4e43-9ae2-bf485af58de3@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <93e7251c-c75d-4e43-9ae2-bf485af58de3@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: FgLfKJCfVf8HndYKUjsUq-UlED5zAPny
X-Proofpoint-GUID: FgLfKJCfVf8HndYKUjsUq-UlED5zAPny
X-Authority-Analysis: v=2.4 cv=f8t4wuyM c=1 sm=1 tr=0 ts=6a3016c6 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22 a=dgB8o7PXAUIPl1LvlvMA:9
 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE2MCBTYWx0ZWRfXw6QlWzzs+Zaz
 QgJXnY9sV6LlccruGxM6EfKfDWOm4HAZRJYr9G+SeLjbmdl5dZM3Nac2OFXoxcREEBFkAX1ZGHJ
 VjlaCktyoFDW492P4G7WhaqwnyWz3O8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE2MCBTYWx0ZWRfX6TeIyyEnZIqv
 OodvvOCJyYf8alnUpaMbpJlVkKs4PuEhuBwE76kc2iILLmNyzgW9F+ouqnxO2Jd4RDUjDJdnAGK
 yxL19N+zN8NEj3TMNWbh2ehymkASGj2l3OKIfHUF1s+rc9kLlDy1av8+sdpHYw51uYReZotFGhe
 DI2vB57UeaHeuedf8dMs6t4uEsC81rLeX87KCEYkdG/EXgN0CqZ9suwuCexE5X+sHDtJ7RA02S5
 Cq4nkGnNjCOPuOjlFjH/t43EFy5qsjx/4ArHluxkDEz15NduQWq+LqKf4rjfhxeJsBTGS5nr5Df
 nVVlM0Ba6y3b1LQdujcjrRZSElKIMPxFt8yE/koUX9r5jgnGrAsa5I9B7MvNfb9GceHFAXJzn/D
 Akrwx9LlQ/7INS++KhloZOICWnKdUfOMuQuWDTKu/hpJxE1Xk8K1x3O6ZvrG8QURvVQJj/u1PWG
 m5D0ZmFfdn2WT1ySENg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 phishscore=0 adultscore=0 clxscore=1015 spamscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150160

On Mon, Jun 15, 2026 at 04:33:38PM +0200, Daniel Lezcano wrote:
> 
> 
> Le 15/06/2026 à 16:11, Dmitry Baryshkov a écrit :
> > On Mon, Jun 15, 2026 at 02:30:49PM +0200, Daniel Lezcano wrote:
> > > Hi Gaurav,
> > > 
> > > Le 15/06/2026 à 14:12, Gaurav Kohli a écrit :
> > > > 
> > > > 
> > > > On 6/15/2026 4:04 PM, Daniel Lezcano wrote:
> > > > > On 6/13/26 13:05, Gaurav Kohli wrote:
> > > > > > 
> > > > > > 
> > > > > > On 6/13/2026 1:11 PM, Krzysztof Kozlowski wrote:
> > > > > > > On 12/06/2026 15:52, Gaurav Kohli wrote:
> > > > > > > > 
> > > > > > > > 
> > > > > > > > On 6/11/2026 5:53 PM, Krzysztof Kozlowski wrote:
> > > > > > > > > On 11/06/2026 13:12, Gaurav Kohli wrote:
> > > > > > > > > > > Why? And where is this generic property defined? You cannot just
> > > > > > > > > > > sprinkle generic properties in random bindings.
> > > > > > > > > > > 
> > > > > > > > > > 
> > > > > > > > > > Ack, will add why part.
> > > > > > > > > > These names are matched with the thermal
> > > > > > > > > > mitigation device identifiers
> > > > > > > > > > populated by remote firmware over QMI and define
> > > > > > > > > > mitigation devices are
> > > > > > > > > > exposed as cooling devices.
> > > > > > > > > 
> > > > > > > > > No, -names correspond to values passed via DT, not
> > > > > > > > > some remote firmware.
> > > > > > > > > The remote firmware should give you interface which
> > > > > > > > > is explicit and does
> > > > > > > > > not need such properties.
> > > > > > > > 
> > > > > > > > thanks Krzysztof for review, We need tmd-names because
> > > > > > > > of following reasons:
> > > > > > > > 
> > > > > > > > Following Daniel's series [1], the thermal framework supports
> > > > > > > > mapping multiple cooling devices per remoteproc/device via indexed
> > > > > > > > cooling-cells.
> > > > > > > > 
> > > > > > > > 1) The thermal framework's cooling-maps reference
> > > > > > > > cooling devices by index (for #cooling-cells = <3>).
> > > > > > > > Without tmd- names,
> > > > > > > > there's no way to know which index corresponds to which
> > > > > > > > TMD, as firmware
> > > > > > > > may return tmd-names in any order.
> > > > > > > > 
> > > > > > > > below are the changes post new thermal mapping changes:
> > > > > > > > DT: tmd-names = "cdsp_sw", "xyz";
> > > > > > > > Firmware: ["cdsp_sw", "xyz1", "xyz2",]
> > > > > > > > Driver registers: Only "cdsp_sw" (index 0) and "xyz" (index 1)
> > > > > > > 
> > > > > > > names property are not to instruct drivers to register or not to
> > > > > > > register something.
> > > > > > > 
> > > > > > > I don't understand the problem and explanation in the binding is
> > > > > > > basically non-existing.
> > > > > > > 
> > > > > > > Remember that all lists and indices ARE FIXED, so driver knows exactly
> > > > > > > which index means what.
> > > > > > > 
> > > > > > 
> > > > > > thanks for review, shall i use driver data, which is basically
> > > > > > pas data structure like below:
> > > > > > 
> > > > > > static const struct qcom_pas_data {
> > > > > >       .crash_reason_smem = 601,
> > > > > >       .firmware_name = "cdsp.mdt",
> > > > > >       .tmd_names = (const char *[]){"xyz", NULL},
> > > > > >       .num_tmds = 1,
> > > > > > 
> > > > > > Is something like above acceptable? and this will also help to
> > > > > > filter tmd names as well?
> > > > > 
> > > > > 
> > > > > How the thermal framework will bind the thermal zone with the TMD ?
> > > > > (node pointer, id) ?
> > > > > 
> > > > 
> > > > Hi Daniel,
> > > > 
> > > > thanks for review.
> > > > 
> > > > With id only, in this case instead of taking tmd names from device tree,
> > > > qmi_tmd will take tmd name from pas_data(driver) and register with the
> > > > cooling framework with id only. Please let us know if this looks fine.
> > > May be I'm missing something but:
> > > 
> > >   - The QMI TMD returns a list of names, not ids
> > >   - The QMI TMD may return the list in different order than assumed
> > >   - The cooling map index points to the name of the TMD in the DT
> > >   - This name is used to match the name in the aformentionned list
> > >   - The index in the list and the id in the DT can differ
> > 
> > Would it be better if we define standard indices for the standard names?
> > This way we decouple the actual firmware strings from the DT.
> 
> I don't think so, it seems to me too fragile and prone to error.
> 
> It is a remote proc, an external subsystem. The contract between the client
> and the server is the protocol. The protocol specifies the identifier as
> named strings, the TMD names, not numerical identifiers.
> 
> When asking for the list of TMDs, we get a list of strings. But as it is an
> external subsystems, may be tomorrow someone decide to send list ordered
> alphabetically, or per number of states, or whatever.
> 
> With hardcoded id the QMI TMD clients break

I was thinking about something like:

#define QCOM_TMD_DSP	0
#define QCOM_TMD_PA	1

cooling-maps {
	map0 {
		cooling-device = <&remoteproc_cdsp QCOM_TMD_DSP 0 2>;
	};
	map1 {
		cooling-device = <&remoteproc_mpss QCOM_TMD_DSP 0 2>;
	};
	map2 {
		cooling-device = <&remoteproc_mpss QCOM_TMD_PA 0 2>;
	};
};


> 
> > > Krzysztof , I don't get why having the TMD names as properties is wrong,
> > > they describes the existing TMDs on the system and the cooling maps index
> > > points to the one to be connected with thermal zone.
> > 
> 

-- 
With best wishes
Dmitry
