Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E5F6181334;
	Fri,  2 Oct 2026 04:22:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790914968; cv=pass; b=LERohNUh71WzlXcCUw06zJ+81beT0nU4tjJTtbDII2JGIPOZGfZz0HCCaDzFjH/Oef7/PlDbossb5rpQyWzKo3iYhv6cscvus/C6QL5eiloLKlNo1OnoLj69WDc7qqYIJewhKWi7+vu53PPasjp9WELlZNLVtnR1R5C0LDancEI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790914968; c=relaxed/simple;
	bh=e88pRB7MkAyUq2c2V8R7ncpEngY3XcHMxiFUuNJtX1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gsVWIs229dKQj11tZRA6v8D0Lt3AKAqAmJkiZ3FyDnkDof1Vi9aMWODTqWeMhK4p0McoUQhgv0diV7xs0VNilze2vCc0ktj5Xn2D+WAZ6m9N1ESsHksXaHFXKILzG8qj9+ElpWremVRvNCydBe5l0Zislqy5uk4I+slZdwkL2UY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=OURzAOxs; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="OURzAOxs"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 2C97D20058C;
	Fri, 02 Oct 2026 06:22:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790914963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eiR1ExEbLsg+Md8FDZk2s7GKs0WpAoHQuPsCgDjYGn8=;
	b=OURzAOxsvpnyOUa3rnjuCf1lV3jTBoFx+9pLFuN5iyWyQe6BOzyfSrAqHcidglfCep8Tna
	1tHOaP/vupf7Mh7D9ZxMlRHHSUHQE3IB8lDfydrKkINsxw9F4zVBI/HSG0w6sRnzbR/djJ
	8KLuQMHJ+aklwyPwhETMxhI9Vi2C2qFUiI+Y2wCN8VIn/qJJQWw2PzPvUT8w9KVFg3peRo
	1XRfF/8/zxtclLa0y/JY84iZCRXgLts6nKhCUy5Ph2tg4v5H2Sx8UN6ea/+N8Rv7G6YYPr
	j0gGZ0hYmHw98f2IbzlRRvFZL4lzpocwuoFgu1hj1gZb12zjx+NFI5P8Bbuqqw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790914963; a=rsa-sha256;
	cv=none;
	b=PJtACP0DrMwPGLway2lHmDd9bO+31qgYdl2xUJiav8YguWCAUmZBR5FTSKTHdEHpUCFgwe
	oabKJgCcdfMECb12qtWo6A8qq09+nTPyrOXUPzmJ7mFvsKdmK4LvbQphzO8gf4dJbVilhm
	LNKfH+aLPAoc4p6o78Mee/UUE9GRiwzmaLrbOX4WfY2+mZR5SxoUzC1LWVRZJdBKQaGKPA
	P72fCi+O8vadUrnv5p4CZ2QWPyDc7/KctEQl9G1k+0Bl6LQjv22Ojl5mv3SU+QXo0WUVUM
	G5S7Ofq2Lwkn3M1BQkCVyMxG2gN9KWv0TeJJCOKDSqmJv6+bS4RIabBTXGSVZg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=ore@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790914963;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eiR1ExEbLsg+Md8FDZk2s7GKs0WpAoHQuPsCgDjYGn8=;
	b=HSsf44kvHuV4qV7gy/WfqnayANRPA13ronMMC0Rdh1gFVFmVvJ727W3q81Fr8y4pC13O8s
	K3i9uehkcruQin3j22ZP6eXWnWs0TqivRese8XcatZbziyP8OJVHSG4pY+T009dLTiCfO0
	zcc+PU2IYC5zlyuQLw/F048O82BRHQyICaIFQjI8Rba9NkfXvAwqdx3OqAG0Go0VVTq8pt
	gtu75MtPSQF01Iijdy72XyB0Sld597EegsIXiGHiTaADLHknjf2ZZOTtqmrjV8FIRaoJs8
	7zV0y8c3pmA1Zo1p3+TW3kgPpt5v59p8bGp+oMtC4bi++x0f5rDZor0KE2EAaQ==
Received: from pty.whiteo.stw.pengutronix.de ([2a0a:edc0:2:b01:1d::c5])
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <ore@pengutronix.de>)
	id 1xCUnD-003pmF-0J;
	Fri, 02 Oct 2026 06:22:43 +0200
Received: from ore by pty.whiteo.stw.pengutronix.de with local (Exim 4.98.2)
	(envelope-from <ore@pengutronix.de>)
	id 1xCUnC-000000078BQ-43aD;
	Fri, 02 Oct 2026 06:22:42 +0200
Date: Fri, 2 Oct 2026 06:22:42 +0200
From: Oleksij Rempel <o.rempel@pengutronix.de>
To: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: Faruque Ansari <faruque.ansari@oss.qualcomm.com>,
	Sebastian Reichel <sre@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Guenter Roeck <groeck@chromium.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Matti Vaittinen <mazziesaccount@gmail.com>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Daniel Lezcano <daniel.lezcano@kernel.org>,
	Zhang Rui <rui.zhang@intel.com>, Lukasz Luba <lukasz.luba@arm.com>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	chrome-platform@lists.linux.dev,
	Umang Chheda <umang.chheda@oss.qualcomm.com>,
	linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	avaneesh.dwivedi@oss.qualcomm.com
Subject: Re: [PATCH v15 1/6] power: Extend power_on_reason.h for upcoming
 PSCRR framework
Message-ID: <ar8xkv8h4x2NJTKl@pengutronix.de>
References: <20260924-pscrr-framework-v15-0-7af87107e0d3@oss.qualcomm.com>
 <20260924-pscrr-framework-v15-1-7af87107e0d3@oss.qualcomm.com>
 <e34e6661-3ecf-42f6-96f2-5136afe7ab65@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-pm@vger.kernel.org
List-Id: <linux-pm.vger.kernel.org>
List-Subscribe: <mailto:linux-pm+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pm+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e34e6661-3ecf-42f6-96f2-5136afe7ab65@oss.qualcomm.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain

On Thu, Oct 01, 2026 at 10:22:44PM +0200, Daniel Lezcano wrote:
> On 9/24/26 09:08, Faruque Ansari wrote:
> > Prepare for the introduction of the Power State Change Reason Recorder
> > (PSCRR) framework by expanding the power_on_reason.h header. This
> > extension includes new power-on reasons:
> > - POWER_ON_REASON_OVER_CURRENT for over-current conditions.
> > - POWER_ON_REASON_REGULATOR_FAILURE for regulator failures.
> > - POWER_ON_REASON_OVER_TEMPERATURE for over temperature situations.
> > - POWER_ON_REASON_EC_PANIC for EC panics.
> 
> How the system knows an EC panic happened?

Hm... looks like I lost this change on the way. I added it for this
case:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/drivers/platform/chrome/cros_ec_lpc.c?h=v7.3-rc5#n458


-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
