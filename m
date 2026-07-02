Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1975A3546C0
	for <linux-pm@vger.kernel.org>; Thu,  2 Jul 2026 12:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782994496; cv=none; b=YaaU4WN51xzuNrUc+CQ80thiWqId635v1aigTBZ7YWDyGIpcOX/GHh3wjfnWS8qtfMYU9wB+a7wwjJk2fH8W/xRXKiB4NAFkTZzUHQS2v68KNufeT+mUyhHVIVOxtq3E7EWlqAPqKufk0FRvCLiUkz/yql+hhK3Nz5ij63xEGWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782994496; c=relaxed/simple;
	bh=3mmx+/0sXAdWT+pakhHyX3kTBrQwKkeYxwkz9M2nEYk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nJdyRPtyAxwXApQz7KsZACvgXb+O1GxkDkKERhuiuPtI94mpdMwLCPJSpOQjcK/rA/hTdQswMeO/pTbEBKX9HUFbsuuUYd3BvkmGwI4IQ/SbSJd48uE3T7dwT+Qave2pIgF1HWQvb8u9snJtCkURAduv0HkfQRSXAxGXqeaawCQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com; spf=pass smtp.mailfrom=oss.qualcomm.com; dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b=Eklqlkdk; dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b=kGc+VJ8C; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.qualcomm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.b="Eklqlkdk";
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="kGc+VJ8C"
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6629L83E4117610
	for <linux-pm@vger.kernel.org>; Thu, 2 Jul 2026 12:14:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=zm20ylCeMzuZiz3s/y5e/wk5
	Pyn0IY6ZLPEKM9fU5YE=; b=EklqlkdkxONpR0ssH8uNTgSBlMOWyb7qIXEVdKze
	tOTnf/GGrpmP7faX6K6FJMtJhVhsazQRM07+nFw6XnY5Rp8voe1/WC5w67qG41AU
	Ye2T3Og026cHn0LN4YASci+ZjzTJzTIN0h/1Y9/CXuzP/KYTyHgOu4RnGwsh5ZLi
	ZpVY+YZBRfxVTcBRBGDbDg8TKFVdt7oWbjiFq5jBFS9U2MSHTbK9354u+6HThI81
	WJJDl1e7PkeWHdvMDYFJxsp3h5L9lsCiMHv7264ucXy3LAXmyWTHY1R1xkOPkcb2
	RdC89JYeALQJvpOBxrfQsdyTSywoKJHoTXo4yYc9E66RbA==
Received: from mail-ua1-f70.google.com (mail-ua1-f70.google.com [209.85.222.70])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5n9bgmy3-1
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
	for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 12:14:54 +0000 (GMT)
Received: by mail-ua1-f70.google.com with SMTP id a1e0cc1a2514c-969289fca9dso368879241.1
        for <linux-pm@vger.kernel.org>; Thu, 02 Jul 2026 05:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oss.qualcomm.com; s=google; t=1782994493; x=1783599293; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=zm20ylCeMzuZiz3s/y5e/wk5Pyn0IY6ZLPEKM9fU5YE=;
        b=kGc+VJ8C/QhXZ9xObaTi8QGSmoncLciXvujqqSoqLXJ86DYu8HudvaV90wntNvGQ6B
         EoC6CEHdTcq0nznU+OkEmts9dDaF6AAFyWmwwSlaD+7QMDA5pcD3qR55T14LJdUkp/g1
         6dlt6EmEAPBk5aDkAXtZbZKEs0BGbnr/PrjHamh/Y/CqUzIjHoOAOfdWNKu1Fj4VJ+c5
         8UXMfZQ6EGFGLefCjtPfup8jQvve0n+uWGrrwIjlf/lt5gPIYXpwQQLvtjtT0+3iS8g0
         ri2FbRfsDCWq4hLsVxJ5lCqaYgsvNkHzXVojnPGfrtL8uIlNgicQ6xvmnhsddGTc/GFG
         7loA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782994493; x=1783599293;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zm20ylCeMzuZiz3s/y5e/wk5Pyn0IY6ZLPEKM9fU5YE=;
        b=ZMqdWlMTfujNILE9yox/1X0+G8OAs4wXfDYhJ1PpeKTTD82pzELv2etgbWQ3i2wU9O
         9K3wyqxG25YNXg/uHYN/9GLh/F4zvYvV89LOW27JJvJ5AH/UkNjgqm1YJFWqpi6HX8S8
         TamDxlQWc6MpIsBBR/h/wTyMzc7irjY1FScjHgTXz40AIbRW2e7Pu8HZzMIJiGaodTUj
         dv9lxOpThi6J5m2jGn/vQMGAwkmoYgcsXrxZxSyd8xVXcKtx9Z2nX5qoYPfwnwNDS8fk
         cVrRcAL4E/Pce3HoZzIU7Q4qq16yyXXCYuo8EYyfvhQFdn4pkdZo0kVRrLEVPDyGe+uk
         mP9Q==
