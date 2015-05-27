From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: Re: power_supply: Add support for TI BQ25890 charger chip
Date: Wed, 27 May 2015 12:27:01 +0300
Message-ID: <20150527092701.GF11734@mwanda>
References: <20150526090441.GA18601@mwanda>
 <CAD03FC+H0JQUR32eGLrVWe_OaiiMTxUmCxdBwuWnPwMRz8XSOQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:21519 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751898AbbE0J1L (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 27 May 2015 05:27:11 -0400
Content-Disposition: inline
In-Reply-To: <CAD03FC+H0JQUR32eGLrVWe_OaiiMTxUmCxdBwuWnPwMRz8XSOQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Laurentiu Palcu <lpalcu@gmail.com>
Cc: sre@kernel.org, laurentiu.palcu@intel.com, linux-pm@vger.kernel.org

On Tue, May 26, 2015 at 09:08:46PM +0300, Laurentiu Palcu wrote:
> Hi Dan,
> 
> On 26 May 2015 17:45, "Dan Carpenter" <dan.carpenter@oracle.com> wrote:
> >
> > Hello Laurentiu Palcu,
> >
> > The patch 4aeae9cb0dad: "power_supply: Add support for TI BQ25890
> > charger chip" from May 19, 2015, leads to the following static
> > checker warning:
> >
> >         drivers/power/bq25890_charger.c:843 bq25890_probe()
> >         warn: impossible condition '(bq->chip_id < 0) => (0-255 < 0)'
> >
> > drivers/power/bq25890_charger.c
> >    841
> >    842          bq->chip_id = bq25890_field_read(bq, F_PN);
> >    843          if (bq->chip_id < 0) {
> >                     ^^^^^^^^^^^^^^^
> > Never true.
> Damn it... :/ I totally missed this. Thanks for catching it. chip_id should
> be int... Out of curiosity, what static checker did you use?

This was a Smatch warning.

regards,
dan carpenter

