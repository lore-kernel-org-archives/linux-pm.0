From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Mon, 24 Aug 2009 03:48:21 +0100
Message-ID: <20090824024821.GA29538__13940.452450379$1251082265$gmane$org@srcf.ucam.org>
References: <1250666651.23178.116.camel@sli10-desk.sh.intel.com>
	<20090819115210.GC12216@srcf.ucam.org>
	<20090820032450.GD26357@sli10-desk.sh.intel.com>
	<20090820074050.GA30288@srcf.ucam.org>
	<20090821063350.GA16694@sli10-desk.sh.intel.com>
	<20090821092316.GA19617@srcf.ucam.org>
	<20090824015046.GA6661@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090824015046.GA6661@sli10-desk.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 24, 2009 at 09:50:46AM +0800, Shaohua Li wrote:
> On Fri, Aug 21, 2009 at 05:23:16PM +0800, Matthew Garrett wrote:
> > Yes, but that's fine because the PME state tells us exactly which device 
> > caused the wakeup. We'll never get a bus notification if the wakeup is 
> > triggered by UHCI on Intel.
> Hmm, but here what we are talking about is if notification is always sent to the device
> which invokes wakeup event.
> I pointed out this isn't true because BIOS might sent notification to a pci bridge and
> OS should scan devices under the bridge to check which devices invokes it by looking at
> PME state. Looks you are talking about other things.

There are two cases:

1) Notification is sent to a device. Since we know the device that 
generated the event, we don't need .wakeup_event.

2) Notification is sent to a bus. This will only happen if the device 
supports PME, so we don't need .wakeup_event.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
