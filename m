From: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Subject: Re: [RFC][PATCH] PCI / PCIe: Ask BIOS for control of all
 native services simultaneously
Date: Wed, 28 Jul 2010 12:39:15 +0900
Message-ID: <4C4FA663.9090204__40555.2264805467$1280329062$gmane$org@jp.fujitsu.com>
References: <201007250105.23610.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201007250105.23610.rjw@sisk.pl>
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
Cc: linux-pci@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Matthew Garrett <mjg@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi,

(2010/07/25 8:05), Rafael J. Wysocki wrote:
> It turns out that asking ACPI BIOS, through _OSC, for control of each
> PCIe port native service individually sometimes confuses the BIOS if
> one sevice is requested while the others are not (eg. requesting
> control of the native PCIe PME without requesting control of the
> native PCIe hot-plug at the same time leads to interrupt storms on
> some systems).

Then why not invent quirks or something for such systems?

IMHO it sounds like a BIOS bug since it should grant PME control to
OS only when both of PME and pciehp (plus PCIe caps) are requested
at same time.

Did you confirm that the system also confuses when pciehp is requested
without requesting PME?
e.g. assume that some BIOS might behave:
  _OSC(pciehp)         =>  OK
  _OSC(PME)            =>  NG (bugs on shared interrupt?)
  _OSC(pciehp|PME)     =>  OK
  _OSC(SHPC)           =>  OK
  _OSC(pciehp|SHPC)    =>  NG (must choose one, not both)
  _OSC(AER|SHPC)       =>  OK

I don't doubt that handling of _OSC needs some improvement...


Thanks,
H.Seto
