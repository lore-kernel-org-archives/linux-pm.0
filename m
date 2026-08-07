Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A282D3F39D7
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 09:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096642; cv=none; b=AxKz0dBEd/jMC6hGB4y+4COrw2ALvnGKMf+XgkDNP6Oc0eDI9Fqej9tWGJNiEGWuGHt7v+K64SKt5F/AvcomTQZYmNLQRtksKA/BrhRbPQCgOcUCsDBW92R5FXuyzjv/fPKrblT32yB3tABaZqqRJ6Vx/khEkPeK0SzMLbzhryg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096642; c=relaxed/simple;
	bh=wFUyEBwydG9qId0K6HY8JSb9tKRnMQzKvHaoEgkKfM8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M5PbCF1Zy+xeuiqQyfOSazNPQveQFuSIGRGZGgJUzqJ/7oOJTOFjohZ/tm2rMFrdttPF22NsfXTDCNM62Ni09fw3b6Lum75NzS6yWO3hJKP1JGVT4lgavNPFVU3+ZeNgTDZTLQti402dKcpQNPFSxSWECXUnfI7JK6O1ldRFiTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=BcoHgmbW; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KqMJu7OS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="BcoHgmbW";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KqMJu7OS"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6777hPdV3533343
	for <linux-pm@vger.kernel.org>; Fri, 7 Aug 2026 09:57:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=14z5z91eG3xJmg4Pw6J1/sgK
	CXaJLKsMSXte81Jepl8=; b=BcoHgmbWI2lYYRJK3S1JyMvL6MRmj7fWpu2xUQ+o
	EI25LcgDehiQD1VfIBf2HJLbeQ9K8ebSP2RUtEhs/+SE5yTbiw1t4Dfo2B0LbBFo
	4FpXWVFELciUBukeU23qyvrza9pmukWvSVUSpdIJhyTn7dJcoZd0oXkezNkWoEaR
	lnwzOORfzr5OJQTiiN9d/HEArMx+8mV2w2USejH++tGJTXtmn7K37+H7cGiF5LIV
	AoIj/55rMBR1HiW5rWN4bpcxd+r3AHu/EKyLQRy1aXe8ShDzikLTlRqau85oavCI
	evc6fJ1Mn/pUhD9tvMkkM7jgNXwKXN+2nCSuC0CgZcgEgA==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fvy6fuent-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 09:57:19 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id d75a77b69052e-51bf321d786so34552321cf.1
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 02:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786096639; x=1786701439; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=14z5z91eG3xJmg4Pw6J1/sgKCXaJLKsMSXte81Jepl8=;
        b=KqMJu7OS8D8Yzrzq0hkrq8uDtB5r6Djmv8dmWU+DUBxqUaMlKDRMWP39TjCQYLaxSM
         qO+hTEs1Dn3DQX2BUQL9+xu480cE0aSdxG/v4Pe83Oi4ESt5osMK8usso9yZf/zaBGw3
         Sjzj4HFBYzr22lSGonPl7H2XVGarfAufdaT/kIxqdgLKzokOMufGWzjOLLVAyOmlWVgn
         /VrL+0U05yXNVynG+1D49EKbEyoHZTPxLsMivkXGaK+1NRmGOBCrQOz8+ViTiI5Ck06Q
         pK8C9okPdEy/Rl+qpFC2dvLP8I2DzDR0yZTG80M5+dy1QDjvLGt+5VkWvYWKXz2OYjF9
         TIdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786096639; x=1786701439;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=14z5z91eG3xJmg4Pw6J1/sgKCXaJLKsMSXte81Jepl8=;
        b=oQCu0HWdNQS3TeaMloWpr7uSAJRY1jhx+na9Nui4C1TQPrryXl0prAJYrfa5SKS8tU
         ZLA6eHG2ChoPcmxPRjF1gjFk7zmoFu/hP3EcazKdKnGYskkbu6VzZkNlJ/Xl+blvuvhC
         t1tGEchvXVtta7wCIy0dBvfMSGgmnkVGeq+uXPlhAUMh4sRiALCP582VGa2MGIBRWDcB
         a/FljwalD7NePHyZmY03szAqpSdzUDkHFiJYCYWeWlarVpHzGsos3TA1ejRstWD7TjUw
         d/13qy6SnH3sQbl81ixHYydcJ380tfja2CUu19dzqWkV/oz/k6n+VmpxRXPwFo2iOh+S
         oF0Q==
