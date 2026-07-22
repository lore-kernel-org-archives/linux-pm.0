Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE2E30C15B;
	Wed, 22 Jul 2026 00:01:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784678491; cv=none; b=q7I2h7gfhqcapiCP0gnZ7g8frHmqmSGirSNWEyDxOhAFXHskJp2zgrHe8faPC7SzM3Hh387Ir87TGE/I6EqVndUjdMK0bYDAri57Ytirj7orSU0XFJHuph1FMnToYHyt8f3b5t71P08exr/WLjkWGJWE7l91im8vWkrLyKnWzi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784678491; c=relaxed/simple;
	bh=hleNQDvp3zDiTHSTss/dUm28GBBbuhZj5Wm+BsAj5gk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=GtIXkrI5uVWcXgAPys8vhuQY/uHriz15ZxcqXKGI0xMP5TJMlOJEBFB/RiuWXRfWUJjJGCvAcDRcRYknGVtLaXaw9oGNvt2RMUTbPXsQipqoZxy8MLYD/oeV9rajltBvKr25BxE0mcMVCDBlTwxdy+1jVxNuYuxOG6RwaPf7x0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7A371F000E9;
	Wed, 22 Jul 2026 00:01:27 +0000 (UTC)
Received: by venus (Postfix, from userid 1000)
	id 582D3180767; Wed, 22 Jul 2026 02:01:26 +0200 (CEST)
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Herman van Hazendonk <github.com@herrie.org>
Cc: linux-pm@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
In-Reply-To: <20260605-submit-power-max8903-dc-limit-v2-0-0c5396e98f14@herrie.org>
References: <20260605-submit-power-max8903-dc-limit-v2-0-0c5396e98f14@herrie.org>
Subject: Re: [PATCH v2 0/2] power: supply: max8903: add DC and USB input
 current-limit GPIO controls
Message-Id: <178467848633.517463.2438801173999791619.b4-ty@collabora.com>
Date: Wed, 22 Jul 2026 02:01:26 +0200
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3


On Fri, 05 Jun 2026 11:18:11 +0200, Herman van Hazendonk wrote:
> v2 addresses two rounds of reviewer feedback on v1.
> 
> Sebastian Reichel (1 finding):
>  - Drop usb-current-limit-values DT property. The IUSB pin is
>    silicon-fixed at 100/500 mA per the MAX8903 datasheet Pin
>    Description ("Drive IUSB logic-low to set the USB current limit
>    to 100mA. Drive IUSB logic-high to set the USB current limit to
>    500mA."), so there's nothing board-specific to expose. The two
>    values are bound to MAX8903_USB_CURRENT_LIMIT_{LOW,HIGH}_UA
>    #defines in the driver with the datasheet quote in a header
>    comment; usb-current-limit-gpios stays as the board parameter.
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: power: supply: maxim,max8903: add DC and USB input current-limit controls
      commit: 353438b3107d56e36a642f117c2b4accc963abbd
[2/2] power: supply: max8903: add DC and USB input current-limit GPIO controls
      commit: 828414660052b629378764e5d5c1f07e60716a48

Best regards,
-- 
Sebastian Reichel <sebastian.reichel@collabora.com>

