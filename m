From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/2]handle pci wakeup event
Date: Mon, 24 Aug 2009 22:07:30 +0200
Message-ID: <200908242207.30750.rjw__41938.556780997$1251144638$gmane$org@sisk.pl>
References: <1251101490.22288.52.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1251101490.22288.52.camel@sli10-desk.sh.intel.com>
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
Cc: linux-pci <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Monday 24 August 2009, Shaohua Li wrote:
> Rafael,
> I separate the PCI wakeup event handle and PCIe native PME patches here
> to make better review/merge.
> 
> patch 1: add an API to handle wakeup event in PCI. Both PCIe native PME
> wakeup event detector or platform method (ACPI GPE) can use the API to
> handle wakeup event.
> 
> patch 2: implement PCIe native PME wakeup event detector

Thanks, I'm looking at the patches right now.

Best,
Rafael
