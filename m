From: Shaohua Li <shaohua.li@intel.com>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Fri, 21 Aug 2009 14:33:50 +0800
Message-ID: <20090821063350.GA16694__19437.2649807066$1250836703$gmane$org@sli10-desk.sh.intel.com>
References: <1250666651.23178.116.camel@sli10-desk.sh.intel.com>
	<20090819115210.GC12216@srcf.ucam.org>
	<20090820032450.GD26357@sli10-desk.sh.intel.com>
	<20090820074050.GA30288@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090820074050.GA30288@srcf.ucam.org>
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
Cc: linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 20, 2009 at 03:40:51PM +0800, Matthew Garrett wrote:
> On Thu, Aug 20, 2009 at 11:24:50AM +0800, Shaohua Li wrote:
> > On Wed, Aug 19, 2009 at 07:52:10PM +0800, Matthew Garrett wrote:
> > > I'm not averse to the general concept, but I'm not entirely sold on it 
> > > being necessary. All the hardware I'm aware of will send non-PME events 
> > > as a notification on a specific device. Under what circumstances will we 
> > > get a wakeup GPE for a non-PME device without knowing which device 
> > > should be woken?
> > Below code is gotten from a laptop (samsung-x10), the PCIB is the PCI bridge.
> > We can't guarantee the device which gets a wakeup event notification is really
> > the device which invokes the wakeup event.
> 
> _L0B will only be triggered if a PME is generated, so we'll be able to 
> determine which device generated the wakeup by looking at the PME 
> registers.
Right, but the event is sent to a bridge. The devices under the bridge invoke
wakeup event, not the bridge itself. So you must scan all devices under the
bridge to check which device has its PME registers set.
So the bridge case isn't what you said (notification always sent to a specific
device which invokes the wakeup event)

Thanks,
Shaohua
