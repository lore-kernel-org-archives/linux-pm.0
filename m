From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 00:18:50 +0100
Message-ID: <20090216231850.GJ1370__32317.8004626699$1234826686$gmane$org@ucw.cz>
References: <200902160010.16955.rjw@sisk.pl> <200902162248.34287.rjw@sisk.pl>
	<20090216225116.GG1370@ucw.cz> <200902170000.43387.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200902170000.43387.rjw@sisk.pl>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Tue 2009-02-17 00:00:41, Rafael J. Wysocki wrote:
> On Monday 16 February 2009, Pavel Machek wrote:
> > Hi!
> > 
> > > > Userland should never ever control the state of a device like this
> > > > directly. It should do so by a) closing the device and b) setting
> > > > latency / functional requirements.
> > > 
> > > The user, however, may want to forcibly put a device into a low power state
> > > without stopping all of the applications that depend on it (eg. have it open).
> > > Do you think that we shouldn't allow users to do such things?
> > 
> > I don't think we should do this... of you want device to be powered
> > down, just don't keep it open. revoke should be enough :-).
> > 
> > ...one execption here is the disk driver; unmounting filesystems to
> > let the disk spin down is probably too heavy.
> 
> Well, I don't think it's viable to make any exceptions here.  Either we do it
> or we don't.  And the agreement appears to be that we don't.

We already have interface to force disk down (for disk protectioon
stuff), so this is already done for other reasons.

But in general, close(joystick) is nicer interface then 'echo
turn-off-joystick-even-when-open > /sys/somewhere'.
					

								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
