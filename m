From: Juha-Matti Tilli <juha-matti.tilli@iki.fi>
Subject: Re: [PATCH v5 0/4] Tegra124 soctherm driver
Date: Thu, 21 Aug 2014 21:03:29 +0300
Message-ID: <20140821180329.GA5447@sandfort.unics.fi>
References: <1408616242-21009-1-git-send-email-mperttunen@nvidia.com>
 <20140821122011.GA99564@sandfort.unics.fi>
 <20140821160127.GA17621@developer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from gw02.mail.saunalahti.fi ([195.197.172.116]:43325 "EHLO
	gw02.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753501AbaHUSDo (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 21 Aug 2014 14:03:44 -0400
Content-Disposition: inline
In-Reply-To: <20140821160127.GA17621@developer>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: Mikko Perttunen <mperttunen@nvidia.com>, rui.zhang@intel.com, swarren@wwwdotorg.org, thierry.reding@gmail.com, linux-pm@vger.kernel.org, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org

On Thu, Aug 21, 2014 at 12:01:29PM -0400, Eduardo Valentin wrote:
> I suppose the 4 C to 5 C difference is not seen anymore in this version,
> right?

Yes, I verified that this newest version writes identical calibration
values to the CONFIG2 registers than the NVIDIA's internal downstream
driver and therefore the temperature difference is not seen anymore.
All the bugs I reported have been fixed in this version.
