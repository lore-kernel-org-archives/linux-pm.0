From: "Alexander Beregalov" <a.beregalov@gmail.com>
Subject: Re: next-0708: build failure at drivers/pci/pci-acpi.c
Date: Tue, 8 Jul 2008 20:29:55 +0400
Message-ID: <a4423d670807080929t3254393jc501e703d6ffb26e__42460.7292902239$1215534840$gmane$org@mail.gmail.com>
References: <a4423d670807080518g31402f60j2f624a2ac2db03aa@mail.gmail.com>
	<200807081712.23937.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200807081712.23937.rjw@sisk.pl>
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
Cc: ak@linux.intel.com, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, jbarnes@virtuousgeek.org, linux-acpi@vger.kernel.org, linux-next@vger.kernel.org, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

2008/7/8 Rafael J. Wysocki <rjw@sisk.pl>:
> On Tuesday, 8 of July 2008, Alexander Beregalov wrote:
>> Hi Rafael
>>
>> drivers/pci/pci-acpi.c: In function 'acpi_pci_sleep_wake':
>> drivers/pci/pci-acpi.c:311: error: implicit declaration of function
>> 'acpi_pm_device_sleep_wake'
>
> I guess this is a compilation with CONFIG_ACPI=y and CONFIG_PM_SLEEP unset.
Indeed.
>
> In that case the appended patch should help.  Please test and report back (I
> can't test linux-next compilation at the moment).

Compilation test passed and the kernel can boot.
