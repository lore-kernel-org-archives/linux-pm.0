From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v2] cpuidle: Fix last_residency division
Date: Fri, 24 Jun 2016 21:43:13 +0200
Message-ID: <3748080.8f21OXxXix@wuerfel>
References: <1466756638-2362-1-git-send-email-shreyas@linux.vnet.ibm.com> <14940457.SEYBmqcunj@wuerfel> <576D595F.9090001@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mout.kundenserver.de ([212.227.17.24]:51132 "EHLO
	mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751081AbcFXTlI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 24 Jun 2016 15:41:08 -0400
In-Reply-To: <576D595F.9090001@linux.vnet.ibm.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, David Laight <David.Laight@aculab.com>, "rjw@rjwysocki.net" <rjw@rjwysocki.net>, "daniel.lezcano@linaro.org" <daniel.lezcano@linaro.org>, "anton@samba.org" <anton@samba.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>

On Friday, June 24, 2016 9:31:35 PM CEST Shreyas B Prabhu wrote:
> > If those functions are called less often than cpuidle_enter_state(),
> > we could just move the division there. Since the divisor is constant,
> > do_div() can convert it into a multiply and shift, or we could use
> > your the code you suggest above, or use a 32-bit division most of
> > the time:
> > 
> >       if (diff <= UINT_MAX)
> >               diff_32 = (u32)diff / NSECS_PER_USEC;
> >       else
> >               diff_32 = div_u64(diff, NSECS_PER_USEC;
> > 
> > which gcc itself will turn into a multiplication or series of
> > shifts on CPUs on which that is faster.
> >
> I'm not sure which division method of the three suggested here to use.
> Does anyone have a strong preference?
> 

It depends on how accurate we want it and how long we expect
the times to be. The optimization for the 4.2 second cutoff
for doing a 32-bit division only makes sense if the majority
of the sleep times are below that.

	Arnd
