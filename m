Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8AA42B319
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 11:49:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782992983; cv=none; b=PXdhrqZW3CGF+4EbxqH1cDymbC/vtTSWX/J6Pa9aLizQ+hTXMlIVMQYUn+tJv5K1ybxXDaxfSBFm82CgLdCR31MfZskplmvXNTXICzMXwm3LafvdcO132suoRFInR3Qqb98bYVtW34J60nCwytdIV9i4hRzO/ul4Lf3t4S7XRUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782992983; c=relaxed/simple;
	bh=rpKAe8dPCwr4VAmvOu6roGpeUIvUI+iDbjBX67nG+NA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bDSYAVW4cv4bEbtdJ5604WsjRfo1O5WGJ10UgLmKjTcPJXXrgnz5SXPSDnTQcmMyErnaRtVtnPrrxgAFeQUNcCbs1Ia0s+LKTkIaaY+xoHfzTwPH9uSAP7L4UMl23WSPzCjs/+8mQ66Wni6xREwRupiohxo0hHh8lmmfMlBIm7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=ErUM/L6m; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=CVHra4xO; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="ErUM/L6m";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="CVHra4xO"
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6628OUwn3009463
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 11:49:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	upmYTcdh4plyAwPWdRv+6/jBs6VO3B/KEZnt0DeG4kA=; b=ErUM/L6mdqprqKRQ
	cQs3FUY/IofhUKWUVx2eovT1TJZT2iGFcebOwUBXSvWXnO26vw9CVo58V5VOeMJF
	wq+k4fP/eraS9R+IP4IZivcgVRrWcGSA3UKPKfaz83Bdsn7IwNaDfG4e3OABPXOp
	4iJKrE/Lkf7ixp3zBcqPw8qJY0urUFTcxcbnspu9x+6c0bIj6XCfAEDpDapH0pBR
	FuP0ws1k+xDugiylOSIFG12xRCrl128Q986KWdEY+6spIxOtPTz17koeWskWsUEb
	RlC5iXYLj3a/M9mdPCHlqdvhRJEbKpjDrnCnAadqqd3mkdDz24BbBbaaKkA5aqTM
	7dw7/Q==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com [209.85.222.197])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f579rutf3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 11:49:41 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-92ac0a54110so224063585a.2
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 04:49:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782992981; x=1783597781; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=upmYTcdh4plyAwPWdRv+6/jBs6VO3B/KEZnt0DeG4kA=;
        b=CVHra4xOmo1kgnMN56rIShQYjH+PYPBdY4opkUWMGjonyv+DVpP4nX1JaLFlzPHNYL
         2IIweEknGTKlziGZbXXnQlUL+K7p/2e768Jgjx90zCxdUcleAyCgdyEigllk2jY/5tB1
         SGD/MfnUMKI0IcRKAagFq8xSvx8fLMnarjEzmQpRNhryMXqHS8xDJB9uRiUcUQUhV5AS
         X9JF/3IRR5xHDfyLb59Lsf7wQkxKGANxkwEexKSZw3nB7vIMNX/enzC4i/ko8pTT7N7r
         M1EtcV95gOrbv/n707H1r8sSsszIwzQBrhdcaDy52ls4sUQQmkf80S+M/zSgpI/YjCao
         aEZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782992981; x=1783597781;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=upmYTcdh4plyAwPWdRv+6/jBs6VO3B/KEZnt0DeG4kA=;
        b=VEPeWDCUiJIAGhEGvM3u+wynIJ+n+quJyaUCYEOsJgEjwQVjua8m/dd6SCJIgzLyEv
         Rm4bMgwhgBBzs8V2Vi9zrdxkbGA/SS2Umg8js6bFCfFJdfYJ6qveSaNM8QimcJUEHyJN
         Qkav3SA7ROSXQdv/IK7EB/OnqXcNASa+VpnAOz6wohtoU7Xxds+J3Ny53N3/vvtNn7oz
         eN2JcqgU3XezuwSUFZN2gkabK9AKTVwcgMxJjngomfazV/TaIRjRdJneE+nTVadl44kV
         wBYr6o1IkqtlbCYXYzQLgAGUYzqOwO2+LlqpV3XBu/5REZey422T3nAEoJIVzyJ/6j2p
         kwNA==
