Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7863E00AA
	for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 08:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784190708; cv=none; b=LICkIiQt706Jlq/B1RgU0iD20eDXvDDXYX2T40DyEfJejWAiko0CWOVDtd9LtwvZIV3A4niYFuXypXIG8PFy/FVoffiQ+KvYnonX0nwWh2+xZqtAZURyK1lPvic0HE4sQjNkt5AWMMsfjHHcbvgfapD/jvziiPEL5GTTi+/FHv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784190708; c=relaxed/simple;
	bh=6DHfUJVqQheLEpAIKU2YHLWqGBbQ8kKr9sjbdC1PERk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrAan1BR14jvMzZBbF1cK2reqkNV7HyoKXoUAUCAgmJrB+xPd/Ybfo5auf4sUU3bOU6KA7Lw+lGYLvmefGqkgBH+nw5GnGX82AXenamIxv360BW8aG/zRVj/ckZPWrD6qyU57ZEDWlUAv0nLi6SAgNV6Nm5w0kZqp95m45e2wkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=cKJ0mHMg; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cKJ0mHMg"
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-383cb94f742so5996267a91.3
        for <linux-pm@vger.kernel.org>; Thu, 16 Jul 2026 01:31:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1784190707; x=1784795507; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Bc4d8vqk+lliMKPmpqbLIgPhIFDsMX/hIWVD5yj9aEU=;
        b=cKJ0mHMg6aEmy0v65cg1aQr6syhYObFrAAz3Ipw+5pyERDObvZIzibmBLAiGagP3hC
         aRtfqHQLa8QGwLsgtmh7oillq20h7IeK0W9uE3ybzhwz9W1Uji6/vw7l/CSFdGv6znBv
         i7dFNY2eg56Mjp71OZbFuVxetr78jDR48UPQM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784190707; x=1784795507;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Bc4d8vqk+lliMKPmpqbLIgPhIFDsMX/hIWVD5yj9aEU=;
        b=TTqV2TRehhV8+gYP4rb7m7u/KAUuwEPn8vdeJNhj9LZlrPplBfVYBrzsvqXca+jGYs
         8p2TVq5ZYa9wkzJYTLgexJfJhhsh9ftp9SYKXGEbNF4BRyt9zPBuaqZVtyB0oBXQIJaK
         bwtAUcamLrf160KfOUYt3CtlnwNPvkZY41gIoAtVp3xu0y2Tz5+xvk918DzX8aei7k/S
         wJEhb/ncJv6O3o3l32vzjEsDWajXM3KhbS/eIjzCXoVUfRJAJ1162e3hw7LY3Kh5l6Mw
         taRZgPEwo/fsXfHODxbaJIEIk8w6UT6pYI6nbfOjghRme58AyxIEH2PPhBPqXFDtDCwv
         +OxA==
X-Forwarded-Encrypted: i=1; AHgh+Rqbmd2yqqroRDyK78k4yeSZhJNfpTM//nl0cqziP73rpSKX37mEmYtoCz/cnadwYGfO+vb/n/ABTw==@vger.kernel.org
X-Gm-Message-State: AOJu0YylgddqM97nY4fVOw1/6zWts4RnQs4M74RNTmpKOBYFtUZ2iJRp
	90MDjh2XDdFRuRGDNEOtHLEml9b5U4thqryRJom9DRMBkiPeZzUY38ztUdaXCrJ6lA==
X-Gm-Gg: AfdE7ckcTNnNu5qs6VEpWpSlzQFgLl96GX/FukmZWi+jaNpuwYzVJ0g6nmt9caSJKsU
	67QC9VMeNuywqMTmzIgJziOrS+oSLNgE3FbOZo37GsQMPwkKqd7Zxi0+xcXiv1qjMjCzIFmHSZv
	WIsZbepseUiGKW4JZGpR4/ipivRhxHH9bAAK+YO/L5okSKbaK/8Mu3x1rDqGANCCIr5GMTYdh6t
	T0jO5n3IBwJk7kvsavGrghjhvX0eUB88EjeTZ5fcvueV/PtE1Mji1NHfiW4SC9ruyZY2V9gTEdw
	lXFS3UtR+t0iICw4hBrKynQeF4pGMOdSoFmQIfoKbTq7XkR426Pbnm4LcXSNz3ABDeZcFIZZWuB
	tmZ5HUTfos3G+CAxC3ez2UOmFjDF2z2UepnEPTu/tipCkNX6CWBEgv4z0lHLy2V88+DqL6hRLwY
	NGzh+3Ll9FC1/wMqtRkLXCaD8GQvtNbDopHg==
X-Received: by 2002:a17:90b:4a04:b0:387:e0bb:5802 with SMTP id 98e67ed59e1d1-38e2a12332amr5930901a91.41.1784190706821;
        Thu, 16 Jul 2026 01:31:46 -0700 (PDT)
