From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [BUG] Commit "Hibernation: Enter platform hibernation
	state in a consistent way)" makes my system to resume instantly
	from S4
Date: Sun, 28 Oct 2007 21:23:15 +0100
Message-ID: <200710282123.15653.rjw__45537.0907825001$1193602079$gmane$org@sisk.pl>
References: <200710271405.32908.maximlevitsky@gmail.com>
	<200710272346.46226.rjw@sisk.pl>
	<200710282200.53910.maximlevitsky@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200710282200.53910.maximlevitsky@gmail.com>
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
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, 28 October 2007 21:00, Maxim Levitsky wrote:
> On Saturday 27 October 2007 23:46:45 Rafael J. Wysocki wrote:
> > On Saturday, 27 October 2007 14:05, Maxim Levitsky wrote:
> > > Hi,
> > > 
> > > Recently I noticed that my system resumes just after suspend to disk.
> > > 
> > > I traced this to commit 9cd9a0058dd35268b24fa16795a92c800f4086d4.
> > > 
> > > Note:
> > > 
> > > This happens only if I enable WOL using /proc/acpi/wakeup
> > > (echo "ILAN" > /proc/acpi/wakeup)
> > 
> > What happens after a suspend to RAM?
> I do more testing tomorrow, but what I remember is that,
> I had no issues with suspend-to-ram.
> (And take into account the fact that _all_ wakeup devices were enabled always,
> the rc.local does that for me, and still I did quite a lot of suspends, but I
> got the immediate resume, only and always after suspend to disk.

Hm, can you please retest with the above commit applied, but with
device_suspend() in hibernation_platform_enter() replaced by device_shutdown()?

> > > and have 
> > > "ACPI-Hibernate-erroneously-disabled-Suspend-wakeup" applied, since otherwise
> > > all wake-up sources are disabled in S4.
> > > 
> > > 
> > > Clearly the above commit confuses the BIOS.
> > > Using latest -git with the above patch reverted makes everything work again fine.
> > 
> > Well, this patch is needed to make wakeup from peripherals (eg. RTC alarm) work
> > on some boxes.
> > 
> > The symptom that you describe is similar to what I'm observing after a suspend
> > to RAM on one test box.
> > 
> > Can you produce a log of kernel messages printed before powering off the
> > system?
> How :-)
> 
> (I will try to set up netconsole, and turn on acpi debugging, maybe this will help)

Yes, I meant something like this.

Greetings,
Rafael
