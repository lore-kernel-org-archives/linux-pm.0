From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / AVS: SmartReflex: Neaten logging
Date: Wed, 14 Sep 2016 03:05:07 +0200
Message-ID: <9788331.PKcMJtbmQZ@vostro.rjw.lan>
References: <20160819161550.31796-1-khilman@baylibre.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:60945 "HELO
        cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with SMTP id S1758428AbcINA7A (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Tue, 13 Sep 2016 20:59:00 -0400
In-Reply-To: <20160819161550.31796-1-khilman@baylibre.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Hilman <khilman@baylibre.com>
Cc: linux-pm@vger.kernel.org, Nishanth Menon <nm@ti.com>, Joe Perches <joe@perches.com>

On Friday, August 19, 2016 09:15:50 AM Kevin Hilman wrote:
> From: Joe Perches <joe@perches.com>
> 
> Use a more common logging style.
> 
> Miscellanea:
> 
> o Use pr_warn
> o Coalesce formats adding missing spaces
> o Argument alignment
> o Remove unnecessary OOM messages as k.alloc does stack dumps
> 
> Signed-off-by: Joe Perches <joe@perches.com>
> Acked-by: Nishanth Menon <nm@ti.com>
> [khilman: update shortlog]
> Signed-off-by: Kevin Hilman <khilman@baylibre.com>
> ---
> Applies on v4.8-rc1

Applied.

Thanks,
Rafael

