From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / clk: Add support for adding a specific clock from device-tree
Date: Mon, 04 Jul 2016 15:05:35 +0200
Message-ID: <2012826.iGRI857Kz0@vostro.rjw.lan>
References: <1466505205-20115-1-git-send-email-jonathanh@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cloudserver094114.home.net.pl ([79.96.170.134]:53566 "HELO
	cloudserver094114.home.net.pl" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1753262AbcGDNBD (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 4 Jul 2016 09:01:03 -0400
In-Reply-To: <1466505205-20115-1-git-send-email-jonathanh@nvidia.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jon Hunter <jonathanh@nvidia.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org

On Tuesday, June 21, 2016 11:33:25 AM Jon Hunter wrote:
> Some drivers using the PM clocks framework need to add specific clocks
> from device-tree using a name by calling the functions
> of_clk_get_by_name() and then pm_clk_add_clk(). Rather than having
> drivers call both functions, add a helper function of_pm_clk_add_clk()
> that will call these functions so drivers can call a single function
> to add a specific clock from device-tree.
> 
> Signed-off-by: Jon Hunter <jonathanh@nvidia.com>

Applied, thanks!

