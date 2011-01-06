From: Jiri Slaby <jirislaby@gmail.com>
Subject: ia64 build broken [was: mmotm 2010-12-23-16-58 uploaded]
Date: Thu, 06 Jan 2011 09:27:05 +0100
Message-ID: <4D257CD9.8060909__7522.71912429041$1294302581$gmane$org@gmail.com>
References: <201012240132.oBO1W8Ub022207@imap1.linux-foundation.org>
	<4D232352.2030809@gmail.com> <4D234F8E.7080102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4D234F8E.7080102@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Brown, Len" <len.brown@intel.com>
Cc: mm-commits@vger.kernel.org, steiner@sgi.com, LKML <linux-kernel@vger.kernel.org>, akpm@linux-foundation.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 01/04/2011 05:49 PM, Jiri Slaby wrote:
> 16dc39c98a6ca56a27f22f7ac6731d8223237a2e is first bad commit
> commit 16dc39c98a6ca56a27f22f7ac6731d8223237a2e
> Author: Len Brown <len.brown@intel.com>
> Date:   Thu Dec 16 23:12:23 2010 -0500
> 
>     ACPI: use ioremap_cache()
> 
>     Although the temporary boot-time ACPI table mappings
>     were set up with CPU caching enabled, the permanent table
>     mappings and AML run-time region memory accesses were
>     set up with ioremap(), which on x86 is a synonym for
>     ioremap_nocache().
> 
>     Changing this to ioremap_cache() improves performance as
>     seen when accessing the tables via acpidump,
>     or /sys/firmware/acpi/tables.  It should also improve
>     AML run-time performance.
> 
>     No change on ia64.

BTW I've just noted, you actually broke ia64. The code reads like:
   return ioremap(unsigned long phys_addr, unsigned long size);

regards,
-- 
js
