Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34DC430E827
	for <linux-pm@vger.kernel.org>; Sat, 18 Apr 2026 19:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776541109; cv=none; b=akJRprm9pJaPh4P6lILC4dhKGj69sXAfz5dINwyf3YOJO3XxJ8ujib/eMhG0iF0AsoUktK5AM6hJ7EdgWMaf6PRKmTNa2ewRHJp2QIXO96chQbOnsPBuzPEmaGkx8quVk0h5NmVhbzHp+SzhBnpYi7y5yWjaX9BEZPFirm5snR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776541109; c=relaxed/simple;
	bh=D9bDtXxW3hYg3zOewGGHaPyX3bjoSoMDKPBs+JVD+jY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E8Pp5TTj9XFOK2mLUzRkZfIDrLrQYKA0uBZOqqxSP7yG3avgfHxCNwoUaiiaR9XK7o33Ra5NNAHRQhCwdM1iwVQ89GFHnGqFWjdXa9euzGdn0LiJKMtGm//Ldvd+FH/nzb0aYpPQPoyyK3YBbIDtN3k3i62HDgMAVL9MWqZUZIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=iPZXIwGw; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=GvFRYeH2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="iPZXIwGw";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="GvFRYeH2"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63I4UQJk1411163
	for <linux-pm@vger.kernel.org>; Sat, 18 Apr 2026 19:38:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=kbwvqRx22EuSdW1o5avcOXEZ
	l4XvhLf+30K9TnHpX7o=; b=iPZXIwGw/DRx+Zt91iZVqqLZHLhQfaqwatR2rPg1
	i8q/oA20HMpxH46pXKnyynNMPPH3db0oFL2PK63Bs7E27TI5ymG5qeIbZF5BvULk
	fRL+sK6vkRG52aO4231tZMZp6/iiQg6i5CfN59YvFzpx/VShtp1gXg1vrhaOqV+d
	sFE0aHqta25IQs3krIY5t1bY8CMV3neSQM9FM4XkgLm9RecZM35805nez8FbngXI
	oSi3ULWHzpk6HGHHBH/6wUwPVCfWam5B1MN7PYZg5E1pyeEM7b7ymoyHzfk2d+Mo
	pacK+MXqrVp5Yz+tWcCcwbV9AGMreEJX2ukMqJDehzcNAA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com [209.85.160.200])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dm2qahb6x-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Sat, 18 Apr 2026 19:38:26 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id d75a77b69052e-50e423a05c8so21335341cf.0
        for <linux-pm@vger.kernel.org>; Sat, 18 Apr 2026 12:38:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1776541105; x=1777145905; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=kbwvqRx22EuSdW1o5avcOXEZl4XvhLf+30K9TnHpX7o=;
        b=GvFRYeH2nJbXQnVmTxae0cy5BJ8CC7+i6hHTuJzCbz2DZFQuqsp6h9lsSypaJ+R+cI
         jah43EYBSdWQPkMBJjUnHE3D3EJz4oShRVHehZgZmrdRI/vh6JqMfaY3/CAUzsagDUif
         odZGQ6ir9XhXkXSZX0iC6WBSmaCpVKaIiO2H59+3lW2cE/HmZl3WtLyBFpiok1/7vgHy
         l65wNvqR2nMICFVuR1Ly0GKJkTSrCUBtAW8nkQLStdyGAp/xHr45qG8f3S12jxNDg0W3
         mknq8FT85rCigmT+2sj++Ytf0n7KH6U+JgqhVR8g0473fOUeLVokq9RNKiQ6jEpdvRYz
         M61g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776541105; x=1777145905;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kbwvqRx22EuSdW1o5avcOXEZl4XvhLf+30K9TnHpX7o=;
        b=orcr9KNqmClUIUOTWcAjemoR8XOUt1h3XEuQqiOuc9o+9FZFT8CZEBG35BHyfRgaEh
         VEDjkHMEN/ANpABK2FEyQSFiwdRBVjwKOgNnSFvDKNKW0ibRCD5asvg67q4UX44Si/A0
         d4jWSoehN/VgyTxapXdzp3hq7Hs+JouypVuWPsEwS6jtGaUtQee0JD9I/fdgWLwH629f
         CHLrH4WsKsvkmvlVb0nNWpn/KNmzxBIGiuPywDtB4eJkbkfGp8ClI6bXkyZIjA2rPgrk
         0lWYHqtF7FbksEOGSQa17U06505wZ7y+A5BvFrxM36U4JB2xLuWrHhpjqYjyphJ5OJ1S
         ApYw==
