From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: wakeup source that was used
Date: Mon, 17 Jun 2013 14:06:08 +0200
Message-ID: <1473113.m7q7YAXoR3@vostro.rjw.lan>
References: <1629766.cbj9daGTOY@linux-5eaq.site>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:40198 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932610Ab3FQL44 (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 17 Jun 2013 07:56:56 -0400
In-Reply-To: <1629766.cbj9daGTOY@linux-5eaq.site>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Oliver Neukum <oneukum@suse.de>
Cc: rafael.j.wysocki@intel.com, linux-pm@vger.kernel.org

On Monday, June 17, 2013 10:21:39 AM Oliver Neukum wrote:
> Hi Rafael,
> 
> is there a good way to find out which source actually triggered a wakeup?
> That is if the whole system was asleep.

Not really.  The only reliable way would be to monitor their wakeup counts
anyway.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
