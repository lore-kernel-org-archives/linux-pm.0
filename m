From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC][PATCH 0/2] Make radeonfb use PCI PM core for
 suspendig device (was: Re: [RFC][PATCH] PCI PM: Be extra careful when
 changing power states of devices)
Date: Mon, 23 Mar 2009 11:09:02 +1100
Message-ID: <1237766942.25062.680.camel__2629.56022420457$1237767354$gmane$org@pasglop>
References: <200903210003.55161.rjw@sisk.pl> <200903222208.22434.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903222208.22434.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 2009-03-22 at 22:08 +0100, Rafael J. Wysocki wrote:
> On Saturday 21 March 2009, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > The story in http://bugzilla.kernel.org/show_bug.cgi?id=12846 shows
> > that setting the power state of a PCI device by
> > pci_raw_set_power_state() may sometimes fail.  For this reason,
> > pci_raw_set_power_state() should not assume that the power state of
> > the device has actually changed after writing into its PMCSR.
> > Instead, it should read the value from there and use it to update
> > dev->current_state.  It also is useful to print a warning if the
> > device's power state hasn't changed as expected.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> OK, since the Ben's radeonfb fix for bug #12846 has been merged, I'd like
> to do something a bit different.
> 
> Patch 1/2 introduces __pci_set_power_state() that will allow the radeonfb
> driver not to open code PCI PM operations.
> 
> Patch 2/2 makes the driver use __pci_set_power_state().
> 
> Comments welcome.

No objection.

Ben.
