Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFB943B7753
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 08:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787731770; cv=none; b=phPwtw8z5uay/UFWY/c1aSmw81ihaw94PFOKhsofOl6e+SmbrnYLNkFIT/fM0EqUT/mu8QO7I323MRLzDo3099WP+Svy4xZpzHtdedORifD0YyVURUTqD3oKadKe5r10JJE1pkdA1pafwh7JBFM3U7nmnbo4nj50CIhaoo3Pa+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787731770; c=relaxed/simple;
	bh=rEbNkFigjp0FGDCJsty0si0XKQ+e9anzsk0sFIsDhoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KOu5iIdDNT3gKLIeTxUWeaBsm996+4M4laFgzrRiccHgeEmDcjH+MwH/v78fQl3YNUt1Q7nAnLdAICK0l/a7pmZDTkl+urIJh3xNxj3hk7bqpm/5Kxvphto5TfK2U6zbawutLvbWdC1MDYoajSEi4qjMOJUkqvmOL0g0wYooSLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=YuQ1hN9N; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=EesU6/Ck; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="YuQ1hN9N";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="EesU6/Ck"
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67Q6RpFV3210627
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 08:09:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	OJXQT0c6OYFN2aHcq1lc8qaGVj0md3a70HDIO/2Fy+0=; b=YuQ1hN9NkB+j/f2K
	jM4IdS4G+UxnMIRU84VU68/00IK/Or+kzo4uaBrPFYs+NqjhdZ3MONsOrl1mXxAV
	Dwj/k1yXeXte7091lspDKCgublXsw+jOBMltcaZFLiUxA+xJ9cghEBkD6925xiAw
	N01RVw4hEZlasO1juIDloEqq5SAL1aC0P2DqultRwCzLNHDq0UH+IKYpsxjfgT2L
	BHGYYkD58l2QL0GpcEDWFPz0giEt7t4wAXs23Ej/tn6kfPB2Y7Ngp+Volbb1PHl4
	bI0WpaxoBUjUO4+HrOIgYSZKTC9LERCexEGDfXVwjKm4JelbNEFSrSYxdjkaFRzM
	HmuAjg==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com [209.85.160.199])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g9fgraurv-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 08:09:27 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id d75a77b69052e-51c0408254aso22077301cf.0
        for <linux-pm@vger.kernel.org>; Wed, 26 Aug 2026 01:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1787731766; x=1788336566; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=OJXQT0c6OYFN2aHcq1lc8qaGVj0md3a70HDIO/2Fy+0=;
        b=EesU6/CkhAShe5PRTIpIMtJ2EBGbKbyHgadTLRkeuz92p10et/KS2G4evShrQJ2ku3
         N5ZbmM4jlP03LgKr6fQs2HGhqg06lvPdERZI0MQGVb3XxFpVpKPxg5S/WkG5AkSvRl9v
         Pzq7BldSswNrmgs5QfVZoBCrR+HbdrbF6ApUvfr6UxyE83sW7QKd7DVNQwldCF5AwdL0
         gFVdNbram0CmziAySg0BJ49YCDIWtWKRDZSiFwP46vPZoG32d+Smu0zDMR5NBQtCjsct
         l2mYWM4saXam+j9LkjaTQIF8crimRdG26FrGnc39y5bxS257rJThH9yEIuuFFvz26QDg
         hMFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787731766; x=1788336566;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=OJXQT0c6OYFN2aHcq1lc8qaGVj0md3a70HDIO/2Fy+0=;
        b=rcHX5nWK9MCbvjH10OAS34HFYCXeOzOKLtB3uefNLmsE1ign3nVRmnloCf92JV0EIj
         liCc8aTdSyvaG755nJi14byRnCtpKnZFmPfhVZDUN5/wLteR/m8uN2v+T6XjTGVwO1ah
         6pJj9QmAdDSrPnFMRwW7zigzv4sX2k48d0bgKONeXD2qLRaA9d+7nX0PQVWEVhkytemA
         cVhKzkGc+gRpnXwgEuyXNcaxOOX62UT29fzmN4eo1zsuzd/04VdNrXOkNXVmCAHaSvc0
         2uU7BO8qxRXMsObLUfO3+TJDPlvVGtyVMpSRFveXQtM+59TOj06UOBxQDBt8PtPdLhFE
         Foog==
X-Gm-Message-State: AFuF++nE44uPMpDSCzzsoWuS9j9u9CmiExZ8OyJ7/YSQU3fp2Xh6r3GE
	3lfZYpWgYg/Ha2Zd0o8u6NA09VhFapcofWNJlHhCjbDCGCvsq09OiiRAhTQo1ZFQ+C77pd1XB4p
	J6fsR8N7cOH6c1XmhX/1RdNEm9IfArXpZy7XOFYOUA3Em+70IkfHdtk9dsJo1Yw==
