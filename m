From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH] intel_pstate: change some inconsistent debug information.
Date: Tue, 16 Jun 2015 01:41:57 +0200
Message-ID: <2535630.urq67NLmxE@vostro.rjw.lan>
References: <1433083607-4150-1-git-send-email-dsmythies@telus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from v094114.home.net.pl ([79.96.170.134]:59396 "HELO
	v094114.home.net.pl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1750960AbbFOXQA (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 15 Jun 2015 19:16:00 -0400
In-Reply-To: <1433083607-4150-1-git-send-email-dsmythies@telus.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Doug Smythies <doug.smythies@gmail.com>
Cc: kristen@linux.intel.com, linux-pm@vger.kernel.org, dsmythies@telus.net

On Sunday, May 31, 2015 07:46:47 AM Doug Smythies wrote:
> In a previous revision,
> commit ce717613f3fb531dea3e11c8c24d80585331f137
> turned per cpu printk into pr_debug.
> However, only half of the change was done,
> introducing an inconsistency between
> entry and exit from driver pstate control.
> This patch changes the exit message to
> pr_debug also.
> 
> The various messages are inconsistent with respect
> to any identifier text that can be used to help
> isolate the desired information from a huge log.
> This patch makes a consistent identifier portion
> of the string.
> 
> Signed-off-by: Doug Smythies <dsmythies@telus.net>

Queued up for 4.2, thanks!


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