X-Forwarded-Encrypted: i=1; AFNElJ9AQn1H1k4RVXW30f+V0iIKZwz/wkgvTNdY6I/6CBw+yqq0Lds5fKav9xRh8oSxUuICXRNGI+iKkg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwAGjCPOwDOQa37wjERuKBgtETe3YgggtVRgx8UE4UdvpdD91C5
	FRyUl8OtRxf8ygr9FDFKp8mrjmtLw6CIql2KiIGGBXHYrpHMijw1JDNKgTHM0wR9xCIFtHK3PJi
	H6g9qh0vB6PotLASNDNQaEWgfvqClavXSsHfpxq/yQ6ibvTZXiYTYrpozLH5OSQ==
X-Gm-Gg: AfdE7cn7pwZPzYTrhbS42HFzDP7dQP5mJK2UqZkj1W6TMBqqUdyTAyRWg3m6RI02PFH
	rUDDJ8fc6y3gPCq+a6W7P8m8NyRqr/3cDFqAUEwdyCbo0SX9TmRY/5UPR0CTAj1eX+TrJf6zEct
	Rblfia7PVA3hG2xnBKGqXaw4fXRtgJglSeY5HddsYNhcuOWg5kjTkXf9TT2QkRo1boKzf3J6qzR
	gMFmtm/C8LKH3ujVqRCFdMS2owXvoaxzLz7b6Fu/EnwZYcRHAFQD+UAOdZV4IvA09fCtgSIlxY0
	+nYHjtgmdBYPLn2mjcY2yqsovpCaRQIARzoMo33YRo8CUWc6e4ccCtJyPgWoQHkpgg8KMMH2E20
	1EcI07JBOj7+VN9mVSRtq916iD9ubl1kap3+Gcv87jampLIlukVLysQkUcS1DiBYBTRGOfZBPp0
	myhW0nFSSCVz/ivYZqkb6/0pnD
X-Received: by 2002:a05:620a:1a26:b0:915:cb40:f76a with SMTP id af79cd13be357-92e782c44c1mr840350185a.39.1782992980676;
        Thu, 02 Jul 2026 04:49:40 -0700 (PDT)
X-Received: by 2002:a05:620a:1a26:b0:915:cb40:f76a with SMTP id af79cd13be357-92e782c44c1mr840346585a.39.1782992980234;
        Thu, 02 Jul 2026 04:49:40 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aec89d52ccsm623900e87.40.2026.07.02.04.49.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 04:49:39 -0700 (PDT)
Date: Thu, 2 Jul 2026 14:49:37 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
Cc: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        jishnu.prakash@oss.qualcomm.com,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Sebastian Reichel <sre@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: soc: qcom: pmic-glink: Document
 batteryless property
Message-ID: <dqe3ntmtmjqixp2l5n7qm6zpcwh4sizr7jd5g3cl3tzpvl6tvo@casnjg3orldd>
References: <fd58d6d7-26cf-4b11-82ad-05b4863b6dd1@kernel.org>
 <20260519082526.odmn5dqi2jftwnln@hu-kotarake-hyd.qualcomm.com>
 <20260519-first-wine-bulldog-a6a4c7@quoll>
 <20260521071341.q4efqssppvettaey@hu-kamalw-hyd.qualcomm.com>
 <86f76a81-832d-4ba5-81d5-38b46b7dc0a7@kernel.org>
 <6c595a5f-b979-4e8b-ae77-d28d24700588@oss.qualcomm.com>
 <e07085c5-0fe8-4ea7-8e51-ebe104e7aa2d@kernel.org>
 <82019c2e-6b6e-4edd-91b3-a28ef6eb09eb@oss.qualcomm.com>
 <20260525120139.dyfnm6nwfzuoxd7p@hu-kotarake-hyd.qualcomm.com>
 <20260702113010.zjrk4kr7fpjp6asj@hu-kotarake-hyd.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260702113010.zjrk4kr7fpjp6asj@hu-kotarake-hyd.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyMyBTYWx0ZWRfXwmyk0oPjrbEt
 RW7cS97O7dN7eIP3pxpZdQ2UMOoV01bvbNC7+RxoMe4lPFpSPCv+8j+JClEOLCC0kONk2G0ksFE
 Txhx14LmbpxSWexu0Y5ukens4IHm5KTI4aYJLIr1nkZBZ48VeKLBiT51OVh7cDZEU7s5w0QwZXb
 fGMuZOfZ19crAD/m+8z5l0yFfD14FKrzG+B5MQvG9+wbPhmT4y5LxvFKWCSUAu+gzxJPsK/fxnJ
 Ld0nm2odulqLAyWZslpcoa7kU9DxeGxqp2y0cztFjN7TnvQ9c1f9brpmTuqUaoLWP7OORXJaOnM
 Zbeuleow5sE8+B02bIdKK/t+wjetRA/xVcmfSfAhEOQ0TJUxtka102UR+4LNlh+59ZDbcPjA7vP
 gjn0wpDKJei/8GeRTw7Kn7MYUTiCPhHguDQOwr4eD13POc34VUeJ+/VE6/PQrtoMVcXMxx+rHkF
 cL0+1g52cwP3a3d27sw==
