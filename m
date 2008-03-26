From: Len Brown <lenb@kernel.org>
Subject: ISA -> ISA_ (Re: [GIT PATCH] ACPI patches for 2.6.25-rc6)
Date: Wed, 26 Mar 2008 11:32:20 -0400
Message-ID: <200803261132.21448.lenb__10670.3297621154$1206546226$gmane$org@kernel.org>
References: <200803180510.47670.lenb@kernel.org>
	<20080326081653.GA8247@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080326081653.GA8247@elte.hu>
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
To: Ingo Molnar <mingo@elte.hu>, Corentin CHARY <corentincj@iksaif.net>
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Bjorn Helgaas <bjorn.helgaas@hp.com>
List-Id: linux-pm@vger.kernel.org


> btw., saw this ACPI-ish commit in rc7:
> 
> | commit b97d4803400a4442b0e4ae14d0bd8e83994b9004
> | Author: Bjorn Helgaas <bjorn.helgaas@hp.com>
> | Date:   Tue Mar 25 11:21:11 2008 -0600
> |
> |    ACPI: fix Medion _PRT quirk (use "ISA_", not "ISA")
> 
> a grep shows that we've got one other case of an "ISA" string in the 
> ACPI code - is the patch below needed too?
> 
> 	Ingo
> 
> -------------------->
> Subject: acpi: fix asus isa
> From: Ingo Molnar <mingo@elte.hu>
> Date: Wed Mar 26 09:05:07 CET 2008
> 
> Signed-off-by: Ingo Molnar <mingo@elte.hu>
> ---
>  drivers/acpi/asus_acpi.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-x86.q/drivers/acpi/asus_acpi.c
> ===================================================================
> --- linux-x86.q.orig/drivers/acpi/asus_acpi.c
> +++ linux-x86.q/drivers/acpi/asus_acpi.c
> @@ -149,7 +149,7 @@ struct asus_hotk {
>  };
>  
>  /* Here we go */
> -#define A1x_PREFIX "\\_SB.PCI0.ISA.EC0."
> +#define A1x_PREFIX "\\_SB.PCI0.ISA_.EC0."

>From an AML point of view, ISA is just as legal as "ISA_"
The NameString paramter to Device() can be 1 to 4 characters.

So if this is correct or not depends on what the BIOS programmer
for the Asus A1x choose to write.  Perhaps Corentin 'Iksaif' CHARY
can confirm if the driver is working properly on that system.

-Len

>  #define L3C_PREFIX "\\_SB.PCI0.PX40.ECD0."
>  #define M1A_PREFIX "\\_SB.PCI0.PX40.EC0."
>  #define P30_PREFIX "\\_SB.PCI0.LPCB.EC0."
> 
