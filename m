Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795428763;
	b=xXHdYLOj53xOrToDRjOj4OU0nnNU2l7GHEvzhA+oFlFfTV21Cr4l06jtTvUYcTzKGLGh
	 7f4w/0W9hVDBiSKjiNp6C0gQCreKZh8El5MNnRQQGNVxdkmfOH6vhK+7IJVxiCRxqc57X
	 pr6x57DF1x+OTtqa7TXmpF/nIKUT4rneJEpYSY1Rjpkt6me66N6ZpT8ZUrVBTgWRl/b54
	 E2EMnCp97bRcQT4FkV9SXUCJUxH60p33rFyAlY8vfT74eQrZc0H/6HlgX36xsMuu38qwQ
	 Xv1U7H8d/uhSTwBsnDIT1gPP+tZfFt5q9NnUuGZNRtP90M9e7XHhYs2uyOzmQN6ytFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795428763;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 MIME-Version:References:In-Reply-To:From:Date:X-Gm-Features:
	 Message-ID:Subject:To:Cc:Content-Type:Content-Transfer-Encoding;
	bh=Z6PZb3pWfu3DBOMyeBvBYRTT0i6m3apihG5iiqFet2Q=;
	b=yimkabs4nHM94QvrNwA0ThJpMyNLmdLhNV1IPB514r/p/zfMnvTyMj6Acrn+ha3e5H0T
	 9FErt8H4F7R/OCUV7MuCt4aWZ80JPJdzEqvpo3ix7PoVyndU2dACdAZpBlcE4dpRDjqgg
	 EdYu8NuYEmawa0eFMUGwTeBOr0Mjk15zoR6YhwM/Fwz32HbjlKIl/H6TRWdjTFMBb6xXR
	 +ktdbsfTvj/tG1fRdWCKqyGEaIidq2MWFiGJIRd0eIh3zcM5lYvMMfnCqK5niiryGA0uO
	 +PskwrrG4di6d9wzfTBMrkQ+huSV3qpVzkv0W08zUbDjVEy+7Nb7dZ066+Tojqy6DXw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=flipper.net;
	spf=pass smtp.mailfrom=flipper.net;
	dkim=pass header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=MqfY2WR5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=209.85.218.41
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD6B8606A32D
	for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 10:12:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BD6B8606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=flipper.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flipper.net
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=flipper.net header.i=@flipper.net header.a=rsa-sha256 header.s=google header.b=MqfY2WR5
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c4203bbb1e9so503852766b.3
        for <linux-pm@vger.kernel.org>; Mon, 23 Nov 2026 02:12:42 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795428761; cv=none;
        d=google.com; s=arc-20260327;
        b=j2Ne+xGDcdsCLpBavH+JiJe7Z172d0/M+qx2iLedGrTCHeEvp4H90q9mB34cYQyHgi
         jNMwD2r5dY5PW4pVshwzniodCaopB3IsdNoHUeDtqzBc7P/w+7KdmPOQSrNwZOoXHk3U
         dz1OrwHVFa+gv/Prlg9GjfH+BQythFWn/Ysv/oVpU3H8J5HM0Y/awhRTMY35J+KcoMZC
         x5svniQamQCXUDc/XkoKNQ3wfl5/sMIWFwBiNIWjjb0T4bKrJDNFLkuXdUegeWALrElk
         vlBp7EMNqRFb/Q98Zd3+I+eu7JGqsuXX8IXFOq7deu/yP+k8cIhd7uH3zqpCFshKcJQS
         LkAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Z6PZb3pWfu3DBOMyeBvBYRTT0i6m3apihG5iiqFet2Q=;
        fh=s5bqvFbi1un9k4Wvph0RDBKHNiATYaaMuiYBugPvaiU=;
        b=FsNo9e7u7xaNFWtQ8MlEOPJyoifwTwej4SxuWMucCEz3E83bhIZwV5CUI9V9XxAbHC
         j1CFC+7BjJLr1U4pBe6jSrEhdKFFfsH+5pg/kEWrjm9J0elk0Lidhga4Kf+n0WjYxspV
         SzHR+/wkLl68f322/gKAMjJWDHhUn5boStsFuYAiTeZGi4kFpL6NZVrqjh4Rx2GOa/qo
         j+DWdVKywxXL8zxUWDgBKOi0LxQeRxsuErwrp0WSeQTQReqmGX49NP2N94D1DwQIHGU7
         GEWUzRcVjTwfh7Phry305uU1uVUn6OD/5IQ+L7PJjedRzcGysRtJPdd/t8cEZLqYLIdx
         BKDA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=flipper.net; s=google; t=1795428761; x=1796033561; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=Z6PZb3pWfu3DBOMyeBvBYRTT0i6m3apihG5iiqFet2Q=;
        b=MqfY2WR5A+tGruAVHjRKrDw5GIaiKkjvwm6WEch6FTIYRq8BLizWLXn5zpDnFwRRwA
         kwN6xPmj02C+f4K6Pesc/ipxTUWAJ/jX7Z2eV2g3S3/G9Ri2i5mYzwiFBYWE4mKlYNib
         JaEKi9jzGkUyZfJGjcv+VdtMrCTPstBpK7aXngyyd0uzeK44uGws21jQUKMvEPyX72E9
         nu0okVVQrxrFvL6Nj9PKzFOum9ntDS1PavLl2r5c/4y05NfY1cHnTTw1MJUAQvpESx1Q
         qXotT3VmYjML0hmwFGL+p+w5OsqphEiy5AfG0/ACGnd6E2yJhxynpmSns7W94umSVVpc
         w4qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795428761; x=1796033561;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Z6PZb3pWfu3DBOMyeBvBYRTT0i6m3apihG5iiqFet2Q=;
        b=UsvulcQvhPmiQTUdXas2D/9w484ckzDWhAJZS3yemp4ikKM5O2azsxyMaPU9A4TIoI
         VvDsWc0UWU0mnTU2wTQP9jDNs0dggV3JUBi6HSZ60CAovu0QPSF3hD//KHBveDTWmFd8
         etLlLXYgck1saGmxP6XoD3eCyPP3PF9cf1LU2/VS3KJQV0zC8CL3/2flpQCtZY7JZ64N
         pglORGzpQgitAn9IreoiPbcuypgmFSPOEVfS7JEbqi/fxKHhU0oS1UW2cUX8L37hQ24t
         8EVQrBrd7deFtmBqT7opdQs823vODhg4cguWTZK00GQ+KesSuTcuA+B5+rB31zNt0BrS
         RGcQ==