X-Forwarded-Encrypted: i=1; AHgh+RoKtyuHjrK9oWmccv75tP5LpufpT6mF6U1z+ttVX9EOP+ReuXPdrp8noybv0jQhhsoYSgTnjBzzDw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz4lSzM+AEpeRp2uFU5yltC1MtGuxxLy4cEL29kmnkUDoZYTY0v
	ccaD0dKS65t0uX2xAp9uv9k8ui8QwaS9wl8jSApKdlJ48y4bGIbSi0tUzym+7NZTcyrHimlnATv
	encbSbs4XYcl1NGBT5juz/IyYS76ghk/sXw3oAwaPHd7RrZQjxkoWhW1/StLwWw==
X-Gm-Gg: AR+sD10/zONaRmiWwiBKdnS1MydX4jSwzVN0olwTkZCLE0xdCMwycTF+yGpEcQUWhbx
	g53PTeIr7mjL5RdeRty8YVdL7LGCGBozTmsthdPUfmjElJ4z7xzkwyYUE4oKEmf76BMScAnJzla
	m7XaNXJdawaB2+bT0nv5MbQCk6LtCrQJscxpPRl8E66bZJr4GJfyNXvKZKA/UfAnR05N4NitVPQ
	O2qYPiFcbZFKGD0/aK67cjP4pUEAiyW6JBXH5hPxt7imQ3oi2dm0wef3XURE7Slc7cM9hGXVbiV
	DaiER7GMHOvcmn4gJbJwkfs+JsGw5x2AkZwFdpmJE9vvcvwwC4Gjm/ZociFhZ0IsH6MKVprFRnk
	balukmZCkj6MGBNMN5CsFoKgIm0lY16/1XQNj9B79HG2Oevs8w+4FVN9SAOv1cPKmn15jREdC6n
	wqSaZNiArHugxqVw==
X-Received: by 2002:ad4:5ce1:0:b0:907:e7e6:9544 with SMTP id 6a1803df08f44-908a6fb7b54mr22407876d6.9.1786096638751;
        Fri, 07 Aug 2026 02:57:18 -0700 (PDT)
X-Received: by 2002:ad4:5ce1:0:b0:907:e7e6:9544 with SMTP id 6a1803df08f44-908a6fb7b54mr22407366d6.9.1786096638277;
        Fri, 07 Aug 2026 02:57:18 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b3050cfa65sm367128e87.20.2026.08.07.02.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:57:16 -0700 (PDT)
Date: Fri, 7 Aug 2026 12:57:15 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Rahul Samana <rahul.samana@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, quic_mohamull@quicinc.com,
        quic_hbandi@quicinc.com, quic_anubhavg@quicinc.com
