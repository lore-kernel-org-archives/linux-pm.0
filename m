From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v3 3/3] memory: tegra124-emc: Add EMC driver
Date: Tue, 19 Aug 2014 11:03:14 +0200
Message-ID: <20140819090314.GC7862@amd>
References: <1408437523-8542-1-git-send-email-tomeu.vizoso@collabora.com>
 <1408437523-8542-4-git-send-email-tomeu.vizoso@collabora.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38017 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752476AbaHSJDQ (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 19 Aug 2014 05:03:16 -0400
Content-Disposition: inline
In-Reply-To: <1408437523-8542-4-git-send-email-tomeu.vizoso@collabora.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: linux-pm@vger.kernel.org, Thierry Reding <thierry.reding@gmail.com>, Terje =?iso-8859-1?Q?Bergstr=F6m?= <tbergstrom@nvidia.com>, Stephen Warren <swarren@wwwdotorg.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, Javier Martinez Canillas <javier.martinez@collabora.co.uk>, Mikko Perttunen <mperttunen@nvidia.com>

On Tue 2014-08-19 10:38:43, Tomeu Vizoso wrote:
> Sets the EMC clock rate based on the bandwidth requirements registered by
> memory clients through the PM_QOS_MEMORY_BANDWIDTH class.
> 
> Note: this is just an example and not a proper driver for a external memory
> controller. Its only purpose is to illustrate how such a driver
> would set the

So... you don't want this to be merged?

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