X-Forwarded-Encrypted: i=1; AL+hErGvXPptLkFRfwOe2s6zAkmQ33OwDimepMl9Lwxjt6QQfjJ2aCSCvUbisN+ALDpjfFZUV/HHP4sMuw==@vger.kernel.org
X-Gm-Message-State: APuU4Z+A0h4KbIEH0/bKWastiAkWrHUYYEzy3TAIS+f7a37vkAxD7kZB
	kJBKCkgCSv+9lCggCFe09p1+owmA6a7d98lremGHHcEqPgPmqQAx3MJgZ+TX0kMdnHDREUMcCL1
	ljPV3NthcwQ8XFqs48xwEuR/qtLD8WG9E9b8OAt2Cqw==
X-Gm-Gg: AZFdTZc2Kpn8TMF8Pao69zSVnVsfdHI8LxJxsnZrgqR0s1zx25fPy1EFZxZ6a+qT5S1
	A2uo0u6uDrKbvF+Q8VRbNCVQaTzqXyXH+b5qa3TJy6C6TMGOjiIaR2qFU4S5maRtDpfX8u2cD0t
	NXwCdnpp7wigBDGjInZ6Zx+Y/1g3qhwPHfmuUIJlWj6DLPhlp3dNITzEEf6lfAb80ypOy8oT8XR
	KS1md+tK5cl9t2lepCICo8GFUNKd/JpYAO1aoVbrIqIRCyG/p1/BJWIh56d5jb3w1JcAoz2ozTK
	6ulbwg4gh2LZja9NUWDGhddd0lqBRa12ApLuNg+lEAD0hUdvfpzGAEImzW2Dsp93sthaDGQHH7+
	YBONZZwbQQ29M9OL3x/YjkP4+HhDDUyuvaInp+MmUxCpndKdtG0xi6MHyxv4vfQ1Rw+SEaXRn31
	2VNkrcUELYmGsjk8U=
