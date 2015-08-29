From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] thermal: power_allocator: allocate with kcalloc what you
 free with kfree
Date: Sat, 29 Aug 2015 10:55:03 -0700
Message-ID: <CA+55aFxJcGGdc+Cf3=RSO39cDie2WjX46E9b7rCwRSo57qe1Vw@mail.gmail.com>
References: <1440526955-9860-1-git-send-email-javi.merino@arm.com>
	<20150827154936.GH5653@e104805>
	<20150829122737.GA2840@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:35364 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752714AbbH2RzF (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Sat, 29 Aug 2015 13:55:05 -0400
In-Reply-To: <20150829122737.GA2840@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: "edubezval@gmail.com" <edubezval@gmail.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Zhang Rui <rui.zhang@intel.com>

On Sat, Aug 29, 2015 at 5:27 AM, Javi Merino <javi.merino@arm.com> wrote:
>
> cf736ea6f902 ("thermal: power_allocator: do not use devm*
> interfaces") was merged for 4.2-rc8.  It leaves an allocation of
> memory with devm_kcalloc() that is then freed with kfree().  The
> patch at the top of the thread[0][1] fixes this.  Can you either
> merge this patch or revert cf736ea6f902 for 4.2?

Applied the patch. Thanks,

                    Linus
