Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CE7144683B
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:00:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786456846; cv=none; b=Fv2zf89dzvXwfC2aMFVrBdibsDaX5WEeakVpxYtHt3NGN4Cng7UgYXLuJ850wWE8EMQBZd+h13Y5Cvr2thpfKxfcsJvV8IoR6KSiOBRZGfpp3YdmvWuGcvOL5xCoWapg+MeQMH5dG0qQ5koffgbgP9rMa5QHnC1j+qUdaeXbrkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786456846; c=relaxed/simple;
	bh=NPWy3LJ19/ZHlEUCNDJG3YX0skdSxRcJW3cfC554JDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LR7roq95Fo83cO+QPseiMenfJk/qTCRBz4GnhFEEw0U3UO8hxUC0FMNpV62a7BC1svhiY/A3IAcq8FCNIqh9IS7CdVPAnVdM7mp+aOQdI64SWsBSaFDZSveFHqOj8gnCxh+UOM8ATOLOiYdT38/X36ntHJbkbE0xSw3RwG/bA7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Eeoi/Y5t; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CTrnKjfE; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eeoi/Y5t";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CTrnKjfE"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BDX2hd3719136
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:00:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	43VxZJ/ASK3ebdYTQtBiIEzFiespXvzS0EyFkM0Yi8I=; b=Eeoi/Y5t9LNrNAld
	R2DD6f/qL/zIV+1Q1H4pO/OoYvvgK1nhsC0p7dH2EGAEpSRTG7FIB4GjHK6R6VV2
	rDM0CF4uQHExWK1HIEYkFdJGDPBqRk8cxSG+iA+6vtZvoUUW3QJDh68ejHl+Em+w
	YAZhgsJHWuH3iNeAAvqD5Zksxwfu5CoCTS2Yu2M2YFz8HwE2cJSNo7M4TC6qEKX/
	NbTsuya12DfqRaj+uCfbNPnhrldWLYqKLtpEjzocbEVhl4jkw/MoeFccBC3j7Y7E
	oK8d07QLVzASdgGFpqBu2JpidJvJNw9Y/3KN8HbhQYBtaYjYcSdCKqKZXTtWHQMY
	aoArqQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyxwesjt3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:00:38 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e9a2b95b5so535806885a.2
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 07:00:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786456838; x=1787061638; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=43VxZJ/ASK3ebdYTQtBiIEzFiespXvzS0EyFkM0Yi8I=;
        b=CTrnKjfE4JNj0Ni8SaxIdB34jwCUOUdUomyUuDW0F2B8jUXkpA4R9q5akQs987hLpK
         MEv8QmgnnZv0B1gK2f+PBTzlRlnj8AqgQc6SFVhIcFweJ1cl42oo8FhG6kOxOJWbca42
         nnRPvQ1WaDNCE/gLPtzOd1FV9bjaTISXmxtf7+GV4wcZn4jWW3r7w7hukwOvfSHGARty
         HD/r89q75gC9OWZnlQtxVfYCK1j1CMe3GWgszgGgXMuCWMeaREJbOAPLhcxmT0uL0/Oh
         YHh8QgueiGiXkqSdCNJWAg4EXkO9+4zX9rj/tmzMlWVmkTmpyuqHSNANjySrZyhyrMeH
         W6SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786456838; x=1787061638;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=43VxZJ/ASK3ebdYTQtBiIEzFiespXvzS0EyFkM0Yi8I=;
        b=NA6wKY4rdMn2IPIulZ6jMxax154Li/StJ0feyvMTBUW5LUVBNdBmBjg6rtHIlp+XiE
         At0UHB+yiY+H8GtAsvzMbI0JzP7V9B+OAOpKFal1VPuAPFIoU31QmN0Mk49J0GjiG1Zg
         TZQ89tKP/ZtaeiZOJKIe0Fl9bU2BfGIpP7dsWEU2egYwTciGsIADjHWdUPso/iYyacW/
         ncyYVbGjMqOHETZ4HNowxIpTIAOqPp5woQ96BD9zNzbvGMxSD8iHKFZ6QpQcQNI+xGGf
         MTUyHvjZacavwlRLMwNtiZCYhSkx2/C6hqAy3tLyHboV9CtOOcY7khLT+057CfdG8pDX
         mUSw==
