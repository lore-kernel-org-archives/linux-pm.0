Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA22C346E4A
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 10:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779703935; cv=none; b=pX6JRr3p7oToq+eUJlMibTXORFVMaw8TPr5vs4irfk73hbiYTMt3q6+FO9hR1atxT1E/Z9247FspAObl+zTlkqYMRJ8wShLuodkgwPu8F+3B5TnIsOaKshrvxLF+3m38xLnaVEugxR8XGxCEjooVbvE56+fq+v2EBRvrqiz0XAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779703935; c=relaxed/simple;
	bh=3sg3hRSFdrfYqCE3ImKh756AK90qi6+lrG58peXytwI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g5O1jR6Uj/l2dTMP7KuEd6uxJlvGxfjgPb1fDl3egTL7S38L7qqajedpdxS6hvI78FUH3pHUQdUXTbMgK4ObpIW4MeAJG6j4sjNE5qUDo4vhtP25JC3krl5ihVfUL8GNE0u3i2k+ciYTYla0UHwwcWWrqTYME6E8d8EJkOocmJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=cO8llDLO; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=LrJGbLlQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="cO8llDLO";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="LrJGbLlQ"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64P9cekm1802358
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 10:12:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=uwUCKvWUz9UKRblR2yyK+gmY
	yUtgsWhpLq6L4tfKyJM=; b=cO8llDLOwJG6kCq6ALAO3AWp60Q3Fn/zM+J0KPKI
	/p+6yMwxOmwy1/wdDoeRBTPMvlOWlcR8Mzh2m9AHX9GakIEr9lQvzuPTpzgcKIzu
	aVhmu628ASoD31XMJ7iS2yy5hXtr6GtJtTih2v6pkf0GlLpVUu/P2x2zwyRrFSyf
	31ywwyhrvR2pGFm2nws8Vzpwusgjci6vf18Rs0OaTh9z0jL7HJJYlrFzcnGm2TTM
	21Q1TOFGby73S/am8enV8104gW1l5+dW51Hm9/wy/EETOnSrukN5xfb7MYyfTXjm
	2Cug3lsM6TCkcYwWz2pfre64SifoHEc2HEGwxhWgnhEuIg==
Received: from mail-ua1-f72.google.com (mail-ua1-f72.google.com [209.85.222.72])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eckyqg488-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 10:12:12 +0000 (GMT)
Received: by mail-ua1-f72.google.com with SMTP id a1e0cc1a2514c-95fcbf9c0e8so15020476241.3
        for <linux-pm@vger.kernel.org>; Mon, 25 May 2026 03:12:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1779703932; x=1780308732; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=uwUCKvWUz9UKRblR2yyK+gmYyUtgsWhpLq6L4tfKyJM=;
        b=LrJGbLlQGL8UNZaG4tpfJkdANCBxDiWG1MwlGxg2cJfW4Xp2b0mEHHW9zZt7EYFWXP
         FuWcq8xgV11jDCeaSbH07AI79Eske8fJecZiPeGAiKqh+eJSUZTpG7i9zkzx23JCvGsT
         7sT0yfsNfzS950VxS5FErbMAh5ExoeXhw+4ErLU/tS4374rSOUzag2M2wa2nK2QnWSom
         +SMkuS0T2VirvACJ/ejrno55KptDirPHFZPE0c7xhqZnHQzV627aPKT7NxiApya8Lzdx
         j8U/oxS1VL/pWjQYUrGV0knrWyMgNwm02iFufbOACKuo3UBVDNVz9mATX0cB0JmOPgcM
         27Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779703932; x=1780308732;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uwUCKvWUz9UKRblR2yyK+gmYyUtgsWhpLq6L4tfKyJM=;
        b=eLQRJ/82vb7VHxZ41O6biV7+C+JyEsZjqt2sV48xcYqWXdrJ6MFL+qIH/6WG4PKluY
         WkLe6MhfLtcJJNH40nHaqvSgi7H0W8Y+iPb8Y1uTHmOnnTONnFG9v8SARFhDzhapkxmT
         Xukn3S0EMnt+SufJEu7gWQoHAzPSKEzFrSu0LBrCfVOXEn9ByzraH2VVtsb/s+EhBo/b
         /d3gmThR9+1fu+q4XKW7LQ6DmgszHlUFYRdfyw/lBtQGIW2z0AkYRePI/0GK8rBtFFtF
         FtsJLjpixZXuA6xPnHJzYM4Sc/ZfUrUYzTRfy8HF3GtzQ0l3b6K0bksiZ7KnwBwotbmL
         s60g==
X-Forwarded-Encrypted: i=1; AFNElJ/9l+0KLcIIO4PmYS6apATDG693BFrKcBRbxCw9cWGo5w/t1D3Pnd10gh+4RH01vFg8nm6fn996nw==@vger.kernel.org
X-Gm-Message-State: AOJu0YzgsSNAYtFPE64urs6xYfA02GksvXXhaPfb8J+wx/M/UtlNadZ1
	6MR4ytGXzl6xeNqIj8KSU4LylP/cTfe7sh+wzbJPY0c+QXGxaZCwl/GT6e+PH0p+nY85zG8m4jH
	vOXElAg9KP1X3gHulmA0KDmMNj5PeL1NzjjXiUH+Yqv8kolmokWkipHkHKCJrEg==
