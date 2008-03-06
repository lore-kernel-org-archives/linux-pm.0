From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Bugs in MMC [was: [Bug 10030] Suspend doesn't work
 when SD card is inserted]
Date: Thu, 6 Mar 2008 15:33:41 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0803061528460.9174-100000__32889.6796134815$1204835739$gmane$org@iolanthe.rowland.org>
References: <20080306155553.GA3908@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080306155553.GA3908@ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Kernel development list <linux-kernel@vger.kernel.org>, Zdenek Kabelac <zdenek.kabelac@gmail.com>, pm list <linux-pm@lists.linux-foundation.org>, Pierre Ossman <drzeus-mmc@drzeus.cx>
List-Id: linux-pm@vger.kernel.org

On Thu, 6 Mar 2008, Pavel Machek wrote:

> On Tue 2008-03-04 16:00:51, Alan Stern wrote:
> > On Tue, 4 Mar 2008, David Brownell wrote:
> > 
> > > > What's wrong with a superfluous probe at resume time, besides the waste 
> > > > of a few milliseconds?
> > > 
> > > I'm more concerned with the undesirable removal of devices at suspend
> > > time ... ones with mounted filesystems etc.
> > 
> > On that we can agree.  The removal is done if the host doesn't define a 
> > resume method.  There doesn't seem to be any point to that, given that 
> > the probing during resume will determine whether a card has in fact 
> > been removed.
> 
> Hmm, if the driver is sleeping too deeply, user might have removed the
> card and put in different one, without driver noticing. That would be
> _bad_.

Ironically, the very same problem now exists with the USB mass-storage 
driver.  I don't see any way for the driver itself to solve it, 
especially during a hibernation (which can be a _very_ deep sleep).

One thing that could be done is for filesystems to verify, after a 
system sleep, that their superblocks haven't changed.  There could 
still be issues with non-mounted partitions, if they have live entries 
in the block cache, but it would be an improvement.

Do you know the right people to mention this to?  Anybody in filesystem 
development interested in suspend/hibernation issues?

Alan Stern
