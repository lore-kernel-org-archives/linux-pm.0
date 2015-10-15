From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PM / hibernate: Move pm_init/pm_disk_init to late_initcall_sync
Date: Thu, 15 Oct 2015 02:36:51 +0200
Message-ID: <17855483.enPLrpsYWM@vostro.rjw.lan>
References: <1444093820-6934-1-git-send-email-wonhong.kwon@lge.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:51674 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1754159AbbJOAII (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 14 Oct 2015 20:08:08 -0400
In-Reply-To: <1444093820-6934-1-git-send-email-wonhong.kwon@lge.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Wonhong Kwon <wonhongkwon@gmail.com>
Cc: len.brown@intel.com, pavel@ucw.cz, linux-pm@vger.kernel.org, gunho.lee@lge.com, Wonhong Kwon <wonhong.kwon@lge.com>

On Tuesday, October 06, 2015 10:10:20 AM Wonhong Kwon wrote:
> pm_init is being invoked by core_initcall and hibernate_image_size_init
> calculates preferred image size (image_size) based on total pages
> (totalram_pages). This totalram_pages can be modified during various
> initcall-s phase and this can cause miscalculated image_size.
> 
> For example, when CMA is being used, init_cma_reserved_pageblock tries
> to change the totalram_pages and this job is done during core_initcall.
> In order words, the totalram_pages doesn't take CMA reserved pages into
> account when image_size is calculated and it can be too small.
> 
> Move pm_init and pm_disk_init to late_initcall_sync so that it happens
> after all other initcall-s change the totalram_pages.
> 
> Reported-by: Sangseok Lee <sangseok.lee@lge.com>
> Signed-off-by: Wonhong Kwon <wonhong.kwon@lge.com>

Applied, thanks!

Rafael

