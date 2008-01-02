From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [patch] hibernation: utilize ACPI hardware signature
Date: Wed, 2 Jan 2008 09:37:13 +0200
Message-ID: <200801020937.13808.maximlevitsky__27461.3312133171$1199259514$gmane$org@gmail.com>
References: <1199257162.14632.4.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1199257162.14632.4.camel@sli10-desk.sh.intel.com>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux acpi <linux-acpi@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 2 January 2008 08:59:22 Shaohua Li wrote:
> ACPI defines a hardware signature. BIOS calculates the signature
> according to hardware configure, if hardware changes, the signature will
> change, in this case, S4 resume should fail.
> 
> Signed-off-by: Shaohua Li <shaohua.li@intel.com>
> ---
>  drivers/acpi/sleep/main.c |   13 +++++++++++++
>  include/linux/suspend.h   |    5 +++++
>  kernel/power/disk.c       |   21 ++++++++++++++++++---
>  kernel/power/power.h      |    6 +++---
>  kernel/power/swap.c       |   24 +++++++++++++++---------
>  5 files changed, 54 insertions(+), 15 deletions(-)

Once reading the ACPI spec I noticed that ACPI supports this feature
so it is qute nice to implement it, since this will prevent resume from disk what hardware was changed.

But.. how many bioses are broken regarding this feature....

Regards,
	Maxim Levitsky