X-Authority-Analysis: v=2.4 cv=X8pi7mTe c=1 sm=1 tr=0 ts=6a465055 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22 a=s3MLSL2Rv04tJSLU0-0A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-GUID: SHADMs9VyQ6aHZys2PSTf3GxlYopCp7U
X-Proofpoint-ORIG-GUID: SHADMs9VyQ6aHZys2PSTf3GxlYopCp7U
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyMyBTYWx0ZWRfX2B4Fm9NSkpM+
 APjhvJK25ua1DQDx5j7hCuXS5Mf5bMFBhkxk7p3Fc2eH+R/l5WecHykJ8sKfKaR5gPFKpkYgu/A
 JTJTzMkwhB5tAXo5MgcrXm2vm7e6AmY=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020123

On Thu, Jul 02, 2026 at 05:00:10PM +0530, Rakesh Kota wrote:
> On Mon, May 25, 2026 at 05:31:39PM +0530, Rakesh Kota wrote:
> > On Fri, May 22, 2026 at 11:24:19AM +0200, Konrad Dybcio wrote:
> > > On 5/21/26 11:58 AM, Krzysztof Kozlowski wrote:
> > > > On 21/05/2026 10:46, Konrad Dybcio wrote:
> > > >> On 5/21/26 9:20 AM, Krzysztof Kozlowski wrote:
> > > >>>> Since firmware does not have a way to dynamically tell if it on a
> > > >>>> debug-board powered device or a DCIN powered device, We are required to
> > > >>>> add this new DT property.
> > > >>>
> > > >>> Neither debug-board powered device nor battery-less will have
> > > >>> monitored-battery, thus again, why lack of that property cannot tell you
> > > >>> what you need?
> > > >>
> > > >> A device with a battery will not have a monitored-battery either
> > > > But why? If for such device property "no battery" is suitable, then for
> > > > me "monitored-battery" is suitable as well. IOW, if you say that having
> > > > a property describing batter is not a accurate hardware property here,
> > > > then neither saying "no battery" is, because no batter is basically some
> > > > sort of battery (just like empty set is still a set, empty array is
> > > > still an array).
> > > 
> > > The battmgr service running on one of the remoteprocs already has all
> > > the information about the battery and it also handles all the type-c,
> > > PD and charger configuration, only letting the OS know about the
> > > results.
> > > 
> > > Hence, unless there's some other hardware at play (e.g. for custom
> > > 200 W charging), which wasn't fully implemented in the QC firmware,
> > > there is no reason to describe a battery separately, since the OS
> > > can't do anything useful with that information
> > > 
> > > In some abstract way, perhaps monitored_battery = <&pmic_glink> could
> > > be thought of as valid (since that's the data source the OS gets to
> > > see)
> > 
> > Should we use monitored-battery = <&pmic_glink>; If so, would it be
> > incorrect to mark pmic_glink as simple-battery, as that may cause the
> > schema validation to fail?
> 
> Hi @Konrad Dybcio, @Krzysztof Kozlowski , 
> 
> Following up on the earlier discussion — is monitored-battery =
> <&pmic_glink>; a valid pattern? And if so, would marking pmic_glink as
> simple-battery cause DT schema validation failures?

I'd say, no, monitored-battery should be pointing to the battery device.
Please fix this on the firmware side, so that the firmware can report
having no battery at all.

-- 
With best wishes
Dmitry
