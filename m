Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5158F3A1A38;
	Sat, 17 Oct 2026 21:56:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792274196; cv=none; b=CfHA4XcBb0VA00q12GghGusOHOXY8vbWIU2k11V85xRnxZDJ1jnDk05sO9L40ADaNtkXwGAgzBYVFc5qYnxwN9yjgrTEfjVmRDjF7gsh/Ykacj9+au0bS8Hd7NCs+EkDakjMnU7QKLkKFSCJCVzF/0JfRt9qeZAmJPyH3GbJfFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792274196; c=relaxed/simple;
	bh=vaZ7b5n1bK7SXCra/rZmIr85JIgToMGZRxxhQ6UwYZA=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WYy14TglfV8/CPLhmHNu8pYAu0rlfbGtDH3JUoMJVi/Vtr187GckfbCnbUI4KkXJLmivo5/r2JSiwBtZOtIlgOqylv5oeY2/+S5gvJAUBIy34/PZ0NvLufKvdhXvwnV7agLUvdzJ5eFgH1fX1Qvq8s/2xX4mAUMWov7QG29t20Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 096DA1F000C8;
	Sat, 17 Oct 2026 21:56:35 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 7B7661824B7; Sat, 17 Oct 2026 23:56:33 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: sre@kernel.org, Joonhoe Kim <26rote@gmail.com>
Cc: konrad.dybcio@oss.qualcomm.com, kamal.wadhwa@oss.qualcomm.com, 
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20261012130053.442-1-26rote@gmail.com>
References: <20261012130053.442-1-26rote@gmail.com>
Subject: Re: [PATCH v2] power: supply: qcom_battmgr: report the USB type
 from USB_ADAP_TYPE
Message-Id: <179227419349.76434.7052897282112702545.b4-ty@b4>
Date: Sat, 17 Oct 2026 23:56:33 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.16.0


On Mon, 12 Oct 2026 22:00:53 +0900, Joonhoe Kim wrote:
> On SM8350 and SM8550 class firmware the USB power supply reads its
> usb_type from the USB_TYPE property. On a Kaanapali (SM8850) tablet that
> property is 1 (SDP) whatever is plugged in, while USB_ADAP_TYPE reports
> the adapter, using the same numbering as POWER_SUPPLY_USB_TYPE_*:
> 
>   PC port                  USB_TYPE 1   USB_ADAP_TYPE 1 (SDP)
>   USB-C dock, 5 V PD       USB_TYPE 1   USB_ADAP_TYPE 6 (PD)
>   65 W PPS charger         USB_TYPE 1   USB_ADAP_TYPE 8 (PD_PPS)
> 
> [...]

Applied, thanks!

[1/1] power: supply: qcom_battmgr: report the USB type from USB_ADAP_TYPE
      commit: a49f86cd1333c6e12fd37bc0b3234ace10072553

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