X-Forwarded-Encrypted: i=1; AHgh+RrLdW1XoWwffMIbIL03tfkIZ0ONKK4XdwYaNiV/fQ4ymdbROp6SP+OSG1gmR/4C5TqWPhkqQ/Uj3Q==@vger.kernel.org
X-Gm-Message-State: AOJu0YzTe10V5cc2o36muGs9UfAPzWqW1QdvT0OYung6UsUWg3LrcJZf
	JUfbFaX8KFF5Suw0mINdEaXXtvsKqfXaV3NtfYuVhpnwRedSWagJ9yp+4myrftjkqnTrQ7VQGyt
	E3Y8b/z9EsettF2/dtXdn4naj05DQ+rILJnPP9bhb18uWmkyhEVFSYyPNAjIayw==
X-Gm-Gg: AfdE7cnGl4H5VlwXkL690EpM/ZmBqBrVhucMFD1mZx2a/W1TIwIyyuawclOiKSQnIht
	tXwUC6vayehjgeJZJouA+5R36MhpGuwHjxodqABTrHsv/yK/cXuVr7OUt9xJk3ehUy+taRs8U+8
	F/WhYBZCBqvh7C0v4xmJrL6PGo0W5yczMT6Ktdzf6WXz6nxZmqWdX16SGZwk+oIYbL3BVxjvr83
	ne+r5/XN0OymcQpYDX2Pwwi6O1DNidLaImWd5di2dcCRdv3Ay+iB8gAEz9oEDj0NAdLoQo/Buxs
	zfqaO1sNzlYl/p3W/eGUiREelF+vCN2i6lXWr3db7o33sgCLy7IYuQ2UtSgZuyVVwenGRLF3apZ
	5M4cMHqCMcS5ORum9Yk7sjJO/CszNMs6IIOCDAtRaMr78f+jAmFXA9IlVua8SS3Am+0rmWlq+vA
	ElFUxUnwLsfgPlZqI9igl4iPlw
X-Received: by 2002:a05:6122:8b12:b0:59f:8ddb:2fc1 with SMTP id 71dfb90a1353d-5bddf5bae25mr1989779e0c.7.1782994493320;
        Thu, 02 Jul 2026 05:14:53 -0700 (PDT)
X-Received: by 2002:a05:6122:8b12:b0:59f:8ddb:2fc1 with SMTP id 71dfb90a1353d-5bddf5bae25mr1989761e0c.7.1782994492816;
        Thu, 02 Jul 2026 05:14:52 -0700 (PDT)
Received: from umbar.lan (2001-14ba-a073-af00-264b-feff-fe8b-be8a.rev.dnainternet.fi. [2001:14ba:a073:af00:264b:feff:fe8b:be8a])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aec89eb6ffsm650658e87.83.2026.07.02.05.14.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 05:14:51 -0700 (PDT)
Date: Thu, 2 Jul 2026 15:14:49 +0300
From: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
        Bartosz Golaszewski <brgl@kernel.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v2 3/4] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Message-ID: <43re752djujsh2kiyvjlkpmztxsh4atg6472qhir4lgay24zbo@mtlkn2xc2ors>
References: <20260702-monza-wireless-v2-0-7b56e2a6a6d4@oss.qualcomm.com>
 <20260702-monza-wireless-v2-3-7b56e2a6a6d4@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260702-monza-wireless-v2-3-7b56e2a6a6d4@oss.qualcomm.com>
X-Proofpoint-ORIG-GUID: tj6YOp_nArQD_io40xCFCRBCiRIFv1Bv
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEyOCBTYWx0ZWRfX82+CjA7VvmB8
 fJE5LiLXt9u//e5iGBNCIoxc8udFBjMomGiuWHXoOdLWJFOZ1pz9nUythUPY2isw6fvE6y819qn
 bPLuigpdDI3NhaGjos8Bs7yO3f/wkgM=
