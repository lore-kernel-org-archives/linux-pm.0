From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PM / Hibernate: Fix memory corruption
	related to swap
Date: Fri, 3 Dec 2010 01:46:37 +0100
Message-ID: <201012030146.37887.rjw__22850.7233471193$1291337298$gmane$org@sisk.pl>
References: <201012030040.37273.rjw@sisk.pl>
	<20101202155453.92e8ca57.akpm@linux-foundation.org>
	<alpine.LSU.2.00.1012021622370.26812@tigran.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LSU.2.00.1012021622370.26812@tigran.mtv.corp.google.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hugh Dickins <hughd@google.com>
Cc: Ondrej Zary <linux@rainbow-software.org>, Kernel development list <linux-kernel@vger.kernel.org>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, Andrew Morton <akpm@linux-foundation.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: linux-pm@vger.kernel.org

On Friday, December 03, 2010, Hugh Dickins wrote:
> On Thu, 2 Dec 2010, Andrew Morton wrote:
> > On Fri, 3 Dec 2010 00:40:36 +0100
> > "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
> > > 
> > > This patch is a fix for a regression and nasty memory corruption, so I'd like
> > > to push it to Linus for 2.6.37 if there are no objections.
> 
> (It will need backport to 2.6.35-stable and 2.6.36-stable:
> IIRC it doesn't quite apply cleanly to those, so we'll need
> to send a separate version.)

That's correct.  I'll backport it when it hits the Linus' tree.

Rafael
