From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] PCI / PCIe: Clear Root PME Status bits early
 during system resume
Date: Thu, 23 Dec 2010 12:54:35 -0800
Message-ID: <20101223125435.248105fa__31247.2754311331$1293137829$gmane$org@jbarnes-desktop>
References: <201012191149.40547.rjw@sisk.pl> <201012191341.23601.rjw@sisk.pl>
	<201012191354.47960.rjw@sisk.pl> <201012191557.16403.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201012191557.16403.rjw@sisk.pl>
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
Cc: Matthew Wilcox <matthew@wil.cx>, linux-pci@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 19 Dec 2010 15:57:16 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> I noticed that PCI Express PMEs don't work on my Toshiba Portege R500
> after the system has been woken up from a sleep state by a PME
> (through Wake-on-LAN).  After some investigation it turned out that
> the BIOS didn't clear the Root PME Status bit in the root port that
> received the wakeup PME and since the Requester ID was also set in
> the port's Root Status register, any subsequent PMEs didn't trigger
> interrupts.
> 
> This problem can be avoided by clearing the Root PME Status bits in
> all PCI Express root ports during early resume.  For this purpose,
> add an early resume routine to the PCIe port driver and make this
> driver be always registered, even if pci_ports_disable is set (in
> which case the driver's only function is to provide the early
> resume callback).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---
> 

Applied to my linux-next branch, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
