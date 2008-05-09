From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: [PATCH 2/2] PCI PM: Introduce pci_preferred_state
Date: Fri, 9 May 2008 10:37:23 -0700
Message-ID: <200805091037.23767.jbarnes__12793.4549157091$1210354889$gmane$org@virtuousgeek.org>
References: <Pine.LNX.4.44L0.0805071139020.3701-100000@iolanthe.rowland.org>
	<200805091024.53027.jbarnes@virtuousgeek.org>
	<200805091934.41341.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805091934.41341.rjw@sisk.pl>
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
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@suse.cz>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Friday, May 09, 2008 10:34 am Rafael J. Wysocki wrote:
> > So in this case pci_choose_state would either change state or leave it
> > untouched if it didn't have a better idea about things.  But now that I
> > look at it I'm not sure it's an improvement. :)
>
> Well, in principle we could go farther and introduce a wrapper around
> pci_set_power_state() that will call platform_pci_choose_state() to obtain
> the new state or use the driver-provided one if that fails.

Hm, yeah that sounds pretty reasonable actually.  Especially given that so 
many drivers just do:
  pci_set_power_state(pdev, pci_choose_state(pdev, state));
anyway...

Jesse
