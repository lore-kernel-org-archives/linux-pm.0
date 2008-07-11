From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 7/8] PCI PM: Introduce pci_prepare_to_sleep
	and	pci_back_from_sleep
Date: Fri, 11 Jul 2008 22:31:33 +0200
Message-ID: <20080711203133.GC6843__31387.1099883274$1215808369$gmane$org@elf.ucw.cz>
References: <200807012356.26669.rjw@sisk.pl> <200807070330.02849.rjw@sisk.pl>
	<200807070335.27309.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200807070335.27309.rjw@sisk.pl>
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
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, Zhao Yakui <yakui.zhao@intel.com>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Andi Kleen <andi@firstfloor.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2008-07-07 03:35:26, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> PCI PM: Introduce pci_prepare_to_sleep and pci_back_from_sleep
> 
> Introduce functions pci_prepare_to_sleep() and pci_back_from_sleep(),
> to be used by the PCI drivers that want to place their devices into
> the lowest power state appropiate for them (PCI_D3hot, if the device
> is not supposed to wake up the system, or the deepest state from
> which the wake-up is possible, otherwise) while the system is being
> prepared to go into a sleeping state and to put them back into D0
> during the subsequent transition to the working state.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK.

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
