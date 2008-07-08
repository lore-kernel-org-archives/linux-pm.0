From: Jesse Barnes <jbarnes@virtuousgeek.org>
Subject: Re: next-0708: build failure at drivers/pci/pci-acpi.c
Date: Tue, 8 Jul 2008 10:40:38 -0700
Message-ID: <200807081040.38777.jbarnes__45628.5745757215$1215538999$gmane$org@virtuousgeek.org>
References: <a4423d670807080518g31402f60j2f624a2ac2db03aa@mail.gmail.com>
	<a4423d670807080929t3254393jc501e703d6ffb26e@mail.gmail.com>
	<200807081858.16321.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807081858.16321.rjw@sisk.pl>
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
Cc: ak@linux.intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Howells <dhowells@redhat.com>, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>, Alexander Beregalov <a.beregalov@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tuesday, July 08, 2008 9:58 am Rafael J. Wysocki wrote:
> On Tuesday, 8 of July 2008, Alexander Beregalov wrote:
> > 2008/7/8 Rafael J. Wysocki <rjw@sisk.pl>:
> > > On Tuesday, 8 of July 2008, Alexander Beregalov wrote:
> > >> Hi Rafael
> > >>
> > >> drivers/pci/pci-acpi.c: In function 'acpi_pci_sleep_wake':
> > >> drivers/pci/pci-acpi.c:311: error: implicit declaration of function
> > >> 'acpi_pm_device_sleep_wake'
> > >
> > > I guess this is a compilation with CONFIG_ACPI=y and CONFIG_PM_SLEEP
> > > unset.
> >
> > Indeed.
> >
> > > In that case the appended patch should help.  Please test and report
> > > back (I can't test linux-next compilation at the moment).
> >
> > Compilation test passed and the kernel can boot.
>
> Thanks!
>
> Jesse, could you please apply the patch below to the linux-next branch, on
> top of the PCI wake-up patchset?
>
> Rafael

David sent me one just like this at 7am this morning, just applied and pushed 
(along with Alexander's tested-by).

Thanks,
Jesse
