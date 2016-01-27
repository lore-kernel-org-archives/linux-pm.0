From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] power: APM_EMULATION does not depend on PM
Date: Wed, 27 Jan 2016 23:56:22 +0100
Message-ID: <8245283.jd8eAvEnqE@vostro.rjw.lan>
References: <1453736913-1959469-1-git-send-email-arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51324 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S934086AbcA0Wz3 (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 Jan 2016 17:55:29 -0500
In-Reply-To: <1453736913-1959469-1-git-send-email-arnd@arndb.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>
Cc: Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>, linux-arm-kernel@lists.infradead.org, Jiri Kosina <jikos@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Monday, January 25, 2016 04:48:28 PM Arnd Bergmann wrote:
> The APM emulation code does multiple things, and some of them depend on
> PM_SLEEP, while the battery management does not. However, selecting
> the symbol like SHARPSL_PM does causes a Kconfig warning:
> 
> warning: (SHARPSL_PM && PMAC_APM_EMU) selects APM_EMULATION which has unmet direct dependencies (PM && SYS_SUPPORTS_APM_EMULATION)
> 
> From all I can tell, this is completely harmless, and we can simply allow
> APM_EMULATION to be enabled here, even if PM is not.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied, thanks!

Rafael

