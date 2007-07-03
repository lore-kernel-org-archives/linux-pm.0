From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 23:25:41 +0200
Message-ID: <200707032325.41952.rjw__15665.4428611093$1183497787$gmane$org@sisk.pl>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031709.29968.rjw@sisk.pl> <20070703192729.GA2125@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070703192729.GA2125@elf.ucw.cz>
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
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, Matthew Garrett <mjg59@srcf.ucam.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 3 July 2007 21:27, Pavel Machek wrote:
> Hi!
> 
> > > > The main reason for deadlocks is because we do a sys_sync() after the
> > > > freeze, which we shouldn't do.
> > > 
> > > So why don't we remove the sys_sync() from freeze_processes() instead?
> > 
> > The patch follows (untested).
> > 
> > Greetings,
> > Rafael
> > 
> > 
> > ---
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > We shouldn't sync filesystems from within the freezer, because it's not needed
> > for suspend to RAM and leads to problems with FUSE.
> 
> Actually... It is not _needed_ for suspend to disk, either. Snapshot is
> atomic, so it should be okay to suspend with filesystems dirty.
> 
> _But_, if anything goes wrong, we'd prefer to have at least
> filesystems synced. Battery running out during s2ram is not quite
> uncommon, so we perhaps should do sync somewhere there. (But we can do
> it before freezer just fine).

OK

So, should I add the sync() to suspend_prepare(), before freeze_processes()
(in analogy with hibernate())?

Greetings
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
