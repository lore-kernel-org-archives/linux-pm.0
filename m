From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/7] ACPI / PCI: Make acpi_pci_run_osc() use
	capbuf to return the result
Date: Mon, 2 Aug 2010 16:12:36 +0200
Message-ID: <201008021612.36221.rjw__14606.3804314055$1280758503$gmane$org@sisk.pl>
References: <201007310020.56546.rjw@sisk.pl> <201007310024.10174.rjw@sisk.pl>
	<4C568CD5.6000801@jp.fujitsu.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4C568CD5.6000801@jp.fujitsu.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Hidetoshi Seto <seto.hidetoshi@jp.fujitsu.com>
Cc: linux-pci@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Kenji Kaneshige <kaneshige.kenji@jp.fujitsu.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Monday, August 02, 2010, Hidetoshi Seto wrote:
> (2010/07/31 7:24), Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> > 
> > There is no reason why acpi_pci_run_osc() should use a separate
> > argument to return the _OSC result, since there is a place for it
> > in the buffer passed via capbuf, as none of the callers needs to
> > preserve the original contents of that buffer, so drop the third
> > argument of acpi_pci_run_osc() and modify the callers accordingly.
> > 
> > Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> > ---
> 
> I think this change is not significant for later patches.
> Can we skip?

Yes, we can, but that's going to make the next patches slightly less readable.

Thanks,
Rafael
