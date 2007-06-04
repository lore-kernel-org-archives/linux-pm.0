From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 1/2] PM: Introduce hibernation and
	suspend notifiers
Date: Mon, 4 Jun 2007 09:56:53 +0200
Message-ID: <200706040956.54292.rjw__34808.9720508598$1180943522$gmane$org@sisk.pl>
References: <200705272229.21263.rjw@sisk.pl> <200706040038.54161.rjw@sisk.pl>
	<20070603225903.GC2971@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070603225903.GC2971@elf.ucw.cz>
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
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, LKML <linux-kernel@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday, 4 June 2007 00:59, Pavel Machek wrote:
> On Mon 2007-06-04 00:38:53, Rafael J. Wysocki wrote:
> > On Sunday, 3 June 2007 18:41, Pavel Machek wrote:
> > > Hi!
> > > 
> > > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > > 
> > > > Make it possible to register hibernation and suspend notifiers, so that
> > > > subsystems can perform hibernation-related or suspend-related operations that
> > > > should not be carried out by device drivers' .suspend() and .resume() routines.
> > > 
> > > One more question: what will we call in suspend-to-both case? I do not
> > > think we can call SUSPEND_PREPARE with frozen tasks, so just one call
> > > to HIBERNATION_PREPARE?
> > 
> > Yes, right now it should work this way.
> 
> (Should it be mentioned in docuementation?)

Eventually, yes.  Still, for now, the STR code in user.c is outdated and needs
fixing.  I'll take care of it later this week.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
