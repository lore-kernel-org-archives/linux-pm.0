From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] PCI PM: Fix suspend error paths and testing
	facility breakage
Date: Tue, 27 Jan 2009 09:48:35 -0800
Message-ID: <200901270948.36109.jbarnes__49483.1472206444$1233079007$gmane$org@virtuousgeek.org>
References: <200901262143.10434.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200901262143.10434.rjw@sisk.pl>
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
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Monday, January 26, 2009 12:43 pm Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> If one of device drivers refuses to suspend by returning error code
> from its ->suspend() callback, the devices that have already been
> suspended are resumed by executing their drivers' ->resume()
> callbacks.  Some of these callbacks expect the device's
> configuration space to be restored if the device has been put into
> D3 before they are called.  Unfortunately, this mechanism has been
> broken by recent changes moving the restoration of config spaces
> of some devices (most importantly, USB controllers and HDA Intel)
> into the resume callbacks executed with interrupts off.  Obviously,
> these callbacks are not invoked in the suspend error path and, as a
> result, the system cannot be successfully brought back into the
> working state in case of a suspend error.  The same thing happens
> in the hibernation error path right before putting the system into
> S4.
>
> Similarly, the suspend testing facility associated with the
> /sys/power/pm_test file is broken, because it uses the very same
> mechanism that is used in the suspend and hibernation error paths.
>
> Fix the breakage by making the PCI core restore the configuration
> spaces of PCI devices that haven't been restored already before
> pci_pm_resume() is called for those devices by the PM core.

Applied to my for-linus branch, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
