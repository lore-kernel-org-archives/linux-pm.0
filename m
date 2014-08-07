From: Andreas Schwab <schwab@suse.de>
Subject: Re: [PATCH] cpufreq: arm_big_little: fix module license spec
Date: Thu, 07 Aug 2014 17:33:22 +0200
Message-ID: <mvmegws8gcd.fsf@hawking.suse.de>
References: <mvmmwbqateb.fsf@hawking.suse.de>
	<1406792216-827-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<mvmiom48knf.fsf@hawking.suse.de>
	<20140807152934.GT1933@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:38580 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932134AbaHGPdZ (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 7 Aug 2014 11:33:25 -0400
In-Reply-To: <20140807152934.GT1933@pengutronix.de> ("Uwe =?utf-8?Q?Kleine?=
 =?utf-8?Q?-K=C3=B6nig=22's?=
	message of "Thu, 7 Aug 2014 17:29:34 +0200")
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, Sudeep Holla <sudeep.holla@arm.com>, kernel@pengutronix.de, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de> writes:

> Does adding
>
> 	#include <linux/module.h>
>
> in that file fix the problem?

Yes, it does.

Andreas.

--=20
Andreas Schwab, SUSE Labs, schwab@suse.de
GPG Key fingerprint =3D 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B=
9D7
"And now for something completely different."
