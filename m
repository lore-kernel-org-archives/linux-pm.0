From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: x86 hibernate, resume with different kernel version
Date: Thu, 16 Jun 2016 14:11:48 +0200
Message-ID: <CAJZ5v0jWStdJDg_HENAMOiK3SaV=SHm6Zy-p6oMDvOUUZJRD+w@mail.gmail.com>
References: <20160616100330.GA4954@sig21.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-wm0-f54.google.com ([74.125.82.54]:36585 "EHLO
	mail-wm0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754060AbcFPMLu (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 16 Jun 2016 08:11:50 -0400
Received: by mail-wm0-f54.google.com with SMTP id f126so48286259wma.1
        for <linux-pm@vger.kernel.org>; Thu, 16 Jun 2016 05:11:49 -0700 (PDT)
In-Reply-To: <20160616100330.GA4954@sig21.net>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Johannes Stezenbach <js@sig21.net>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, the arch/x86 maintainers <x86@kernel.org>, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>

On Thu, Jun 16, 2016 at 12:03 PM, Johannes Stezenbach <js@sig21.net> wrote:
> Hi,
>
> it's not important for me but I hibernated kernel v4.5.7
> and inadvertantly resumed using v4.6.2, and ISTR this
> should work (confirmed by looking into git where I found
> commit cc456c4e7cac3837a86aaa7ca3cb9f488d44d196).
>
> My swap is an LVM volume inside dm-crypt, on boot the kernel read
> the resume image but then immediately reset and invalidated it.
> I'm using Debian sid, the initrd calls /bin/resume from
> klibc-utils package.
>
> So, should this still work?  I couldn't find any
> information about it.

It should in theory, but may not in fact due to bugs discovered
recently.  This patch should help:
https://patchwork.kernel.org/patch/9172981/ (it has to be applied to
both the image and boot kernels).

Thanks,
Rafael