X-Forwarded-Encrypted: i=1; AFNElJ/6eLWYn/4AtOnfi7cQ7ynUbC98ilfbPngRSNIdSxqX6uf/fpFLwDvFbchY4YZ7FnPpL450tMfYHg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzyxrPiwnTAmcFBCHa1qKtDIp3c3WXyucfuqyhhCPC3c2wzfGvg
	88gzPzHKGsECHPFBV6O4L00gQDMWk7zxeYaHs2+XPEiXY3L18h/pom19RW775zEFK7BuXSTih8Z
	ivTYHOhSRZ9n67nbO0AgwElZ44poY8ww2bJ2Se11TQkTsSPy/Vw1n6rKT9xS73w==
X-Gm-Gg: AeBDieu2pBi920x5l3XC1XKKxmugyCXljDpJ/FPKIP090DJ8DBQ9+kmJEulW1g8PKXN
	x6F4Xk98ux6gkMAVS6GfNHNs1neBdsskzp7gGyZGLf6WVoQkaBgExo0OuffzR+Elyzqnlc3ejUh
	IAnh1gYmxZ3Olc1N+HyOP3plhMxqQYDIgJ4O79UlMHeTlMXT5YJlSvq2CrtcqQn2UkuNCPbKzHM
	tuFv0pP1YfJ96uYkxkx4ug3IcGtaB9Bv0nBjX8Jtbx0FfMxyj4FS8NVrb0vzvUInwTi/I+HMZap
	KlkkKv2/F7LgZ55ZXIcBSwV47nD4gQ3rMg1gdncO6XlXrkcHnVzY5yVwD71RnFRpQNL3X3z2WNF
	moC2/v918B8lOqSYGn89HyY1DwuR2x/IlYYZOkOvQZIdWoWoq4nJ2yj2ScsgVrnqW8O3Bd180TA
	hffA70uzcFUC+w+0nxfihEgX0oxTdKeA6wsymFtBrE2M7YKw==
X-Received: by 2002:a05:622a:48c:b0:50d:9c1b:941f with SMTP id d75a77b69052e-50e3661b147mr97389831cf.8.1776541105483;
        Sat, 18 Apr 2026 12:38:25 -0700 (PDT)
X-Received: by 2002:a05:622a:48c:b0:50d:9c1b:941f with SMTP id d75a77b69052e-50e3661b147mr97389461cf.8.1776541105035;
        Sat, 18 Apr 2026 12:38:25 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a4187e7dd0sm1553387e87.69.2026.04.18.12.38.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Apr 2026 12:38:22 -0700 (PDT)
Date: Sat, 18 Apr 2026 22:38:21 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Luca Weiss <luca.weiss@fairphone.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, linux-wireless@vger.kernel.org,
        ath10k@lists.infradead.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: Re: [PATCH v3 3/8] wifi: ath10k: snoc: support powering on the
 device via pwrseq
Message-ID: <hdypom3nioc6tk26gh647imy5ykhcjqvknideilnbc2b5p7eo7@hm7fsscleutf>
References: <20260119-wcn3990-pwrctl-v3-0-948df19f5ec2@oss.qualcomm.com>
 <20260119-wcn3990-pwrctl-v3-3-948df19f5ec2@oss.qualcomm.com>
 <DHUHU7UIT487.139L3KIVRVREU@fairphone.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DHUHU7UIT487.139L3KIVRVREU@fairphone.com>