X-Received: by 2002:a17:906:115a:b0:c3e:ee86:d2c with SMTP id
 a640c23a62f3a-c513a866684mr820899566b.27.1795428760997; Mon, 23 Nov 2026
 02:12:40 -0800 (PST)
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Post: <mailto:linux-pm@vger.kernel.org>
List-Help: <mailto:linux-pm+help@vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-pm+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
References: <20261122-pcie6_fix-v2-0-2e0fe615d90b@oss.qualcomm.com> <20261122-pcie6_fix-v2-2-2e0fe615d90b@oss.qualcomm.com>
In-Reply-To: <20261122-pcie6_fix-v2-2-2e0fe615d90b@oss.qualcomm.com>
From: Alexey Charkov <alchark@flipper.net>
Date: Mon, 23 Nov 2026 14:12:30 +0400
X-Gm-Features: Aa3M54q-Xar7VXEu12WPkFbFHzHu90UHCgQbyjxEoWpDnyAZhVgjhAvqOSDzA9E
Message-ID: <CAKTNdwEuu75UHA2_r9FLmximPjXVHp05Aztk201AjnFGcGSXRw@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] power: sequencing: pcie-m2: Add support for PCIe
 M.2 Key B connectors
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>
Cc: Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Bartosz Golaszewski <brgl@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konradybcio@kernel.org>, Abel Vesa <abelvesa@kernel.org>, linux-pci@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-pm@vger.kernel.org, linux-arm-msm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Krishna,

On Sun, Nov 22, 2026 at 10:46=E2=80=AFAM Krishna Chaitanya Chundru
<krishna.chundru@oss.qualcomm.com> wrote:
>
> Add support for handling the power sequence of the PCIe M.2 Key B
> connectors. These connectors are used to attach WWAN Adapters to the
> host machine over interfaces such as PCIe, USB3.1 Gen1, SSIC, or USB
> 2.0.
>
> Currently, this driver only supports driving the 3.3V/VBAT power
> supply along with the FULL_CARD_POWER_OFF#, RESET#, and W_DISABLE1#
> GPIOs as a single "pcie" target, since Key B Adapters expose only a
> discoverable PCIe/USB interface and no non-discoverable bus (unlike
> Key E's UART-attached Bluetooth device), so no serdev creation is
> needed. The other signals described in the binding are not supported
> yet.
>
> Signed-off-by: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.co=
m>
> ---
>  drivers/power/sequencing/pwrseq-pcie-m2.c | 70 +++++++++++++++++++++++++=
++++++
>  1 file changed, 70 insertions(+)
>
> diff --git a/drivers/power/sequencing/pwrseq-pcie-m2.c b/drivers/power/se=
quencing/pwrseq-pcie-m2.c
> index 56c5d51293c1..8af4a059b596 100644
> --- a/drivers/power/sequencing/pwrseq-pcie-m2.c
> +++ b/drivers/power/sequencing/pwrseq-pcie-m2.c
> @@ -39,6 +39,8 @@ struct pwrseq_pcie_m2_ctx {
>         struct notifier_block nb;
>         struct gpio_desc *w_disable1_gpio;
>         struct gpio_desc *w_disable2_gpio;
> +       struct gpio_desc *full_card_power_off_gpio;
> +       struct gpio_desc *reset_gpio;
>         struct device *dev;
>         struct list_head pci_devices;
>         struct mutex list_lock;
> @@ -135,6 +137,45 @@ static const struct pwrseq_unit_data pwrseq_pcie_m2_=
e_pcie_unit_data =3D {
>         .disable =3D pwrseq_pci_m2_e_pcie_disable,
>  };
>
> +static int pwrseq_pci_m2_b_pcie_enable(struct pwrseq_device *pwrseq)
> +{
> +       struct pwrseq_pcie_m2_ctx *ctx =3D pwrseq_device_get_drvdata(pwrs=
eq);
> +       int ret;
> +
> +       ret =3D gpiod_set_value_cansleep(ctx->full_card_power_off_gpio, 0=
);
> +       if (ret)
> +               return ret;
> +
> +       ret =3D gpiod_set_value_cansleep(ctx->reset_gpio, 0);
> +       if (ret)
> +               return ret;
> +
> +       return gpiod_set_value_cansleep(ctx->w_disable1_gpio, 0);

Can this signal be exposed as an rfkill device instead? Otherwise the
pwrseq driver hogs it enabled with no way for userspace to control the
radio power, and WWAN power draw is quite non-negligible for portable
devices. Ditto for w_disable2_gpio (GNSS).

I'm also wondering if the WWAN-related signals should be skipped
altogether for non-WWAN module configs?

Best regards,
Alexey
