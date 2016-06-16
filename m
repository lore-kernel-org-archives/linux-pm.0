From: Johannes Stezenbach <js@sig21.net>
Subject: x86 hibernate, resume with different kernel version
Date: Thu, 16 Jun 2016 12:03:30 +0200
Message-ID: <20160616100330.GA4954@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.sig21.net ([80.244.240.74]:41958 "EHLO mail.sig21.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753846AbcFPKVF (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Thu, 16 Jun 2016 06:21:05 -0400
Content-Disposition: inline
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: linux-pm@vger.kernel.org, x86@kernel.org
Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

Hi,

it's not important for me but I hibernated kernel v4.5.7
and inadvertantly resumed using v4.6.2, and ISTR this
should work (confirmed by looking into git where I found
commit cc456c4e7cac3837a86aaa7ca3cb9f488d44d196).

My swap is an LVM volume inside dm-crypt, on boot the kernel read
the resume image but then immediately reset and invalidated it.
I'm using Debian sid, the initrd calls /bin/resume from
klibc-utils package.

So, should this still work?  I couldn't find any
information about it.


Thanks,
Johannes
