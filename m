From: Felipe Balbi <me@felipebalbi.com>
Subject: Re: [PATCH 0/8] Suspend block api (version 6)
Date: Thu, 20 May 2010 21:50:57 +0300
Message-ID: <20100520185057.GA25089__43692.1748369516$1274381572$gmane$org@gandalf>
References: <4BF51C9D.8050406@nt.tu-darmstadt.de>
	<15003.23611.qm@web180316.mail.gq1.yahoo.com>
Reply-To: me@felipebalbi.com
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <15003.23611.qm@web180316.mail.gq1.yahoo.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: David Brownell <david-b@pacbell.net>
Cc: "me@felipebalbi.com" <me@felipebalbi.com>, Theodore Ts'o <tytso@mit.edu>, Andrew Morton <akpm@linux-foundation.org>, Brian Swetland <swetland@google.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Geoff Smith <geoffx.smith@intel.com>, Kernel development list <linux-kernel@vger.kernel.org>, Liam Girdwood <lrg@slimlogic.co.uk>, Oleg Nesterov <oleg@redhat.com>, Tejun Heo <tj@kernel.org>, Vladimir Pantelic <pan@nt.tu-darmstadt.de>, felipe.balbi@nokia.com, "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thu, May 20, 2010 at 10:40:17AM -0700, David Brownell wrote:
> Some apps do abuse kernel mechanisms, and whether the bug is in the
> app or that kernel mechanism can be a judgement call.  I'd expect to

hey come on, there's no judgement call for an app polling every second
to check battery status or some other status that doesn't change that
frequently.

> I may have overlooked it, in one of the 100K messsages in my mailbox
> about versions of suspend block/etc patches ...
> 
> But surely NOBODY is actually contending that broken aps NOT get
> fixed??
> 
> It's clear to me that tools are needed to identify power hogs;
> powertop can't be the extent of such tools.  (ISTR it doesn't monitor
> display power usage, for one thing; maybe newer versions do so.)  Once
> such hogs get identified they will need to get fixed.  Any other
> proposal seems broken to me...

that's my feeling too. I don't see any needs for suspend blockers in any
real system. I acknowledge we need tools probing power consumption to be
shipped to production device, that's a good idea, but forcing apps to
modify just to have that UI fill up some treeview, I think it's a bit
too much.

-- 
balbi
