From: Jike Song <albcamus@gmail.com>
Subject: Re: [PATCH 2/8] PCI / PCIe/ AER: Introduce
	pci_aer_available()
Date: Tue, 3 Aug 2010 17:41:38 +0800
Message-ID: <AANLkTimZV8KSkAR5Tc0nDK=TmzX1edKiJ9qSSgZ8v0h9__45315.453495323$1280828641$gmane$org@mail.gmail.com>
References: <201008022351.31406.rjw@sisk.pl> <201008022354.46369.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201008022354.46369.rjw@sisk.pl>
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
Cc: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>, linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Aug 3, 2010 at 5:54 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Introduce a function allowing the caller to check if PCIe AER should
> be enabled.
>

Maybe it's misnamed?  How about pcie_aer_disable is not set and MSI is
enabled, but there is not AER capability implemented at all?

-- 
Thanks,
Jike