X-Forwarded-Encrypted: i=1; AHgh+Rr2GvZQ6L+QPzU/lXbsOyqmSLD0TYw0X5VgBauTw/H7sLjAMAxB4ZqgOe3TevsEkGSnx2okzyFhHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyN9B9vzVbHMjOXCBy5y7tasuZj/I1UFObsPBaIdLTKp9H06J+w
	SqdDXibUL4i29WAjHOvC41XolfHrbeAm/ww6RJRGEq/B5Z5hv5g+CoKmHRZZBxK6lSjgZ8JkK8q
	T6mt1rsxHBlpoDug2Ne0Y82p+0QBRaiuhbDZYcVjbUDsOzSmLjBZ+pdM/WpQvgg==
X-Gm-Gg: AR+sD13h0wyncJ4lyPOLxRZ93XtEvRE1Y5gO4vYieEhdN31/rIo33mNWJhf66IgEiLH
	61TRqFg2IfT/oqDiHlvkJezVQ1m0GaP1nTBuHSRG7iaWxZ/2E4TSN9mPZXU2e/4uNgI+C4PsWLR
	m8shtIPc6b8GpS0FP9uNbVN1Qlk7Ilpl0J8GICkRLg5+BA/MrtynynR28f8is0F5xaSoqEpDZpz
	7CKWgmaIpLOQKPYelKxkEA7jEVNgY7XGdrtMDPu066XioyiA8tyDcDzH+vt9vnEXG7xiptvlfgq
	fJsxGG6+ImJUnjDLvYUYCs82OM0qowIGRiFUxEpJGGV0/RFMW1yCKa7Y7FeGJusxLOny70UBZW8
	rR2Ppl6NqOQH0PxWGyeX9KmDYM/pB0kqJnhL0ZneYv1NCCr62EcqrDDYWFEKqCII/eL2cNMvUXp
	CtilLD8nVL2oNZQA==
X-Received: by 2002:ac8:5f54:0:b0:51b:eb55:2916 with SMTP id d75a77b69052e-52d5860dbb9mr26160461cf.34.1786456837709;
        Tue, 11 Aug 2026 07:00:37 -0700 (PDT)
X-Received: by 2002:ac8:5f54:0:b0:51b:eb55:2916 with SMTP id d75a77b69052e-52d5860dbb9mr26158271cf.34.1786456836761;
        Tue, 11 Aug 2026 07:00:36 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b448724e50sm327065e87.46.2026.08.11.07.00.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 07:00:35 -0700 (PDT)
Date: Tue, 11 Aug 2026 17:00:33 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
Cc: djakov@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
        krzysztof.kozlowski@oss.qualcomm.com, odelu.kukatla@oss.qualcomm.com,
        raviteja.laggyshetty@oss.qualcomm.com, vivek.aknurwar@oss.qualcomm.com,
        quic_afilipov@quicinc.com, loic.poulain@oss.qualcomm.com,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/3] dt-bindings: interconnect: Add Qualcomm CAMNOC
 ICC binding
Message-ID: <fg6pzufv6u7wgx2smzh3oes53vdte7wynbgc6ias2yjuff4opa@l2ok3e6nyeja>
References: <20260807114951.4164439-1-atanas.filipov@oss.qualcomm.com>
 <20260807114951.4164439-2-atanas.filipov@oss.qualcomm.com>
 <2ssduce25rimjg7bry6dxzrf2d4f7msqqa2lvukwuxxacm36yc@lylvi42lwmm3>
 <65c47a9b-5f1d-4e17-bbed-4c37369025ff@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <65c47a9b-5f1d-4e17-bbed-4c37369025ff@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDExNiBTYWx0ZWRfX9i8Cl2Xja3N2
 6f8mm43eORQccCIMHOMK343BEc2oxkX3ESQWa41EW3REBgFyj+DhAN+iAC2ELeb4l3S0DvmrRBi
 GfC2p2+U8FKea/nMvUk8rMOzH99S04I=
X-Proofpoint-GUID: -ZyOecXKMbbGSKqrem-vpFyMa8x5hmUe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDExNiBTYWx0ZWRfX2nfxPMsyEeSF
 lAU1+WysV2GxgOFZnA2hM67p/q7m6x2IygaZfwIBBhxA0zH0yLQNwtjs0/Q89pNWPZKKJj6ArhS
 DEH09zdLehm1XnB/xc3HIg9IYBVxHuK+hvoQ+k3Ry9vFZdcZHMCkYxFJM2b1P8HO1roWgFU5wOm
 S2l6RWnPnGDl4oV+tFoFUUY4TcaF3XYi0D/R8gka2M3prOsUIQNWufRZeRFy5p/rVe+s2MLoK5Q
 cI+cKeln43o1ZTWzn7OkWNJNuiWklVBvngxIJg9Sjvr/dMAl1vGgXTHboJiyiaFwzejw663HaOP
 dJNoUudGEaSEeGyPBP/mkO93H5LOVZbkew5wxDtS9xh0I2rPh2hGz1cXsLfBXPUGc1MjOad3R+b
 HG8FJWa7Bg0TOkzTkau1H1KOHVkqfg==