X-Proofpoint-GUID: -2RdFEprskuz10vSg9h-vfCNXobiXcJN
X-Authority-Analysis: v=2.4 cv=KdDidwYD c=1 sm=1 tr=0 ts=69e3ddb2 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=bC-a23v3AAAA:8
 a=EUspDBNiAAAA:8 a=Rs7pINfTDodmtXVth3IA:9 a=CjuIK1q_8ugA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=FO4_E8m0qiDe52t0p3_H:22
X-Proofpoint-ORIG-GUID: -2RdFEprskuz10vSg9h-vfCNXobiXcJN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDE4MDE5NiBTYWx0ZWRfX+fZMNUVMS4//
 Ktzl8tCvub8GmHj82YM1dWHbZn/8BIeJ/ddpqqtB603C9aDXa/Zfl4UGe9iQXs/Ww5XclvXoBBu
 7e/ysHCd4eLiItnjExN5ex8kcO5elfdrS92o6+KmXHh0idfHPEjCyMyHdh9LgtWL7IH+rmWVVR3
 8+7cuyH0AcFwGOGu8VDvHhGIEKYAlTLX7cMbC9J6vZW6r9pgDT+Y8siNeRicHkraljZQpBx6Zg+
 +umkHtO7gI2bP8YTZpnKMG32ImheXDURN1CZ5N8nmgmCOjDs51i+Ly/CHf9ddUhPRH1yZKPP8f0
 LMhQ168LF3xJjAVXoJ7YuUj8o4Jfc5shz70GPBrvXcdPeBaMSELnxmsuFEFhbS9B9bGsSgQQccP
 RibpHN1fdsmb3km2OssF14A1sdnptogO4fVdlXKtiZTTkDPPDtVf/LWu+U6zqL462vT9yPmEqvE
 AsnIhUE/FxhVNkfbUBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-18_05,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 spamscore=0 priorityscore=1501 malwarescore=0
 suspectscore=0 adultscore=0 phishscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604180196

On Thu, Apr 16, 2026 at 12:06:09PM +0200, Luca Weiss wrote:
> Hi Dmitry,
> 
> On Mon Jan 19, 2026 at 6:07 PM CET, Dmitry Baryshkov wrote:
> > The WCN39xx family of WiFi/BT chips incorporates a simple PMU, spreading
> > voltages over internal rails. Implement support for using powersequencer
> > for this family of ATH10k devices in addition to using regulators.
> >
> > Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
> > Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> > ---
> >  drivers/net/wireless/ath/ath10k/snoc.c | 53 ++++++++++++++++++++++++++++++++--
> >  drivers/net/wireless/ath/ath10k/snoc.h |  3 ++
> >  2 files changed, 53 insertions(+), 3 deletions(-)
> >
> > +	ar_snoc->pwrseq = devm_pwrseq_get(&pdev->dev, "wlan");
> > +	if (IS_ERR(ar_snoc->pwrseq)) {
> > +		ret = PTR_ERR(ar_snoc->pwrseq);
> > +		ar_snoc->pwrseq = NULL;
> > +		if (ret != -EPROBE_DEFER)
> > +			goto err_free_irq;
> 
> I'm fairly sure this is now broken with CONFIG_POWER_SEQUENCING=n since
> then pwrseq_get() is returning ERR_PTR(-ENOSYS) which is not handled
> here.
> 
> I'm observing my ath10k_snoc is now failing to probe "with error -38"
> which definitely seems to be related, but I haven't debugged it further
> yet.

Posted https://patch.msgid.link/20260418-ath10k-snoc-pwrseq-v1-1-832594ba3294@oss.qualcomm.com

-- 
With best wishes
Dmitry
