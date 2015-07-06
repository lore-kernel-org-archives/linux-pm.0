From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [PATCH 1/1] suspend: delete sys_sync()
Date: Mon, 6 Jul 2015 13:11:05 +0200
Message-ID: <20150706111105.GD381@amd>
References: <4290667.ZqInAykFGS@vostro.rjw.lan>
 <CAJvTdKn71W0+js3D4OwK5Tx4z5KdA8hb-FyRMTuw0rdyQj9pRw@mail.gmail.com>
 <20150703014250.GM7943@dastard>
 <1496051.AgsebokWnB@vostro.rjw.lan>
 <20150706000614.GB3902@dastard>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20150706000614.GB3902@dastard>
Sender: linux-kernel-owner@vger.kernel.org
To: Dave Chinner <david@fromorbit.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Len Brown <lenb@kernel.org>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Alan Stern <stern@rowland.harvard.edu>, One Thousand Gnomes <gnomes@lxorguk.ukuu.org.uk>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Len Brown <len.brown@intel.com>
List-Id: linux-pm@vger.kernel.org

Hi!

> > Moreover, question is if we really need to carry out the sync on *every*
> > suspend even if it is not pointless overall.  That shouldn't really be
> > necessary if we suspend and resume often enough or if we resume only for
> > a while and then suspend again.  Maybe it should be rate limited somehow
> > at least?
> 
> If you suspend and resume frequently, then the cost of the sync
> shoul dbe negliable because the amount of data dirtied between
> resume/suspend shoul dbe negliable. hence my questions about where
> sync is spending too much time, and whether we've actually fixed
> those problems or not. If sync speed on clean filesystems is a
> problem then we need to fix sync, not work around it.

And yes, that's solution I'd really prefer over adding knobs to
suspend.
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
