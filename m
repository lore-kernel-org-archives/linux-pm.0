From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / Domains: cleanup: rename gpd -> genpd in debugfs interface
Date: Wed, 04 Mar 2015 15:49:51 +0100
Message-ID: <2591586.pYKtbEshPf@vostro.rjw.lan>
References: <1425324268-16090-1-git-send-email-khilman@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:64517 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1757064AbbCDO0Q (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 4 Mar 2015 09:26:16 -0500
In-Reply-To: <1425324268-16090-1-git-send-email-khilman@kernel.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@kernel.org>
Cc: linux-pm@vger.kernel.org, Maciej Matraszek <m.matraszek@samsung.com>, Ulf Hansson <ulf.hansson@linaro.org>, Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, open list <linux-kernel@vger.kernel.org>

On Monday, March 02, 2015 11:24:28 AM Kevin Hilman wrote:
> From: Kevin Hilman <khilman@linaro.org>
> 
> To keep consisitency with the rest of the file, use 'genpd' as the
> name of the 'struct generic_pm_domain' pointer instead of 'gpd'.
> 
> This is just a rename, no functional changes.
> 
> Signed-off-by: Kevin Hilman <khilman@linaro.org>

Applied, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
