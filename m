From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Wed, 08 Jul 2015 09:51:13 +0200
Message-ID: <1436341873.5636.5.camel@suse.com>
References: <4290667.ZqInAykFGS@vostro.rjw.lan>
	 <1527037.PaGp0dsCau@vostro.rjw.lan> <1436279906.2658.4.camel@suse.de>
	 <1522789.fQO6RUUx40@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:59376 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933250AbbGHHwS (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 8 Jul 2015 03:52:18 -0400
In-Reply-To: <1522789.fQO6RUUx40@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dave Chinner <david@fromorbit.com>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Len Brown <len.brown@intel.com>, Len Brown <lenb@kernel.org>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Alan Stern <stern@rowland.harvard.edu>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>

On Wed, 2015-07-08 at 00:11 +0200, Rafael J. Wysocki wrote:
> On Tuesday, July 07, 2015 04:38:26 PM Oliver Neukum wrote:
>  
> > That is a tough nut. But that's not a reason to make it worse.
> > I'd say there's no reason not to use a secondary interface to
> > suspend without syncing or to extend or introduce such an interface
> > if the API is deficient.
> 
> Well, the point here is that the sync we have doesn't prevent all potentially
> possible bad things from happening.  It's a partial measure at best in that
> respect.

Well, removed hardware doesn't work. That is a very basic limitation.
But can we guarantee that any returned syscall actually wrote to disk?
Yes, but it must be done in kernel space. So doing a sync has a true
benefit.
I don't see why you would want to generally remove it. What is wrong
with an interface allowing a selection there to those who don't care
about additional guarantees?

	Regards
		Oliver


