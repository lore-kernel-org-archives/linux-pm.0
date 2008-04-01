From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] ACPI PM: Restore the 2.6.24 suspend ordering
Date: Tue, 1 Apr 2008 21:55:51 +0200
Message-ID: <200804012155.52547.rjw__24717.60916892$1207079912$gmane$org@sisk.pl>
References: <200803300319.08398.rjw@sisk.pl> <200803301515.33922.rjw@sisk.pl>
	<20080401084523.GA25278@atrey.karlin.mff.cuni.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080401084523.GA25278@atrey.karlin.mff.cuni.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, Carlos Corbacho <carlos@strangeworlds.co.uk>, LKML <linux-kernel@vger.kernel.org>, Arthur Erhardt <erhardt@pit.physik.uni-tuebingen.de>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Felix M?ller <fm@opensuse.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 1 of April 2008, Pavel Machek wrote:
> Hi!

Hi,

> > > > > > For the reasons outlined above, the change of the suspend ordering
> > > > > > should be reverted, which is done by the patch below.
> > > > > 
> > > > > But this will break those few nvidia-based systems, no?
> > > > > 
> > > > > this may have been a good idea in -rc1 days, but we are in -rc7
> > > > > now... and the patch is slightly big.
> > > > 
> > > > It's quite obvious, though.
> > > 
> > > Yes, but breaking systems between -rc7 and final is _very_ unnice.
> > 
> > Breaking systems between 2.6.24 and 2.6.25 is even worse, which is why
> > I've posted this patch.
> > 
> > IOW, we tried to fix systems that were broken with 2.6.24, but it didn't work,
> > because our "fix" broke systems that were OK with 2.6.24.  Solution: revert
> > the "fix" and go back to the design board.  That's all we can do so late in
> > the release cycle, IMO.
> 
> Well, I agree that regression from 2.6.24 is worse, but it is
> _slightly_ worse... -rcs are really expected to improve...
> 
> ...plus it no longer looks like macbook regression is caused by _PTS
> ordering?
> 
> > > > I think we _can_ do something about the failing NVidia systems in the 2.6.26
> > > > time frame, but that will require some more consideration.
> > > 
> > > We could simply blacklist them, no?
> > 
> > Yes, but for this purpose we'll have to redesign the core so that everything
> > (including debugging and the error paths) works if _PTS is executed before
> > suspending devices.  _That_, however, is not a 2.6.25 thing.
> 
> So we have solution that fixes 2.6.24 systems, makes system that
> worked in 2.6.25-rc5 work with command line option, but gets error
> handling wrong.
> 
> I guess we could use that?

IMO we should not use that, because it's broken.  That's why I posted the
patch.

Thanks,
Rafael
