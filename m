Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71477442B2B;
	Wed,  5 Aug 2026 11:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.200.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785928036; cv=none; b=b3ePiHfTZwNoNHXNVF+3d8MYNKQba/kubnBEqyBEl/aZwNriYZgecl0VIs6a9JId9TK1xZXwEiCdPGPj6mMhD3mfLVWREEXZjIz4L9Akn/Z69DOHdlSz8PFa9JL2MtQI/QPDi8pKT7ljwa9jJhAZOPPliZmRzet7K7HGxf9gI7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785928036; c=relaxed/simple;
	bh=XKYGVrsCTiEueohldcNT0cgENNK9VSd8JZWn/sggJ5Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=O/xy+LAYjBUVKkdb2ZxTxpBYb5ZS7XKdsJdMvytjFjU8sOyXXJMiY9pPStBpGzSYOz/vL0UAFojKSUUc7aBYeG0jX3q+RlU5+PH5o2aO+0FmuNFwf0RfCrt3B2S1LSBMFu6p0n+mJcdAFw9G9qBuAr8trLuIGSnD9oMcJCBjvEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id C918220007B;
	Wed, 05 Aug 2026 13:07:07 +0200 (CEST)
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1wrZSl-00366L-2F;
	Wed, 05 Aug 2026 13:07:07 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1wrZSl-0000000D7A9-2Myx;
	Wed, 05 Aug 2026 13:07:07 +0200
Date: Wed, 5 Aug 2026 13:07:07 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Faruque Ansari <faruque.ansari@oss.qualcomm.com>
Cc: Sebastian Reichel <sre@kernel.org>, Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Daniel Lezcano <daniel.lezcano@linaro.org>, kernel@pengutronix.de,
	linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	linux-pm@vger.kernel.org,
	=?utf-8?B?U8O4cmVu?= Andersen <san@skov.dk>,
	Guenter Roeck <groeck@chromium.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	Ahmad Fatoum <a.fatoum@pengutronix.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <kees@kernel.org>, Francesco Valla <francesco@valla.it>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	chrome-platform@lists.linux.dev
Subject: Re: [PATCH v12 0/6] Introduce the Power State Change Reasons
 Recording (PSCRR) framework
Message-ID: <anMZW8khZl59A773@pengutronix.de>
References: <20260731095959.296056-1-o.rempel@pengutronix.de>
 <b8813d68-dcf2-4836-acd5-4ada63c20f51@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <b8813d68-dcf2-4836-acd5-4ada63c20f51@oss.qualcomm.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

Hi Faruque,

On Wed, Aug 05, 2026 at 03:04:42PM +0530, Faruque Ansari wrote:
> Hi Oleksij,
> 
> On 31-Jul-26 3:29 PM, Oleksij Rempel wrote:
> > changes v12:
> > - Drop all provider drivers and their tests; post the framework alone. The
> >    NVMEM-cell binding a recorder needs to pick its storage is still
> >    deadlocked, and several projects already need the framework - so unblock
> >    the core now and let the providers (NVMEM, PMIC, ...) follow separately.
> > - Rework into a multi-provider design (per-provider /sys/kernel/pscrr/
> >    directories); add reason tokens and a built-in /chosen/reset-source
> >    provider.
> > 
> 
> When do you plan to post the provider series (NVMEM, PMIC, etc.) separately
> to the mailing list?

After this patch stack is merged.

Currently I do not have capacity to continue. If you can, it would be
good it if you can take over next upstreaming rounds for this core. All
related follow-up patches are in my git repo.

Best Regards,
Oleksij
-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
