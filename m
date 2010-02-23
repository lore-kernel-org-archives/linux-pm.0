From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 1/8] PCI PM: Add function for checking PME
 status of devices
Date: Mon, 22 Feb 2010 16:21:42 -0800
Message-ID: <20100222162142.06095230__6213.37064444578$1266884714$gmane$org@jbarnes-piketon>
References: <201002172335.47703.rjw@sisk.pl> <201002172336.58766.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201002172336.58766.rjw@sisk.pl>
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
Cc: Garrett <mjg@redhat.com>, Matthew@smtp1.linux-foundation.org, Linux PCI <linux-pci@vger.kernel.org>, "Moore, Robert" <robert.moore@intel.com>, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Bjorn@smtp1.linux-foundation.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 17 Feb 2010 23:36:58 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Add function pci_check_pme_status() that will check the PME status
> bit of given device and clear it along with the PME enable bit.  It
> will be necessary for PCI run-time power management.
> 
> Based on a patch from Shaohua Li <shaohua.li@intel.com>
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

Applied this series and dropped the old patches, thanks Rafael.

-- 
Jesse Barnes, Intel Open Source Technology Center
