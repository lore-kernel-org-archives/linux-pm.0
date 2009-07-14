From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend to disk now broken
Date: Tue, 14 Jul 2009 18:14:01 +0200
Message-ID: <200907141814.02265.rjw__9481.78305193341$1247588150$gmane$org@sisk.pl>
References: <20090712151947.25446ceb.celejar@gmail.com>
	<200907140045.52764.rjw@sisk.pl>
	<20090714013202.55c0c575.celejar@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090714013202.55c0c575.celejar@gmail.com>
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
To: Celejar <celejar@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 14 July 2009, Celejar wrote:
> On Tue, 14 Jul 2009 00:45:52 +0200
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> 
> > On Monday 13 July 2009, Celejar wrote:
> > > On Mon, 13 Jul 2009 03:39:34 +0200
> > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > 
> > > > On Sunday 12 July 2009, Celejar wrote:
> > > > > On Sun, 12 Jul 2009 22:56:01 +0200
> > > > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > > 
> > > > > > On Sunday 12 July 2009, Celejar wrote:
> > > > > > > On Sun, 12 Jul 2009 22:19:52 +0200
> > > > > > > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > > > > > 
> > > > > > > > On Sunday 12 July 2009, Celejar wrote:
> > > > > > > > > Hi,
> > > > > > > > > 
> > > > > > > > > A recent change to the kernel has apparently broken suspend to disk on
> > > > > > > > > my machine.  It still works fine in 2.6.30.1, but hangs during the
> > > > > > > > > 'devices' phase of suspension with 2.6.31-rc2.  [I originally saw the
> > > 
> > > ...
> > > 
> > > > Do you use IDE drivers?
> > > 
> > > Yes.  The system uses IDE/PATA drivers (PIIX).
> > 
> > If they are of the "old IDE" flavor, there've been some fixes merged recently.
> > Please check 2.6.31-rc3 when it's out (or the current mainline).
> 
> I built what I think is mainline:
> 
> git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux-2.6.git

Yes, this is the mainline.

> and it works.

Great, thanks for testing.

Best,
Rafael
