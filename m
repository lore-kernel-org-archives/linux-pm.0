Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E5EB32AAD6
	for <linux-pm@vger.kernel.org>; Sun,  7 Jun 2026 11:11:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780830685; cv=none; b=tgFdKQf0a/hXonoWotuMmP+5HY8PjrCXMmx1DYc/b6IizJXHR9Y7X1VjOE3wc4sA3HAbniEGNCVRRUoJhJn8KAurlzgSg+eB/h28PX5b8lt4Hz/UcALjnZMZZuaBYfvHOvztMiI3pnAxzzigGTzZDICFJ7PRl8KzdTTKGrkXwfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780830685; c=relaxed/simple;
	bh=sMsp642kKY2y2R6hX/UTzXvkYUwhH5hKMqWVKhO2G1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qe36ziBx0+6St6HQBf++yxC9CbMpIqW6TGhCILEcWT+Gqy3hDVX2BNsCON0fK8qPJ62gFGepiRgPLHAqoF1ynryzlQXa9wl6JSBz5ihunf7WTNubEEu1wiwfuLOwOJyVVGgOnoKg+50jRiwMcbANMOcasOpZR/vmfc3vxL+eiE4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NVqi4toQ; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=jk02n1jH; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NVqi4toQ";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="jk02n1jH"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 657B0utE4080259
	for <linux-pm@vger.kernel.org>; Sun, 7 Jun 2026 11:11:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=NhkfC+zO5m2l38KnMKzme9p0
	QV8URIExTzvGlgOcfvs=; b=NVqi4toQWG/8NpCIEkwap5h7Fh6rO84WOMC1eCMm
	SQoftjUEkBk3NCDA0Oi16HEoabXsX/kMfCxoOoUyN7FhHDzO0Ep6JobAXV0neueY
	FFSa0yv31znli7LKYh6ZGdpc7t3ILP8gx6gPETCfJPX1K7fLxIfPcPD3Ahd1phY/
	eF9wGvNQaT/dXPzGb46vh1hcpFJVKxXrW62FpXxZXGcMWgdo+Fqc/6L1tYV4hfe4
	6QADlQ10UHY8cahv0iXIWkOcYXNS3FjpoFhCSyLKYpZFTfGZzpTk4Fpf84G4v4v/
	n5IIlVpFJLJp2rqP2C7rpH4GFd0UDL3/6BBHMP2Z8v+uSg==
