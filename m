Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 012C947AF4D
	for <linux-pm@vger.kernel.org>; Wed,  8 Jul 2026 14:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783520717; cv=none; b=hG0ghtjb5f9Z/5+uXlAFtBK/i0q3fY0h1TDMS1FMdF5ZRjzhnPGqMi0nzG1IJojZHqQMfBI4VOWNpmpEHSblnkHq2ePkuxmMzRQvEtYlRhmZfNh1Sg314qL6mf2Z+Jn+sCNa9UkSxDR+R9SxbbA51NV1X+BNb3SJVCqkcduQc/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783520717; c=relaxed/simple;
	bh=sSmsdnmJrwAPWW1KiyJRt8MCa+4Zum/gNQgF63z/D1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azUMloxi4EVsGO+Gg+9bynTWJnAtxCsN8p0SOWFZP5X8BtN+W1l/fDNEO6PoyCgsEo3kec5gaL1I5u+T4cRPdu3zOSx9A4AZUj7AaAXgngpTlHKwYkq98j2E0/kMtzY5gzegNRWokMJ5zsNfQ9SeOQ8SALS+PEEEoDUGZJgrzx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=PyP7HEO3; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=KysYUSt/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="PyP7HEO3";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="KysYUSt/"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 668C3SC42667491
	for <linux-pm@vger.kernel.org>; Wed, 8 Jul 2026 14:25:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	GvPOfAqnErBt8ztKSYP7B2XU9RLRHl2bIpX+eaysQj4=; b=PyP7HEO3JF6XT+gG
	EJuLTNmpvlkCRZfJUJSEB8ReOvor7VAA44TxaSxdLDVWeJhZ6vdU3jOojmVKBHtl
	ks1eKw/63ND/vu+kjFJcAMFIQVKNeu62WpXECEAsV+Zx5uViAopvuE18Hue+ETs6
	vSMurlyjcDwN+wwrH9JXxDvSlwPsxelBvAnh44CsYBtQIlnLvB6Vc4pq9JjgFEnb
	B2REVAaXWJDnIJtMRZK9aa5158Eyen0EhQpPn7Sv2N+wEe9MlW745VtzHyXR3x8f
	crwjvf1Bhs8ylRMHihreF1s8nJw2Wg7FZElD+gi2mcfUVv4Bio04PUNzn4lAMJl5
	EttpbA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com [209.85.219.71])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f99hguk9p-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 14:25:14 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-8eac2620cb0so12197766d6.3
        for <linux-pm@vger.kernel.org>; Wed, 08 Jul 2026 07:25:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1783520714; x=1784125514; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=GvPOfAqnErBt8ztKSYP7B2XU9RLRHl2bIpX+eaysQj4=;
        b=KysYUSt/n7df9m0u4H206uG9MrZS1BzYIxUq55BC+0E4SJSU1QFpj3u9vt/pp3zr1m
         MdezqKTfQlOvoAB+ETVxmqibI14Q92FSWj4nqF3EPcOYyBnLq+hzkU5VMUBun6Z00+yR
         +nYoxfH7jtgRhq8wjCSHftLv0BfUf2kzPkObYqHspPM1vCR0LRWN+TnANX7LAuTMIykT
         vHNnY0nhnJrUr+CyFefENO5ZLizsQa47ty4tB6s75ZguM6YB2dTGhG2tXWnaEv5BaiFW
         qfLV97345i+i7wMLrG1Bt6I6GJwJgIzFdURmfHwfBXknvGOkyJJMlG2x+UOczRFVoPwN
         VUzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783520714; x=1784125514;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=GvPOfAqnErBt8ztKSYP7B2XU9RLRHl2bIpX+eaysQj4=;
        b=PKUP80IbplLYR0WxmlRZedUcqkb2ue5Wre9oAte7WtTjoBgTLdasHPE9qzrGHoeQhN
         4ITqk3gvPxwqTwwwwAg8EyOIQJfcNrhyVpdHSugIPDhLrtJJUlFks+P/otPlzLrgYcF3
         DB/exAtsTCtnvBn4yGFwE2WXgSb2Tb65Qe/7PMwngOxfXdd9FyUepVPHuSGCimeHTzzi
         vHqmkdGnBMcM6qWJDKs5ncVP91t+Lt6SZ7hxh/l31q2bKKQlLLIhumvTGsAXROH4rmr4
         iAK32ksiKhPb4Usow2ENoXSCFCXJm8yNK0scIjWE2qgqNlNJhnmFOv+B9yOhKWlPX7uc
         xFQg==
