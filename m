From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 0/5] PM: Enable option of re-use runtime PM callbacks
 at system suspend
Date: Fri, 6 Dec 2013 01:53:19 +0100
Message-ID: <20131206005318.GB27953@amd.pavel.ucw.cz>
References: <CAJvTdKnqD3ccPUzh7kNMNqrEYFfD93Vh9hgFuKyHz+pjGNHdtA@mail.gmail.com>
 <Pine.LNX.4.44L0.1312051720330.869-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:52669 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752956Ab3LFAxU (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Thu, 5 Dec 2013 19:53:20 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.1312051720330.869-100000@iolanthe.rowland.org>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Len Brown <lenb@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <len.brown@intel.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>

On Thu 2013-12-05 17:21:50, Alan Stern wrote:
> On Thu, 5 Dec 2013, Len Brown wrote:
> 
> > This thread raises the question...
> > 
> > Do we still need to have PM_RUNTIME apart from PM_SLEEP?
> > 
> > What is the benefit of being able to build-in one one without the other?
> > If that benefit is not significant, perhaps the time has come to
> > replace them both with CONFIG_PM...
> 
> There are lots of embedded/SoC platforms that implement PM_RUNTIME but
> not PM_SLEEP.

And lots of PCs where PM_SLEEP is useful but PM_RUNTIME is not :-).
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