Subject: Re: [PATCH v2 1/6] dt-bindings: bluetooth: qca: add QCC2072
Message-ID: <dduqm25cy2j3ab7gu65qjho76gifij3sgnvgsgqyvncjxa46x6@vg7egioz5vxx>
References: <20260727-rb3-industrial-bt-uart-v2-0-2d100f30e202@oss.qualcomm.com>
 <20260727-rb3-industrial-bt-uart-v2-1-2d100f30e202@oss.qualcomm.com>
 <20260731-first-righteous-bear-dd72ed@quoll>
 <712f8a14-d2a1-4a90-82f9-05cd694f2658@oss.qualcomm.com>
 <c1875dd6-fe3a-4a69-a6fd-b461c8fba6e4@kernel.org>
 <6d6465bb-47ac-464c-af4e-0ca72325705f@oss.qualcomm.com>
 <8a388310-d3cc-4d02-abb6-0eb98c24cfce@kernel.org>
 <4523441f-498a-4bbd-80f3-97a7a9206c00@oss.qualcomm.com>
 <6e0b9e79-ccd4-4689-9a6b-9b4fc556d5e4@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e0b9e79-ccd4-4689-9a6b-9b4fc556d5e4@kernel.org>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA3NSBTYWx0ZWRfXyxVaS0AbP8lr
 052AWTg91paDnnCqZdklzKsbdmKZ1KPLdqh+zlIcVempXjllTteJqhnBSfFNLrKck2mOxeRDiD6
 WHAldp8S193EhJ9JdItvYZSvSvLRcsv6fiAMCfsQhA9yEPBb+yAf0zBEM2NAdZsCm5lDyD+nxgz
 M4LwKwvrjAuZy6SHqGGXtSdwEfRoZ+5pMUNBpHjcrY2QVj2fsslFVPU3rE8umXjmtceRzQQHfBO
 o0QFEzzRoIGGu6/bexjjFwcfNNrsm4LIr6ImiiQZDFoVPA8g/wUCtXCpOxyX2j2tbPgyjAl+AxI
 34ufIDLo9yhmwfdLdjzCKT3VhmMEvtptMTHuFbXpLAUbwhhm+f9w8vUnsqi8wScu71zOji9VfbQ
 /kS8Vy0pcETqXkfltrXzpXBKujqO/h535WAq/T3J+/Mq3lQrKi3KrLoGM+FMFBoNlLlip5lHlh6
 QVzGH6gOkvMpQd7pL3w==
X-Authority-Analysis: v=2.4 cv=DvhmPm/+ c=1 sm=1 tr=0 ts=6a75abff cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=vuXs5oDAzq-yw9ntQScA:9 a=CjuIK1q_8ugA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: w8lGkacQ8dYkxBFxYFS5PiibvIxt65h6
X-Proofpoint-GUID: w8lGkacQ8dYkxBFxYFS5PiibvIxt65h6
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA3NSBTYWx0ZWRfX8fJFiu0F/NgW
 19p8xyUseuSmReO540CdnaESSX4Zblee98g1gT1FGyJsCjsth3CjKgAdrSP9A9/eAPseGyUk9S6
 Bjp22K+Cvjfb2d0Cj+4lgs+vuzzoaAk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0
 suspectscore=0 adultscore=0 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070075

