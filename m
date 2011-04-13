From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: freezer: should barriers be smp ?
Date: Wed, 13 Apr 2011 22:58:17 +0200
Message-ID: <201104132258.17705.rjw__32526.6310167082$1302728458$gmane$org@sisk.pl>
References: <BANLkTi=F-C-vwX4PGGfbkdTBw3OWL-twfg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTi=F-C-vwX4PGGfbkdTBw3OWL-twfg@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Mike Frysinger <vapier@gentoo.org>
Cc: uclinux-dist-devel@blackfin.uclinux.org, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, April 13, 2011, Mike Frysinger wrote:
> when we suspend/resume Blackfin SMP systems, we notice that the
> freezer code runs on multiple cores.  this is of course what you want
> -- freeze processes in parallel.  however, the code only uses non-smp
> based barriers which causes us problems ... our cores need software
> support to keep caches in sync, so our smp barriers do just that.  but
> the non-smp barriers do not, and so the frozen/thawed processes
> randomly get stuck in the wrong task state.
> 
> thinking about it, shouldnt the freezer code be using smp barriers ?

Yes, it should, but rmb() and wmb() are supposed to be SMP barriers.

Or do you mean something different?

Rafael
