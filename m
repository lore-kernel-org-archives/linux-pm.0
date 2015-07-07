From: Oliver Neukum <oneukum@suse.com>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Tue, 07 Jul 2015 15:16:48 +0200
Message-ID: <1436275008.4460.18.camel@suse.com>
References: <4290667.ZqInAykFGS@vostro.rjw.lan>
	 <1595559.BsCkcDEfNB@vostro.rjw.lan> <20150707011756.GC3902@dastard>
	 <1652992.e7VOEWpWyZ@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from cantor2.suse.de ([195.135.220.15]:37213 "EHLO mx2.suse.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753297AbbGGNRx (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Tue, 7 Jul 2015 09:17:53 -0400
In-Reply-To: <1652992.e7VOEWpWyZ@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Dave Chinner <david@fromorbit.com>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alan Stern <stern@rowland.harvard.edu>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>

On Tue, 2015-07-07 at 14:14 +0200, Rafael J. Wysocki wrote:
> For example, on desktop systems I use user space syncs filesystems
> before
> writing to /sys/power/state, so the additional sys_sync() in the
> kernel doesn't
> seem to serve any purpose.

There is a race you cannot close in user space.

	Regards
		Oliver