X-Gm-Gg: AR+sD13CfDI/VZ+A6MyX0XPGMUEK8GU9SB+f/8MdxRky4HNYwRBCGKcfuuC09F/r+/M
	UEWFzCQu9/auc1L82Cl7I4AOy2T1iolLu2dNwmHK/p38FU1UZvtXKO6Z8lNlGdbJJH7M+G9uD+a
	/Y7p4HefBCdUOlm7otQ9KGfOcv95Jbkpb+EuBN7wf1+s5OegrPQmfGkVjfRunDDOTsPE5lx5kYf
	Vg9tlXno46YelLhuiRrLKW9Y7FpOQVFDXyF3BU7YGcUGw1BZjzUjO5iA4Y0pN40KVwEwo5QBfXa
	e/kTNDxhOpQW1LgbXSEWBi1ow2XNvS/eoujZ/Z+1y+oIIIDg0/oJhFJZYMHPZVJwYiSrXDrEAgL
	5QQeNyj9Pna0VgLTbp2slY6/3v3zJ
X-Received: by 2002:a05:622a:cc:b0:516:82e2:7788 with SMTP id d75a77b69052e-52e2ec1e3c5mr116721431cf.1.1787731766306;
        Wed, 26 Aug 2026 01:09:26 -0700 (PDT)
X-Received: by 2002:a05:622a:cc:b0:516:82e2:7788 with SMTP id d75a77b69052e-52e2ec1e3c5mr116721221cf.1.1787731765865;
        Wed, 26 Aug 2026 01:09:25 -0700 (PDT)
Received: from brgl-qcom.home ([2a01:cb1d:dc:7e00:dfd4:a0a3:2df2:7724])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499dc96bff9sm18773245e9.5.2026.08.26.01.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:09:24 -0700 (PDT)
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
To: Bartosz Golaszewski <brgl@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Alessio Belle <alessio.belle@imgtec.com>,
        Luigi Santivetti <luigi.santivetti@imgtec.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
        Jeff Johnson <jjohnson@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Chen-Yu Tsai <wens@kernel.org>,
        Loic Poulain <loic.poulain@oss.qualcomm.com>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: linux-pm@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, imagination@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pci@vger.kernel.org,
        Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Subject: Re: [PATCH v3] power: sequencing: rename pwrseq_power_on/off() to pwrseq_enable/disable()
Date: Wed, 26 Aug 2026 10:09:22 +0200
Message-ID: <178773176015.26343.5524450275043262993.b4-ty@oss.qualcomm.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260731-pwrseq-vote-rename-v3-1-44e60b8be053@oss.qualcomm.com>
References: <20260731-pwrseq-vote-rename-v3-1-44e60b8be053@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: 7p4X0VJn9ppNX95AsukTPKvs5DEHk0hW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDA2NiBTYWx0ZWRfX34f9Ccv5Jad7
 ekx1oCdaV7AttIBOjgVu+a66BEx1/r5Xl9jC7SadNuAKGw6Z2vgKLOxlnELjzm2xj8iU7usMHX0
 0w5MUcmCZDCod+RYOtEljtNUJg0BSxeW4DTizm+JwSbNRq5CFUsM5um5fIMopuweLNyyPMyO3GF
 dxi6gPkbRfs6HHOc6nEeZhwDtjKQqcXESrC6uIQnFclDS2/pM8aeKtnFqvfJCRLY8VxWQYIxRCB
 C7IHkc+mZwh2LiBJ9ofmP45actx686toXV4kKK5LD0yQ1UllcNMl1EO0sDwsv6O0EJHv8kpFKT0
 dBij5AyxtPWErnzKWn6Usx7R4onKG7c/OFfFMRdBUhiONx5HHlESxV+IP6uTFzkSYLDWHLy2ba5
 Ax4PKnbzUZjEShO4VvF3UP5llYqk48dUAxjkl53OJ9dh6cKaceRYir8qTQL2d0wd9YI0nkWubvT
 k91iQK1RkDw81yZG5HA==
X-Authority-Analysis: v=2.4 cv=d8LFDxjE c=1 sm=1 tr=0 ts=6a8e9f37 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22 a=VwQbUJbxAAAA:8
 a=EUspDBNiAAAA:8 a=_EivlD1RsPJwtJxW0JgA:9 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-ORIG-GUID: 7p4X0VJn9ppNX95AsukTPKvs5DEHk0hW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDA2NiBTYWx0ZWRfX9C5BsNZUhHai
 fcdmBpOamsvcTrZv5bWQvorSTASLFN4FK94Yki1BMx+mrNMkF9+/Lq4YNuOgMxaAEQDqKI6pyE2
 VhEO44L1zReR10zb3dEAj2BxjLq/YQg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_02,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 malwarescore=0 suspectscore=0 lowpriorityscore=0
 bulkscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260066


On Fri, 31 Jul 2026 15:42:18 +0200, Bartosz Golaszewski wrote:
> The way power sequencing works means that a call to pwrseq_power_on()
> does not necessarily result in the pwrseq target being powered-on at
> that time: it may have already been powered on before. Similarly: a call
> to pwrseq_power_off() does not have to result in an actual powering off
> of resources: there may still be other users that requested a power-on
> before.
> 
> [...]

Applied, thanks!

[1/1] power: sequencing: rename pwrseq_power_on/off() to pwrseq_enable/disable()
      https://git.kernel.org/brgl/c/d51fc9d4cd6eb18ac82913d83ecf7bd8c85f71ee

Best regards,
-- 
Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