X-Proofpoint-GUID: tj6YOp_nArQD_io40xCFCRBCiRIFv1Bv
X-Authority-Analysis: v=2.4 cv=bOom5v+Z c=1 sm=1 tr=0 ts=6a46563e cx=c_pps
 a=R6oCqFB+Yf/t2GF8e0/dFg==:117 a=xqWC_Br6kY4A:10 a=kj9zAlcOel0A:10
 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22 a=EUspDBNiAAAA:8
 a=GH4E13IOXdwHnVtn7D4A:9 a=CjuIK1q_8ugA:10 a=TD8TdBvy0hsOASGTdmB-:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEyOCBTYWx0ZWRfX87oXyn9o0wNA
 7G8pd4e9uCSuIGCys+WPJZAcF3h0NcpWA1XRkRHPhFtTmmCueBR25ceUJBshf3rCmY2ZTleWPZh
 KOPOgyFFBIrw8DZYvFnT2i7GDx6U96oONo8fAIBjEAJF8P32RqrKIREY/szcV8MXt0jaFIatCgK
 O+tR9sM7iHPZSp7cvnaTpi9yyTXdKjhUQp23ogegyCwSlyOXR4KQCQmQs62ZyJu8WmxIJzwkWVd
 vWwSxIJOJ3aIqxVPg7T50NXrU7Z4oO9W+uXugggnNsOzR4JcRqORzKFmAN1UniNAIp5iOh9R95a
 5oJLfVyban6pRAbuKtt8xQWxpWK6cX6zbbFgzi1YOSmgS5wzsF+BIMtAqBMliuQk8pZrFtzO7q5
 WMAg8yOIYbDnrXrY43WpCd6eP3q55Sx8+Q4ohJLhYiN/wOf8UsgpnmLSdtLEQEAXlyK7oQ8cx3H
 67zqTIKXEzdMkaqUGCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 clxscore=1015 suspectscore=0
 phishscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020128

On Thu, Jul 02, 2026 at 12:46:15PM +0200, Loic Poulain wrote:
> For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable
> is controlled by the W_DISABLE2# signal managed by the pcie-m2 power
> sequencer rather than a dedicated BT enable GPIO.
> 
> When the serdev controller has an OF graph (indicating it is connected
> to an M.2 connector), acquire the 'uart' pwrseq target from the
> connector's power sequencer and use it to control BT power instead of
> the bt-enable GPIO.
> 
> Also allocate bt_power unconditionally for all SOC types since the

Can we just fold it into the main struct?

> pwrseq path is independent of the SOC type switch.
> 
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 81 ++++++++++++++++++++++++---------------------
>  1 file changed, 43 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index e09debdb00a1b8e74ccd5de6147e240e533b4594..b04593a96e14ac9e87ae76fa00eda308e81dea25 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hdev)
>  			/* Controller needs time to bootup. */
>  			msleep(150);
>  		}
> +
> +		if (qcadev->bt_power->pwrseq)
> +			pwrseq_power_on(qcadev->bt_power->pwrseq);
>  	}
>  
>  	clear_bit(QCA_BT_OFF, &qca->flags);
> @@ -2256,7 +2259,7 @@ static void qca_power_off(struct hci_uart *hu)
>  		break;
>  	}
>  
> -	if (power && power->pwrseq) {
> +	if (power->pwrseq) {
>  		pwrseq_power_off(power->pwrseq);
>  		set_bit(QCA_BT_OFF, &qca->flags);
>  		return;
> @@ -2387,6 +2390,35 @@ static int qca_init_regulators(struct qca_power *qca,
>  	return 0;
>  }
>  
> +/*
> + * Acquire the M.2 connector power sequencer.
> + *
> + * An OF graph link on the serdev controller is only present when the BT
> + * device is attached through an M.2 Key E connector. In that case the UART
> + * enable (W_DISABLE2#) is driven by the pcie-m2 power sequencer instead of a
> + * dedicated BT enable GPIO, so grab the "uart" pwrseq target from it.
> + *
> + * Returns 0 if no M.2 connector is present (nothing to do), a negative errno
> + * on error, otherwise 0 with qcadev->bt_power->pwrseq populated.
> + */
> +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev, bool *bt_en_available)
> +{
> +	struct serdev_device *serdev = qcadev->serdev_hu.serdev;
> +	struct device *dev;
> +
> +	if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
> +		return 0;
> +
> +	qcadev->bt_power->pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");
> +	if (IS_ERR(qcadev->bt_power->pwrseq))
> +		return PTR_ERR(qcadev->bt_power->pwrseq);
> +
> +	dev = pwrseq_to_device(qcadev->bt_power->pwrseq);
> +	*bt_en_available = device_property_present(dev, "w-disable2-gpios");

I think here you are looking into the exact details of the other of the
graph. There might be other devices on that side, while the code now
assumes M.2. Or, consider having an M.2 controller which handles
W_DISABLE2# internally rather than through the GPIO.

> +
> +	return 0;
> +}
> +
>  static int qca_serdev_probe(struct serdev_device *serdev)
>  {
>  	struct qca_serdev *qcadev;

-- 
With best wishes
Dmitry