X-Authority-Analysis: v=2.4 cv=K8QS2SWI c=1 sm=1 tr=0 ts=6a7b2b06 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=gEfo2CItAAAA:8
 a=EUspDBNiAAAA:8 a=COk6AnOGAAAA:8 a=M_pLgmAVH1dBIuucIvUA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-ORIG-GUID: -ZyOecXKMbbGSKqrem-vpFyMa8x5hmUe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_03,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 adultscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2608110116

On Tue, Aug 11, 2026 at 02:59:04PM +0300, Atanas Filipov wrote:
> On 8/8/2026 12:12 AM, Dmitry Baryshkov wrote:
> > On Fri, Aug 07, 2026 at 02:49:49PM +0300, Atanas Filipov wrote:
> > > Add a device tree binding for the Qualcomm Camera Network-on-Chip
> > > (CAMNOC) interconnect provider. CAMNOC is the internal AXI
> > > interconnect within the camera subsystem that arbitrates bandwidth
> > > between camera sub-devices and the external memory interconnect.
> > > 
> > > The CAMNOC ICC provider aggregates bandwidth requests from multiple
> > > independent consumers and scales the CAMNOC AXI clock accordingly,
> > > avoiding the race conditions that arise when each consumer calls
> > > clk_set_rate() directly on the shared clock.
> > > 
> > > Signed-off-by: Atanas Filipov <atanas.filipov@oss.qualcomm.com>
> > > ---
> > >   .../bindings/interconnect/qcom,camnoc.yaml    | 98 +++++++++++++++++++
> > >   .../dt-bindings/interconnect/qcom,camnoc.h    | 12 +++
> > >   2 files changed, 110 insertions(+)
> > >   create mode 100644 Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
> > >   create mode 100644 include/dt-bindings/interconnect/qcom,camnoc.h
> > > 
> > > diff --git a/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml b/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
> > > new file mode 100644
> > > index 000000000000..b2f5c140ff80
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/interconnect/qcom,camnoc.yaml
> > > @@ -0,0 +1,98 @@
> > > +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/interconnect/qcom,camnoc.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Qualcomm Camera NOC (CAMNOC) Interconnect Provider
> > > +
> > > +maintainers:
> > > +  - Aleksandar Filipov <quic_afilipov@quicinc.com>
> > > +
> > > +description:
> > > +  The Camera Network-on-Chip (CAMNOC) is the internal AXI interconnect
> > > +  within the Qualcomm camera subsystem. It arbitrates AXI bandwidth
> > > +  between camera sub-devices (IFE, JPEG, BPS, etc.) and the external
> > > +  memory interconnect. Multiple consumers may independently request
> > > +  bandwidth; the CAMNOC ICC provider aggregates these requests and
> > > +  scales CAM_CC_CAMNOC_AXI_CLK accordingly.
> > > +
> > > +properties:
> > > +  compatible:
> > > +    enum:
> > > +      - qcom,sm8250-cam-virt
> > > +
> > > +  clocks:
> > > +    items:
> > > +      - description: CAMNOC AXI clock
> > > +
> > > +  clock-names:
> > > +    items:
> > > +      - const: camnoc_axi
> > > +
> > > +  '#interconnect-cells':
> > > +    const: 1
> > > +
> > > +required:
> > > +  - compatible
> > > +  - clocks
> > > +  - clock-names
> > > +  - '#interconnect-cells'
> > > +
> > > +additionalProperties: false
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/qcom,camcc-sm8250.h>
> > > +    #include <dt-bindings/interconnect/qcom,camnoc.h>
> > > +
> > > +    camnoc_icc: interconnect {
> > > +        compatible = "qcom,sm8250-cam-virt";
> > > +        clocks = <&camcc CAM_CC_CAMNOC_AXI_CLK>;
> > > +        clock-names = "camnoc_axi";
> > > +        #interconnect-cells = <1>;
> > > +    };
> > > +
> > > +    /* Example camera sub-device consuming the CAMNOC provider above */
> > > +    camera-subsystem@ac53000 {
> > > +        reg = <0x0ac53000 0x1000>;
> > > +
> > > +        interconnects = <&camnoc_icc MASTER_CAMNOC_JPEG
> > > +                         &camnoc_icc SLAVE_CAMNOC_AXI>;
> > > +        interconnect-names = "camnoc";
> > > +
> > > +        /*
> > > +         * Optional: an operating-points-v2 table lets the consumer
> > > +         * drive its CAMNOC bandwidth vote from the same OPP that
> > > +         * selects its core clock rate and RPMh performance state.
> > 
> > Is this a table for the camera-subsystem or for the CAMNOC_AXI_CLK? In
> > the latter case, the OPP table should be a part of the camnoc device.
> > 
> 
> The OPP table in the example belongs to the consumer device, not to the
> CAMNOC provider. It describes the operating points
> of the camera sub-device itself: core clock frequency, RPMh performance
> state, and CAMNOC bandwidth vote bundled together in
> a single OPP entry. The opp-peak-kBps field is the bandwidth the consumer
> passes to icc_set_bw() when it transitions to that
> operating point.
> 
> This follows the standard ICC consumer pattern: the consumer owns the OPP
> table and uses opp-peak-kBps to drive its bandwidth
> vote. The CAMNOC provider has no per-consumer bandwidth table of its own —
> it only aggregates the votes it receives.

And because we only select the max of the votes (via the peak kBps)
instead of summing (via average kBps), we can't end up in a situation
when the final CAMNOC vote would require higher voltage than the one
specied by any of the consumers.

I agree here, but it would be nice to point it out in the commit
message.

> 
> The comment in the example was perhaps misleading. I will reword it in v2 to
> make it clear that the OPP table belongs to the
> consumer and that opp-peak-kBps is the ICC bandwidth vote, not a clock rate
> table for CAMNOC_AXI_CLK.
> 
> > > +         */
> > > +        operating-points-v2 = <&camera_opp_table>;
> > > +
> > > +        camera_opp_table: opp-table {
> > > +            compatible = "operating-points-v2";
> > > +
> > > +            opp-100000000 {
> > > +                opp-hz = /bits/ 64 <100000000>;
> > > +                opp-peak-kBps = <22246>;
> > > +                required-opps = <&rpmhpd_opp_min_svs>;
> > > +            };
> > > +
> > > +            opp-200000000 {
> > > +                opp-hz = /bits/ 64 <200000000>;
> > > +                opp-peak-kBps = <44492>;
> > > +                required-opps = <&rpmhpd_opp_low_svs>;
> > > +            };
> > > +
> > > +            opp-400000000 {
> > > +                opp-hz = /bits/ 64 <400000000>;
> > > +                opp-peak-kBps = <88983>;
> > > +                required-opps = <&rpmhpd_opp_svs>;
> > > +            };
> > > +
> > > +            opp-480000000 {
> > > +                opp-hz = /bits/ 64 <480000000>;
> > > +                opp-peak-kBps = <106780>;
> > > +                required-opps = <&rpmhpd_opp_svs_l1>;
> > > +            };
> > > +        };
> > > +    };
> > > diff --git a/include/dt-bindings/interconnect/qcom,camnoc.h b/include/dt-bindings/interconnect/qcom,camnoc.h
> > > new file mode 100644
> > > index 000000000000..a03f5e3f6446
> > > --- /dev/null
> > > +++ b/include/dt-bindings/interconnect/qcom,camnoc.h
> > > @@ -0,0 +1,12 @@
> > > +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause */
> > > +/*
> > > + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
> > > + */
> > > +
> > > +#ifndef __DT_BINDINGS_INTERCONNECT_QCOM_CAMNOC_H
> > > +#define __DT_BINDINGS_INTERCONNECT_QCOM_CAMNOC_H
> > > +
> > > +#define MASTER_CAMNOC_JPEG	0
> > 
> > I guess, there are other connection ports. Please describe them.
> > 
> > > +#define SLAVE_CAMNOC_AXI	1
> > > +
> > > +#endif /* __DT_BINDINGS_INTERCONNECT_QCOM_CAMNOC_H */
> > > -- 
> > > 2.34.1
> > > 
> > 
> 

-- 
With best wishes
Dmitry
