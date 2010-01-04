From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH] PCI / PM: Use per-device D3 delays
Date: Mon, 4 Jan 2010 15:48:07 -0800
Message-ID: <20100104154807.295bee59__22958.8717026219$1262649036$gmane$org@jbarnes-piketon>
References: <200912311215.54412.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200912311215.54412.rjw@sisk.pl>
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
Cc: Linux PCI <linux-pci@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Stephen Hemminger <shemminger@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, "Maciej J. Woloszyk" <mat@esi.com.pl>
List-Id: linux-pm@vger.kernel.org

On Thu, 31 Dec 2009 12:15:54 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> It turns out that some PCI devices require extra delays when changing
> power state from D3 to D0 (and the other way around).  Although this
> is against the PCI specification, we can handle it quite easily by
> allowing drivers to define arbitrary D3 delays for devices known to
> require extra time for switching power states.
> 
> Introduce additional field d3_delay in struct pci_dev and use it to
> store the value of the device's D0->D3 delay, in miliseconds.  Make
> the PCI PM core code use the per-device d3_delay unless
> pci_pm_d3_delay is greater (in which case the latter is used).
> [This also allows the driver to specify d3_delay shorter than the
>  10 ms required by the PCI standard if the device is known to be able
>  to handle that.]
> 
> Make the sky2 driver set d3_delay to 150 for devices handled by it.
> 
> Fixes http://bugzilla.kernel.org/show_bug.cgi?id=14730 which is a
> listed regression from 2.6.30.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Applied to my for-linus branch, thanks.

-- 
Jesse Barnes, Intel Open Source Technology Center
