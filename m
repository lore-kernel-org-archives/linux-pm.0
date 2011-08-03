From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH 1/5] mrst_pmu: driver for Intel Moorestown
 Power Management Unit
Date: Wed, 03 Aug 2011 16:04:32 -0700
Message-ID: <4E39D400.2080507__47022.0646741383$1312412920$gmane$org@zytor.com>
References: <1312400648-17636-1-git-send-email-lenb@kernel.org>
	<8e24ed2af46a5d008d85bfeb128d25efc394a3fd.1312400543.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <8e24ed2af46a5d008d85bfeb128d25efc394a3fd.1312400543.git.len.brown@intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Len Brown <len.brown@intel.com>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 08/03/2011 12:44 PM, Len Brown wrote:
> From: Len Brown <len.brown@intel.com>
> 
> The Moorestown (MRST) Power Management Unit (PMU) driver
> directs the SOC power states in the "Langwell" south complex (SCU).
> 
> It hooks pci_platform_pm_ops[] and thus observes all PCI ".set_state"
> requests.  For devices in the SC, the pmu driver translates those
> PCI requests into the appropriate commands for the SCU.
> 
> The PMU driver helps implement S0i3, a deep system idle power idle state.
> Entry into S0i3 is via cpuidle, just like regular processor c-states.
> S0i3 depends on pre-conditions including uni-processor, graphics off,
> and certain IO devices in the SC must be off.  If those pre-conditions
> are met, then the PMU allows cpuidle to enter S0i3, otherwise such requests
> are demoted, either to Atom C4 or Atom C6.
> 
> This driver is based on prototype work by Bruce Flemming,
> Illyas Mansoor, Rajeev D. Muralidhar, Vishwesh M. Rudramuni,
> Hari Seshadri and Sujith Thomas.  The current driver also
> includes contributions from H. Peter Anvin, Arjan van de Ven,
> Kristen Accardi, and Yong Wang.
> 
> Thanks for additional review feedback from Alan Cox and Randy Dunlap.
> 
> Signed-off-by: Len Brown <len.brown@intel.com>
> Acked-by: Alan Cox <alan@linux.intel.com>
> ---
>  MAINTAINERS                     |    6 +
>  arch/x86/platform/mrst/Makefile |    1 +
>  arch/x86/platform/mrst/pmu.c    |  817 +++++++++++++++++++++++++++++++++++++++
>  arch/x86/platform/mrst/pmu.h    |  234 +++++++++++
>  4 files changed, 1058 insertions(+), 0 deletions(-)
>  create mode 100644 arch/x86/platform/mrst/pmu.c
>  create mode 100644 arch/x86/platform/mrst/pmu.h
> 

Acked-by: H. Peter Anvin <hpa@linux.intel.com>

	-hpa
