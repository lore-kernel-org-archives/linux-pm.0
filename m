Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 888E434678C
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 19:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779305283; cv=none; b=R4zjDS2h0nrORxoZjFpqiPeV5Wd/3nnQMhYI9F5EoF32hqBM71Ij3ACsHJH9iOMI1nx7TvXtSJ63obPO6w4QQzJF9YQstDFVaA5dmFkmNXmo1elRBrwfgVqsRcg0AIAT6q6C4vQk9naJqe+haadtvnNS0p3wRb5f1xXSFT6OlaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779305283; c=relaxed/simple;
	bh=yt8U84SiDNiOBcj3+VaG0c0qI29ReIVNRDRbFKUrqeY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CIlmYQt0O5MJd6KP4FayK7DgP1yUR2kxoOfh7yvwKk5g6fw+jz9cwwti2ZfuzFyK+DqGnG7hNTvhOCYlSs6RVV3eoXkVCH7BRcyRAoOcTMTNKI9qF6S4Dd3hC4Yzr2cWmi7LOdKzR/SCY4hlMOGsEnfHs9It19DolKgLR+hyPwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=EShGzp/p; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=d3Xr2cv5; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="EShGzp/p";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="d3Xr2cv5"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KE2RZC826685
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 19:28:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Cof4BFpLE8vZCh1gO98ccWcI
	wNC66MDdBlVTZ4MDiEA=; b=EShGzp/piJbn2vB2HmeCAIC1oZaEe0Ci7oZxhdl4
	SmFFJo6uDuGCpWhTJfCssLC54nTBO7yo8LHU6ss8GfTbeHZd/quCgo8TX+fSGbXk
	ImdT1yjKVdfi6T6+AwngTd4twe5Sk0j64yY/Ex2iUWsiVOJPE92e0mIrQYLCiXD2
	2BlqrxeSpkigYdNkfF/dyThRbu8R96ZjmhBsF/HULl87qNmw6jktX/eBLZA4PHqM
	6Xlgm9ESGLCqWvxfcll7hmIseSVQOAee1hFmcPCe4LKAvQQapEIJYzNT23HixFxI
	Ayl/vCHd1McTYlqhKpn4WPIOSPAyx6mBq0CE2pY+rMTnNg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e9ecahees-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 19:28:00 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-50d5d1c2289so156263181cf.2
        for <linux-pm@vger.kernel.org>; Wed, 20 May 2026 12:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779305279; x=1779910079; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=Cof4BFpLE8vZCh1gO98ccWcIwNC66MDdBlVTZ4MDiEA=;
        b=d3Xr2cv5UB14kTG+GawAddoFuwI4df37wsDY1z86GtNaGPPl157o5sLg7GJBIMdERK
         ORhfr33npSrnoDYHFLI9mWw63dLV8RdQRd3u+WLviwVNuPmZDpc5eENErJwvJW77IE3v
         wFPOPylnZFENghErUgvX3Qaw54+hI0wWkJvMe51qfTek/0EBchB/xx0jM2SCgbjUcmxS
         0AWVCtcMaiFPxmmyxsoTzy/Ur/Ytji2niZpTlzrBq17jpEUKi8fNruXa3DKpq4wbrDLV
         VeVqAcZWHnrrb8oB86WOzA58mbeIlbQsIhAKu7V5rtLyKAaLpPaEhFNRRktff1XtA08j
         hyMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779305279; x=1779910079;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Cof4BFpLE8vZCh1gO98ccWcIwNC66MDdBlVTZ4MDiEA=;
        b=O79uOOIMHq6N3QYdmjbErD488hs9Hfq5YpYRdPPzrQfNRdT3V61CqlCE8Bqdfh3egd
         yk8SSJhXdycL18kVMYdgitzzK6SnQwHpVzfd8YwL0gRIdIISuDXNOgfsesO6LWL82t3w
         f1W4zs2MIqnvbyQ+WR1ro3p4QWbcKhjJ5TRMhkIiWFm5ntH7cbBvxvAG/FLIo0r6QrLC
         ns7JhmyImWLfAF+YXuqGZwYB9Cw89AGPDGiWhCmszymudQZzKzJbJfOCYwtEXxsDM6lm
         Lz8yznUj5VRaAdMRbiC04LTMOFnoPG61UZdtRc/jaMtptVrYo5iNc0PVfFpYhb7re0hx
         sk+Q==
X-Forwarded-Encrypted: i=1; AFNElJ878qhK2tgZCl6q8vex4pC74uapiJTm8GSVcSC1l4LU5MZiv3C8WHABRV8gFFS2GoID8aobvdGxzg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwpPWX6SAMFhwwOmS3hn+sk7XlNGvpW5130VbFuhMFc0hKXywCN
	M+eti2Jn3sEhs8O6zsLUFxwB6IBxZrUftpSE7sYS5GCuOvvHyPLJ41RcrxlxdAufm666DwGXDxQ
	2bEB5xGl/YNDyNB4Nea/wodVHEYcd23V441te195JhOsN3U74E+3dpT4+F7UGMA==
