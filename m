From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch 2.6.26-git] pm selftest:  rtc paranoia
Date: Fri, 25 Jul 2008 15:22:02 -0700
Message-ID: <200807251522.02789.david-b__45732.5518866584$1217024642$gmane$org@pacbell.net>
References: <200807251326.51987.david-b@pacbell.net>
	<20080725144946.5e1b78c8.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080725144946.5e1b78c8.akpm@linux-foundation.org>
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
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday 25 July 2008, Andrew Morton wrote:
> On Fri, 25 Jul 2008 13:26:51 -0700
> David Brownell <david-b@pacbell.net> wrote:
> 
> > From: David Brownell <dbrownell@users.sourceforge.net>
> > 
> > Cope with a quirk of some RTCs (notably ACPI ones) which
> > aren't guaranteed to implement oneshot behavior when they
> > woke the system from sleeep:  forcibly disable the alarm,
> > just in case.
> > 
> > ...
> 
> I assume this fixes some reported bug?  Any references?

It's more paranoia than anything else ... I saw a version
of this with on x86, but that was because of problems in
the HPET glue (fixed by a previous patch).

 
> Is this needed in 2.6.26.x?  2.6.25.x?

The selftest only merged this week, so not 2.6.25;
and since it's just paranoia, it shouldn't be critical
for 2.6.26 either.

- Dave
