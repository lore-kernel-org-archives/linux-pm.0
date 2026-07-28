Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E257A31AF24;
	Tue, 28 Jul 2026 10:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785233552; cv=none; b=mcjdso+JgX3Ptz7l9Pc009V5PNtJgw/MwciGsngbG/z7HnlGDKZ5RY5VaZ3ovnFW9WVMQOyELA1qMv+fKFHWjtQuR4LL842+WU4ngmIfLnep3sLLsd4MDyRJxRqJufoyFTOVbqCPVqHUaX/lrxPcU58ru60AAijkm8qeQjbirNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785233552; c=relaxed/simple;
	bh=BPZ7OnzW55SWVPVySk6bV//44HSTwAssV3ggZ/G8350=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IXNIfUzA+bLwve8SwXwgn4tzRHGwi9MkJEN81xkOoa4BEjO6xGFqpS9CWx3d+XgjX5X8bteRDVPp8qM63yu10pIujPNQAXVa4rtF/JT5pzWvJa2UuOtMQT/mBSqwY0X9WAE/Hvxjtj22YT2tkDMg2NJl10Quy1VUnELrYcj3tGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=NXu3hsx5; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="NXu3hsx5"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66S82FSs2144851;
	Tue, 28 Jul 2026 10:12:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	pabq9wu5SQ+hulPgerZ946d6+pss6XS0GFEUXcqdLdU=; b=NXu3hsx5SlzArvUJ
	8SLCZO85fu0LO3DKZB6tuA598TVdGUI+FR4aIJBzttYJBWnaCxLPnKnXCNiWmScZ
	kMlNFJquHlTxKLoATA32WVTj4htQPKkCcyQ3liwJaXjr8gsl8RBKQPNpufHRDwrr
	LLXAaosTXTOmMnR1oHc1x8U+oLxARbFyo/KyfUbb1euLLZaoWXZKgh0mfMLhEkAw
	KUaI7U20NZ8GUv5ICsjgynOs1dt6PiTvmooNMukt37hFb1qMHHEiOLt/9IE+WUDW
	1GSxuQtDeQDhXtKLWcibwra0LvfnQfrS6/jb6sx+/Fnylz4l9DIitd4zUEHoeJag
	D1+0lw==
Received: from apblrppmta02.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fpn19hec6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 10:12:27 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SACOXK003847;
	Tue, 28 Jul 2026 10:12:24 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 4fmp7k1vnm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 10:12:24 +0000 (GMT)
Received: from APBLRPPMTA02.qualcomm.com (APBLRPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.1.12) with ESMTP id 66SACOlX003841;
	Tue, 28 Jul 2026 10:12:24 GMT
Received: from hu-devc-hyd-u22-c.qualcomm.com (hu-kotarake-hyd.qualcomm.com [10.213.97.140])
	by APBLRPPMTA02.qualcomm.com (PPS) with ESMTPS id 66SACOeG003840
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 10:12:24 +0000 (GMT)
Received: by hu-devc-hyd-u22-c.qualcomm.com (Postfix, from userid 2389607)
	id 6D079B3C; Tue, 28 Jul 2026 15:42:23 +0530 (+0530)
Date: Tue, 28 Jul 2026 15:42:23 +0530
From: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Kamal Wadhwa <kamal.wadhwa@oss.qualcomm.com>,
        Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
Subject: Re: [PATCH v6 2/3] dt-bindings: power: reset: fix minimum reg count
 for pmk8350-pon
Message-ID: <20260728101223.5uvgmqmpwgvjvysz@hu-kotarake-hyd.qualcomm.com>
References: <20260724-b4-add_pwrkey_and_resin-v6-0-41acc214d93a@oss.qualcomm.com>
 <20260724-b4-add_pwrkey_and_resin-v6-2-41acc214d93a@oss.qualcomm.com>
 <20260727-weightless-fierce-tiger-a9c6ed@quoll>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260727-weightless-fierce-tiger-a9c6ed@quoll>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Authority-Analysis: v=2.4 cv=TJV1jVla c=1 sm=1 tr=0 ts=6a68808c cx=c_pps
 a=Ou0eQOY4+eZoSc0qltEV5Q==:117 a=Ou0eQOY4+eZoSc0qltEV5Q==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=dqXgivLOxkXPvlrrVikA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDA4OSBTYWx0ZWRfX9p4YXYsrOIol
 nj11YDq8Ggubj+85wX9UnNEL531BFaGJ4E9pKDgnh132Ibn2RrSsQqcVZlqGjEcWmFcj1hbiiOq
 +uDG85IUqML79GyCmJqKYT5gDaoL6WykQvdmFM1Za5dH9JQ+5IBkVwlRmmC3suN7714ElLKpsU+
 /op//qQvQKFjUBNdKB3otfqPsMiZk9JmwlCIMivnIALOFVByw7gTIW+h36camcv06z6nPRf8vj/
 1jp9KKkaBRtd73t7yxZ9rrNxknxVdxhdl6uJPJQHjZugFiKG/G4qqKyk1EfnwfwlrR0IpCi2zHt
 3Q2OL0gbgySg3hTWPp+q1upzVatLzyIAw9MRfrBSgCudUasZyx00KJjCi8PsAolx7XA6T2mLwIE
 5DghY5/YfrHdUlq6NTp+kz/IShLK/I5L3RdSNWNZQ8RK0+kZMS6nAHfxWuIpBfeSmzJ93ibjA5g
 d9IBxicyK96njdQ+x4w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDA4OSBTYWx0ZWRfX9fbI4FxV3I+Z
 38bIIwwt7NT9BwoW3hd0woFG1//849zA2GH85S3rf+jGYh3KMcfg7yWJAk58L53YgGAgJx820Dx
 OJ6SkQSD2I9oQkzio7klBagCmAGlw6I=
X-Proofpoint-GUID: hynp0ykjlZPZWp2Ph2nWC3gXs-GrEAys
X-Proofpoint-ORIG-GUID: hynp0ykjlZPZWp2Ph2nWC3gXs-GrEAys
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_02,2026-07-27_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 spamscore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607280089

On Mon, Jul 27, 2026 at 08:36:38AM +0200, Krzysztof Kozlowski wrote:
> On Fri, Jul 24, 2026 at 03:44:12PM +0530, Rakesh Kota wrote:
> > The GEN3 PON peripheral requires two register address spaces: "hlos"
> > for the primary PON block and "pbs" for the address needs to be
> > specified to facilitate software debouncing. Set minItems: 2 for reg
> 
> That's ABI break and I do not underestand if this was broken before or
> not. Driver ignores the PBS, so everything was working fine, no? Then
> why PBS is required now? Is it actually working or not?
>

Not an ABI break. All in-tree GEN3 DTs using qcom,pmk8350-pon have
always specified both "hlos" and "pbs" reg entries — pmk8350.dtsi,
pmk8550.dtsi, pmk8850.dtsi, sc8280xp-pmics.dtsi. No issues were seen
precisely because PBS was never omitted on any GEN3 platform.

minItems: 2 simply enforces in the schema what has always been present
in practice, ensuring future GEN3 DTs cannot accidentally omit the PBS
address space which is a GEN3 hardware requirement.

regards
Rakesh Kota

> > in the qcom,pmk8350-pon if/then constraint to enforce that both
> > address spaces are always present.
> > 
> > Signed-off-by: Rakesh Kota <rakesh.kota@oss.qualcomm.com>
> > ---
> >  Documentation/devicetree/bindings/power/reset/qcom,pon.yaml | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> Best regards,
> Krzysztof
> 
