From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH v5 1/2] PM / sleep: Go direct_complete if driver has no
 callbacks
Date: Mon, 5 Oct 2015 11:07:27 +0200
Message-ID: <20151005090727.GA24851@xo-6d-61-c0.localdomain>
References: <1443529760-17612-1-git-send-email-tomeu.vizoso@collabora.com>
 <1443529760-17612-2-git-send-email-tomeu.vizoso@collabora.com>
 <20151004151621.GA12684@xo-6d-61-c0.localdomain>
 <CAAObsKDtE_uj7iA53pzMaoT+EPctCgnHxypVhXL6GuVUQimn+w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from atrey.karlin.mff.cuni.cz ([195.113.26.193]:41760 "EHLO
	atrey.karlin.mff.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751872AbbJEJHa (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 5 Oct 2015 05:07:30 -0400
Content-Disposition: inline
In-Reply-To: <CAAObsKDtE_uj7iA53pzMaoT+EPctCgnHxypVhXL6GuVUQimn+w@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Tomeu Vizoso <tomeu.vizoso@collabora.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Alan Stern <stern@rowland.harvard.edu>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, martyn.welch@collabora.co.uk, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>, Kevin Hilman <khilman@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Ulf Hansson <ulf.hansson@linaro.org>

On Mon 2015-10-05 10:25:45, Tomeu Vizoso wrote:
> On 4 October 2015 at 17:16, Pavel Machek <pavel@ucw.cz> wrote:
> > On Tue 2015-09-29 14:29:19, Tomeu Vizoso wrote:
> >> If a suitable prepare callback cannot be found for a given device and
> >> its driver has no PM callbacks at all, assume that it can go direct to
> >> complete when the system goes to sleep.
> >>
> >> The reason for this is that there's lots of devices in a system that do
> >> no PM at all and there's no reason for them to prevent their ancestors
> >> to do direct_complete if they can support it.
> >
> > Dunno. This sounds like asking for trouble. Even if most devices can handle
> > this, is not this bound to introduce some bugs?
> 
> Hi Pavel,
> 
> in which situations do you think that this could be problematic?

Well.. driver with no PM callbacks probably works "by accident", and now you are changing
its environment. Do you have explanation why it will not break?

									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
