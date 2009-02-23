From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
 during suspend-resume
Date: Sun, 22 Feb 2009 16:05:11 -0800 (PST)
Message-ID: <alpine.LFD.2.00.0902221603440.3111__47567.499013576$1235347750$gmane$org@localhost.localdomain>
References: <200902221837.49396.rjw@sisk.pl>
	<alpine.LFD.2.00.0902220946070.3111@localhost.localdomain>
	<200902222342.08285.rjw@sisk.pl> <200902230048.33635.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902230048.33635.rjw@sisk.pl>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, Ingo Molnar <mingo@elte.hu>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org



On Mon, 23 Feb 2009, Rafael J. Wysocki wrote:
> 
> The updated patch is appended.

Ok, looks sane to me. I'll try it on my poor eeepc, although right now 
Fedora-11 rawhide (that poor laptop gets _all_ the crazy stuff thrown at 
it, and runs btrfs to boot) has broken something in X by enabling DRI2, so 
I may not get around to it today.

		Linus
