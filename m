From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH 2/2] PM: Rework handling of interrupts
	during suspend-resume
Date: Mon, 23 Feb 2009 23:11:34 +0100
Message-ID: <200902232311.36133.rjw__22838.4952912622$1235427453$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <20090223171630.GA28651@elte.hu>
	<alpine.LFD.2.00.0902230926030.3111@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0902230926030.3111@localhost.localdomain>
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
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Thomas Gleixner <tglx@linutronix.de>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Monday 23 February 2009, Linus Torvalds wrote:
> 
> On Mon, 23 Feb 2009, Ingo Molnar wrote:
> > 
> > Linus, do you have a strong opinion about which variant we 
> > should use?
> 
> Strong? No. I think mine is better just because _if_ another CPU is busy 
> handling an interrupt that we're just now disabling, we'll just go on to 
> the next interrupt. Waiting for them all at the end is always more 
> efficient.
> 
> But does it really matter? No. In this case I think we've shut down all 
> other CPU's anyway, so the whole "serialize_irq()" should probably not 
> even be needed. 

But we're going to move the shutting down of the other CPUs after this point.

Finally, the sequence is going to be:
- "normal" suspend of devices
- disable device interrupts
- "late" suspend of devices
- _PTS
- disable nonboot CPUs
- local_irq_disable
- sysdev_suspend
[This is because ACPI wants us to put devices into low power states before
doing the _PTS, which in turn is supposed to be done before the disabling of
nonboot CPUs, and we want to put devices into low power states during "late"
suspend.  Of course, analogously for the resume part.]

So, I think your version is _really_ better. :-)

Thanks,
Rafael
