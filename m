From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [RFD] Functional dependencies between devices
Date: Fri, 30 Oct 2015 15:52:42 -0700
Message-ID: <20151030225242.GA2480@kroah.com>
References: <1623682.7KVblAB3KQ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:43248 "EHLO
	mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965292AbbJ3Wwn (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Fri, 30 Oct 2015 18:52:43 -0400
Content-Disposition: inline
In-Reply-To: <1623682.7KVblAB3KQ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, Grant Likely <grant.likely@linaro.org>, Mark Brown <broonie@kernel.og>, Rob Herring <robh@kernel.org>, Tomeu Vizoso <tomeu.vizoso@collabora.com>, Thierry Reding <treding@nvidia.com>, Dmitry Torokhov <dtor@google.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Michael Turquette <mturquette@baylibre.com>

On Tue, Oct 27, 2015 at 04:24:14PM +0100, Rafael J. Wysocki wrote:
> My idea is to represent a supplier-consumer dependency between devices (or
> more precisely between device+driver combos) as a "link" object containing
> pointers to the devices in question, a list node for each of them and some
> additional information related to the management of those objects, ie.
> something like:
> 
> struct device_link {
> 	struct device *supplier;
> 	struct list_head supplier_node;
> 	struct device *consumer;
> 	struct list_head consumer_node;
> 	<flags, status etc>
> };
> 
> In general, there will be two lists of those things per device, one list
> of links to consumers and one list of links to suppliers.
> 
> In that picture, links will be created by calling, say:
> 
> int device_add_link(struct device *me, struct device *my_supplier, unsigned int flags);

At first glance, I like this, nice.  Now to see how well it can be
implemented :)

Again, nice job.

greg k-h
