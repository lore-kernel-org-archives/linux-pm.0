From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC][PATCH 0/2] Export
 platform_pci_set_power_state() and make radeonfb use it
Date: Mon, 23 Mar 2009 15:23:30 -0700
Message-ID: <20090323152330.536a5a1c__9106.40559527582$1237847298$gmane$org@hobbes.virtuouswap>
References: <200903210003.55161.rjw@sisk.pl> <200903222208.22434.rjw@sisk.pl>
	<200903232230.10831.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903232230.10831.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 23 Mar 2009 22:30:09 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Sunday 22 March 2009, Rafael J. Wysocki wrote:
> > On Saturday 21 March 2009, Rafael J. Wysocki wrote:
> > > From: Rafael J. Wysocki <rjw@sisk.pl>
> > > 
> > > The story in http://bugzilla.kernel.org/show_bug.cgi?id=12846
> > > shows that setting the power state of a PCI device by
> > > pci_raw_set_power_state() may sometimes fail.  For this reason,
> > > pci_raw_set_power_state() should not assume that the power state
> > > of the device has actually changed after writing into its PMCSR.
> > > Instead, it should read the value from there and use it to update
> > > dev->current_state.  It also is useful to print a warning if the
> > > device's power state hasn't changed as expected.
> > > 
> > > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > > ---
> > OK, since the Ben's radeonfb fix for bug #12846 has been merged,
> > I'd like to do something a bit different.
> > 
> > Patch 1/2 introduces __pci_set_power_state() that will allow the
> > radeonfb driver not to open code PCI PM operations.
> > 
> > Patch 2/2 makes the driver use __pci_set_power_state().
> > 
> > Comments welcome.
> 
> Well, Jesse doesn't like these patches very much, so here's an
> alternative.
> 
> 1/2 changes platform_pci_set_power_state() into an exported function
> (and uses it to simplify pci_set_power_state() a bit) so that the
> radeonfb driver can use it.
> 
> 2/2 modifies the radeonfb driver itself.

The thing I didn't like was that it made the radeon driver use an
internal interface; I'd really prefer a proper return value from
pci_set_power_state, which in turn means auditing all its current
callers. But that doesn't seem worth it unless we see other drivers
needing something similar...

And if we did go with something like your first patch, I'd still rather
see the timeout done in the driver, rather than having the attempts &
delay included in the function...

-- 
Jesse Barnes, Intel Open Source Technology Center