Received: from google.com ([2a00:79e0:201d:8:8cee:ac9c:232c:cca3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e39e5f713sm923742a91.14.2026.07.16.01.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jul 2026 01:31:46 -0700 (PDT)
Date: Thu, 16 Jul 2026 16:31:41 +0800
From: Chen-Yu Tsai <wenst@chromium.org>
To: Loic Poulain <loic.poulain@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, linux-pci@vger.kernel.org,
	linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-msm@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	devicetree@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>
Subject: Re: [PATCH v3 08/11] Bluetooth: hci_qca: Support QCA2066 on M.2
 connector via pwrseq
Message-ID: <20260716083141.GA4101439@google.com>
References: <20260710-monza-wireless-v3-0-46253587af64@oss.qualcomm.com>
 <20260710-monza-wireless-v3-8-46253587af64@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260710-monza-wireless-v3-8-46253587af64@oss.qualcomm.com>

On Fri, Jul 10, 2026 at 11:57:34AM +0200, Loic Poulain wrote:
> For QCA2066 (and other QCA chips) on M.2 connectors, the UART enable is
> controlled by the W_DISABLE2# signal managed by the pcie-m2 power sequencer
> rather than a dedicated BT enable GPIO.
> 
> When the serdev controller has an OF graph (indicating it is connected to
> an M.2 connector), acquire the 'uart' pwrseq target from the connector's
> power sequencer and use it to control BT power instead of the bt-enable
> GPIO. This is factored out into qca_serdev_get_m2_pwrseq().
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> Signed-off-by: Loic Poulain <loic.poulain@oss.qualcomm.com>
> ---
>  drivers/bluetooth/hci_qca.c | 35 ++++++++++++++++++++++++-----------
>  1 file changed, 24 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 24dc5bf6d192be7e1d500df6bdf36e6184f9eaf7..f6529d359ffbd97f8a3c4c0593680ab200215b36 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -1872,6 +1872,9 @@ static int qca_power_on(struct hci_dev *hdev)
>  			/* Controller needs time to bootup. */
>  			msleep(150);
>  		}
> +
> +		if (qcadev->bt_power.pwrseq)
> +			pwrseq_power_on(qcadev->bt_power.pwrseq);
>  	}
>  
>  	clear_bit(QCA_BT_OFF, &qca->flags);
> @@ -2387,6 +2390,20 @@ static int qca_init_regulators(struct qca_power *qca,
>  	return 0;
>  }
>  
> +static int qca_serdev_get_m2_pwrseq(struct qca_serdev *qcadev)
> +{
> +	struct serdev_device *serdev = qcadev->serdev_hu.serdev;
> +
> +	if (!of_graph_is_present(dev_of_node(&serdev->ctrl->dev)))
> +		return 0;
> +
> +	qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->ctrl->dev, "uart");

Note that this ultimately ties the lifecycle of the returned pwrseq
descriptor to the uart, which is probably not what you want.

I ended up manually doing pwrseq_get() with devm_add_action_or_reset()
so that the descriptor is released when the serdev driver is unbound.
This was for the Realtek driver. I haven't sent patches yet.

> +	if (IS_ERR(qcadev->bt_power.pwrseq))
> +		return PTR_ERR(qcadev->bt_power.pwrseq);
> +
> +	return 0;
> +}
> +
>  static int qca_serdev_probe(struct serdev_device *serdev)
>  {
>  	struct qca_serdev *qcadev;
> @@ -2417,6 +2434,10 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  	else
>  		qcadev->btsoc_type = QCA_ROME;
>  
> +	err = qca_serdev_get_m2_pwrseq(qcadev);
> +	if (err)
> +		return err;
> +
>  	switch (qcadev->btsoc_type) {
>  	case QCA_WCN3950:
>  	case QCA_WCN3988:
> @@ -2426,17 +2447,9 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  	case QCA_WCN6750:
>  	case QCA_WCN6855:
>  	case QCA_WCN7850:
> -		/*
> -		 * OF graph link is only present for BT devices attached through
> -		 * the M.2 Key E connector.
> -		 */
> -		if (of_graph_is_present(dev_of_node(&serdev->ctrl->dev))) {
> -			qcadev->bt_power.pwrseq = devm_pwrseq_get(&serdev->ctrl->dev,
> -								  "uart");

It's already incorrect here. But I think the original patch that
introduces this hasn't landed?


ChenYu

> -			if (IS_ERR(qcadev->bt_power.pwrseq))
> -				return PTR_ERR(qcadev->bt_power.pwrseq);
> +		/* M.2 connector modules are powered by the pwrseq acquired above. */
> +		if (qcadev->bt_power.pwrseq)
>  			break;
> -		}
>  
>  		if (!device_property_present(&serdev->dev, "enable-gpios")) {
>  			/*
> @@ -2528,7 +2541,7 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>  			return PTR_ERR(qcadev->susclk);
>  		}
>  	}
> -	
> +
>  	if (qcadev->bt_power.pwrseq) {
>  		bt_en_available = pwrseq_power_is_controllable(qcadev->bt_power.pwrseq);
>  		if (!bt_en_available) {
> 
> -- 
> 2.34.1
> 
