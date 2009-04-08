From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: 2.6.29 on MacBook 2,
	1 fails to reboot (was Re: 2.6.29-git13: Reported regressions from
	2.6.28)
Date: Wed, 8 Apr 2009 10:00:28 +0200
Message-ID: <200904081000.30313.rjw__22070.5182794065$1239177845$gmane$org@sisk.pl>
References: <n4io5wq70ZO.A.gzG.rFn2JB@chimera>
	<9b1675090904071352x513510ecm8b2574859b088275@mail.gmail.com>
	<9b1675090904071816k59080f1fn39737767db4dc0c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <9b1675090904071816k59080f1fn39737767db4dc0c@mail.gmail.com>
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
To: "Trenton D. Adams" <trenton.d.adams@gmail.com>
Cc: Adrian Bunk <bunk@kernel.org>, Linux SCSI List <linux-scsi@vger.kernel.org>, Takashi Iwai <tiwai@suse.de>, Network Development <netdev@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Natalie Protasevich <protasnb@gmail.com>, Linux ACPI <linux-acpi@vger.kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Andrew Morton <akpm@linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Linux PM List <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 08 April 2009, Trenton D. Adams wrote:
> On Tue, Apr 7, 2009 at 2:52 PM, Trenton D. Adams
> <trenton.d.adams@gmail.com> wrote:
> > On Tue, Apr 7, 2009 at 1:23 PM, Stefan Richter
> > <stefanr@s5r6.in-berlin.de> wrote:
> >>
> >> But more importantly, is this init scripts related bug really what's
> >> happening at your system?  Or do you actually experience an entirely
> >> different bug?
> >
> > It could be.  I will try it out when I get home from work, and get
> > back to you.  That would be cool if it was a simple init script
> > problem.  Cause then I don't have to do anymore git bisects. ;)
> 
> Yes, the order is what causes this, you can close the bug.

Closed.

Thanks,
Rafael
