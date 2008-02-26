From: David Brownell <david-b@pacbell.net>
Subject: Re: Fundamental flaw in system suspend,
	exposed by freezer removal
Date: Tue, 26 Feb 2008 01:16:17 -0800
Message-ID: <200802260116.18142.david-b__26831.7800750539$1204017603$gmane$org@pacbell.net>
References: <Pine.LNX.4.44L0.0802251439030.5536-100000@iolanthe.rowland.org>
	<200802252313.23399.david-b@pacbell.net>
	<47C3CD15.1060908@davidnewall.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <47C3CD15.1060908@davidnewall.com>
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
To: David Newall <davidn@davidnewall.com>
Cc: linux-pm@lists.linux-foundation.org, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday 26 February 2008, David Newall wrote:
> 
> Hardware can be inserted and removed while we're in a suspend state; and
> there's nothing that we can do about it until we resume.  Is it fair to
> say, then, that having started suspend, we could reasonably ignore any
> device insertion and removal, and handle it on resume?

"Ignore" seems a bit strong; those events may be wakeup triggers,
which would cause the hardware to make it a very short suspend state.

"Defer handling" is more to the point, be it by hardware or software.


> Presumably we need to scan for hardware changes on resume.

Not on most busses I work with; the hardware issues notifications
whenever the devices are removable.

Which is a Good Thing ... scanning, as you suggest, is inherently
not reliable.  If a mouse is swapped, it likely doesn't matter a
lot whether it's the "same" or not.

But ... how about if some removable storage media was taken out,
updated on a different system, then restored before the resume?
Not many filesystems handle that sanely.  You *really* want to
have hardware which reports disconnect/reconnect events, or which
physically prevents them (locked case etc).

- Dave
