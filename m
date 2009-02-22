From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFD] Automatic suspend
Date: Sun, 22 Feb 2009 14:46:18 +0100
Message-ID: <20090222134618.GA1436__4350.90341275117$1235310550$gmane$org@ucw.cz>
References: <200902160010.16955.rjw@sisk.pl> <20090216225831.GH1370@ucw.cz>
	<200902170026.06966.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902170026.06966.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > The recent descussion about the Android PM patches sent by Arve shows that
> > > there is a need to introduce a mechanism allowing us to:
> > > (1) automatically put the system as a whole into a sleep state (eg. suspend to
> > >     RAM) when it is found to be "idle", where the meaning of "idle" has to be
> > >     defined too,
> > 
> > Well; I'd prefer to keep the interface very minimal.
> > 
> > If no devices are being used,
> 
> We'll need some kind of infrastructure to detect such situations.

Yes, I like the latest 'atomic_t + bit in struct device' ideas...
 
> > and next wakeup is far enough in the future,
> 
> What exactly do you mean by "next wakeup"?

Next timer in kernel and next sleep/select timeout in userspace.

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
