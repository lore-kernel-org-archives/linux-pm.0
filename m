From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFC] PCI: Runtime power management
Date: Fri, 14 Aug 2009 10:37:19 -0700
Message-ID: <20090814103719.79e99d91__25512.6532204033$1250271583$gmane$org@jbarnes-g45>
References: <200908081625.57333.rjw@sisk.pl> <200908092313.05541.rjw@sisk.pl>
	<20090813002925.GA2532@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090813002925.GA2532@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: linux-usb@vger.kernel.org, linux-pci@vger.kernel.org, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 13 Aug 2009 01:29:25 +0100
Matthew Garrett <mjg59@srcf.ucam.org> wrote:

> I got a fixed BIOS from Dell and have been able to get this working
> now. It seems entirely happy with USB, but I'd like some sanity
> checks on whether I'm doing this correctly. There's certainly a
> couple of quirks related to setting the ACPI GPE type that would need
> a little bit of work in the ACPI layer, and it breaks ACPI-mediated
> PCI hotplug though that's easy enough to fix by just calling into the
> hotplug code from the core notifier.
> 
> This patch builds on top of Rafael's work on systemwide runtime power
> management. It supports suspending and resuming PCI devices at
> runtime, enabling platform wakeup events that allow the devices to
> automatically resume when appropriate. It currently requires platform
> support, but PCIe setups could be supported natively once native PCIe
> PME code has been added to the kernel.

PCI bits look pretty good to me, though Rafael should take a look too.
Card readers and firewire could benefit from similar treatment, maybe
that would get us to .5W territory on some machines.

-- 
Jesse Barnes, Intel Open Source Technology Center
