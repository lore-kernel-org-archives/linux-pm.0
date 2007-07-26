From: Mattia Dongili <malattia@linux.it>
Subject: Re: [patch 2.6.21-rc5-git 2/3] ACPI driver model flags
	and platform_enable_wake()
Date: Thu, 26 Jul 2007 16:07:39 +0900
Message-ID: <20070726070739.GB3901__21688.9330222786$1185433953$gmane$org@inferi.kami.home>
References: <200704051249.10407.david-b@pacbell.net>
	<200707251304.03191.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200707251304.03191.david-b@pacbell.net>
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
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 25, 2007 at 01:04:02PM -0700, David Brownell wrote:
> I'm curious about the status of the appended patch ... without it,
> the new acpi_pm_device_sleep_state() routine isn't really able to
> do anything intelligent.  The patch still applies to 2.6.23-rc1-git;
> my patches-that-still-haven't-merged queue has had this at the very
> top for quite a few months now...
> 
> As I recall, Mattia Dongili <malattia@linux.it> reported an error
> with a Vaio laptop; it would wake immediately after entering STR.
> It didn't reproduce for anyone else.  But that was eventually tracked
> down to a bug in iwl3945, which has since been fixed (yes?).

not exactly. The problem was a pcmcia express card reader disconnecting
itself after suspend and thus triggering the wakeup.
A good summary is this and following posts:
http://marc.info/?l=linux-acpi&m=118250426218485&w=2

AFAICT it is reproducible by simply suspending and disconnecting an usb
mouse, that should trigger the wakeup event :)

...
> On Thursday 05 April 2007, David Brownell wrote:
> > This upgrades the ACPI code to start cooperating with the two driver
> > model wakeup flags and with pci_enable_wake(), based on the previous
> > patch updating that PCI call:

ciao
-- 
mattia
:wq!
