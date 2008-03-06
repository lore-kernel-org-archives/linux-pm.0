From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Bugs in MMC [was: [Bug 10030] Suspend doesn't work
	when SD card is inserted]
Date: Thu, 6 Mar 2008 22:31:13 +0100
Message-ID: <200803062231.14773.rjw__4348.86080115593$1204839494$gmane$org@sisk.pl>
References: <20080306155553.GA3908@ucw.cz>
	<Pine.LNX.4.44L0.0803061528460.9174-100000@iolanthe.rowland.org>
	<c4e36d110803061253i7f8edd6eu97887d2e628453e2@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <c4e36d110803061253i7f8edd6eu97887d2e628453e2@mail.gmail.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Zdenek Kabelac <zdenek.kabelac@gmail.com>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Thursday, 6 of March 2008, Zdenek Kabelac wrote:
> 2008/3/6, Alan Stern <stern@rowland.harvard.edu>:
> > On Thu, 6 Mar 2008, Pavel Machek wrote:
> >
> >  > On Tue 2008-03-04 16:00:51, Alan Stern wrote:
> >  > > On Tue, 4 Mar 2008, David Brownell wrote:
> >  > >
> >  > > > > What's wrong with a superfluous probe at resume time, besides the waste
> >  > > > > of a few milliseconds?
> >  > > >
> >  > > > I'm more concerned with the undesirable removal of devices at suspend
> >  > > > time ... ones with mounted filesystems etc.
> >  > >
> >  > > On that we can agree.  The removal is done if the host doesn't define a
> >  > > resume method.  There doesn't seem to be any point to that, given that
> >  > > the probing during resume will determine whether a card has in fact
> >  > > been removed.
> >  >
> >  > Hmm, if the driver is sleeping too deeply, user might have removed the
> >  > card and put in different one, without driver noticing. That would be
> >  > _bad_.
> >
> >
> > Ironically, the very same problem now exists with the USB mass-storage
> >  driver.  I don't see any way for the driver itself to solve it,
> >  especially during a hibernation (which can be a _very_ deep sleep).
> >
> >  One thing that could be done is for filesystems to verify, after a
> >  system sleep, that their superblocks haven't changed.  There could
> >  still be issues with non-mounted partitions, if they have live entries
> >  in the block cache, but it would be an improvement.
> >
> >  Do you know the right people to mention this to?  Anybody in filesystem
> >  development interested in suspend/hibernation issues?

I don't really think so (but I may be wrong ...)

> IMHO the way would be to try to unmount fs if it's possible - if not -
> user should be notified on suspend/hibernation that he must preserve
> media in its place after resume and it should be checked and user
> should be notified if different devices/fs were find...

This is a very long standing issue which IMO can only be solved by making
filesystems suspend-aware.

Thanks,
Rafael