X-Gm-Gg: Acq92OEN5LRLEzV9UX6AcYBDY94H+pEDB8U5D/Q4nmdZ8KSAZgOX17D00i/QfgKJm6s
	V8it3EsmAt3NK3YTnqRpFm4P+yoDoyIB8KmpwfAXS17d5dplFBmjLEMYxg8ANwUfjuoQfispRII
	79mkvN13tj6OQQCDw+9caHTLr/9JEvq3BnR25Lg0gFRBwrVsQGR8esTlgcikPEAaldnWWAqoA82
	zvSAz3T0bmo2aPsSjw2khnUsiuApzJ4wavvVZXbgdTVM3prbtkPILJ1ZGpDBn29hL50VlZmvMrg
	GWf9ODYW3ocZPh/ezFfs8J4WbJVdcYx6rx98AB5cyKI8p+/SRTmy/3H8UNYTtM8mLCJDQWhhkJk
	EzQsxZHi2ct7z7K8IHP5UZSx7TV5IarKZn+NTTPK2X9agxrqmiyYtTVcsRxSrfeIXn5cNtPeR6U
	0wwe9e4WbgbsrbZDT0LE+b7UMmIzB3/sFm/fw=
X-Received: by 2002:a05:622a:3d0:b0:50b:4e60:93b7 with SMTP id d75a77b69052e-5165a20d00cmr344523691cf.43.1779305274414;
        Wed, 20 May 2026 12:27:54 -0700 (PDT)
X-Received: by 2002:a05:622a:3d0:b0:50b:4e60:93b7 with SMTP id d75a77b69052e-5165a20d00cmr344523161cf.43.1779305273869;
        Wed, 20 May 2026 12:27:53 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-395882c74d6sm31850691fa.15.2026.05.20.12.27.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 12:27:51 -0700 (PDT)
Date: Wed, 20 May 2026 22:27:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Georgi Djakov <djakov@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>,
        Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Rajendra Nayak <quic_rjendra@quicinc.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: interconnect: qcom,x1e80100-rpmh: add
 clocks property to enable QoS
Message-ID: <7oador7jxw443astffc6hjuf3gots64fqmvsjdsshfhhonc2l7@2unu723p2orx>
References: <20260422-x1e80100_qos-v1-0-bcc2afe4cc78@oss.qualcomm.com>
 <20260422-x1e80100_qos-v1-1-bcc2afe4cc78@oss.qualcomm.com>
 <20260423-thick-beneficial-capuchin-e4aaad@quoll>
 <99830e85-5837-4ed5-8f89-fea5d3e632f8@kernel.org>
 <c583a03f-381d-4af9-acb0-ac47a1e35b47@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c583a03f-381d-4af9-acb0-ac47a1e35b47@kernel.org>
X-Proofpoint-GUID: qs3wyAJXG8nR_7uiS2y-SqGnOg_q0rUT
X-Authority-Analysis: v=2.4 cv=WqMb99fv c=1 sm=1 tr=0 ts=6a0e0b40 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=Qe6B47XUAAAA:8
 a=EUspDBNiAAAA:8 a=mpWlrPG02yKYcU8NnnEA:9 a=CjuIK1q_8ugA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=QWPKR-PWjQKaio0naagv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE5MCBTYWx0ZWRfX85wfW4KOBB8w
 l1jibCy9tkFBwZEcq6e1ldwNFgCMgfYPT5DFUbaUVu6HfN3BEcBiu/LLwxWKYNqS/GhsuIul9Yf
 hxC5n55bzlFgAkMQ62KEfoVHV8D5OI2f8y+jwqzjvECMe9j3dAsC3SQt/EieiQiIB6SyR35soTR
 0XrwhoiEe4D99U1ypr12+xhBip79FOSZOcvE4kW7KtjHPzTrBHAbBJ+PNeoZjzVu3KrvXI0/M62
 obDSkyCQPuHm0FdMdAnwMLa65g9bk+M86xCODwpYpZ8Kq5JnzjXsv/T/0UgeEIa5m9ENPDoy2RY
 awjWtrCig8F2gHoQRwhhAe5uXoXCoDf/ly7RcLRmEOgKhuGhBxJzx7APOYxZ2DpZg8rGmlRdo2R
 T4BNN+rY0Wx1+yVpW5WBmXIhJJ+LNgD+F+PDQh4OKWbuOOUlzl87cpc9OWiBwFEFiaQ61YIXhod
 xSN0leIr9n0uUmubFxA==
X-Proofpoint-ORIG-GUID: qs3wyAJXG8nR_7uiS2y-SqGnOg_q0rUT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 adultscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200190

On Wed, May 20, 2026 at 10:11:47PM +0300, Georgi Djakov wrote:
> On 5/20/26 9:51 PM, Krzysztof Kozlowski wrote:
> > On 23/04/2026 10:38, Krzysztof Kozlowski wrote:
> > > On Wed, Apr 22, 2026 at 02:05:11AM +0000, Raviteja Laggyshetty wrote:
> > > > Some interconnect nodes on X1E80100 have QoS registers located inside
> > > > a block whose interface is clock-gated. For those nodes, driver
> > > > must enable the corresponding clock(s) before accessing the
> > > > registers. Add the 'clocks' property so the driver can obtain
> > > > and enable the required clock(s).
> > > > 
> > > > Only interconnects that have clock-gated QoS register interface
> > > > use this property; it is not applicable to all interconnect nodes.
> > > > 
> > > > Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> > > > ---
> > > >   .../bindings/interconnect/qcom,x1e80100-rpmh.yaml  | 62 ++++++++++++++++++++++
> > > >   1 file changed, 62 insertions(+)
> > > 
> > > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
> > 
> > And unreviewed as it breaks users:
> > https://krzk.eu/#/builders/102/builds/70/steps/23/logs/warnings__3_
> > 
> 
> I will just drop these patches for now, i have put them in a separate branch anyway.

I think, dropping 'required' clause would be the easiest fix. Or just
wait for Bjorn to pick up the DT changes.

-- 
With best wishes
Dmitry
