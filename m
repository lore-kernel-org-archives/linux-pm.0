From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 3/3][update] PM / sleep: Introduce command line
 argument for sleep state enumeration
Date: Tue, 10 Jun 2014 15:12:06 +0200
Message-ID: <20140610131206.GA7626@amd.pavel.ucw.cz>
References: <1817539.9KW2IGGbDV@vostro.rjw.lan>
 <2280756.TV3GPFuASb@vostro.rjw.lan>
 <1579932.qSkFQPvI6f@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:37329 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752027AbaFJNMI (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Tue, 10 Jun 2014 09:12:08 -0400
Content-Disposition: inline
In-Reply-To: <1579932.qSkFQPvI6f@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM list <linux-pm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>

Hi!

> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> On some systems the platform doesn't support neither
> PM_SUSPEND_MEM nor PM_SUSPEND_STANDBY, so PM_SUSPEND_FREEZE is the
> only available system sleep state.  However, some user space frameworks
> only use the "mem" and (sometimes) "standby" sleep state labels, so
> the users of those systems need to modify user space in order to be
> able to use system suspend at all and that is not always possible.

I'd say we should fix the frameworks, not add option to change kernel
interfaces.

Because, as you mentioned, if we add this, we are probably going to
get stuck with it forever :-(.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