Received: from mail-vk1-f197.google.com (mail-vk1-f197.google.com [209.85.221.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4emcqguc9g-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sun, 07 Jun 2026 11:11:23 +0000 (GMT)
Received: by mail-vk1-f197.google.com with SMTP id 71dfb90a1353d-5a94a743521so2723226e0c.2
        for <linux-pm@vger.kernel.org>; Sun, 07 Jun 2026 04:11:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1780830682; x=1781435482; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NhkfC+zO5m2l38KnMKzme9p0QV8URIExTzvGlgOcfvs=;
        b=jk02n1jHSUalvijTDIy3hXAPO+MkgTnx1ZY21NNr/rZR0PnNKfg3AigGtAHFeNO+D6
         7m+XDzZVO7ZwmGFV4k7eYkcTThNVDUldIFnH1dsjejfqT7gYTyyhyUSD9JQsn7AL74bT
         xWAvkwliIMcHonhVFYx9pi0lYLtqe48RWi6Kp2LaUQZ9R89JLAqcBgriv2MvnwBDjQgm
         7K/wouE4r1pAsTCnx/fpbWBr6iWL47FO7I6Z7VNxdix51X4sw8QWysRdwDR2DQk+UocD
         dGXRF7yns7ser56HEKVmjaOUvOE+YEo7ExHlK1vMAjLBiCcgJy6qWdh5NlGzY9HMlbfo
         h/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780830682; x=1781435482;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NhkfC+zO5m2l38KnMKzme9p0QV8URIExTzvGlgOcfvs=;
        b=IXkisO+i3enka+BvtL4gX5NmihdO9yzfUPI6lOMqru+y934KM8qQQ9FET7LMY0bTjZ
         K2N2wF6vxGk5kTI1E6UuKGKbSuYU/exVG5+5wDMA5aYuHau+Bvg/mVmhU9Od1wFZLsWa
         V+UFEVitrdgcX49mbSeShZU6JtOMbv9v1GsXFH/UCgs7BF1HhzoFdaCRFcyY87OdE8Jz
         MDMq/pUeMTmBPh7M2zs+iJ2OXhi4c2gQrl2LxVPbR0t/8xSz5WuCi/het9lVNGyFf1qH
         WiPyOy2L9ZAPOtRdc/koZJf9A4B3ZG42BJUXTFajrw3RurxrNMjhCK+qd9gdf2ioBVHb
         W0cw==
X-Forwarded-Encrypted: i=1; AFNElJ+ABFbDosEyAqXLaj2nsOBzuZ1oOtD86fMXJGWklLXeKUC37Vglx1Ee7+mvg4FDR8vPCjLRhI2+cQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzA0bHNCF3SBDAW89UvYHZ2akoPbPsVMQDT4E2ggEiwvetu3miA
	9AGBihw/HkEM+JNiAiw/WMlwvUhI96VNpfgxQMr5b+aZ1nIl5Ll8nrMfYS5wQ0BTTLXiBE+E8SI
	70DQiOf7/V05ZkcjGspxs8Z+7V04g1vu+p3XR6d/56yzI0zgpFwbW+iSUCvSPvZLwI2mcTQ==
X-Gm-Gg: Acq92OEajXpGa3MZN+lvZPyDLfwK0uMyKbUMOss5YjrT1gaOkNksPaQqw54totHWyxb
	WZr7Rcpt4agT5SukkX1+2xi9t3nkil2CdnFpHJ2P+Y5ehUKkajZoW/zem1/Wn+m0vNuY2G/DwiU
	FFmwwA+cuzhlLXgZ9E1s/0tWvEZ4RCDnRiF7LjuXuL7jQubBWKvmU4CXqqVE5byyHUNDVVr4oof
	cqtQEZpZaOAjc+dQB47UTIt3XdKxKQzD4s6Ebxp564jBOSIlosxwwgJZkn7EKLKdf2HHsVKM1eQ
	Hms+U/Izwyf0ZJEfZHQmOslH3TmWETnQbj4VFllus76vK0rS9x9SyYslT1zTwp9EXU+PVYRQB7f
	xW7o9I8qNGWU9Oti2aXi9FwnWiOBj3Y4E+ow3A/kK8B1MHTRURqQSrwkXZN0gSP6W0KCAEWmsG8
	PfYkWDryqcqh27D5tX0ruWxQpZhFEa6/m6jIkKMxDsewnJoQ==
X-Received: by 2002:a05:6102:1609:b0:643:80f1:33d8 with SMTP id ada2fe7eead31-6ff0294a345mr5115491137.4.1780830682065;
        Sun, 07 Jun 2026 04:11:22 -0700 (PDT)
X-Received: by 2002:a05:6102:1609:b0:643:80f1:33d8 with SMTP id ada2fe7eead31-6ff0294a345mr5115485137.4.1780830681536;
        Sun, 07 Jun 2026 04:11:21 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa7b8fba62sm3068943e87.19.2026.06.07.04.11.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2026 04:11:19 -0700 (PDT)
Date: Sun, 7 Jun 2026 14:11:16 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: github.com@herrie.org
Cc: Georgi Djakov <djakov@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] dt-bindings: interconnect: qcom: add msm8660 NoC
Message-ID: <xhuunpe34foapf7klna4otsyw3nah3ihb6frjw2omzrc53vhzm@qbzrnrdinehn>
References: <20260606-submit-interconnect-msm8660-v3-0-f9da0158cdf8@herrie.org>
 <20260606-submit-interconnect-msm8660-v3-1-f9da0158cdf8@herrie.org>
 <wypnu53w5pesj52zyrj3pydqzf2rbfrxa72uplz3mq64u447wf@gypyaug7iwkd>
 <d6a95e9626845469764a11587ed65c7e@herrie.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d6a95e9626845469764a11587ed65c7e@herrie.org>
X-Authority-Analysis: v=2.4 cv=dJGWXuZb c=1 sm=1 tr=0 ts=6a2551db cx=c_pps
 a=JIY1xp/sjQ9K5JH4t62bdg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=gEfo2CItAAAA:8
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=cTwmTnRGAAAA:8 a=OCxULHVomhrf1m7jPP0A:9
 a=CjuIK1q_8ugA:10 a=tNoRWFLymzeba-QzToBc:22 a=sptkURWiP4Gy88Gu7hUp:22
 a=cvBusfyB2V15izCimMoJ:22 a=GUWCSGlMWfG-xDt5EnV5:22
X-Proofpoint-GUID: c7B9dn4PNSAserbI9fnCt2c2SIqKI6G9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA3MDEwOSBTYWx0ZWRfX9tfn4tk8dngN
 CxQgyb1oTcJvrNiVW33lYw30TanzN51mkxxA8AYoEzTjErLKCQ8uuJJdebmOAMtR4mJVw0O6ol9
 gguXw2cUvbZuk4ZPCvyeyQIP6DkRFlspDNh1PfFWd0yExk5ZNDGA0zuMZ2LOcbDQ2e3O+GJ1t7s
 hYgKpeCv+M9xA/KqW22GHjLBMe/W3yY9YSliixe820f7QFDoAkpKsLJzS6JEDtbNVkiYLJmOoNr
 A9anVHBCmiqrMU/GqxCDNZT1DsPA+Z0QNtQ4qYRMW5RqetWCKyeG1IfAEnX1YyETyAjbrSCFRJh
 GtpnacSrzpK0aDkaJRgxPumP77kjC/euB3z18beuUnSoICBybf2WfdZFRHtyVCVaHkj1Rc+1rcn
 XIcklENEc/Al9Euc5VzxIDnVi7KuCqnW+77m819oFSGhsJBdRTAlbpJy/2S76DUUeHh2z+juS2+
 7+r0sJTmE9IT7iBA9+g==
X-Proofpoint-ORIG-GUID: c7B9dn4PNSAserbI9fnCt2c2SIqKI6G9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-07_03,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 adultscore=0 phishscore=0
 clxscore=1015 lowpriorityscore=0 impostorscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606070109

On Sat, Jun 06, 2026 at 04:32:21PM +0200, me@herrie.org wrote:
> On 2026-06-06 15:23, Dmitry Baryshkov wrote:
> > On Sat, Jun 06, 2026 at 02:34:50PM +0200, Herman van Hazendonk wrote:
> > > Add a dt-binding schema and an interconnect master/slave ID header for
> > > the MSM8x60 family (MSM8260/MSM8660/APQ8060) Network-on-Chip.  The
> > > chip exposes four NoC fabrics that the qnoc-msm8660 driver models:
> > > 
> > >   AFAB  - Applications fabric (Scorpion CPU + L2)
> > >   SFAB  - System fabric (DMA, SPS, security)
> > >   MMFAB - Multimedia fabric (MDP, GPU, camera, video, rotator)
> > >   DFAB  - Daytona fabric (SDC, ADM master/slave)
> > > 
> > > The schema covers all four compatible strings, per-fabric clock-name
> > > lists (bus / bus_a / ebi1 / ebi1_a for AFAB; bus / bus_a / smi /
> > > smi_a for MMFAB; bus / bus_a for SFAB and DFAB), the required
> > > qcom,rpm phandle through which the provider hands the arbitration
> > > buffer to RPM firmware, and #interconnect-cells = <1>.
> > > 
> > > The ID header lists per-fabric master / slave / gateway indices
> > > derived from the legacy vendor msm_bus_board_8660.c enums,
> > > normalised to the upstream interconnect-framework naming convention.
> > > 
> > > Assisted-by: Claude:claude-opus-4-7 Sashiko:claude-haiku-4-5
> > > Signed-off-by: Herman van Hazendonk <github.com@herrie.org>
> > > ---
> > >  .../bindings/interconnect/qcom,msm8660.yaml        | 166
> > > +++++++++++++++++++++
> > >  include/dt-bindings/interconnect/qcom,msm8660.h    | 156
> > > +++++++++++++++++++
> > >  2 files changed, 322 insertions(+)
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/interconnect/qcom,msm8660.yaml
> > > b/Documentation/devicetree/bindings/interconnect/qcom,msm8660.yaml
> > > new file mode 100644
> > > index 000000000000..ff28c7d46c32
> > > --- /dev/null
> > > +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8660.yaml
> > > @@ -0,0 +1,166 @@
> > > +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> > > +%YAML 1.2
> > > +---
> > > +$id: http://devicetree.org/schemas/interconnect/qcom,msm8660.yaml#
> > > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > > +
> > > +title: Qualcomm MSM8x60 family Network-On-Chip interconnect
> > > +
> > > +maintainers:
> > > +  - Herman van Hazendonk <github.com@herrie.org>
> > > +
> > > +examples:
> > > +  - |
> > > +    #include <dt-bindings/clock/qcom,rpmcc.h>
> > > +
> > > +    interconnect-afab {
> > > +        compatible = "qcom,msm8660-apps-fabric";
> > > +        clocks = <&rpmcc RPM_APPS_FABRIC_CLK>,
> > > +                 <&rpmcc RPM_APPS_FABRIC_A_CLK>,
> > > +                 <&rpmcc RPM_EBI1_CLK>,
> > > +                 <&rpmcc RPM_EBI1_A_CLK>;
> > > +        clock-names = "bus", "bus_a", "ebi1", "ebi1_a";
> > > +        qcom,rpm = <&rpm>;
> > > +        #interconnect-cells = <1>;
> > > +    };
> > > +
> > > +    interconnect-sfab {
> > > +        compatible = "qcom,msm8660-system-fabric";
> > > +        clocks = <&rpmcc RPM_SYS_FABRIC_CLK>,
> > > +                 <&rpmcc RPM_SYS_FABRIC_A_CLK>;
> > > +        clock-names = "bus", "bus_a";
> > > +        qcom,rpm = <&rpm>;
> > > +        #interconnect-cells = <1>;
> > > +    };
> > > +
> > > +    interconnect-mmfab {
> > > +        compatible = "qcom,msm8660-mmss-fabric";
> > > +        clocks = <&rpmcc RPM_MM_FABRIC_CLK>,
> > > +                 <&rpmcc RPM_MM_FABRIC_A_CLK>,
> > > +                 <&rpmcc RPM_SMI_CLK>,
> > > +                 <&rpmcc RPM_SMI_A_CLK>;
> > > +        clock-names = "bus", "bus_a", "smi", "smi_a";
> > > +        qcom,rpm = <&rpm>;
> > > +        #interconnect-cells = <1>;
> > > +    };
> > > +
> > > +    interconnect-dfab {
> > > +        compatible = "qcom,msm8660-daytona-fabric";
> > > +        clocks = <&rpmcc RPM_DAYTONA_FABRIC_CLK>,
> > > +                 <&rpmcc RPM_DAYTONA_FABRIC_A_CLK>;
> > 
> > Looking at it, I don't think those clocks sould be exposed here. Please
> > follow what Konrad did some time ago for smd-rpm interconnects: add
> > direct voting to the interconnect driver, them drop them from the clocks
> > driver. Ping me if you need help finding corresponding patch series (as
> > there were few more tricks.
> Feel free to send it. This is my first work on kernel ever and to be fair a
> lot of it comes from piggy backing on previous work, legacy kernels and
> insights from Claude & Gemini.
> 
> I can say it "works" for my limited tests, but I haven't run a full fledged
> OS yet to stress test most things.
> 
> HP TouchPad boots, audio works (though no Q6 (yet)), graphics works (Adreno
> 220), camera works (camss & vfe31), video plays via vidc, rotator, vfe
> works, sensors work (ALS, magnetometer, gyro), leds work, usb works,
> touchscreen works. Only thing I'm struggling with is wifi & bluetooth for
> the moment. It could very well be that when I rework things "properly" my
> wifi and bluetooth issues disappear and start to work. This old silicon is
> very unforgiving when it comes to bits set the wrong way.
> 
> So any guidance is much appreciated :)

See https://lore.kernel.org/all/20230526-topic-smd_icc-v7-0-09c78c175546@linaro.org/

Note, it bears some backwards compatibility quirks, which you don't
need, because we never had interconnects on those platforms. The only
issue, as I wrote, is SCM on APQ8064. But, I think, the clock was added
there only to fulfill the bindings. I'd say, ignore it for now.

> 
> As always there are multiple roads that lead to Rome :)

-- 
With best wishes
Dmitry
