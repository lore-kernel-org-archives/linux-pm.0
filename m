From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 2/8] PCI / PCIe/ AER: Introduce
	pci_aer_available()
Date: Tue, 3 Aug 2010 21:50:28 +0200
Message-ID: <201008032150.28626.rjw__39144.2111380913$1280865445$gmane$org@sisk.pl>
References: <201008022351.31406.rjw@sisk.pl> <201008022354.46369.rjw@sisk.pl>
	<AANLkTimZV8KSkAR5Tc0nDK=TmzX1edKiJ9qSSgZ8v0h9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTimZV8KSkAR5Tc0nDK=TmzX1edKiJ9qSSgZ8v0h9@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Jike Song <albcamus@gmail.com>
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, August 03, 2010, Jike Song wrote:
> On Tue, Aug 3, 2010 at 5:54 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > Introduce a function allowing the caller to check if PCIe AER should
> > be enabled.
> >
> 
> Maybe it's misnamed?  How about pcie_aer_disable is not set and MSI is
> enabled, but there is not AER capability implemented at all?

The BIOS is supposed to tell us about that or we will find out from the
registers contents.  This function tells us whether to _try_ to enable AER
(ie. ask the BIOS and so on).

Thanks,
Rafael
