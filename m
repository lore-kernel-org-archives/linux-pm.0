From: Matthew Wilcox <matthew@wil.cx>
Subject: Re: [PATCH] PCI / PCIe: Clear Root PME Status bits
	during early	resume
Date: Sun, 19 Dec 2010 04:36:58 -0700
Message-ID: <20101219113658.GH1263__44755.1563069739$1292758767$gmane$org@parisc-linux.org>
References: <201012191149.40547.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201012191149.40547.rjw@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 19, 2010 at 11:49:40AM +0100, Rafael J. Wysocki wrote:
> in pci_pm_default_resume_early() and not in the port's resume
> routine, because it's generally necessary even if the PCI Express
> port driver is not used).

We should make it impossible to not use the PCIe port driver.
(This isn't a reason to not take this patch for now, just a direction
we should be heading in for the future).

-- 
Matthew Wilcox				Intel Open Source Technology Centre
"Bill, look, we understand that you're interested in selling us this
operating system, but compare it to ours.  We can't possibly take such
a retrograde step."
