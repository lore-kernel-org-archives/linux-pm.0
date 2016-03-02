From: One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>
Subject: Re: [RESEND PATCH v3 5/6] power: cros_usbpd-charger: Add EC-based
 USB PD charger driver
Date: Wed, 2 Mar 2016 12:31:54 +0000
Message-ID: <20160302123154.5a488f66@lxorguk.ukuu.org.uk>
References: <1456907012-19268-1-git-send-email-tomeu.vizoso@collabora.com>
	<1456907012-19268-6-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from lxorguk.ukuu.org.uk ([81.2.110.251]:37914 "EHLO
	lxorguk.ukuu.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752873AbcCBMcl (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 2 Mar 2016 07:32:41 -0500
In-Reply-To: <1456907012-19268-6-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-kernel@vger.kernel.org, Sameer Nanda <snanda@chromium.org>, Javier Martinez Canillas <javier@osg.samsung.com>, Lee Jones <lee.jones@linaro.org>, Benson Leung <bleung@chromium.org>, Enric =?UTF-8?B?QmFsbGV0YsOy?= <enric.balletbo@collabora.co.uk>, Vic Yang <victoryang@chromium.org>, Stephen Boyd <sboyd@codeaurora.org>, Vincent Palatin <vpalatin@chromium.org>, Randall Spangler <rspangler@chromium.org>, Todd Broch <tbroch@chromium.org>, Gwendal Grignou <gwendal@chromium.org>, Shawn Nematbakhsh <shawnn@chromium.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, linux-pm@vger.kernel.org, David Woodhouse <dwmw2@infradead.org>


> +static int ec_command(struct cros_ec_dev *ec_dev, int version, int command,
> +		      uint8_t *outdata, int outsize, uint8_t *indata,
> +		      int insize)
> +{

int is a very odd type to use for sizes that cannot be negative,
especially given all your callers use sizeof() which is a size_t and is
not necessarily an int type and you then pass it to memcpy which expects
a size_t anyway


Alan
