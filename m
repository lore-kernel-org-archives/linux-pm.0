From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [PATCH] thermal: power_allocator: do not use devm* interfaces
Date: Wed, 5 Aug 2015 09:50:20 -0700
Message-ID: <20150805165020.GB3603@dtor-ws>
References: <20150804163340.GA33245@dtor-ws>
 <20150805082910.GB2688@e104805>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33138 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752494AbbHEQuX (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 12:50:23 -0400
Content-Disposition: inline
In-Reply-To: <20150805082910.GB2688@e104805>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Javi Merino <javi.merino@arm.com>
Cc: Eduardo Valentin <edubezval@gmail.com>, Zhang Rui <rui.zhang@intel.com>, Lukasz Majewski <l.majewski@samsung.com>, Peter Feuerer <peter@piie.net>, Sascha Hauer <s.hauer@pengutronix.de>, Punit Agrawal <Punit.Agrawal@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Aug 05, 2015 at 09:29:11AM +0100, Javi Merino wrote:
> On Tue, Aug 04, 2015 at 05:33:40PM +0100, Dmitry Torokhov wrote:
> > The code in question is called outside of standard driver
> > probe()/remove() callbacks and thus will not benefit from use of devm*
> > infrastructure.
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> 
> We added the devm* calls because Eduardo asked for them in the review.
> I don't have a strong opinion regarding this, I'll leave the decision
> to Eduardo.

I tried to look for his reasons, if any, but even in earliest posted
versions use devm* for allocating memory

I guess this is one of examples of devm* usage in wrong context. Given
that you, as you have to, because this is not a device driver, manually
freeing that memory with devm_kfree(), the only thing that devm_kzalloc
and friends buy you here is extra memory allocations for devres
structures and few extra cycles for maintaining them.

Thanks.

-- 
Dmitry
