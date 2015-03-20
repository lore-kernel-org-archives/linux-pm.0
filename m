From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v3] driver core / PM: Add PM domain callbacks for device setup/cleanup
Date: Fri, 20 Mar 2015 13:57:15 +0100
Message-ID: <1654636.FxBHsexDm1@vostro.rjw.lan>
References: <3533423.QQDErEmeTO@vostro.rjw.lan> <5975784.LhOHuiUKGO@vostro.rjw.lan> <1810625.BTgaNclHRk@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:63398 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751637AbbCTMdS (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 20 Mar 2015 08:33:18 -0400
In-Reply-To: <1810625.BTgaNclHRk@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ulf Hansson <ulf.hansson@linaro.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alan Stern <stern@rowland.harvard.edu>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Kevin Hilman <khilman@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Russell King <linux@arm.linux.org.uk>, Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>


