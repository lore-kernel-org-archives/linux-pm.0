From: Johannes Stezenbach <js@sig21.net>
Subject: Re: x86 hibernate, resume with different kernel version
Date: Thu, 16 Jun 2016 21:06:21 +0200
Message-ID: <20160616190621.GA3849@sig21.net>
References: <20160616100330.GA4954@sig21.net>
 <CAJZ5v0jWStdJDg_HENAMOiK3SaV=SHm6Zy-p6oMDvOUUZJRD+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.sig21.net ([80.244.240.74]:60943 "EHLO mail.sig21.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752587AbcFPTGb (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 16 Jun 2016 15:06:31 -0400
Content-Disposition: inline
In-Reply-To: <CAJZ5v0jWStdJDg_HENAMOiK3SaV=SHm6Zy-p6oMDvOUUZJRD+w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

On Thu, Jun 16, 2016 at 02:11:48PM +0200, Rafael J. Wysocki wrote:
> On Thu, Jun 16, 2016 at 12:03 PM, Johannes Stezenbach <js@sig21.net> wrote:
> > it's not important for me but I hibernated kernel v4.5.7
> > and inadvertantly resumed using v4.6.2, and ISTR this
> > should work (confirmed by looking into git where I found
> > commit cc456c4e7cac3837a86aaa7ca3cb9f488d44d196).
> >
> > My swap is an LVM volume inside dm-crypt, on boot the kernel read
> > the resume image but then immediately reset and invalidated it.
> > I'm using Debian sid, the initrd calls /bin/resume from
> > klibc-utils package.
> >
> > So, should this still work?  I couldn't find any
> > information about it.
> 
> It should in theory, but may not in fact due to bugs discovered
> recently.  This patch should help:
> https://patchwork.kernel.org/patch/9172981/ (it has to be applied to
> both the image and boot kernels).

I applied it to both the v4.5.7 and v4.6.2 kernels, booted
v4.5.7, hibernated, booted v4.6.2 to resume: still resets.

Let me know if you have something else to test.
BTW, the machine has a serial port in case you'd
like me to capture logs, but then please be specific
about the how and what so I don't waste my time.


Thanks,
Johannes
