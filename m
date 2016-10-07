From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [patch 17/32] greybus: power supply driver
Date: Fri, 7 Oct 2016 16:12:58 +0200
Message-ID: <20161007141258.GA25284@kroah.com>
References: <20160914100949.GA6179@kroah.com>
 <20160916064058.GA17821@kroah.com>
 <20160916141058.GE1252@kroah.com>
 <20161007134902.GC19976@amd>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:57042 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751412AbcJGOMw (ORCPT
        <rfc822;linux-pm@vger.kernel.org>); Fri, 7 Oct 2016 10:12:52 -0400
Content-Disposition: inline
In-Reply-To: <20161007134902.GC19976@amd>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Pavel Machek <pavel@ucw.cz>
Cc: sre@kernel.org, dbaryshkov@gmail.com, dwmw2@infradead.org, linux-pm@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, Johan Hovold <johan@hovoldconsulting.com>, Rui Miguel Silva <rmfrfs@gmail.com>, Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Sandeep Patil <sspatil@google.com>, Matt Porter <mporter@kernel.crashing.org>, John Stultz <john.stultz@linaro.org>, Rob Herring <robh@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Alex Elder <elder@linaro.org>, David Lin <dtwlin@google.com>, Bryan O'Donoghue <pure.logic@nexus-software.ie>, Vaibhav Agarwal <vaibhav.agarwal@linaro.org>, Mark Greer <mgreer@animalcreek.com>

On Fri, Oct 07, 2016 at 03:49:02PM +0200, Pavel Machek wrote:
> On Fri 2016-09-16 16:10:58, Greg KH wrote:
> > 
> > This driver implements the Greybus power supply class protocol.
> 
> Probably
> 
> POWER SUPPLY CLASS/SUBSYSTEM and DRIVERS
> M:      Sebastian Reichel <sre@kernel.org>
> M:      Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> M:      David Woodhouse <dwmw2@infradead.org>
> L:      linux-pm@vger.kernel.org
> 
> should be cc-ed?

You didn't read the 00 email, or anything else in this thread, did you?

thanks,

greg k-h
