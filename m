Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CFE389115
	for <linux-pm@vger.kernel.org>; Tue,  1 Sep 2026 14:31:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=205.220.180.131
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788273108; cv=pass; b=Pv3PZyZf83lWdenOmXgWeThaCpw0JZ/DXGXKe+QVUHvh7HoKN4WTp6HE8euLedO4XSl2qCEPqlWVN47Dyd8VUWYCovF+HeSksesYVdBITOSoJtd4sT73Ycj2/DJVGX1pIlQrlGHRFp72xsPsmL2KJWYG5VKp7/eSt+rTKdm/8qU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788273108; c=relaxed/simple;
	bh=CL+Fm//7PJAuTWNWRctOu0wP9tKrbcMfws3PNuylb8Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qfc3bzTneFTaauyWQOyNMIj1gfAmDkowUoqJt2wmFHSdkrZgmb42jOWnMBN761QmZHBShM4bSX19kf8oiVwvr36ppAVrFaZyYBgMBb8IlMGx9OE+CqozceXDGCe+ueoSRuT5f+O3pdJRZKlvdKL+ScDlcBruwvszm9971CgdNEQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=TWKV/Sbg; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=MHUJpS+J; arc=pass smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="TWKV/Sbg";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="MHUJpS+J"
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 681E8pWw2910735
	for <linux-pm@vger.kernel.org>; Tue, 1 Sep 2026 14:31:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	PzV75RyAsYZ+frAuiZ8woVoIVYpRn/LT5APqR6Tm2RE=; b=TWKV/SbgV9p0gmBq
	Ix/czCMtVc6C+fPEUJMX/wN5rmWOaY2sWrV8k3FCPsPVdBHPZds82x79UGxpCqCp
	/pVpjTMlX8ruOOfAB4pzE0il1Minieoe88KD9Sw4VJi1bgOh+zoS/6IfzDz5g8KM
	J4padN2WR4QivG/XXxD+bL//mbXyEPOzB4v81QzF5er6+cvoinwDYAqvjPEBlKjb
	fjX5HcnJIoAASFUUS/1g6Hq2e6QJhqKeo3LNE8Ut9OkR3ueWUadOU0OQD4ljSMCK
	j2mGoFWfUxYrnESW4/FvIxt6z6yf87rCmLVgMvOg92INvotvppxD5od8KkAFNDZv
	mmzjXw==
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gdp7r2u32-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 14:31:45 +0000 (GMT)
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-84e4ef486c7so1123772b3a.1
        for <linux-pm@vger.kernel.org>; Tue, 01 Sep 2026 07:31:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788273104; cv=none;
        d=google.com; s=arc-20260327;
        b=jgvO6FxPLtte0dZk/+vW90/7RYboblUrNx5KRtrVvvkd1MQ+C4MgzrosVzVTD+FBMb
         iuP9aZGWPb15j2hLbULAOrt+qJkbKi5gWNyxlaX2UJ3Ydi6M9hArUkNbuAx2uu6t7QLb
         32hCEBr9m38vS21HrpEQvwC3eaSP6AOlyOHFPgQ5O8Zk9FmKFnaaNnoB2yboG1IQcNzv
         VYBCqT05ZsiHqBvtSBVC/Kk8wzMeAmvNyFXExQkaCKOVBw7iWN0tfZp4MY8zS8FllCj6
         se5fLXGGgLRfRl7PxV9V5qKIwP53Y6cV6q1vIZ8J18cxECzdwiy/VnkBP9QgwMjqwRyw
         WJuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=PzV75RyAsYZ+frAuiZ8woVoIVYpRn/LT5APqR6Tm2RE=;
        fh=NORrDHT8BGb+UyqNxx2Ld06loghEWg0K9TUYS3KBLCY=;
        b=kyq864gaM+dRm+08C5PnRyT0sYO9AHSPN8zlRmJsEgl3vcuQjEzOj72e8FSyOsxrO3
         M7ZXg/jiXzGH5npNu4U8g/NVH49Osg4vqy+GMuuKU9Ocv8A9UwEzY1XDBXYdtAS2/fhq
         V/glfrhuQ728TEURfO8LtkaEywBoSV9Hqm6XrjNyGRmeYhZ/De/5eMi/fXyRTzhFFgdF
         EA0ea9aEYDWd2KC2RgH8aWdReGTDHlJ+8ozZMdcjJOu8bB15zTM2V6U9ioDMCUE2laPL
         j1uqSG2J7P07D2tp1Ymt8lePblLSRB9ITVYY6MtGJinxFJ3xeihCNCzoTzVem/WynYL7
         l0Sw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1788273104; x=1788877904; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=PzV75RyAsYZ+frAuiZ8woVoIVYpRn/LT5APqR6Tm2RE=;
        b=MHUJpS+JNG++WoSWrEusvWGQMqlLb+1WmCAkp+miG6kasuPoeE49mS8n7EzTVE2WUl
         s95CVfOFKfNjrElcCawac1ADbMDyc8E32+S0feYuZoYFvsar7b1F4KT8ixYVsoGrEzSh
         6VHSl0jYgm+3WW8E9FjvQFb2czYam8VpCI3nQLMCkz5xAqEgDHkFpfuIQph89MTzBSC5
         E/cfUPjZuZkHiZUfZdXQrFo9OD56US+ILdg8evX8Enajd9ij5XyZLZM/Bs91xmFiG62B
         UJANEaiKgCk3ahQGG3i6rxwj5D+ewO0pdoTwlIGI+54ea5lCe/vO+BTCaZeyBW+Lo2Do
         FSIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788273104; x=1788877904;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=PzV75RyAsYZ+frAuiZ8woVoIVYpRn/LT5APqR6Tm2RE=;
        b=hPb6NP/Z2FR/v8zZA+u7Im6vyTq6gKj4+ZhCsTNZkHXsa0uIwp/iQPaWD5iLPvCmJC
         k4y4ybxZwh4Kkf+0I/iBrpzNRuhht5SnsNKG7bA2IbgzRc4GPUileo2uf64/WEt15wky
         u3Z1v3uUiIyvrPTEBhuxkY3IzgwnqrgHmIG5B2McpaPK5w/Z4VFpj3xBVZ6OdtqnREpS
         SnF/VftttNoIYExddOqSxKWkweQ14tXrcDqhO2xBfpLf/m3fZK2MG11F7ZsJcpvv0ekp
         GEofKHgjXbnA3LUger7vqJpCzQ3RCg1/TB/f3ETloFyi8I3B8Ytv1LyWpNry3YemNUpW
         o9YQ==
