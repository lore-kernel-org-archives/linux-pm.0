From: Antti P Miettinen <ananaza@iki.fi>
Subject: Re: [PATCH RFC v2 2/2] Documentation: arm: define DT C-states
 bindings
Date: Mon, 27 Jan 2014 14:48:15 +0200 (EET)
Message-ID: <20140127.144815.1048814583962628826.apm@brigitte.kvy.fi>
References: <1390240079-6495-3-git-send-email-lorenzo.pieralisi@arm.com>
	<20140125.101546.1134862463481697494.apm@brigitte.kvy.fi>
	<20140127114125.GD16639@e102568-lin.cambridge.arm.com>
Reply-To: ananaza@iki.fi
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx.kvy.fi ([83.143.60.202]:10385 "EHLO mx.kvy.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751431AbaA0MsV (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 27 Jan 2014 07:48:21 -0500
In-Reply-To: <20140127114125.GD16639@e102568-lin.cambridge.arm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: lorenzo.pieralisi@arm.com
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org, Dave.Martin@arm.com, Mark.Rutland@arm.com, Sudeep.Holla@arm.com, Charles.Garcia-Tobin@arm.com, nico@linaro.org, robh+dt@kernel.org, pdeschrijver@nvidia.com, grant.likely@linaro.org, galak@codeaurora.org, santosh.shilimkar@ti.com, mark.hambleton@broadcom.com, hanjun.guo@linaro.org, daniel.lezcano@linaro.org, amit.kucheria@linaro.org, vincent.guittot@linaro.org, sboyd@codeaurora.org, t.figa@samsung.com, khilman@linaro.org

From: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> That's why I defined the worst case. How did you implemented it in your
> idle drivers ? That would help generalize it, after all these bindings
> are there to simplify drivers upstreaming, feedback welcome.

Currently we do not handle this well downstream either. The problem
with worst case is that the absolute worst case can be really bad and
probability of it might be very low. Sorry - no ready answer :-)

	--Antti
