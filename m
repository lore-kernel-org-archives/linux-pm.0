Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2642E4014A9
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 15:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781537142; cv=none; b=XwpIM116tb72vbLmL8GwPnww2Ngv2Zy/c8Jj2PjkKHWxbNeCEJnx7r24Mj5kLmZ6qewY6Db86KXbZ2NbgI9VDnrKcUQaHR6M+OedLciOqgDBKcO+fny5O+C0pz/NXxLrPvRAUvuszDZ9rFPO5iI7ciI6iTnT2PHfXsIJev9aQDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781537142; c=relaxed/simple;
	bh=pXCNxxs1mjxtAFSmX6jArvznuLHZysx3NusI3L+39Pw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DChw1tRhLXqkotSlDOt5qp+9PXUpHFvfWzYSTrmBl4338mah51DFLYn97HoSrcDX01Vrw6nW9ws8cmRODwizEMHmuX4atSWmd7nZoYCP8Xll7Ubw7WmBKMMEC1BrewoVR01YX95fq7iWn1W1Chpyzp/lJvrb8scc7HEW9tkIW4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=l4M/MlVP; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=A6V4p5Ch; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="l4M/MlVP";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="A6V4p5Ch"
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FFJsaQ398973
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 15:25:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KlkMVStFd7TWXdQCQgPLMRWEvG6VtN6Kkt81Xs5cI7Q=; b=l4M/MlVPuoz7uIWz
	L8uDQx0ogLGUSABWffL7prFfnmiR9DH52U3Fa5627ssYiDIgBtx9vYSyWu/KPabe
	p3JDNBGaIAzzh50jazHiWyVdV/CmSfsWshguFQeB+/iJQkxNO+uiIEgabJVVZUB5
	yz8EU02w+Wjda5Wc8qaVkB+9WDVqJXOHO+R9powEEtTURySoWlVd1MnaZ8B34+7R
	r9bUVIAgpxuOE1zlU+j5TlTdSSX+898RdvdRD381yMfbEELtvoC/lIc4n4f12rRH
	dMBQPHw2rZ1Xr8typfCR3evcK7VHDIzxjpdzindbGHVeAR1APCBgo4gj/mpKSOGc
	qnsWRQ==