X-Forwarded-Encrypted: i=1; AHgh+Ro/AmjW8eWK0FU6pQq4EOFuavU4x7xPaQtxJ4cF9/GZip6SD2elCAj5amREyo+89ssM/L6VNiLD8g==@vger.kernel.org
X-Gm-Message-State: AFuF++nWukXY3Rld1xRAzO6ktUqWb0+LoFLu6W77/Ds64VBAK6XZhwo3
	r3BswCPFWJuEPUNbJPNmrXoxogHVk01PUP30KGrkOx8u8q5v5ieBbxRIw5PrSApejIES8zRUU5g
	xD4sBpF/5sZYtfitCpCTfUAqAhEije2ozTjVLfn30Wau1Fr6hDA1TAIkHGdW8oNOV1W4iXgQ49/
	axMWVhHxaApeq/56XkANfju7FUZvyPyIV7uHOL
X-Gm-Gg: AR+sD10UwvE1fOTAXPyRFs2CuwNW58qvS8OfLD0Vsf6Wu6po7J9HsA9QzFH7fkBlv1l
	1FMsQBmPOwKDjyMEBmyvWO3WNDR/oUbsTjzZpd2yynHOerANSUpkGhj0x5PmM2nHkEcpn1sVu4T
	E4eI/C2nCeHoB00u3QNS2uTIN3qs8Cv7+zEvMIKFZqLrA38EpJEpMLutZGnw==
X-Received: by 2002:a05:6a00:420f:b0:854:b3d3:8631 with SMTP id d2e1a72fcca58-85bcacec88dmr5178991b3a.12.1788273104242;
        Tue, 01 Sep 2026 07:31:44 -0700 (PDT)
X-Received: by 2002:a05:6a00:420f:b0:854:b3d3:8631 with SMTP id
 d2e1a72fcca58-85bcacec88dmr5178917b3a.12.1788273103642; Tue, 01 Sep 2026
 07:31:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-0-091697dbeb02@oss.qualcomm.com>
 <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-1-091697dbeb02@oss.qualcomm.com>
In-Reply-To: <20260827-derive_clk_perf_tbl_from_perf_domain_opp_table-v2-1-091697dbeb02@oss.qualcomm.com>
From: Ulf Hansson <ulf.hansson@oss.qualcomm.com>
Date: Tue, 1 Sep 2026 16:31:32 +0200
X-Gm-Features: AcwNN1WwQtMTDpu5tktdI1Fc85e8Ltr3tWd5G78kHHK2UXE66ekj0IR3sGBbeCc
Message-ID: <CAPx+jO8HQj4PtBScf-w+nQz-9xe+7QxZLMtp=J=sFSwEHVLL_w@mail.gmail.com>
Subject: Re: [PATCH v2 1/9] pmdomain: arm: Fix -EINVAL from
 scmi_pd_set_perf_state() on state 0