X-Forwarded-Encrypted: i=1; AHgh+RruP1BWcVFTjsgMwrplAsRdkH/KaYhTsYOP1FaGVUOGx1kDLpla8V/hN9Q6vROKsYwMAd4QttJdsA==@vger.kernel.org
X-Gm-Message-State: AOJu0YysbxnIgD6qy9JW99aOixbtgBZKk1VTmhJSkfPaGlt2RGjsedE2
	pv/9AdSIGPpWPDVNthoMGuhvq52kAO/C/M6lG3bDtKFBxn0BcniYEWLz/wc0DzbqLgilL5reygA
	OiVNuZ9BpguC+ql0G5KiIbeeTllqJlK+fSG0QfFzSTzPiEmMsE718XpVhXWAt9TFQehb17A==
X-Gm-Gg: AfdE7clO2ULkN2GPPZq/gcfbW0vMcOSX1PnVkumV5A3Hzj8IzU9WUppeTDAcgVjIXOg
	pYn/0aPKANoRYe0OFbdwgBuf5a4F1EoeerBr9c2Yfwg/+6u0nbjeppSM4uP/PkFIeIsTsHKoaIE
	Z3fOQKikxZqHffJiLewc6rDzZigmr6QApFaLB6o3Al/TA9mQGGR4s2lTtZZGDnFXPByobcYS+nr
	LAd4jjWitv250WY6M2CCFmC6fuUdzJyHtPEPgXyIqYJ2JYErxEFHKQ94RCKcYTcsHiKjBDNQFz6
	TzECxCe97jvIKlQkr1mjG1jiVBxpx6NcDUOMmgKQfi0vX0oHRezaXvmIppssVuVqOiSFBPKdcJD
	fB4Fv3ofFWKQoQQKhcybxtPdnOidBEunsVMEWZ21mmEfBojBtCdHdk9vHAqUcW8H6/t3pIt+akk
	2HEg5NZxZn7uXdJKkBEP6zs+MV
X-Received: by 2002:a05:622a:1e1a:b0:51c:ecf:4eb3 with SMTP id d75a77b69052e-51c8b3cc299mr27193491cf.44.1783520713643;
        Wed, 08 Jul 2026 07:25:13 -0700 (PDT)
X-Received: by 2002:a05:622a:1e1a:b0:51c:ecf:4eb3 with SMTP id d75a77b69052e-51c8b3cc299mr27192631cf.44.1783520712722;
        Wed, 08 Jul 2026 07:25:12 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aed13c1c4dsm4527420e87.66.2026.07.08.07.25.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 07:25:11 -0700 (PDT)
Date: Wed, 8 Jul 2026 17:25:09 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
Cc: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
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
Subject: Re: [PATCH v4 01/10] dt-bindings: firmware: qcom: tmd: add TMD
 device type constants
Message-ID: <2tu35aavp7sc2npni33ky5bve57idzy3bzp2pk7eh5lryq3r4v@gmm3dhayu4cf>
References: <20260703-qmi-tmd-v4-0-3882189c1f83@oss.qualcomm.com>
 <20260703-qmi-tmd-v4-1-3882189c1f83@oss.qualcomm.com>
 <977711ef-c1fb-4735-b82a-4ca2f4797f51@oss.qualcomm.com>
 <8ad14017-bce7-485e-9677-9cbf8ecb2742@oss.qualcomm.com>
 <yvggh2zs6qkuyuzvwydkecswnjoyba2d7t27br6xpk6d2csp53@i25g6okdktz5>
 <10a346d8-fbb1-4142-a650-507c3917b8f6@oss.qualcomm.com>
 <dv4n4ntnfvhouv23asgshgs7wcolkmqs7lbuni52maexo4s44x@4bqhf33x4fr6>
 <1aca8d60-8e39-4532-9095-a5260bba76ac@oss.qualcomm.com>
 <e7eho7ezujbrdzgumshapf2r7hu2jaujib7lvotrqvcj5er5ut@xpd6l2kgipqu>
 <9dc4b29e-e9fb-421a-b789-eb16a68ff915@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9dc4b29e-e9fb-421a-b789-eb16a68ff915@oss.qualcomm.com>
X-Proofpoint-GUID: vmuzk1aBkRFhP_pY8RfR2KH-JSTw6qIk
X-Authority-Analysis: v=2.4 cv=CviPtH4D c=1 sm=1 tr=0 ts=6a4e5dca cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=EUspDBNiAAAA:8
 a=DU7i0n-ryPtEfpeWOdgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-ORIG-GUID: vmuzk1aBkRFhP_pY8RfR2KH-JSTw6qIk
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE0MSBTYWx0ZWRfX4yLB+NmHolAO
 JMfaL6vfF2pZdCmfH8bcvfEJJu7diivAemZOJNW0WEa8VxXb84pRwxGk27/oM1QiZDAWlgc6e22
 hf0I5waPw9t6UNZVGtAjCJXtx4fYNlY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE0MSBTYWx0ZWRfXyd7JxOpaXbnT
 EUyEmJwGKSE09pR23+oaSwD56sSf5QQAYkYGn3TxzBMPNpEgUZtVfj445V7wDY6gsXiixS0tJmc
 Sk9oCX4Pje/q7iLdMu4zGMJofWxqoP+Vk40YPYG82Z5jmUM1LSgikk7etSK62B3uyXt6O52VQZi
 ty0Zu+S1NDOoZ2/xKTfno7QLv09HeCX/pxJOSIM0NXPudwat8CWte+/kOKmAZMm10x8ej//Bz/s
 dx9Z2UhhbrK+VOlbxda3kmr0vcjh0gTZmfSM+YVv4F767d7Cff6+wx7lkwcwEUp7ap3oPuSqjbr
 916fmlBrH2zkMGbwk+R0Krcs+Ic76RdqKYuGAESceE8+ZpDAmVkmUDr/IvUWrSDGuWH6gNsKRZx
 /jgeTYdFGQX7iYKEGdad1MYc74UNGTSn9FDuZMVB2VPajMH2jWSXEbuqPWtR/t/T/S0zEVvCMYm
 lOZlTP8X5u+S6xwGEvA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080141

