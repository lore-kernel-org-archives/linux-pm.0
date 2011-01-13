From: Sebastian Ott <sebott@linux.vnet.ibm.com>
Subject: Re: Oops while going into hibernate
Date: Thu, 13 Jan 2011 12:48:40 +0100 (CET)
Message-ID: <alpine.LFD.2.02.1101131238480.1899__17878.1251227067$1294919402$gmane$org@localhost6.localdomain6>
References: <alpine.LFD.2.02.1101121443230.1900@localhost6.localdomain6>
	<20110112162655.GA13496@thunk.org>
	<alpine.LFD.2.02.1101121755400.2011@localhost6.localdomain6>
	<20110112172646.GB13496@thunk.org>
	<alpine.LFD.2.02.1101121934060.2011@localhost6.localdomain6>
	<A01161D0-D08F-4522-A546-90057B2E1F2A@mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <A01161D0-D08F-4522-A546-90057B2E1F2A@mit.edu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Theodore Tso <tytso@mit.edu>
Cc: pm list <linux-pm@lists.linux-foundation.org>, "linux-ext4@vger.kernel.org development" <linux-ext4@vger.kernel.org>, LKML Kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org


On Wed, 12 Jan 2011, Theodore Tso wrote:
> That looks really bogus.  /usr/bin/killall is a system binary, and there's
> no good reason that hibernation should be trying to write pages to that
> binary.
> 
> You said originally that the oops was happening "while going into
> hibernation right after resuming with...".   So that means you did a
> successful suspend/resume, and then the second suspend caused the oops?
Yes. I basically did a
echo reboot > /sys/power/disk
for i in {1..5} ;do echo disk > /sys/power/state ;done
and it crashed very early in the second suspend.

> It looks like somehow the pages were left marked as dirty, so the
> writeback daemons attempted writing back a page to an inode which was
> never opened read/write (and in fact as a text page for
> /usr/bin/killall, was mapped read/only).
> Given that ext4 initializes jinode only when the file is opened
> read/write, the fact that it is null, and the fact that it makes no
> sense that a program would be modifying /usr/bin/killall as part of a
> suspend/resume, it looks very much like we just unmasked a software
> suspend bug....
Ah, ok. Thanks for the explanation!

Regards,
Sebastian
