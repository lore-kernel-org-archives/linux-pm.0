From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Fri, 21 Aug 2009 10:23:16 +0100
Message-ID: <20090821092316.GA19617__46690.1823449463$1250846783$gmane$org@srcf.ucam.org>
References: <1250666651.23178.116.camel@sli10-desk.sh.intel.com>
	<20090819115210.GC12216@srcf.ucam.org>
	<20090820032450.GD26357@sli10-desk.sh.intel.com>
	<20090820074050.GA30288@srcf.ucam.org>
	<20090821063350.GA16694@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090821063350.GA16694@sli10-desk.sh.intel.com>
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

On Fri, Aug 21, 2009 at 02:33:50PM +0800, Shaohua Li wrote:
> On Thu, Aug 20, 2009 at 03:40:51PM +0800, Matthew Garrett wrote:
> > _L0B will only be triggered if a PME is generated, so we'll be able to 
> > determine which device generated the wakeup by looking at the PME 
> > registers.
> Right, but the event is sent to a bridge. The devices under the bridge invoke
> wakeup event, not the bridge itself. So you must scan all devices under the
> bridge to check which device has its PME registers set.
> So the bridge case isn't what you said (notification always sent to a specific
> device which invokes the wakeup event)

Yes, but that's fine because the PME state tells us exactly which device 
caused the wakeup. We'll never get a bus notification if the wakeup is 
triggered by UHCI on Intel.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