On Tue, Jul 07, 2026 at 03:55:13PM +0530, Gaurav Kohli wrote:
> 
> 
> On 7/7/2026 1:04 AM, Dmitry Baryshkov wrote:
> > On Mon, Jul 06, 2026 at 08:11:35PM +0200, Daniel Lezcano wrote:
> > > On 7/6/26 19:47, Dmitry Baryshkov wrote:
> > > > On Mon, Jul 06, 2026 at 07:03:18PM +0200, Daniel Lezcano wrote:
> > > > > On 7/3/26 17:42, Dmitry Baryshkov wrote:
> > > > > > On Fri, Jul 03, 2026 at 07:43:39PM +0530, Gaurav Kohli wrote:
> > > > > > > 
> > > > > > > 
> > > > > > > On 7/3/2026 1:23 PM, Konrad Dybcio wrote:
> > > > > > > > On 7/3/26 7:03 AM, Gaurav Kohli wrote:
> > > > > > > > > Add Device Tree binding constants for Qualcomm Thermal Mitigation
> > > > > > > > > Device (TMD) types used by remoteproc-backed thermal cooling devices.
> > > > > > > > > 
> > > > > > > > > Qualcomm remote processors expose thermal mitigation endpoints
> > > > > > > > > through QMI. These endpoints can be registered with the thermal
> > > > > > > > > framework via the `#cooling-cells` property on the remoteproc node.
> > > > > > > > > 
> > > > > > > > > The QMI TMD protocol identifies devices using string names (for example,
> > > > > > > > > "pa", "modem", and "cdsp_sw"), while the DT cooling-device binding with
> > > > > > > > > `#cooling-cells = <3>` requires numeric device id in the form:
> > > > > > > > > 
> > > > > > > > >       <&phandle device_id min_state max_state>
> > > > > > > > > 
> > > > > > > > > Define common TMD device index constants shared across currently
> > > > > > > > > supported platforms. If a future target requires a different mapping,
> > > > > > > > > additional target-specific constants can be introduced while preserving
> > > > > > > > > existing DT ABI.
> > > > > > > > > 
> > > > > > > > > Signed-off-by: Gaurav Kohli <gaurav.kohli@oss.qualcomm.com>
> > > 
> > > [ ... ]
> > > 
> > > > > > Why are you using only those TMD devices?
> > > > > > 
> > > > > > > More constants can be added as needed.
> > > > > > 
> > > > > > Kodiak is one of the supported platforms.
> > > > > 
> > > > > What would be the benefit of having more than thirteen cooling devices
> > > > > declared in the thermal framework and having only a couple of them mapped in
> > > > > a thermal zone ?
> > > > > 
> > > > > I agree there are more TMDs but if they are unused for the moment, why do we
> > > > > need to add them ? Can we do that incrementally ?
> > > > 
> > > > That's what I am trying to understand: why the implementation uses only
> > > > the selected two devices, if the modem on Kodiak supports others. How
> > > > can we find out, which TMDs to use on other devices.
> > > 
> > > My understanding is that is an initial thermal setup. Gaurav will add them
> > > step by step while setting up all the thermal zones instead of sending a big
> > > patchset. And TBH, that will be much easier to review.
> > 
> > In such a case it should be noted in the commit message and/or cover
> > letter.
> 
> Thanks for the review/guidance. Not all TMD endpoints are relevant for
> kernel thermal zone binding — some like BCL and cold temperature are handled
> from userspace when needed. The constants here cover only

What if there is no userspace? Or the userspace is different from what
you expect? I doubt we have TMD-speaking userspace yet.

> what is needed for modem and CDSP thermal zones on the currently posted
> targets.

Again, SLPI, ADSP?

> 
> Will add a note in the cover letter clarifying for current tmd's.
> Please let me if this is fine.
> 
> > 
> > 
> 

-- 
With best wishes
Dmitry
