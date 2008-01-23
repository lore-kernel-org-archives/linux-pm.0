From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/3] More updates for 2.6.25
Date: Wed, 23 Jan 2008 16:10:03 +0100
Message-ID: <200801231610.04820.rjw__22719.2284459763$1201101243$gmane$org@sisk.pl>
References: <200801110118.46106.rjw@sisk.pl>
	<20080123083010.GB11223@elf.ucw.cz>
	<200801231605.39598.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200801231605.39598.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 23 of January 2008, Rafael J. Wysocki wrote:
> On Wednesday, 23 of January 2008, Pavel Machek wrote:
> > On Wed 2008-01-16 13:37:18, Rafael J. Wysocki wrote:
> > > On Wednesday, 16 of January 2008, Pavel Machek wrote:
> > > > On Tue 2008-01-15 23:22:33, Len Brown wrote:
> > > > > On Thursday 10 January 2008 19:18, Rafael J. Wysocki wrote:
> > > > > > Len,
> > > > > > 
> > > > > > Please add the following three patches to the suspend branch.
> > > > > 
> > > > > Applied (and suspend branch has been re-based to latest linus tree)
> > > > 
> > > > Was that "lets reorder notifications, old order was more logical, but
> > > > it fixes apm?" series?
> > > 
> > > Yes, plus the docs update from Dave Brownell.
> > 
> > Can we stop that reordering? I do not think it is such a good idea.
> 
> In this particular case it's needed to unbreak the APM emulation and it
> certainly is not a good idea to have two different orderings of the notifiers
> vs the freezer

Sorry, s/notifiers vs the freezer/console switch vs the notifiers/

> (hence the second patch in the series).
