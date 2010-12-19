From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] PCI / PCIe: Clear Root PME Status bits
	during early resume
Date: Sun, 19 Dec 2010 13:38:23 +0100
Message-ID: <201012191338.24070.rjw__34380.3853299052$1292762393$gmane$org@sisk.pl>
References: <201012191149.40547.rjw@sisk.pl>
	<20101219113658.GH1263@parisc-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20101219113658.GH1263@parisc-linux.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Wilcox <matthew@wil.cx>
Cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sunday, December 19, 2010, Matthew Wilcox wrote:
> On Sun, Dec 19, 2010 at 11:49:40AM +0100, Rafael J. Wysocki wrote:
> > in pci_pm_default_resume_early() and not in the port's resume
> > routine, because it's generally necessary even if the PCI Express
> > port driver is not used).
> 
> We should make it impossible to not use the PCIe port driver.

Actually, that's not correct.  In some cases (e.g. _OSI doesn't allow us
to use PCIe native services), we simply can't use it (because it is unsafe
and leads to serious problems).

Thanks,
Rafael