To: Praveen Talari <praveen.talari@oss.qualcomm.com>
Cc: konrad.dybcio@oss.qualcomm.com, Sudeep Holla <sudeep.holla@kernel.org>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Ulf Hansson <ulfh@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Mark Brown <broonie@kernel.org>,
        Viken Dadhaniya <viken.dadhaniya@oss.qualcomm.com>,
        Andi Shyti <andi.shyti@kernel.org>, mukesh.savaliya@oss.qualcomm.com,
        chandana.chiluveru@oss.qualcomm.com, arm-scmi@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-serial@vger.kernel.org, linux-spi@vger.kernel.org,
        linux-i2c@vger.kernel.org, Abel Vesa <abel.vesa@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Authority-Analysis: v=2.4 cv=beZbluPB c=1 sm=1 tr=0 ts=6a96e1d1 cx=c_pps
 a=m5Vt/hrsBiPMCU0y4gIsQw==:117 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=gowsoOTTUOVcmtlkKump:22 a=EUspDBNiAAAA:8 a=iiyz0f3IVUh47B4zfGIA:9
 a=QEXdDO2ut3YA:10 a=IoOABgeZipijB_acs4fv:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDEyOSBTYWx0ZWRfXzc99/VzX7djy
 U787NJbnEjUskskFsE++Mzg1xv25MS4c8X1PbmXPAA9LKvPHCU4WH6z8JjriWxf7NEvwg4Lmuh6
 TvNfGgttXNWk1m0j6zGGTMntQIHnqW5K7QB8NatLSfL4fa5pSM6sY6qbtNZm6khlmcW/PL8mhFS
 fBRLYoPTS6eJAbuzlqWxHRY1bhb6gl6urxB4MAiYcdaBZZVxFpYbWMHzbSSJGyEA1R2aDcYqsDb
 AhsZkXd+tGMIrVLpC1xAHvBqQSUvWfEQ4z0vl2FCjB2z6wb1SSa5AOXDnom7vjQKpn8rlhVnHwF
 0CVQdwJjoE7Kk+nuzJtvNSMpLoELudsXb7F03LnJcI+WxmZ/L2oBGDwXkBU5WWSfr4QFRNsB06q
 XW9nSr4I+L6+jjLnlVIliACPcDiZYkLXOXsVFw+BcoXZZzx/7ZRFo3py2FBIYH80/du6zDn72JQ
 4hji/wmkaN3G3ec56Iw==
X-Proofpoint-GUID: AKbGKZSv2wGYXlV2D9Qw_Vw1ZqHCoZHg
X-Proofpoint-ORIG-GUID: AKbGKZSv2wGYXlV2D9Qw_Vw1ZqHCoZHg
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDEyOSBTYWx0ZWRfX19+dFaqU6mK0
 lfIH8bNbpSxlAtKHvgTEzZr2rN+GbqTm7OrPcktUqwPLsjnCL1wXaQIxfm9IYf/qz72un85fHoH
 QeRN1zeFb9ZHxXCwWRA7tnrGDU17OzU=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_04,2026-09-01_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010129

On Thu, Aug 27, 2026 at 7:59=E2=80=AFPM Praveen Talari
<praveen.talari@oss.qualcomm.com> wrote:
>
> Currently, scmi_pd_set_perf_state() treats a performance state of 0 as
> invalid and returns -EINVAL. As a result, devices attached to SCMI
> performance domains can report failures when relinquishing their
> performance vote.
>
> The OPP framework use performance state 0 to indicate that no performance
> vote is required. For example, dev_pm_opp_set_rate(dev, 0) is commonly
> used (by firmware or linux)  when a device is runtime suspended.
>
> A zero performance state does not require any SCMI performance request
> to be sent. Treat it as a no-op and return success instead of reporting
> an error.
>
> Reviewed-by: Abel Vesa <abel.vesa@oss.qualcomm.com>
> Reviewed-by: Mukesh Savaliya <mukesh.savaliya@oss.qualcomm.com>
> Signed-off-by: Praveen Talari <praveen.talari@oss.qualcomm.com>

This is already in v7.2. Please rebase your series.

Kind regards
Uffe

> ---
>  drivers/pmdomain/arm/scmi_perf_domain.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/pmdomain/arm/scmi_perf_domain.c b/drivers/pmdomain/a=
rm/scmi_perf_domain.c
> index 3693423459c9..e390f902a444 100644
> --- a/drivers/pmdomain/arm/scmi_perf_domain.c
> +++ b/drivers/pmdomain/arm/scmi_perf_domain.c
> @@ -33,7 +33,7 @@ scmi_pd_set_perf_state(struct generic_pm_domain *genpd,=
 unsigned int state)
>                 return 0;
>
>         if (!state)
> -               return -EINVAL;
> +               return 0;
>
>         ret =3D pd->perf_ops->level_set(pd->ph, pd->domain_id, state, fal=
se);
>         if (ret)
>
> --
> 2.34.1
>
