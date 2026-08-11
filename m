Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD1FD40BCAD
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 21:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786485300; cv=none; b=oH2PdHWCbkPKPAuFzr0ZlTc9l3jitaqwdTDz/34DMWehe+zQLh5qrVkmk7/HRtMTSKhTpo2UDSsrJLj+47Vo8+/9BBFmXrTbD5dsMvTm9KopaY6C0moc/nBcEeXHYJjUI9IsaNqKhkyk8ubgy1Mt0iJaZHojCsZOwGm2nXP0hdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786485300; c=relaxed/simple;
	bh=K0qHNXC7XUAR6czQRw2ccRE+viWZzRlnoUqvKGWaejQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3/Z8rAdol4RvZMZjNaGAVQXvMbJChGBgMnfVpAyGDqlgZ3rQftlJSIaCzJoydQ1pvsgG9OTdggoRWTICPmhVC79Dc+SN3uoRd5Yn5wIwni2xZiDHu0pu7rA7HId/CWXxDIU2C8GZu2N6km3n9Q5edbyKh04lLJevl5wULKfmy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=nMJATCG2; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=NRkYAwNI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="nMJATCG2";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="NRkYAwNI"
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67BLbOUi617654
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 21:54:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=Lg7r4jRNOyzkLhjbQxRqnnTg
	A8DYDTKbQUaLgWsm+OI=; b=nMJATCG2ECKwJBOYcXB6q27b91R56y3xTaMVYyG5
	psmZ+Ai02U4LU2YDkLd2iow1Vcdc3XCIG9iabzVolj0PAWELV2Tvp7uQCh0HysWi
	L5gL+RHBZVEuLnQGULWXRnkp/s+1q3tRr8Bu0w7lOtMn8H38G6/uFQqiBABUS3u3
	CLROt70QL64DDG2GWieBqPQZWTg/1XxavfEeFRgbZ3JApcGTum0Su82EQL4F9H2h
	8HBeg/+Zr4i8bAZX/BT58wAYKvopg9kxrtlWBv2SAMW7oNh5nhP7rq58DfhLkyK1
	8M3wkZI9YMV3lI8A03Cr5VtTCrQ1gZ32jhAwzRXshPV5SA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fyxweuh32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 21:54:57 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-51c07f25de2so3510601cf.3
        for <linux-pm@vger.kernel.org>; Tue, 11 Aug 2026 14:54:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1786485297; x=1787090097; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Lg7r4jRNOyzkLhjbQxRqnnTgA8DYDTKbQUaLgWsm+OI=;
        b=NRkYAwNILfqj9XbME/QvuXvVse8x4BKajhNBVNPgAuOmlX45EZFYrPjSRDJfQ9Sf4P
         m1T6SdqCHIijOa3JFtBVxB36ZRThppy/8pchHiC12KsvJeqmxJ1B1T4c4yhOYRMlC7ME
         rGfHPCQrbEDIQmnu571z5CC9sTs3WbQ2pVmmAqJ/2N3KNQTvovJm09YB4jwThSK6lE87
         VO3j0nBc/4usrGKl5wQfJYJKAa9f0c7hyp23vyO2qkwLNRb+lPh/ur94wLFQsrJTI4la
         SqJf5TdAB8gpupyepBZYdYUTqu2haq/THAEDc5lkb9Ao45zIGww1E3xOtkVlvAnnK1RP
         MhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786485297; x=1787090097;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Lg7r4jRNOyzkLhjbQxRqnnTgA8DYDTKbQUaLgWsm+OI=;
        b=B8E0vr4Y3uH+2zIRUDOtiMmwmZp5KgeUVZlckd7BgncwrlWpn/5lmEhNsdCaHvac3y
         8J8ivTaqq4zYYWkBsF4zxTdqq9Z8yPEVU90dZrE+1HHGa92fYK2bcBpbKfnL7C8JUtlC
         Ua1YXHSI7OloRWwjqJblThW74q2vMYrHLt6e2zSRf9JHC1Kvt6KAB9C4iVpaqghz+pYp
         azgxkl7IxDTMBXTTtwE5bZDyUqMtrpILdMB0EO3/0gbV5B1pT5LzXyWqLyZKmgfgXhw3
         qhFMQunp2cxU69TlNoj8pbuXaee3pfP6Rc+2+wshbIJH3izb/9ovugEV9yqQ1LuEdFKw
         CnwQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr7XHcuetHMFg40Vh04l6hLALa/wj/1ML3p6kK9ZwgzI0Zlr5c6IkpwkeTyz0DYYK+Co52vYMOP2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxcBQpbOWStSNQkC9PmbMC8FSQRonx5y54tupjK5dl42gOYzZJq
	WLZhHjtn/4oB2Wvu01WGMyZrQ5WLPEFd2kOqk9rBPEL3WcL0Wft0aVySKyfqu8v/eUa1U82e3xq
	kI2jgJyHaDIiRv1J5sCGGdwb8qJU73k8QrDlUjMHUM+94NHg0Y8EcjCson6VQxw==
