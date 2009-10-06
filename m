From: Jesse Barnes <jesse.barnes@intel.com>
Subject: Re: [Resend][PATCH] PCI PM: Read device power state from
 register after updating it
Date: Tue, 6 Oct 2009 09:08:55 -0700
Message-ID: <20091006090855.650ef454@jbarnes-g45>
References: <200910050048.40699.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200910050048.40699.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Andreas Mohr <andi@lisas.de>, pm list <linux-pm@lists.linux-foundation.org>, granade <kevin.granade@gmail.com>, kevin@smtp1.linux-foundation.org, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 5 Oct 2009 00:48:40 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> After attempting to change the power state of a PCI device
> pci_raw_set_power_state() doesn't check if the value it wrote into
> the device's PCI_PM_CTRL register has been stored in there, but
> unconditionally modifies the device's current_state field to reflect
> the change.  This may cause problems to happen if the power state of
> the device hasn't been changed in fact, because it will make the PCI
> PM core make a wrong assumption.
> 
> To prevent such situations from happening modify
> pci_raw_set_power_state() so that it reads the device's PCI_PM_CTRL
> register after writing into it and uses the value read from the
> register to update the device's current_state field.  Also make it
> print a message saying that the device refused to change its power
> state as requested (returning an error code in such cases would cause
> suspend regressions to appear on some systems, where device drivers'
> suspend routines return error codes if pci_set_power_state() fails).
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Applied to my for-linus branch, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
