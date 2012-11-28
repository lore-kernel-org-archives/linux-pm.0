From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM / devfreq: remove compiler error with module governors (2)
Date: Wed, 28 Nov 2012 13:51:45 +0100
Message-ID: <2435852.sRrong0YH0@vostro.rjw.lan>
References: <18994982.208311354098418554.JavaMail.weblogic@epml02>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7Bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from hydra.sisk.pl ([212.160.235.94]:35156 "EHLO hydra.sisk.pl"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754291Ab2K1MrA (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 28 Nov 2012 07:47:00 -0500
In-Reply-To: <18994982.208311354098418554.JavaMail.weblogic@epml02>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: myungjoo.ham@samsung.com
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "myungjoo.ham@gmail.com" <myungjoo.ham@gmail.com>, "nm@ti.com" <nm@ti.com>

On Wednesday, November 28, 2012 10:26:58 AM MyungJoo Ham wrote:
> > On Wednesday, November 28, 2012 10:57:21 AM MyungJoo Ham wrote:
> > > Governors compiled as modules may use these functions.
> > 
> > OK
> > 
> > Do you want me to take this directly?
> > 
> > Rafael
> 
> 
> Yes.
> 
> You can either take it directly or pull it with
> git://git.kernel.org/pub/scm/linux/kernel/git/mzx/devfreq for-rafael tags/pull_req_20121128
> as well.

OK, I think I'll take it directly.  I'll do some extra build testing of the
devfreq branch before I merge it back into the linux-next branch, however.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
