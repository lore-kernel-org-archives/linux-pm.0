From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: i915 hibernation patch (was: Re: [Suspend-devel]
 2.6.25-rc2 System no longer powers off aftersuspend-to-disk. Screen becomes
 green.)
Date: Fri, 22 Feb 2008 18:07:56 -0800 (PST)
Message-ID: <alpine.LFD.1.00.0802221805540.21332@woody.linux-foundation.org>
References: <Pine.LNX.4.64.0802210101050.3576@boston.corp.fedex.com>
	<200802230031.20292.rjw@sisk.pl>
	<alpine.LFD.1.00.0802221653000.21332@woody.linux-foundation.org>
	<200802230255.54510.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200802230255.54510.rjw@sisk.pl>
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
Cc: Jeff Chua <jeff.chua.linux@gmail.com>, Dave Airlie <airlied@linux.ie>, Greg KH <gregkh@suse.de>, lkml <linux-kernel@vger.kernel.org>, Romano Giannetti <romano@dea.icai.upcomillas.es>, linux-acpi@vger.kernel.org, Jesse Barnes <jesse.barnes@intel.com>, pm list <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org



On Sat, 23 Feb 2008, Rafael J. Wysocki wrote:
> 
> In the revised patch below I redefined the PM_EVENT_* things as flags so
> that I can "or" them and defined PM_EVENT_SLEEP in analogy with
> CONFIG_PM_SLEEP.

Ok, looks fine by me.

> > Didn't you miss the apci_pci_choose_state() thing that also needs this 
> > extension?
> 
> No, I didn't.  That one operates on the ACPI D* states.

Ok. I consider that just about the worst interface ever, but whatever...

> OK, please have a look at the modified patch below.

All right, I'm fine with it. Now we just need to confirm that it works for 
people..

		Linus
