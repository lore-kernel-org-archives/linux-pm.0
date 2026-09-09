Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8886A5452A0
	for <linux-pm@vger.kernel.org>; Wed,  9 Sep 2026 18:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788979697; cv=none; b=Vf8paOwoh/Mk4K1ebjbILINyjturWYkfMobULTwteI20TT6xgimvRL4ybkzhJT/fXzPI5hsnXuERdIEsYEDvpoJYT1rAuVCmlJLo+rqy84sBEul99c8qxyav32aHO95sNHR87ywsBeKLWUm9IWepidXq1EKN76Wy1BUDHQhO5yM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788979697; c=relaxed/simple;
	bh=j7AomWY1thDMvf7jR4qY04R02EHtj/ZGDJ+4eUXR6c0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bsxF6zq6z6IGbZ7TLGQki3+RIZwLbKOcVoSGS+QnfYe1QBq4ZOtR6qRTkX4yUfx1ZUN+FrtZA0OcTej1kBlk3w8t6bxfO2g4rzJ70zQ8nn50nqnoZmyPRVttPjhfGAAX0oATJSyDm8gomZWD5MoYfg6wSG9T8sC5OdTDZlTZzbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=G5TadpFj; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=esW158Rm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="G5TadpFj";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="esW158Rm"
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 689IgJJv2687213
	for <linux-pm@vger.kernel.org>; Wed, 9 Sep 2026 18:48:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=B2hhKwHh4L/fYX52LOdqYTcz
	ulimqc3bkV7EnEkdcCc=; b=G5TadpFjgRMBag1VZK9dlVXajPoJaiYkYimCE2Rs
	tC4eLNklRdIMutzTIwqtSLx1y3sbB3MNBwb5gqGBlu7Gt0NxC6m2ttg4cx33FkwG
	mR/qUJXoGeNnZtyhdIY3CwmpvUe47iOUF9xi/WxWtlVD5Esx6Q5Nnee5CqxBnLzL
	AV5MUQVLnF5LXr7EvO4G304Nge2LaJME18Ccd3mdu3OgzVCywUnfBPgt+FCFrulq
	wCBRTK1VZBCSWRRyU0hP+lIL6q18REZ6C+wjInrzKQF1NEf0VGqhHDdfPDVDc631
	s1RnHt8NmPdC4uupkMsUisxj9Kbt/T3eO8iCNK8TdmMDQA==
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com [209.85.219.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gkcyfr10e-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 18:48:11 +0000 (GMT)
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-90ce8ad8002so114424296d6.2
        for <linux-pm@vger.kernel.org>; Wed, 09 Sep 2026 11:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788979691; x=1789584491; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=B2hhKwHh4L/fYX52LOdqYTczulimqc3bkV7EnEkdcCc=;
        b=esW158RmTa5cMITIN6/YrguXvC/CaFyiQJSmAfh+cRo1rP40rlNKN20kXgPqNWGGdd
         VfVkanK5pjHCYAo8g6QIlMtgqBTAwEYxxJdcckiiZ106TGsQ9Vum44TvIBxu/46wmqJj
         qIHlcUxp+X9W8kB4MfQeOyOwrP2Vlm2mSvebZsbqPONL7bbk6el/z6KXz585n5CzueM4
         6G03kbn1v3yLXqHK65hxS3mK6EjhQjQIoCWAtvzBuOKLBtBVC2efeZMl1MTHLt0R7wBs
         pYT/vMuD4RdhZ+YfZ1I3DEtI9T5gOl9TqhM8J2z8EcWZJx8s8JEEyr3WHeS/nURd6InY
         E6AQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788979691; x=1789584491;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=B2hhKwHh4L/fYX52LOdqYTczulimqc3bkV7EnEkdcCc=;
        b=JHlpiYVzm6V3kMPeftMOBpo0ebdcFlxJm6PSBtkKyHtKpx8Jo5Xbth4H2WwqyVqMcc
         Po6BVN0nDyvIRHsDZQPvLqZ6T70UxvJZOIdWvwu8J406wVagrG700XXwlkGpkTVlxtka
         0YWl/7MSr/WSn8klzJpg/25QKcD/SekcbCqAjjCC/GG4asim0BtDNExwV2aDk5XjvDwZ
         5qUkhsLPuWqfsdaOhKaLHjpGR8DzCABw+C3sYSCgVSUEj28ObYMkkGVMdCpSfc31IrmQ
         A4e43sw9ouGs2OrTTP5AOMJsX8AfVgWHZAxXkooTiddzMckhat5c36GPx868+oLEml7b
         TvaA==
X-Forwarded-Encrypted: i=1; AKwUvBys8s8tx9LtqKt1tD/QudE3jPfuSzWYADaeHA3OJEFM+mc3wKifE9AY5yPruy1h8TaBnDC2TfLsKg==@vger.kernel.org
X-Gm-Message-State: AFuF++lweFr52QzhuIiMWaI+Bzy4tX+L7cDjs3F2COahuy1W64e6uXQu
	n49L28lYODIxHSGLYC5ycOKZtBJWSyHi7RwbzUsNj14uPrTQwWxARamXnQTkwZyMeoVYPuWYe48
	T4PrtgRdJ/wN/W0Bgsa541evimqy7O/aLzMaG1O65HIs6WeksN9VYKXxrOQyQgvkGo9AGmQ==
X-Gm-Gg: AYBFou2vh+cqLc0q0feOqcNHtvxIaYPx34H2257YOw+70AoPbpGN+HCLV/JwAr8/zc3
	a9Po/cc/NZzRRlD8qtQKD4+DOGFiCIDF0MocxdgLBDaeodFS6/ZO7IkUjtKYgoY+QD2ojblJtuZ
	7nHFFB7VvSjTdsYH3D3ArFhu0FJFl77znsAVxVg1chWA3rek2a9eWEgSP1/7mSOhJvBjV0dFiHV
	bogeVrDCKlM7ksp67s+NdG1K7uS5Jcrem25OJRHZy6tbJ9PgUJFV4V99MqTdOuLSlB376oOW2T/
	T0ZlXmtXXnQ/Og1WY6jLxWtX082NdWJJA0PFEx1vxBoPRuHEBPro/atTKmXt92fl4KhyOGpWJxo
	kX7gKDAsgq8/TS3JL2O85zB3+veE25FhTrFUfm3VFbhGmAvK+IvVQljBlcM3Uyd0abCnfm30fSB
	CjSzK5xEWKVRrw
X-Received: by 2002:a05:6102:644c:b0:786:d33d:af15 with SMTP id ada2fe7eead31-78a4a94a067mr16558661137.6.1788979299757;
        Wed, 09 Sep 2026 11:41:39 -0700 (PDT)
X-Received: by 2002:a05:6102:644c:b0:786:d33d:af15 with SMTP id ada2fe7eead31-78a4a94a067mr16558625137.6.1788979299306;
        Wed, 09 Sep 2026 11:41:39 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a37059b0c3sm48907741fa.30.2026.09.09.11.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 11:41:38 -0700 (PDT)
Date: Wed, 9 Sep 2026 21:41:36 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Konrad Dybcio <konradybcio@kernel.org>
Cc: Georgi Djakov <djakov@kernel.org>, Evan Green <evgreen@chromium.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Dmitry Baryshkov <lumag@kernel.org>,
        Adam Skladowski <a39.skl@gmail.com>, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Subject: Re: [PATCH 5/6] interconnect: qcom: msm8996: Configure auxiliary
 Venus QoS port
Message-ID: <tmngp4764jqdprnvtg5nwtvhvtpptlswje35zthugs6mx6qpsk@cmgudihs3zjt>
References: <20260909-topic-icc_rpm_smd_qol-v1-0-6dc5b5e97626@oss.qualcomm.com>
 <20260909-topic-icc_rpm_smd_qol-v1-5-6dc5b5e97626@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260909-topic-icc_rpm_smd_qol-v1-5-6dc5b5e97626@oss.qualcomm.com>
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDIxMCBTYWx0ZWRfX3sWiars5Ev61
 DrdSger7Sm4NBLwv/4DDat4+EG6Obi+GGRD1iiiTnwMMxQvc1Q3BQTDymUIic7tHeS1u+Ky0fu5
 +j39LjptncfRZoAviIN/zYdqrXhUm34eHi+e+PmtcV0srav2HWCJ9gFZO8b1Ff7xEPXP7dwkTxu
 0AMCv/9iY91DqALHPCW9FHCH7B+0j7K9MlaFZlAhwWFkq1StwLZ7jxwmMVxUEr5A78RbGAL6AyV
 5chcMD64wXLUQXLPTPKGpbC8E//WuhE6M/nixsAUzzy7k7jf7cRhPJLPVgF+qpLiPpPBLsGfRwI
 niJd6fRbgxCN9tTZLriF/4AlpvFQv4r746YShqw4mN8qwDgGzZABH9/ldie7XpSaPJ7kA1G5Dqm
 LmrJBbwhCF/udRUYd0C8bIixBtJLkA==
X-Proofpoint-GUID: R9cAmit7drRNV6Y5SOuFU7bpUQ0MB3O_
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDIxMCBTYWx0ZWRfX7PZjte8BOieC
 A34JzO1sPNnbu/ncUXAV0iHdmNnbqu9TRKwQoqwmTlr/fJAfzvIljpcapyGaqjpNdii+kA4roPL
 RR6qiBi0dKpeoR3tSMRNz7o3oIM7EDY=
X-Authority-Analysis: v=2.4 cv=GNqdgeNK c=1 sm=1 tr=0 ts=6aa1a9eb cx=c_pps
 a=oc9J++0uMp73DTRD5QyR2A==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22 a=EUspDBNiAAAA:8
 a=YMW5T1WhuyZJOF4bxVQA:9 a=CjuIK1q_8ugA:10 a=iYH6xdkBrDN1Jqds4HTS:22
X-Proofpoint-ORIG-GUID: R9cAmit7drRNV6Y5SOuFU7bpUQ0MB3O_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 malwarescore=0 bulkscore=0 spamscore=0
 suspectscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2609040000 definitions=main-2609090210

On Wed, Sep 09, 2026 at 06:41:58PM +0200, Konrad Dybcio wrote:
> From: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> 
> Enable the secondary QoS port used by the MSM8996 Venus node.
> 
> Assisted-by: LLM
> Fixes: 7add937f5222 ("interconnect: qcom: Add MSM8996 interconnect provider driver")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
> ---
>  drivers/interconnect/qcom/msm8996.c | 1 +
>  1 file changed, 1 insertion(+)
> 

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>


-- 
With best wishes
Dmitry
