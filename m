From: Oliver Neukum <oneukum@suse.com>
Subject: Re: suspend resume query
Date: Wed, 17 Feb 2016 10:40:15 +0100
Message-ID: <1455702015.7626.13.camel@suse.com>
References: <CANMsd03Y67iVEtUZaWnjywNxVVSvmpQfh72y8uJeqqgP=PrH=g@mail.gmail.com>
	 <1455700241.7626.10.camel@suse.com>
	 <CANMsd02oPfRZ4dRRF8R61VtN+h62ROfmNCDK=NohKjYWhOL4Hg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:49940 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756815AbcBQJmv (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 17 Feb 2016 04:42:51 -0500
In-Reply-To: <CANMsd02oPfRZ4dRRF8R61VtN+h62ROfmNCDK=NohKjYWhOL4Hg@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Ryan <ryanphilips19@googlemail.com>
Cc: linux-pm@vger.kernel.org

On Wed, 2016-02-17 at 15:07 +0530, Ryan wrote:

> I am referring to suspend-resume in ARM platform. The boot sequence is
> 
> bootrom
> bootloaders
> kernel

That is the standard done on most architectures including x86 and
x86_64.

> When system is suspended, I am told that when suspend-resume occurs
> it depends on the bootrom/bootloaders during resume. I did not understand why
> that should be case. Hence i am asking are there any dependencies between
> the bootloaders and the suspend-resume on a arm platform.

Suspend to RAM or suspend to disk?

	Regards
		Oliver


