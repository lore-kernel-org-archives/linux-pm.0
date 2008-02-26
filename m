From: David Newall <davidn@davidnewall.com>
Subject: Re: Fundamental flaw in system suspend,
 exposed by freezer removal
Date: Tue, 26 Feb 2008 18:55:57 +1030
Message-ID: <47C3CD15.1060908__855.834692674939$1204041604$gmane$org@davidnewall.com>
References: <Pine.LNX.4.44L0.0802251439030.5536-100000@iolanthe.rowland.org>
	<200802252325.09439.rjw@sisk.pl>
	<200802252313.23399.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802252313.23399.david-b@pacbell.net>
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
Cc: linux-pm@lists.linux-foundation.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

David Brownell wrote:
> This "flaw" isn't a new thing, of course.  I remember pointing out the rather
> annoying proclivity of the PM framework to deadlock when suspend() tried to
> remove USB devices ... back around 2.6.10 or so.  Things have shuffled around
> a bit, and gotten better in some cases, but not fundamentally changed.

Hardware can be inserted and removed while we're in a suspend state; and
there's nothing that we can do about it until we resume.  Is it fair to
say, then, that having started suspend, we could reasonably ignore any
device insertion and removal, and handle it on resume?  Presumably we
need to scan for hardware changes on resume.
