From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH RFC] PM / Runtime: Better support for nested irq_safe
 drivers
Date: Wed, 3 Dec 2014 10:22:06 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.1412031018300.1538-100000@iolanthe.rowland.org>
References: <547E332D.3060405@ti.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from iolanthe.rowland.org ([192.131.102.54]:55369 "HELO
	iolanthe.rowland.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with SMTP id S1751378AbaLCPWI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Wed, 3 Dec 2014 10:22:08 -0500
In-Reply-To: <547E332D.3060405@ti.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Jyri Sarha <jsarha@ti.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org, pavel@ucw.cz, t-kristo@ti.com, tomi.valkeinen@ti.com

On Tue, 2 Dec 2014, Jyri Sarha wrote:

> Is there something seriously wrong with the code part too? Or is this 
> just a matter of updating the comment (sorry that I missed that)?
> 
> If the thing I am doing somehow fundamentally flawed, I 	apologize. 
> However, this was an RFC patch after all and the problem I am trying to 
> solve is real.

What exactly _is_ the problem you are trying to solve?

When I first wrote the irq_safe stuff, I considered doing something 
like what you want.  But there was no demand for it at the time, and 
leaving it out seemed simpler and safer.

However, if you have a genuine use case then I don't object to allowing
parents of irq-safe devices to enter runtime suspend, provided the
parents are also irq-safe.

Alan Stern

