From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: [PATCH 1/5] introduce .wakeup_event ops
Date: Wed, 19 Aug 2009 12:52:10 +0100
Message-ID: <20090819115210.GC12216__39995.6983783797$1250682803$gmane$org@srcf.ucam.org>
References: <1250666651.23178.116.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <1250666651.23178.116.camel@sli10-desk.sh.intel.com>
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

On Wed, Aug 19, 2009 at 03:24:11PM +0800, Shaohua Li wrote:

> Usually driver should does nothing in the op as bus can handle it. But in some
> cases, like pci bus, UHCI controller doesn't use standard PME registers for
> wakeup, instead of using special approach. In this case, UHCI controller driver
> should implement this op.

I'm not averse to the general concept, but I'm not entirely sold on it 
being necessary. All the hardware I'm aware of will send non-PME events 
as a notification on a specific device. Under what circumstances will we 
get a wakeup GPE for a non-PME device without knowing which device 
should be woken?

-- 
Matthew Garrett | mjg59@srcf.ucam.org
