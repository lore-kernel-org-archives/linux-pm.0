From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [GIT PULL] Thermal SoC management updates for v4.8-rc1
Date: Thu, 04 Aug 2016 13:21:59 +0800
Message-ID: <1470288119.26646.5.camel@intel.com>
References: <1470265127-22631-1-git-send-email-edubezval@gmail.com>
	 <20160803232638.GA25554@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:53872 "EHLO mga14.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751198AbcHDFXT (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 4 Aug 2016 01:23:19 -0400
In-Reply-To: <20160803232638.GA25554@localhost.localdomain>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>

On 三, 2016-08-03 at 16:26 -0700, Eduardo Valentin wrote:
> On Wed, Aug 03, 2016 at 03:58:47PM -0700, Eduardo Valentin wrote:
> > 
> > Hello Rui,
> > 
> > Please pull from
> So, forgot to mention that I have been away from upstream work for
> some
> time now, and I am still catching up on my emails.
> 
> I've just realized that this may be a bit too late for the pull. I
> saw
> that you had some comments on the thermal subsystem reorg. Let me
> know
> if this pull still causes troubles. We can always post pone to next
> merge window.
> 
Yes, there are two updated patch from me to fix two different problems,
which are not included in your pull request, plus, I believe there is
still another problem reported by lkp, which is not addressed yet.
> 
> Let me know how you want to handle this one.
> 
I believe a new pull request without the thermal reorg and locking
changes is needed.

thanks,
rui

