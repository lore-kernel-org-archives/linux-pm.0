From: Aaron Lu <aaron.lu@intel.com>
Subject: Re: [PATCH 0/2] virtio: Replace CONFIG_PM with CONFIG_PM_SLEEP
Date: Fri, 06 Sep 2013 16:29:03 +0800
Message-ID: <5229924F.3070007@intel.com>
References: <1378455607-32459-1-git-send-email-aaron.lu@intel.com> <20130906082235.GE29367@grmbl.mre>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([143.182.124.21]:55781 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745Ab3IFI2w (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Fri, 6 Sep 2013 04:28:52 -0400
In-Reply-To: <20130906082235.GE29367@grmbl.mre>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Amit Shah <amit.shah@redhat.com>
Cc: Rusty Russell <rusty@rustcorp.com.au>, "Rafael J. Wysocki" <rjw@sisk.pl>, virtualization@lists.linux-foundation.org, linux-pm@vger.kernel.org

On 09/06/2013 04:22 PM, Amit Shah wrote:
> On (Fri) 06 Sep 2013 [16:20:05], Aaron Lu wrote:
>> This patchset replace CONFIG_PM with CONFIG_PM_SLEEP for all virtio
>> drivers and virtio pci driver.
>>
>> With patch 1/2, two compile warnings are eliminated for virtio pci
>> driver, and patch 2/2 is a clean up for all virtio drivers as suggested
>> by Amit Shah.
> 
> Thank you.

My pleasure, thanks for your review.

I was addressing a comment for my patch:
http://marc.info/?l=linux-pm&m=137839111130358&w=2
and accidentally found this issue here :-)

-Aaron

> 
> Reviewed-by: Amit Shah <amit.shah@redhat.com>
> 
> 		Amit
> 

