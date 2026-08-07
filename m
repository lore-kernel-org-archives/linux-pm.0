Received: from mail-vs1-f42.google.com (mail-vs1-f42.google.com [209.85.217.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C9384749D2
	for <linux-pm@vger.kernel.org>; Fri,  7 Aug 2026 14:59:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.217.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786114801; cv=pass; b=FuHm2DEVV1j+bZJvKeJkamsnkNDvHllEpLQvwQ5aEBuCfLttt7c00lOmygZmT5PJmXQ77VCfSebsJ/VCCJHfIVH2vOR73PU/DHIdFBbjKcyHd/AX3w/XroqjWqhAgqdC4OzpRyL42HzSDFEA21n2+pTHbbhDQeONVLIkSfu4e8k=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786114801; c=relaxed/simple;
	bh=gV20Qq1q8KHAEqMNSgw5mTDYx8Xl3nfNz4w7UDZshT8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N3YSGbsmcpQzISkUrASYXhUKBLTCnYapL64uvi5a3R6jJoETl5iikzlfnOkF2BzrNRURwzbxCOo4r4ZXLz2Q0EhXpkgEZQ+yPNzZhLwa+RWVhdGn8hThg4z1ZqVpiYaZcvIZ5+8EJ4hVTQ1+z7HR8686RY0QHa5MyFSXtxAM0TE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gyl+qiOJ; arc=pass smtp.client-ip=209.85.217.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gyl+qiOJ"
Received: by mail-vs1-f42.google.com with SMTP id ada2fe7eead31-73b909fbb6bso2047074137.2
        for <linux-pm@vger.kernel.org>; Fri, 07 Aug 2026 07:59:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786114799; cv=none;
        d=google.com; s=arc-20260327;
        b=pLegZ44brLifTGnhm5FzSjNiimUp/Ncaw41ggcdmP8IwOXrOmqSSJ0tYxP6if6XrDU
         tAmW0RceDl/G/NB9XPJ6VZUjy51PJLM9bNccMRG6TVwMvnB+AiAd5QTqFPTQZWakGsYJ
         gcZHZTOUtMagrNFt2ZmXHiPSVEK+UAMYKM0MSitkJp3AQO3tTT6KM3Jqr6i0LY4wLaXJ
         HbqR7eskMOXtBolW9DG7y0jp026GH44EhMNfd6dRtEYQ6oEibtj5eUzvFthY2VXfTkO3
         cKl9RJvn7qdZWyzlMEHwCWlvNL310av5mfG91y5kV2JsiArUdsw3rsK+WrBmU+tkApac
         Q0kg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=xvuSwihRV3vLoITfKBXt24sePvRgdmUhr3+yUrenF18=;
        fh=D6+hXAsXm4CkeLKJwpHhxVqtzL+uuOuiqq1yIsuIIkU=;
        b=gXakr1LC9vgX5cftYYykTA2N8cpBaCC3Pd0XI+C/bexCW2Ce+vPxtDZqAT+dwsFt0L
         aZ+Tyu/YdBRiaAfi9MyjXp9njQjF2Oo3SI8ZUep2QY3cPPu2koZSnopU7LK3Lin9Rkm2
         SDEdfCPJmo12Y8EJdiCOnxWh/k5AF3beC+oKrPNn34ZymO6YB92uFGqN9YMG6soCe9kV
         quNznpijib3lbCFo9wpvAIEZovXXmRHpUyzBhNJ3SSG3ugklNk2zIPhqbNE62+8olW6g
         4p09yVXxlmIMVwf0P0TV9LTzBk4y2HLNAMEGKY/N6bY8VfqYoH5M2NjAoRkLt/UOXQIl
         M25Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786114799; x=1786719599; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=xvuSwihRV3vLoITfKBXt24sePvRgdmUhr3+yUrenF18=;
        b=Gyl+qiOJiAmjPzSOy+yAUbgHE7C2l5ryrcwZj7SEstdeZ+RQ/gj0b3pqLcoW8xI+G2
         w2S7/9zA5bbP10Ap0l2Y67e5QA9K44vSAFVIWbKWgO6Z/6LORJD2qArzV6qC4vK4fVhi
         eMxU0mH8NslkObuipwS/rQBTeJrw5of9PMksU9uX9cTRAZW3bLaQY6gq3kblSvGOAJvT
         3U2CmeCH60eiIbrMmDDH3T+kowUcOpAd++FiuYPTcTvC8T+++pRDc2WTzkLjNMsD0y8b
         mryaobBDYudLE61t/mF0Znw65XqqXKH37ghcuoyZbB9lu0pIgHgMsV332cNNIFOP1TRa
         E9HA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786114799; x=1786719599;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=xvuSwihRV3vLoITfKBXt24sePvRgdmUhr3+yUrenF18=;
        b=Q0JVDI1geXfhXvXlhAOUkQbLSCpI5heMZ6dbcPVdX1finDlqdAG4WCp1XhxhV11YxW
         STEXA8PI6DSX8V79mkys98PKbw6I9y6BN3WEJpNJ0TAm/nMthKYQRYwfwoVlaYiC6Dcg
         uTAmm6CaUQW4mTxwGe3O2kLn7dfSldRKDXi3W+V1uEPNuyBqHJMqkjuFlHu3P4gtRJFI
         wi0JG3Lj1sQz4WVtacUnGvtn2NWsc3CIemb76EGJTVRV55jthNUWO4D+F3ZLTpy4c9+Z
         4ljU8r+v0NlDLfzAFKN+ULr1TZbyH1JV3CiYlLkAkUfUx2xBFh/GXz0mZDKEPAs24fcc
         kZBA==
X-Forwarded-Encrypted: i=1; AHgh+RotKqmCD5bucBfT3GRTY2gwbJz14Huxk1JpvuXrJeDM9Y8DeS2TgaGZPe40wswpGr7918MmSuq34Q==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw71EAEfzAsf8Dfhzvx1xShNNJc1PDSfkWEbZFC+oY2FCCn9vt1
	xyyzKk0PwK6wG5/HiFqHoaS1PEHNV3mPZBUwKBLPug+k0bIwsBbHWVKGt12Qc1Hn1xMFF+w2M+f
	ZEdwpzF76bq4f0ZmRxdk6UZy6s5cOvYE=
X-Gm-Gg: AR+sD133CoLUpNz4jy/E5Jvf+O7twpcotpEtylq86XVj/TAqNNV5wsbMK9PdmxNKxrS
	/jgZB4RffL9P7+Ozmz75jctUXyT+KkKYU+ghpQ52JHLzagfsKwhiCMRYOI+UhAsHBkKnC99JHE1
	iPjneVkcMCM19ppOg0RGuquH55rQKLgxiMddxZdmFALj6WmYfoMYT+KcyDBbSf0bOSnYzcwPLM0
	sRufWkOM926SqutJV0arWEg/84AtHUQTx7fjSM4bqGTmZJqe2zM8GQXfuKd0dfjEtwfI1UyloSR
	vpQaFCVvKmCk3S4EsscfKUPcpW9VsX74VCqLNMLL86U9NcOc0kxynAooN7Y8lon3LiizUcp+cFC
	GSJVpv0NM4RlYFIuoEj4k+t0O0mePmGpA54odaX+bbaAaItd/i2QxhI2/fHPM5XRjskWH8uYhvh
	HBa8vmWiR+CKSlNMjGe6x6i6XQSv5eoNRGisEo
X-Received: by 2002:a05:6102:54ac:b0:738:bf0f:d0c6 with SMTP id
 ada2fe7eead31-760e3b9ab74mr7413161137.0.1786114798682; Fri, 07 Aug 2026
 07:59:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260806-submit-mdio-of-dynamic-v2-v4-0-4beb0c50d5ba@gmail.com> <b2e83ba0-2e9c-4105-b806-8a155e8b9aa5@lunn.ch>
In-Reply-To: <b2e83ba0-2e9c-4105-b806-8a155e8b9aa5@lunn.ch>
From: James Hilliard <james.hilliard1@gmail.com>
Date: Fri, 7 Aug 2026 08:59:47 -0600
X-Gm-Features: AUfX_mzMI4rGrSWJxil0rkCdGHQcdQSp5kYsnGxukt-NVGzxhhYkib-rvufG5PE
Message-ID: <CADvTj4rame1n8eQL2GUOaJHnOcR_cqNxzNYO+QeCLYDczEFeUA@mail.gmail.com>
Subject: Re: [PATCH net-next v4 0/4] net: mdio: support dynamic OF device changes
To: Andrew Lunn <andrew@lunn.ch>
Cc: Heiner Kallweit <hkallweit1@gmail.com>, Russell King <linux@armlinux.org.uk>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Florian Fainelli <f.fainelli@gmail.com>, Richard Cochran <richardcochran@gmail.com>, 
	Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>, 
	Florian Fainelli <florian.fainelli@broadcom.com>, Jonas Gorski <jonas.gorski@gmail.com>, 
	Vladimir Oltean <olteanv@gmail.com>, Ciprian Regus <ciprian.regus@analog.com>, 
	Andreas Larsson <andreas@gaisler.com>, Mark Einon <mark.einon@gmail.com>, 
	Iyappan Subramanian <iyappan@os.amperecomputing.com>, 
	Keyur Chudgar <keyur@os.amperecomputing.com>, Michael Chan <michael.chan@broadcom.com>, 
	=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>, 
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, Doug Berger <opendmb@gmail.com>, 
	Pavan Chebbi <pavan.chebbi@broadcom.com>, =?UTF-8?B?VGjDqW8gTGVicnVu?= <theo.lebrun@bootlin.com>, 
	Conor Dooley <conor.dooley@microchip.com>, Wei Fang <wei.fang@nxp.com>, 
	Frank Li <frank.li@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, 
	Jijie Shao <shaojijie@huawei.com>, Jian Shen <shenjian15@huawei.com>, 
	Bryan Whitehead <bryan.whitehead@microchip.com>, UNGLinuxDriver@microchip.com, 
	Vladimir Zapolskiy <vz@mleia.com>, Piotr Wojtaszczyk <piotr.wojtaszczyk@timesys.com>, 
	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>, Timur Tabi <timur@kernel.org>, 
	nic_swsd@realtek.com, Byungho An <bh74.an@samsung.com>, 
	Steve Glendinning <steve.glendinning@shawell.net>, 
	Maxime Chevallier <maxime.chevallier@bootlin.com>, Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
	Alexandre Torgue <alexandre.torgue@foss.st.com>, FUJITA Tomonori <fujita.tomonori@gmail.com>, 
	Siddharth Vadapalli <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>, 
	Jiawen Wu <jiawenwu@trustnetic.com>, Mengyuan Lou <mengyuanlou@net-swift.com>, 
	Thangaraj Samynathan <Thangaraj.S@microchip.com>, Sebastian Reichel <sre@kernel.org>, 
	Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org, imx@lists.linux.dev, 
	linux-arm-kernel@lists.infradead.org, 
	linux-stm32@st-md-mailman.stormreply.com, linux-omap@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-pm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 7, 2026 at 7:16=E2=80=AFAM Andrew Lunn <andrew@lunn.ch> wrote:
>
> On Thu, Aug 06, 2026 at 09:54:19PM -0600, James Hilliard wrote:
> > MDIO buses enumerate firmware children only when the bus is registered.=
 A
> > later devicetree overlay or status transition is ignored, unlike on I2C=
 and
> > SPI buses. Supporting live reconfiguration also means that population a=
nd
> > removal can race address scanning, PHY attachment and bus teardown.
>
> Please make the bootloader work around the issues, and drop this
> patchset.

This is just fixing OF_DYNAMIC for mdio now, it's no longer used
by the AC200/AC300 PHY patches anymore.

>
>         Andrew
