From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] Cpuidle drivers,
	Suspend : Fix suspend/resume hang with intel_idle driver
Date: Sat, 30 Jun 2012 00:13:42 +0200
Message-ID: <201206300013.42974.rjw@sisk.pl>
References: <4FEC20D2.2070501@linux.vnet.ibm.com>
	<4FED3CA0.3050909@linux.vnet.ibm.com>
	<4FED6CED.2060908@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4FED6CED.2060908@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: preeti <preeti@linux.vnet.ibm.com>
Cc: Linux PM mailing list <linux-pm@vger.kernel.org>, Dave Hansen <dave@linux.vnet.ibm.com>, linux-acpi@vger.kernel.org, "Srivatsa.S.Bhat" <srivatsa.bhat@linux.vnet.ibm.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Friday, June 29, 2012, preeti wrote:
> 
> From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> 
> Dave Hansen reported problems with suspend/resume when used
> with intel_idle driver.More such problems were noticed.
> https://bugs.launchpad.net/ubuntu/+source/linux/+bug/674075.
> 
> The reason for this could not be suspected till he reported
> resume hang issue when used with acpi idle driver on his Lenovo-S10-3
> Atom netbook.
> 
> The patch-[PM / ACPI: Fix suspend/resume regression caused by cpuidle
> cleanup],fixed this issue by ensuring that acpi idle drivers prevent
> cpus from going into deeper sleep states during suspend to prevent
> resume hang on certain bios.
> http://marc.info/?l=linux-pm&m=133958534231884&w=2
> 
> Commit b04e7bdb984e3b7f62fb7f44146a529f88cc7639
> (ACPI: disable lower idle C-states across suspend/resume) throws
> light on the resume hang issue on certain specific bios.
> 
> Also the following lines in drivers/idle/intel_idle.c suggest intel_idle
> drivers should also ensure cpus are prevented from entering idle states
> during suspend to avoid a resume hang.
> 
> /*
>  * Known limitations
>  * [..]
>  *
>  * ACPI has a .suspend hack to turn off deep c-states during suspend
>  * to avoid complications with the lapic timer workaround.
>  * Have not seen issues with suspend, but may need same workaround here.
>  *
>  */
> This patch aims at having this fix in a place common to both the idle
> drivers.
> 
> Suspend is enabled only if ACPI is active on x86.Thus the setting of
> acpi_idle_suspend during suspend is moved up to ACPI specific code with
> both acpi and intel idle drivers checking if it is valid to enter deeper
> idle states.The setting of acpi_idle_suspend is done via PM_SUSPEND_PREPARE
> notifiers to avoid race conditions between processors entering idle states
> and the ongoing process of suspend.
> 
> The check on acpi_idle_suspend is included in the most appropriate header
> so as to be visible to both the idle drivers irrespective of the
> different configurations.Even if ACPI is disabled intel idle drivers can
> still carry out the acpi_idle_suspend check.
> 
> Reported-by: Dave Hansen <dave@linux.vnet.ibm.com>
> Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> Reviewed-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>

The patch didn't get any better as a result of modifying the changelog.

Please consider it as rejected.

Thanks,
Rafael