X-Gm-Gg: AR+sD12dm4iX6OVhOh2n6Oluu0MFRtoSdFks1B9QDWhD5+yy0LcurtJfEIr11Y6EOTj
	Tc0WoME+hJXc7s2wy+o/UAPLlrMkzu5m/tLVTmSzSh0bsR/fHeb3pXtFBt2rIwXUwl9bWRx2QT3
	zW0WQfwizRt921yNCAVIHJ86pYqiL6K2VPclAp7v/BYbHyi+YyMRHrJky1BliGVUVI/dfppNm/W
	2x44qxFjf/cF36BJ1AASULEOZDmyD7AZBcXPUXs2NSFVpasv6APdf85SeBVOkaXAyVtt887o99B
	dDa35Vlf3JhKoKYWT/Y1tm3Dr7ZIfHUdeJJ49/0LCeGy+1eOM+VexAGbF10eLnyOKDAS1uKLShG
	sw7m1f9/+MlPVhIyKBrtA7QLM0s/aNG9yhJUHxNuNxFou+V72J3kVwz1c9hGvWbqxJsSDYyPcyG
	MhSVmS7cZ7icrHBA==
X-Received: by 2002:a05:622a:1a93:b0:51c:d1c:10e3 with SMTP id d75a77b69052e-52d64855f63mr3822131cf.35.1786485296809;
        Tue, 11 Aug 2026 14:54:56 -0700 (PDT)
X-Received: by 2002:a05:622a:1a93:b0:51c:d1c:10e3 with SMTP id d75a77b69052e-52d64855f63mr3821811cf.35.1786485296383;
        Tue, 11 Aug 2026 14:54:56 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b44d046df0sm108492e87.69.2026.08.11.14.54.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2026 14:54:55 -0700 (PDT)
Date: Wed, 12 Aug 2026 00:54:51 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: rafael@kernel.org, broonie@kernel.org, jishnu.prakash@oss.qualcomm.com,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
        "open list:QUALCOMM TSENS THERMAL DRIVER" <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v2] thermal/drivers/qcom: Fix missing spmi adc tm5 gen3
 file
Message-ID: <r3bw6yzla5b6k43crebsrexufmeeudiaqa7sepcf4eutjozpnj@blgu2vl55ke7>
References: <20260811145427.3089426-1-daniel.lezcano@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260811145427.3089426-1-daniel.lezcano@kernel.org>
X-Proofpoint-GUID: 1-nF01dHfUG0xnpuFTV8BUwNbeaZ7D4T
X-Authority-Analysis: v=2.4 cv=K8QS2SWI c=1 sm=1 tr=0 ts=6a7b9a31 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22 a=bC-a23v3AAAA:8
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=0md38Pq4iEJnK0vhYSYA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: 1-nF01dHfUG0xnpuFTV8BUwNbeaZ7D4T
X-Proofpoint-Spam-Info: AW1haW4tMjYwODExMDE4NSBTYWx0ZWRfX+G/aGvINlADW
 4nNVKaOANp3vntOjZLicMQw2sExELrb2TaRvVx93Dp9liD/8DM3X2w09VKxY+j/Ga0BU+Dv9SU1
 B3epROEyosWi/CJDKK6InwLlzfb9bEY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODExMDE4NSBTYWx0ZWRfX39XNDKRLUmPO
 rech9iTOWyPa9P+Qf6oYbDjJkrTuiipPaBObyKQhQ9dBj32Vz4LYTHQCBdw/D3UwWPjLGDw9ev6
 gMXLE0WawlLNF54WCM7fwKGeV3Wl+ZO25jd7l+rSg32L0Ixb+4ED84clAP7s6Le0zobeQw0ERuJ
 ruOO1RVacj8GaeyKdBoUPDBDlO8blVZImJpGej631PDkVT935LjRvN0niDmju++b8KDBwrt3IRj
 wPl2TstCE+pWQC2PHXcrlqSmROoWs/Ud7xeUura7Sp5OnzWEhgp1KvZvC59GQguvim+0JpAOZ6g
 4JEMnGxNfGl7X+LpFFoI9CfetH2hFdQ2kJJc1d55IjFsotNdWsdngVqggtfPG5jLJPKzOj7U9Cd
 iUGhrazZgjrAbbm0obNZW/Nwi4i/UWCb8xjEbway0yGo+HK10WxiCZgClj6dsuuwaxG59qHSS4D
 J5/zARIARa+gIY0kzqA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-11_05,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0
 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608110185

On Tue, Aug 11, 2026 at 04:54:26PM +0200, Daniel Lezcano wrote:
> From: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> 
> Add missing file resulting from a manual application of the change
> below after fixing a conflict in the Makefile.
> 
> Fixes: 948ee3a74f35 ("add support for PMIC5 Gen3 ADC thermal monitoring")
> Signed-off-by: Jishnu Prakash <jishnu.prakash@oss.qualcomm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
> Signed-off-by: Daniel Lezcano <daniel.lezcano@kernel.org>
> Link: https://patch.msgid.link/20260811094544.2939556-1-daniel.lezcano@kernel.org
> ---
>  drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c | 434 ++++++++++++++++++
>  1 file changed, 434 insertions(+)
>  create mode 100644 drivers/thermal/qcom/qcom-spmi-adc-tm5-gen3.c
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