X-Gm-Gg: Acq92OEFKBSpr/qGRRwqmzhsJ4Lne4dfqRab+FzzoIVQiTPf90ZVhweVJcPLkKbR6KC
	+BVsUDWhdnyTx2LhKnqoMb12qDXearXG5f4P1jwDVm6BsbVaPVCYhKX8wIq7m6J2PL5ySkQxpkZ
	QDLEnwtNwtdyoja/1BsO+37lRnz53mUws71TOjKvJ0u7/oDos7FaZNbXJvKUZ4jYtOWpBsYt9MS
	WT68FY6KzCc+uzwHOSHU++iYEwPhbalaotpHgYqWM5/qolyZKLGyp31obSOv5sblZUrQei8hrRk
	93YtPqCNazQehTc7eDVMcp8/stCZyv8ru4rnqUd8MDT2QJpN/1mis21cnfu+tl1v8bmwZ46uopI
	5BG6vJwn9xW1t2PFIaAqJpaljcaNyepKeuwiZ9+bLh8AaEa0QZ+7/gYWTSVrOx8zl1s9M6tzky1
	rrRTXop6SOrZC/LSCew8I7RQrA0RLskfyI8n8R5lB5xTJP6A==
X-Received: by 2002:a05:6102:d90:b0:631:d3e4:efc9 with SMTP id ada2fe7eead31-67c8bd35beemr6714644137.27.1779703931787;
        Mon, 25 May 2026 03:12:11 -0700 (PDT)
X-Received: by 2002:a05:6102:d90:b0:631:d3e4:efc9 with SMTP id ada2fe7eead31-67c8bd35beemr6714624137.27.1779703931381;
        Mon, 25 May 2026 03:12:11 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32cbaaf2sm2606780e87.33.2026.05.25.03.12.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:12:10 -0700 (PDT)
Date: Mon, 25 May 2026 13:12:07 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
Cc: Georgi Djakov <djakov@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
Subject: Re: [PATCH 2/2] interconnect: qcom: Add EPSS L3 scaling support for
 Shikra SoC
Message-ID: <ld3bxsk4brqehwzxxpjuxwdego2bs6g3p3h35b5i352hbeu3zk@4wyckysck7r4>
References: <20260524-shikra_epss_l3-v1-0-b1528a436134@oss.qualcomm.com>
 <20260524-shikra_epss_l3-v1-2-b1528a436134@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260524-shikra_epss_l3-v1-2-b1528a436134@oss.qualcomm.com>
X-Authority-Analysis: v=2.4 cv=RMyD2Yi+ c=1 sm=1 tr=0 ts=6a14207c cx=c_pps
 a=ULNsgckmlI/WJG3HAyAuOQ==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=EUspDBNiAAAA:8
 a=AL6Zp-OlWJ-5pd4xuMwA:9 a=CjuIK1q_8ugA:10 a=1WsBpfsz9X-RYQiigVTh:22
X-Proofpoint-ORIG-GUID: -WxhsYgQLMPV8ghpu57625DjypPu0lBT
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI1MDEwMyBTYWx0ZWRfX1EyuZrPqcwYL
 VlqxLk7OizadhxGFqW5HuxAagvDEXhINDKTcnbgGDAydQqx/70tKbBBBbQR7mxCcmrkj/DdSyGB
 pNwrAi3wGRmV75OjnqNeMLoZUv7uezR4a3utRXdIZK/kKSjQd3FS8zAIjPCcqkgVcC4VkO/Kodw
 Rqm/leAq9E+02Z93OHiaJy8VXRz3GcSODqMjaRD8Xqj+AQwTpbhlqPW9V9K3gSi/NGzzyvWG6TR
 ANGBqP4MR56OLcz7NQSfWebB10EQhqcySdRZDsJVUhZgalX/EhSnAmoNs5/mrWkA1M04ZR/a8K2
 0+rHSDG9wYFUfYEtBPkJJq1rEh8AdzTOWxoak8oG/nkZ7l/2Mi8xJZtdxQdIs4wCb2C3A6cz8gS
 +03EjIei6L78g8tUWGkHPG1fxLlJxf/KPf2rIoOapzuHhQ0LhXMNyZ9GtoHgX18bRiG50xKQcft
 kyFEscvjiPjnTGL/tPg==
X-Proofpoint-GUID: -WxhsYgQLMPV8ghpu57625DjypPu0lBT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-25_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0 clxscore=1015
 lowpriorityscore=0 phishscore=0 adultscore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605250103

On Sun, May 24, 2026 at 06:03:36PM +0000, Raviteja Laggyshetty wrote:
> Add Epoch Subsystem (EPSS) L3 interconnect provider support on
> Qualcomm Shikra SoC.
> 
> The EPSS L3 block on Shikra SoC is similar to existing Qualcomm EPSS/OSM
> L3 providers, but supports only up to 12 frequency lookup table entries.
> Reading beyond the supported LUT entries can expose incorrect frequencies.
> Add shikra-specific EPSS descriptor shikra_epss_l3_perf_state that reuses
> existing EPSS configuration with appropriate LUT entries limit.
> 
> Co-developed-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Odelu Kukatla <odelu.kukatla@oss.qualcomm.com>
> Signed-off-by: Raviteja Laggyshetty <raviteja.laggyshetty@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/osm-l3.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
