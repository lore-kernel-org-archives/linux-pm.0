From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 0/2] virtio: Replace CONFIG_PM with CONFIG_PM_SLEEP
Date: Fri, 6 Sep 2013 13:52:35 +0530
Message-ID: <20130906082235.GE29367@grmbl.mre>
References: <1378455607-32459-1-git-send-email-aaron.lu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43047 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750956Ab3IFIWn (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 6 Sep 2013 04:22:43 -0400
Content-Disposition: inline
In-Reply-To: <1378455607-32459-1-git-send-email-aaron.lu@intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Aaron Lu <aaron.lu@intel.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, "Rafael J. Wysocki" <rjw@sisk.pl>, virtualization@lists.linux-foundation.org, linux-pm@vger.kernel.org

On (Fri) 06 Sep 2013 [16:20:05], Aaron Lu wrote:
> This patchset replace CONFIG_PM with CONFIG_PM_SLEEP for all virtio
> drivers and virtio pci driver.
> 
> With patch 1/2, two compile warnings are eliminated for virtio pci
> driver, and patch 2/2 is a clean up for all virtio drivers as suggested
> by Amit Shah.

Thank you.

Reviewed-by: Amit Shah <amit.shah@redhat.com>

		Amit
