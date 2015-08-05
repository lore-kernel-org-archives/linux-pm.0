From: Javi Merino <javi.merino@arm.com>
Subject: Re: [PATCH] thermal: power_allocator: do not use devm* interfaces
Date: Wed, 5 Aug 2015 18:29:03 +0100
Message-ID: <20150805172902.GE2688@e104805>
References: <20150804163340.GA33245@dtor-ws>
 <20150805082910.GB2688@e104805>
 <20150805165020.GB3603@dtor-ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from fw-tnat.cambridge.arm.com ([217.140.96.140]:36660 "EHLO
	cam-smtp0.cambridge.arm.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1751912AbbHER3V (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 5 Aug 2015 13:29:21 -0400
Content-Disposition: inline
In-Reply-To: <20150805165020.GB3603@dtor-ws>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Eduardo Valentin <edubezval@gmail.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Zhang Rui <rui.zhang@intel.com>, Lukasz Majewski <l.majewski@samsung.com>, Peter Feuerer <peter@piie.net>, Sascha Hauer <s.hauer@pengutronix.de>, Punit Agrawal <Punit.Agrawal@arm.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>

On Wed, Aug 05, 2015 at 05:50:20PM +0100, Dmitry Torokhov wrote:
> On Wed, Aug 05, 2015 at 09:29:11AM +0100, Javi Merino wrote:
> > On Tue, Aug 04, 2015 at 05:33:40PM +0100, Dmitry Torokhov wrote:
> > > The code in question is called outside of standard driver
> > > probe()/remove() callbacks and thus will not benefit from use of devm*
> > > infrastructure.
> > > 
> > > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > 
> > We added the devm* calls because Eduardo asked for them in the review.
> > I don't have a strong opinion regarding this, I'll leave the decision
> > to Eduardo.
> 
> I tried to look for his reasons, if any, but even in earliest posted
> versions use devm* for allocating memory

http://thread.gmane.org/gmane.linux.power-management.general/45000/focus=45265
http://thread.gmane.org/gmane.linux.power-management.general/46064/focus=1722858

He didn't give reasons and I didn't ask for them.  He insisted on it so I just added
it across the board.

Cheers,
Javi
