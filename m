Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 343E83EC6B5
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 11:05:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787742315; cv=none; b=juGA5owNMG/SvKaM0ZBghgICOkmrvEXX9LZZQhi2OQKrwUBIrkl0CgMQSVY7yo0q+1Xl+GFDFmsfOJawBWpfwZINSwRTBpHI3n7zoOW6uz4fQW63YeRqcEkpRAKHlO9CuzVxLsxqOkFHG4wPibmCfcMVU/psafPAjvbic/KoMlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787742315; c=relaxed/simple;
	bh=YyYUUVqBJGI286K5cUmRrDnI792ynvOKG4YEV7L1rJY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iKYMPhXPZOjjD2N8QGxUvWeoVxYuvXREQeHGQ0hAC+fHin19lCJx4Rd+MPIE+e1/mH8KfopvtrnHQd8pXzTQZXxtgzbHOrkAOWKJnRX4tXHhepkkdprMpG7Dx8wgjAOH3y2iJR/PjkvNwP8N/0OWABpP8ueBsc4HGQLunLKzDMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=oRINjrDx; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=JsVheKM/; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="oRINjrDx";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="JsVheKM/"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QAGrup647182
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 11:05:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=EnUK4lzSsA+4H8FJzIU3OLV4
	bLy+1PASPEgPsSBWvBs=; b=oRINjrDxgmZqQjIfpGtUwo0eDBbgp1Y8D7vzVdek
	LLP0kpFXcUyoAf44yoD3tsow7sa/jKRgoZ5onKcGz6gTcRQ3tk7HzUulXmX1UlkS
	HXSTm18zJT3h6jsPxajQ7XuAijAO4nNMSYWaZpj0Yd6ipmsj58deSmBmKnuzsrmc
	F3iZI0wwKUx8UUgtICHJO47G70yfaWl65qbBxVy02x7/JQbyyBKW/lnF7vsb558B
	WceseKuuIGRLKzJ4jQLVY2e7spvVlrGdWuV8qzmSJpRsbzyi9AdOEiuJsnuTW5yx
	u7Tjy4xw+v69OV4J2gyhr/D4WFHnLyjGNjeHOuTxvsoB8Q==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com [209.85.160.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9g4mub8f-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 11:05:05 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id d75a77b69052e-51c21c01cf3so14972921cf.2
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 04:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787742304; x=1788347104; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=EnUK4lzSsA+4H8FJzIU3OLV4bLy+1PASPEgPsSBWvBs=;
        b=JsVheKM/rHLITwg1/j261Lis6usL3OvBgP2rSinXrZPB4La9FwZUAuZf0Gr3Byzs66
         hQPh92ykkHw/Z2O+VOVtKfNtMH4KTqgvKE3Dwn17iMeZpx1M3ZQS5zuP+RbZ4ibWlGsI
         TQ5epCHmeQq60UfQDlCwtjn0BnHd9JliwIndQL4GA2xLIzq36KqzQh+PhQuvkawzns3Z
         +JPp6Bgh/WCh7QCEyEWp8xpxdFYWWmWXAkxO7fnZ9zLzMLxohO4fvFwJYm4pp1ZEobJB
         9WVtIZ4ZgYNA8JqgEOngPe4feyAF2SXGS3juB0rM3kZFNUEcOAXXR08mF/w4q42gJyTF
         2tSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787742304; x=1788347104;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=EnUK4lzSsA+4H8FJzIU3OLV4bLy+1PASPEgPsSBWvBs=;
        b=jdlZJv7fZHeQ/Y2cGbZ7x1Or/9t50JNoQn/kj2TYaCVcgVW5I+wGiDsiMatZRTjbux
         4LNQy6VOml+BuK7c833bHst9Wjej1tbnBYzcgR+EeQTvqLx7uDsvbfHhoMjmiCh3M8pG
         oNmW2c7arZyZMNJzmphPU9HCnw7rONE6fpYf9xAKCOjBrz7qhT0+TqItOfnnZGMXp9/M
         SitNKM1mX8LrPaGNkbMWDiDK24qZ2YBoXvxwUfAqiAVsM9ZGmnwJAlMZN7TjuQIpRW6J
         wtqMaHJKkpU4gIgdFTwKm5Ogc1f2LWZmkgWFBJBFg8ki/nb9N7c0o9KaZ0UOT4Nv7K9B
         aRhg==
X-Forwarded-Encrypted: i=1; AHgh+RociKYSSmRWq16SgY5nP6AfTfwj1Gko/rHhhQS9PlNO5yAO4WzOjFNghzStSmKP+HCzkbM26LE7cQ==@vger.kernel.org
X-Gm-Message-State: AFuF++l32N2MFGFIVs2Ki6QkeipAsYOD0jXZl2L1rT2yDB2EnmHCK7dd
	7Qo1L+juIcuh2CTV8NpcR7D8GslQMe3+zzoqMmT5gDmINBDeBFIiz0LMYKo/Gw2X9pu/lCqSg/q
	4gDFteMyJLWoADxQUC4uom8oxyXCR1liDPZaoCDR56j893k+lSLyMGppzA+Qftg==
X-Gm-Gg: AR+sD13STseo4wLJoX14W5OXkQz0NzTwV56T7wmmeQkbke5rGBQPcOTfrVWlksMkETN
	GppEVGuWe4xkrJhqciAkocRbS6JcXLy3PzHTHsPEyINfAdxYHERN5p1mJDPYF3+4FZxeEfkDSkC
	vkZX0vxSKjax6IgzFU7VGVkHNAkBY9yG+2hXcVxbYKATpEFefRz6+efCPUEvzdIP6B0YVU1t+wn
	rv+yEhP0MvzAnzul0m/e42gNYx1hofPYzBbwT/fY6mb9u4RQF4AZPCEC5oWeI7OBJSYu7YTMcVu
	yRaBZds5ueru0Rp6o3P4JVyz16qrrnSji4mQJRsesvPldKwEF7fTqkzTH7qVgA5rfWvu4FNa5md
	K7dmsnaoMaHAc
X-Received: by 2002:a05:622a:1b25:b0:52d:f376:c254 with SMTP id d75a77b69052e-52e422cbe1fmr59964531cf.10.1787742304418;
        Wed, 26 Aug 2026 04:05:04 -0700 (PDT)
X-Received: by 2002:a05:622a:1b25:b0:52d:f376:c254 with SMTP id d75a77b69052e-52e422cbe1fmr59963661cf.10.1787742303900;
        Wed, 26 Aug 2026 04:05:03 -0700 (PDT)
Received: from oss.qualcomm.com ([86.121.170.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a6fda4fsm496909466b.16.2026.08.26.04.05.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 04:05:02 -0700 (PDT)
Date: Wed, 26 Aug 2026 14:05:00 +0300
From: Abel Vesa <abel.vesa@oss.qualcomm.com>
To: Shawn Guo <shengchao.guo@oss.qualcomm.com>
Cc: Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] pmdomain: qcom: rpmhpd: Add NMXC power domain for
 Nord
Message-ID: <24kdkayk7odpbojcvbhzwupzvhqgtlei7d2bvbrjpi372z7hnh@7fte77gqooaa>
References: <20260826102746.633076-1-shengchao.guo@oss.qualcomm.com>
 <20260826102746.633076-3-shengchao.guo@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260826102746.633076-3-shengchao.guo@oss.qualcomm.com>
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA5MiBTYWx0ZWRfXywg2WeXl1Evc
 gRv1DoyWjwgbjyGme01Msk79PT7kNmAxjnSOCN+t20KsKmKKa9P8W8HlUDmJ0bs4KdlV7TyBf5w
 3DWlFySwIvBu9l4pD06dj3rWhli+V4o=
X-Proofpoint-ORIG-GUID: Yy6dSKUv2Sa-lcC13Ppdk0cSAbzfM5dq
X-Authority-Analysis: v=2.4 cv=eYgNubEH c=1 sm=1 tr=0 ts=6a8ec861 cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=clBUptZa5v5FR042Ey+sjA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=WUwTdx2_Dbflg4nuc2oA:9 a=CjuIK1q_8ugA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA5MiBTYWx0ZWRfX4XKXPZxvirz6
 dOybx1pOjM2/x0vTLF32Ei85Byjm0596wNW6IOcleROi+oaFYfHKvdSmxHivELA991jy9eWLbDt
 gsFaVigVsuQf4K+uGlSC3ejQMzpIucC50Q2VpcqnaIIC50mFNlY9COm3FQZo+HtU2fMvhsZi27K
 Tcl8Zb/7kTl1zTuwNeU+E4G1K2RhlEjk2WJr1nCV04shmcOJpVqDWGlrdJm5R3uDsKoMtX/XiKp
 /2RmPUiFst14Nkridm+QpMnVTykqJBeZ/+kAUi0Xb8YBsGEN+DoXanb89lMdLkyEqnljwFOOQ8m
 RHem9GG0SNT7tOd30q5x8wFE84HocPwuO2Yuvgmn2WFyOcUR+VxUKQTxpY09u/YlrfqHr1F9F7U
 VQdKDMpvDX56kYD4vTqKrNHZKab3lmZjctfu9paeMKo279Zp3N6m1OLjE6YE801lxwT853uReY+
 SRDfKhSvhuLfo3SGKYw==
X-Proofpoint-GUID: Yy6dSKUv2Sa-lcC13Ppdk0cSAbzfM5dq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 clxscore=1015 lowpriorityscore=0 bulkscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260092

On 26-08-26 18:27:44, Shawn Guo wrote:
> From: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>
> 
> Add the nmxc.lvl RPMh resource and register it in the Nord power domain
> table. Nord supplies the NSP memory rail from this dedicated resource
> rather than from the shared MX rail, so consumers need it exposed as its
> own power domain.
> 
> Signed-off-by: Anurag Pateriya <anurag.pateriya@oss.qualcomm.com>
> Signed-off-by: Shawn Guo <shengchao.guo@oss.qualcomm.com>

Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
