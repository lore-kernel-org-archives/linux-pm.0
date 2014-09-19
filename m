From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH v2 1/1] power: Add simple gpio-restart driver
Date: Thu, 18 Sep 2014 21:35:04 -0700
Message-ID: <541BB278.9010701@roeck-us.net>
References: <1409167431-21155-1-git-send-email-davidriley@chromium.org> <1409167431-21155-2-git-send-email-davidriley@chromium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from bh-25.webhostbox.net ([208.91.199.152]:38458 "EHLO
	bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751458AbaISEfK (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 19 Sep 2014 00:35:10 -0400
Received: from mailnull by bh-25.webhostbox.net with sa-checked (Exim 4.82)
	(envelope-from <linux@roeck-us.net>)
	id 1XUpuX-0022MF-7V
	for linux-pm@vger.kernel.org; Fri, 19 Sep 2014 04:35:09 +0000
In-Reply-To: <1409167431-21155-2-git-send-email-davidriley@chromium.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: David Riley <davidriley@chromium.org>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>
Cc: Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>, Mark Rutland <mark.rutland@arm.com>, Ian Campbell <ijc+devicetree@hellion.org.uk>, Kumar Gala <galak@codeaurora.org>, Grant Likely <grant.likely@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Anton Vorontsov <anton@enomsg.org>, Marc Carino <marc.ceeeee@gmail.com>, Anders Berg <anders.berg@lsi.com>, Laxman Dewangan <ldewangan@nvidia.com>, Ivan Khoronzhuk <ivan.khoronzhuk@ti.com>, Maxime Ripard <maxime.ripard@free-electrons.com>, Haojian Zhuang <haojian.zhuang@linaro.org>, Jamie Lentin <jm@lentin.co.uk>, Doug Anderson <dianders@chromium.org>, devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org

On 08/27/2014 12:23 PM, David Riley wrote:
> This driver registers a restart handler to set a GPIO line high/low
> to reset a board based on devicetree bindings.
>
> Signed-off-by: David Riley <davidriley@chromium.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

