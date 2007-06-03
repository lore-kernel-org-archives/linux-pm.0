From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC][PATCH -mm 1/2] PM: Introduce hibernation and
	suspend notifiers
Date: Mon, 4 Jun 2007 00:59:03 +0200
Message-ID: <20070603225903.GC2971__44360.6874942363$1180911598$gmane$org@elf.ucw.cz>
References: <200705272229.21263.rjw@sisk.pl> <200706020243.20117.rjw@sisk.pl>
	<20070603164143.GB4093@ucw.cz> <200706040038.54161.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706040038.54161.rjw@sisk.pl>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2007-06-04 00:38:53, Rafael J. Wysocki wrote:
> On Sunday, 3 June 2007 18:41, Pavel Machek wrote:
> > Hi!
> > 
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > Make it possible to register hibernation and suspend notifiers, so that
> > > subsystems can perform hibernation-related or suspend-related operations that
> > > should not be carried out by device drivers' .suspend() and .resume() routines.
> > 
> > One more question: what will we call in suspend-to-both case? I do not
> > think we can call SUSPEND_PREPARE with frozen tasks, so just one call
> > to HIBERNATION_PREPARE?
> 
> Yes, right now it should work this way.

(Should it be mentioned in docuementation?)
									Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