On Sat, Aug 01, 2026 at 05:49:53PM +0200, Krzysztof Kozlowski wrote:
> On 01/08/2026 17:31, Rahul Samana wrote:
> > 
> > 
> > On 01-08-2026 20:18, Krzysztof Kozlowski wrote:
> >> On 31/07/2026 17:51, Rahul Samana wrote:
> >>>
> >>>
> >>> On 31-07-2026 20:34, Krzysztof Kozlowski wrote:
> >>>> On 31/07/2026 16:45, Rahul Samana wrote:
> >>>>>
> >>>>>
> >>>>> On 31-07-2026 15:16, Krzysztof Kozlowski wrote:
> >>>>>> On Mon, Jul 27, 2026 at 09:15:01PM +0530, Rahul Samana wrote:
> >>>>>>> QCC2072 can be used on M.2 E-key cards where the card power resources are
> >>>>>>> described by the pcie-m2-e-connector node. In that setup, the M.2 power
> >>>>>>> sequencing provider creates the Bluetooth serdev child after matching the
> >>>>>>> QCC2072 PCI function.
> >>>>>>>
> >>>>>>> Integrated non-M.2 designs need board-specific power resources. Document
> >>>>>>> only the compatible for now and leave those properties to be added with
> >>>>>>> matching driver support.
> >>>>>>>
> >>>>>>> Document the qcom,qcc2072-bt compatible used for QCC2072 Bluetooth
> >>>>>>> controllers connected over UART.
> >>>>>>>
> >>>>>>> Signed-off-by: Rahul Samana <rahul.samana@oss.qualcomm.com>
> >>>>>>
> >>>>>> NAK, exactly same comments as before.
> >>>>>>
> >>>>>> Nothing got improved, although what is weird - original SoB is gone, so
> >>>>>> this is legally dubious work.
> >>>>>>
> >>>>>> Best regards,
> >>>>>> Krzysztof
> >>>>>>
> >>>>>
> >>>>> Hi Krzysztof,
> >>>>>
> >>>>> Thanks for the review.
> >>>>>
> >>>>> For the binding contents, I tried to capture the current scope in the binding
> >>>>> description itself. This series supports QCC2072 only as an M.2 E-key card,
> >>>>> where the card power resources are described by the pcie-m2-e-connector node
> >>>>> and the M.2 pwrseq provider creates the Bluetooth serdev child.
> >>>>>
> >>>>> The binding also says:
> >>>>>
> >>>>>   Integrated non-M.2 designs require board-specific power resources. Those
> >>>>>   properties, together with a static devicetree example, should be added when
> >>>>>   integrated non-M.2 support is added.
> >>>>
> >>>> Bindings must be complete and your driver support is irrelevant here.
> >>>>
> >>>> If you claim this is a PCI device thus you do not need any resources,
> >>>> then the binding is not needed either. PCI devices are enumerable. And
> >>>> to prove it: look at your DTS. Do you see qcom,qcc2072-bt being used? No.
> >>>>
> >>>>>
> >>>>> We do not currently have an integrated non-M.2 QCC2072 design, so I do not
> >>>>> have board-specific regulator supplies to document for that topology.
> >>>>>
> >>>>> Could you please suggest how you would prefer this binding to be handled for
> >>>>> the current M.2-only use case? 
> >>>>
> >>>> Drop the binding, you do not need it.
> >>>>
> >>>> Anyway the problem is that more comments were ignored.
> >>>>
> >>>
> >>> Hi Krzysztof,
> >>>
> >>> Just to clarify the reason for adding this binding in v2: 
> >>> v1 did not add a binding because this series only targets the M.2 use case.
> >>>
> >>> I added the minimal binding in v2 because checkpatch reported
> >>> qcom,qcc2072-bt as an undocumented compatible, and I interpreted the request
> >>> to fix the checkpatch warnings as requiring this compatible to be documented.
> >>> I also had the earlier feedback in mind, where the indirect
> >>> qcom,qcc2072-bt compatible was pushed back because it was undocumented:
> >>>
> >>> https://lore.kernel.org/all/20260703-eliza_evk-v1-3-7624440bd76d@oss.qualcomm.com/
> >>>
> >>> Based on your clarification here, I will drop the binding patch in v3 and
> >>> keep qcom,qcc2072-bt only as the pwrseq-created child compatible for this
> >>> M.2 case.
> >>
> >> My previous statement is also valid, please read entire threads.
> >>
> >> You cannot have undocumented qcom,qcc2072-bt.
> >>
> >> I ask you to drop both, because they are not needed. But feel free to
> >> prove me wrong, see my first paragraph in the previous reply.
> >>
> >>
> > The PCIe M.2 power sequencing driver, pwrseq-pcie-m2.c, uses
> > pwrseq_m2_pci_ids to translate the enumerated PCI function into the
> > Bluetooth compatible used for the generated serdev child.
> > 
> > For example, WCN7850 maps PCI ID 17cb:1107 to qcom,wcn7850-bt, then hci_qca
> > matches that compatible to select qca_soc_data_wcn7850.
> > 
> > For QCC2072, pwrseq-pcie-m2.c matches PCI ID 17cb:1112 and creates the
> > generated Bluetooth serdev child with compatible "qcom,qcc2072-bt". The
> > hci_qca driver then matches "qcom,qcc2072-bt" and uses qca_soc_data_qcc2072
> > as the controller-specific data.
> 
> The purpose of Devicetree is not to describe Linux internal driver
> matching. Do not use compatibles for that.

So, if instead of M.2 module the WiFi chip gets soldered to the main
board, the qcom,qcc2072-bt wll be a legitimate compat string?

Also, I understand your concerns about the DT bindings / usage, but
speaking about the driver ;-)
The BT is a serial driver attached to a serial bus. There only two
options to bind a serial driver: OF and ACPI. But maybe we should add
something like serial_device_id and let serials have internal IDs.
It sounded strange in the beginning, but now I think it is a correct way
to go.

-- 
With best wishes
Dmitry