Received: from mail-vs1-f71.google.com (mail-vs1-f71.google.com [209.85.217.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4etfa71axq-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 15:25:40 +0000 (GMT)
Received: by mail-vs1-f71.google.com with SMTP id ada2fe7eead31-71b5daaf011so1195669137.3
        for <linux-pm@vger.kernel.org>; Mon, 15 Jun 2026 08:25:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1781537139; x=1782141939; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=KlkMVStFd7TWXdQCQgPLMRWEvG6VtN6Kkt81Xs5cI7Q=;
        b=A6V4p5Ch8blpMBWBDM19iotY4dQfgAxzJQgYmnYyuWOIcWsMag+VhUJUrThga2D2RM
         IpOfp4Cd2LvMzo15Fhtnp4ZsDdNjy9j+qJOVCpnOp18BUrzpkY3vkGPcJ7H9y8zAIBas
         iSjNu3FlyDdWtFLZyDXskEB3Kz6t+uKFxOjKx9YjrAtZKvOGqCwjqj3UX0LFoG43Qi/A
         yAQ+H2B2g5NUQkLgb4hQ4dwsxCHa816D3mNxyWmBkhChzF73lk0vrrZMzbXetUZhKroC
         iAEIF1pOyhlJjF1VS5nGFMPk9z+kYeSolqlonGn1SGcujXB9s7m4AHozQoVLKnpTJTS/
         0C9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781537139; x=1782141939;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlkMVStFd7TWXdQCQgPLMRWEvG6VtN6Kkt81Xs5cI7Q=;
        b=OdxtRqsyFEfcWyi6woygdeip9uPcs2ZI1QeZ227qNX/cw/SFyH82huxvNHoE8UwhSb
         aKtOC0GE7li/ilPmb1asp7JgOCIgCaDjNghztNmcyBtgRhCvVzZQY8exL+oznOvfyJm+
         dZp35pg2EOoRdHDaxYdIEMqTYx/pL+5w85EZd8FfarhHP2/P0rroVJXWLCDH+JmFW9+a
         FCad+SnSS+w1QlqWHS46iIWBgeSE8Rgl74Q0UFzY8FfTwojMzjnWzSgJl4JdmzwyUuR4
         AzvcEekXd+SIPU4j1ZcIMriDYcogi+dbzVsD9dN8G2Q0mAelLpQyezy1QcAR99xnleCR
         mRFg==
X-Forwarded-Encrypted: i=1; AFNElJ/xccNCEQAKrx3zn4kr7akMVVqIsHNeY9Q4JHy8Hgqtl5K+zXChljS6oXTDdkGAoymGijKrV15ecQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTrdjjrDpdZweR/+FibbyHOcd1qBHNwmh6H8gwNWQQTIzD8n7i
	SaZDd7+KIdq9bK/EI0MqO0eMi9vR96Ire8xjDqvTRW6PyYuwQ2v6aj2qram8PlbUj7swZ/I3qHX
	0mhN04Y91tiFw9CV45eUPYf/P57Bgjbq/dNuFZyrAIpkAMdHIee4kmKK+30f47g==
X-Gm-Gg: Acq92OF8pNECp9NRSq7quObMuPzFbvNiPuNPzMu5nUb86xCYBO/ff/coJV6OjglNo8M
	pxE77uAZsKkxWVZeAUwDJRRu47BCnh558zbVEcrTykcq15q/xSXx9RJ84GDred9m8RQdF2RTY2g
	Mbl8lFdC1S9fjFb2YXWIxc+fgnIRgWyENfbkiy/dC8MguGyxWY9VcxFr08/uNbVR5PtuzMOncfX
	7+BpzE9PqFLGrjqh3qMsK3CcnIzWKCKcDTWLeapkwhYBFzTN5zWKTOzYYZu34NFudqXdClCotK2
	1nKeATb/kmDrjfTryK3aYOJsRm7X7BX+XPexpm8F3U6D5aamWHx6vdeRaVbWl9IiymiOFetbN+V
	P1D4dO8XljNXeyyP4J8FtLRhH/uv88WwiPXBLGnsDv7yfax01Ex405PRdOSdJVWFv/0aBNfDReB
	KRsumYJs9lyP2Z8g5XCqARQuki4eGzh6XpMOU=
X-Received: by 2002:a05:6102:5124:b0:605:ead:8f38 with SMTP id ada2fe7eead31-71e88e0ca67mr7376534137.29.1781537139225;
        Mon, 15 Jun 2026 08:25:39 -0700 (PDT)
X-Received: by 2002:a05:6102:5124:b0:605:ead:8f38 with SMTP id ada2fe7eead31-71e88e0ca67mr7376497137.29.1781537138656;
        Mon, 15 Jun 2026 08:25:38 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3995c19aba4sm178721fa.30.2026.06.15.08.25.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 08:25:37 -0700 (PDT)
Date: Mon, 15 Jun 2026 18:25:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amit.kucheria@oss.qualcomm.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Kees Cook <kees@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Manaf Meethalavalappu Pallikunhi <manaf.pallikunhi@oss.qualcomm.com>
Subject: Re: [PATCH v3 4/8] arm64: dts: qcom: kodiak: Enable CDSP & Modem
 cooling
Message-ID: <ezggulsc6wvd3gbgnm6tepvtcnvwkeyvva4szrrwbcksxgcesg@qo5l5pjtz77n>
References: <20260609-qmi-tmd-v3-0-291a2ff4c634@oss.qualcomm.com>
 <20260609-qmi-tmd-v3-4-291a2ff4c634@oss.qualcomm.com>
 <pf6rymdtbfcqqzt6vnn6gc3uuod4vlfpw42dxxag33aom7lltu@6ymibirvwfnc>
 <4006d16f-a159-4f1b-ba80-f19bef8f4c5c@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4006d16f-a159-4f1b-ba80-f19bef8f4c5c@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: K9_aAOyzzaKNv3SeMop2eFdYFDTN6Tgo
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDE2MSBTYWx0ZWRfXyANxdDOGomxO
 F5tMXbcQXwly8s2/o2dAsJvQuQrJIXjW5cl8nUvJ/w1a4XgdxyKexn95lf/nlAmRq2TcCx/ru/s
 c2LN0h7ZUroM7lgQYoyyqNKiebSnQF8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDE2MSBTYWx0ZWRfX7oNiUNcyunUL
 O0gg4k/SxXdG2fGZX5/osTnHYN4Fq5NA+TobRD3arF97G6lvUcFABNPB0UD6zSNz7fdbqp13eiJ
 d1x57SXqjQd5UuXtOOJH/mXZSskk9R2zR4SRmRtQWA713x67mNCyU3lvMxbWpwe0vAWhRVDUXGi
 nWO5JCOxeaTUiZsL6CyI6f2S5eLSl216iTetPm+f1YVhsZAdAAmztd+xR8uLFsiQLfIZ4NarE+D
 hDHS8GWmRxQ+1pUspDpUrjSF5d2aensQ16ZUIPvMSvfbZ6EiZFz2oEveWrnQxZvo+C61/LfiXUd
 82+2Cr+0HGgBZEsEfdhB6umAdbZsv47PjIFMjhUoEG2jq+yclCKwnxns+QxwQnzym8zynurTvjr
 hTvP1+2Ru6GEm7IoukRFl+TNWxT5XRGG7pZSSFkO2EIh8X9UE0+yOOO+1DyX8eVs0sjCW68+0YC
 my4Nr2TKEG6699DHNQA==
X-Proofpoint-GUID: K9_aAOyzzaKNv3SeMop2eFdYFDTN6Tgo
X-Authority-Analysis: v=2.4 cv=AN2yTM5Z c=1 sm=1 tr=0 ts=6a301974 cx=c_pps
 a=P2rfLEam3zuxRRdjJWA2cw==:117 a=xqWC_Br6kY4A:10 a=8nJEP1OIZ-IA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=NIeLh5r5xWi6Lh3APS4A:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
 a=ODZdjJIeia2B_SHc_B0f:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606150161

On Mon, Jun 15, 2026 at 11:02:22AM +0530, Gaurav Kohli wrote:
> 
> 
> On 6/9/2026 4:27 PM, Dmitry Baryshkov wrote:
> > On Tue, Jun 09, 2026 at 03:52:59PM +0530, Gaurav Kohli wrote:
> > > Unlike the CPU, the CDSP/Modem does not throttle its speed automatically
> > > when it reaches high temperatures in kodiak.
> > > 
> > > Set up CDSP cooling by throttling the cdsp when it reaches 100°C and
> > > for modem when it reaches to 95°C.
> > > 
> > > Remove inherited mdmss cooling-map nodes for Non Modem kodiak variant.
> > 
> > Why? If it is a GNSS-only MPSS, does it not provide any thermal
> > mitigation mechanisms? Does ADSP provide those? WPSS?
> > 
> 
> Hi Dmitry,
> 
> Thank you for the review.
> 
> Since the remoteproc_mpss node doesn't exist on these boards, the
> cooling-maps that reference it cause DT compilation errors. That's why
> we need to remove the inherited cooling-maps from the SoC DTSI.
>  /delete-node/ &remoteproc_mpss;

Ok. Explain that in the commit message. And maybe we need to fix those
boards to provide mpss instead.

> 
> Regarding thermal mitigation for other subsystems:
> ->CDSP and Modem are the primary heat sources based on our internal
>   thermal testing and evaluation.
> ->ADSP and WPSS have lower power consumption and don't typically reach
>   thermal thresholds that require active mitigation
> ->For this, I'm checking with our internal team to confirm if ADSP/WPSS
>   provide any TMD mechanism across all targets.

They do. I've posted the dump of qrtr-lookup somewhere.

> 
> > > 
> > > Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > ---
> > >   arch/arm64/boot/dts/qcom/kodiak.dtsi               | 127 ++++++++++++++++++++-
> > >   .../boot/dts/qcom/qcs6490-radxa-dragon-q6a.dts     |  17 +++
> > 
> > So, you removed those for Radxa Q6A, but not forRB3 Gen2. Why?
> > 
> 
> Ack, this is a miss. will fix this.
> 
> > >   .../dts/qcom/qcs6490-thundercomm-minipc-g1iot.dts  |  17 +++
> > >   .../boot/dts/qcom/qcs6490-thundercomm-rubikpi3.dts |  17 +++
> > >   .../boot/dts/qcom/sc7280-herobrine-lte-sku.dtsi    |  18 +++
> > >   .../boot/dts/qcom/sc7280-herobrine-wifi-sku.dtsi   |  16 +++
> > >   6 files changed, 208 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/arch/arm64/boot/dts/qcom/kodiak.dtsi b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> > > index fa540d8c2615..d345add2d8c8 100644
> > > --- a/arch/arm64/boot/dts/qcom/kodiak.dtsi
> > > +++ b/arch/arm64/boot/dts/qcom/kodiak.dtsi
> > > @@ -3427,6 +3427,9 @@ remoteproc_mpss: remoteproc@4080000 {
> > >   			qcom,smem-states = <&modem_smp2p_out 0>;
> > >   			qcom,smem-state-names = "stop";
> > > +			#cooling-cells = <3>;
> > > +			tmd-names = "pa", "modem";
> > > +
> > >   			status = "disabled";
> > >   			glink-edge {
> > > @@ -4787,6 +4790,9 @@ remoteproc_cdsp: remoteproc@a300000 {
> > >   			qcom,smem-states = <&cdsp_smp2p_out 0>;
> > >   			qcom,smem-state-names = "stop";
> > > +			#cooling-cells = <2>;
> > > +			tmd-names = "cdsp_sw";
> > 
> > I'm going to review only this DT, the comments apply to the rest of
> > them.
> > 
> > So, we have two cases, CDSP and MPSS. Why does CDSP have only 2 cells?
> > Just because tmd-names has only one name? What if we add another
> > mitigation (which can be added in the firmware), do we suddenly have to
> > change number of cells and all the cooling devices to reflect it?
> > 
> 
> As Cdsp has only one relevant tmd to mitigate, so we have used cooling cells
> as 2. But i will change this to 3 as this is backward compatible.
> 
> > Finally. If I understand correctly, these mitigtion mechanisms are
> > provided by the firmware. Firmware differs between the boards. Vendors
> > (in theory) can change them. Why do we list these names here, in the SoC
> > DT?
> > 
> 
> Below are the main reason for this, replied in other thread also.
> Please guide, if i can use qcom_pas_data to define names.
> 
> Following Daniel's series [1], the thermal framework supports
> mapping multiple cooling devices per remoteproc/device via indexed
> cooling-cells.
> 
> 1) The thermal framework's cooling-maps reference
> cooling devices by index (for #cooling-cells = <3>). Without tmd-names,
> there's no way to know which index corresponds to which TMD, as firmware
> may return tmd-names in any order.

You can #define the indices to the well known names, turning those into
bindings.

> 
> below are the changes post new thermal mapping changes:
> DT: tmd-names = "cdsp_sw", "xyz";
> Firmware: ["cdsp_sw", "xyz1", "xyz2",]
> Driver registers: Only "cdsp_sw" (index 0) and "xyz" (index 1)

What if the DT has "cdsp_sw", but the firmware doesn't report it? That's
an error, as it seems.

> 
> This allows cooling-maps like below:
> cooling-device = <&remoteproc 0 ...>  // "cdsp_sw"
> cooling-device = <&remoteproc 1 ...>  // "xyz"
> 
> 2) Not all firmware-provided TMDs should be
> exposed as cooling devices. The tmd-names property acts as a filter,
> allowing board-specific DT to select only the relevant TMDs for that
> platform.

But then the properties should be defined in the board DT rather than
the platform DT.

> 
> [1]
> https://lore.kernel.org/all/20260526140802.1059293-12-daniel.lezcano@oss.qualcomm.com/
> 
> Shall i use pas data to define tmd-names instead of dt ?

Let's settle in the thread with Daniel.

> 
> > > +
> > >   			status = "disabled";
> > >   			glink-edge {
> > > +			cooling-maps {
> > > +				map0 {
> > > +					trip = <&mdmss0_alert1>;
> > > +					cooling-device = <&remoteproc_mpss 0 0 2>;
> > 
> > What does this mean? I assume that the first cell is one of the
> > mechanisms. What is the difference between them? Do we really need to
> > list them one by one here?
> > 
> 
> Let me check, if i can document different tmd's somewhere:
> 
> -> modem tmd used for Modem Processor mitigation.
> -> pa is used for Power Amplifier mitigation.

What does that mean?

> 
> And we need to list them for binding purpose mainly.
> 
> > What do other cells mean? Why are they 0 and 2 rather than
> > THERMAL_NO_LIMIT? How does one come with those values? This should all
> > be documented and explained somewhere.
> > 
> 
> Will change to THERMAL_NO_LIMIT. Let me check, if i can use
> qli doc for documentation.
> 
> > > +				};
> > > +
> > > +				map1 {
> > > +					trip = <&mdmss0_alert1>;
> > > +					cooling-device = <&remoteproc_mpss 1 0 2>;
> > > +				};
> > > +			};
> > >   		};
> > 
> 

-- 
With best wishes
Dmitry
