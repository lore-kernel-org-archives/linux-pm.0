From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH] PM / Hibernate: Allow to abort falling asleep by <ESC>
 or <DELETE> key press
Date: Thu, 27 Jun 2013 13:01:45 +0200
Message-ID: <20130627110142.GA13606@amd.pavel.ucw.cz>
References: <10331372289504@web1g.yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:38339 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752067Ab3F0LBr (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 27 Jun 2013 07:01:47 -0400
Content-Disposition: inline
In-Reply-To: <10331372289504@web1g.yandex.ru>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Kirill Tkhai <tkhai@yandex.ru>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>

Hi!

> Add input handler to be able to abort hibernation() action.
> 
> Sometimes user needs this to stop unnecessary hibernation()
> caused by himself or by DE utils/daemons.

I can't say I like this too much.

root user did ask for hibernation, and now we allow anyone who might
be present at console to abort it (cat?). 

For s2ram, we already set up wakeup devices. If wakeup event happened
during hibernation, that might be reason to abort it.

Plus, root user will be able to control if cat is allowed to abort
hibernation or not...

							Pavel

> Signed-off-by: Kirill Tkhai <tkhai@yandex.ru>
> CC: Pavel Machek <pavel@ucw.cz>
> CC: "Rafael J. Wysocki" <rjw@sisk.pl>
> ---
>  kernel/power/console.c   | 96 ++++++++++++++++++++++++++++++++++++++++++++++++
>  kernel/power/hibernate.c |  7 ++++
>  kernel/power/power.h     |  3 ++
>  kernel/power/swap.c      | 19 ++++++++++
 
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
