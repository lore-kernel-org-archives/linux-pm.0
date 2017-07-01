From: Eduardo Valentin <edubezval@gmail.com>
Subject: Re: [PATCH v2] thermal: bcm2835: Fix error code in
 'bcm2835_thermal_probe'
Date: Fri, 30 Jun 2017 19:55:11 -0700
Message-ID: <20170701025509.GB11217@localhost.localdomain>
References: <20170623194435.8094-1-christophe.jaillet@wanadoo.fr>
 <1667598657.325840.1498249545131@email.1und1.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:36413 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751370AbdGACzQ (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 30 Jun 2017 22:55:16 -0400
Content-Disposition: inline
In-Reply-To: <1667598657.325840.1498249545131@email.1und1.de>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Stefan Wahren <stefan.wahren@i2se.com>
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>, rjui@broadcom.com, sbranden@broadcom.com, kernel@martin.sperl.org, rafal@milecki.pl, eric@anholt.net, rui.zhang@intel.com, bcm-kernel-feedback-list@broadcom.com, f.fainelli@gmail.com, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org

On Fri, Jun 23, 2017 at 10:25:45PM +0200, Stefan Wahren wrote:
> 
> > Christophe JAILLET <christophe.jaillet@wanadoo.fr> hat am 23. Juni 2017 um 21:44 geschrieben:
> > 
> > 
> > 'tz' is a valid pointer at this point, so calling PTR_ERR on it is
> > pointless.
> > This 'err = PTR_ERR(tz)' looks like a cut'n'paste from a few lines above.
> > So remove it. 'err' is already the error we want to report.
> > 
> > Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> Thanks, but Dan Carpenter already send a fix for this.

Yeah, and I applied Dan's version as it was coming first in my queue. Sorry.
