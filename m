From: Zhang Rui <rui.zhang@intel.com>
Subject: Re: [Panic - Bisected] f1a18a10566081abfce1649c2f3884b28fff7372
 cases panic on boot
Date: Wed, 24 Jul 2013 09:14:07 +0800
Message-ID: <1374628447.2112.0.camel@rzhang1-mobl4>
References: <CAELBVzCK3Dm-HtAn3iy0Nz-MeOJVvRO20KqE0WojWF1nFv_-1Q@mail.gmail.com>
	 <CAELBVzCUrJXWB1dO2mOwoX97x+RO2AeCNEazXzG4DrHXSk9JmQ@mail.gmail.com>
	 <CA+55aFwQ02N=Q8ArztM-XhdC-cSj=GE-EvwvkarkpZfDUt+Rsg@mail.gmail.com>
	 <CAELBVzDcwmEsDDgSrAk_AGFrwyqXh9Qh6d6NB21_YsQDrTBz2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga09.intel.com ([134.134.136.24]:60758 "EHLO mga09.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750716Ab3GXBOa (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 23 Jul 2013 21:14:30 -0400
In-Reply-To: <CAELBVzDcwmEsDDgSrAk_AGFrwyqXh9Qh6d6NB21_YsQDrTBz2w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kevin Winchester <kjwinchester@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Tue, 2013-07-23 at 21:56 -0300, Kevin Winchester wrote:
> On 22 July 2013 23:11, Linus Torvalds <torvalds@linux-foundation.org> wrote:
> > On 22 July 2013 21:45, Kevin Winchester <kjwinchester@gmail.com> wrote:
> >> I have found that the new CPU Package temperature thermal driver introduced
> >> in this merge window causes my HP laptop to panic on boot.
> >
> > I just merged Zhang's pull request that should contain a fix for this,
> > but was planning on the allmoconfig build finishing before pushing it
> > out. Give me a few minutes..
> >
> 
> Yes, I have tested with your latest tree, and it works even with the
> driver enabled.
> 
Good to know. Thanks for testing. :)

-rui


