From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC 0/5] device wakeup event support v2
Date: Mon, 15 Sep 2008 01:50:00 +0200
Message-ID: <200809150150.01687.rjw__19574.7745609426$1221436131$gmane$org@sisk.pl>
References: <20080911063037.698427944@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080911063037.698427944@sli10-desk.sh.intel.com>
Content-Disposition: inline
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
Cc: linux-acpi@vger.kernel.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Thursday, 11 of September 2008, Shaohua Li wrote:
> This series add device wakeup event detection support. This is the base to
> implement runtime device suspend/resume, though we don't support it now.
> But David said USB is approaching to this. See this bugzilla
> http://bugzilla.kernel.org/show_bug.cgi?id=6892 for detail.
> 
> changes v1 -> v2:
> 1. scan pci bridge for PME. Current implementation is just doing scan if target device is a bridge
> 2. move device_receive_wakeup_event() call to pci, and provide an API (pci_handle_wakeup_event()) for non-ACPI & non-PCIe platform
> 3. fixed a lot of coding style issues
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>

Thanks for posting the update.

Unfortunately, I won't be able to review the patches until after I get back
from the Kernel Summit.

Thanks,
Rafael
