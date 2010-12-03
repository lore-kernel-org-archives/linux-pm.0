From: Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH] PM / Hibernate: Fix memory corruption
	related to swap
Date: Thu, 2 Dec 2010 16:37:21 -0800 (PST)
Message-ID: <alpine.LSU.2.00.1012021622370.26812__23324.0601527088$1291336704$gmane$org@tigran.mtv.corp.google.com>
References: <201012030040.37273.rjw@sisk.pl>
	<20101202155453.92e8ca57.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101202155453.92e8ca57.akpm@linux-foundation.org>
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
Cc: Ondrej Zary <linux@rainbow-software.org>, Kernel development list <linux-kernel@vger.kernel.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

On Thu, 2 Dec 2010, Andrew Morton wrote:
> On Fri, 3 Dec 2010 00:40:36 +0100
> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > 
> > This patch is a fix for a regression and nasty memory corruption, so I'd like
> > to push it to Linus for 2.6.37 if there are no objections.

(It will need backport to 2.6.35-stable and 2.6.36-stable:
IIRC it doesn't quite apply cleanly to those, so we'll need
to send a separate version.)

> 
> It looks OK to me for 2.6.37 but for 2.6.38 please let's make
> everything here a 100% no-op for CONFIG_PM_SLEEP=n builds. 
> Specifically the slight overhead in __alloc_pages_nodemask.

I expect you're right that the CONFIG_PM would better be CONFIG__PM_SLEEP;
but I think you misunderstand gfp_allowed_mask in __alloc_pages_nodemask:
it came from slab & slub, to fix some early bootup issues, and predates
Rafael's recent use of it in suspend and hibernation.

> 
> Because given the global nature of saved_gfp_mask and the unlocked way
> in which it is accessed, this facility won't be at all useful for
> anything other than suspend.

... and bootup.

Hugh
