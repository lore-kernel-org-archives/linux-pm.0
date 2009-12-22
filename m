From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [RFD] Asynchronous suspend/resume of PCI devices
Date: Tue, 22 Dec 2009 08:30:01 -0800
Message-ID: <20091222083001.10ce3948__35666.3224440583$1261499591$gmane$org@jbarnes-x200>
References: <200912200031.38775.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912200031.38775.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus@smtp1.linux-foundation.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Sun, 20 Dec 2009 00:31:38 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> Hi,
> 
> I'd like to know your opinions about the viability of suspending and
> resuming PCI devices asynchronously during system-wide PM transitions
> (suspend to RAM and hibernation).
> 
> Linus says it's generally dangerous, because some PCI devices may
> indirectly depend on the others, but if that's the case, I wonder if
> we really can power manage PCI devices at run time.
> 
> It follows from my experiments that suspending and resuming PCI
> devices asynchronously doesn't lead to problems as long as we make
> sure that every PCI device is suspended before and resumed after its
> ACPI "shadow" partner. However, I'm not sure if this is generally
> correct.
> 
> What are possible problems we can run into while doing asynchronous
> suspend and resume of PCI devices?  What do we need to do in general
> to avoid that problems?
> 
> Please tell me what you think.

AFAIK it should be *mostly* safe.  Individual drivers are generally
independent of one another.  However, there are quite a few
multifunction devices (some exposed as such, some exposed as multiple
busses and devices on the same device) where interdependencies are
possible.  In some cases, we just won't see power savings until the
whole chip is powered down (which may require extra code in the form of
a "bus" driver of some sort), in other cases a driver may inadvertently
power down a piece of a device needed by another driver.

That said, the best practice for those sorts of devices is to create a
bus driver anyway, that binds to the master device and has a few
child drivers, so maybe even that case won't be much trouble...

Jesse
