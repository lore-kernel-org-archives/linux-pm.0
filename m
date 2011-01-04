From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend hangs at platform phase [was: mmotm
	2010-12-23-16-58 uploaded]
Date: Tue, 4 Jan 2011 23:57:08 +0100
Message-ID: <201101042357.08600.rjw__5171.97741796753$1294181961$gmane$org@sisk.pl>
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
To: Jiri Slaby <jirislaby@gmail.com>
Cc: "Brown, Len" <len.brown@intel.com>, mm-commits@vger.kernel.org, steiner@sgi.com, LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, akpm@linux-foundation.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, January 04, 2011, Jiri Slaby wrote:
> On 01/04/2011 02:40 PM, Jiri Slaby wrote:
> > On 12/24/2010 01:58 AM, akpm@linux-foundation.org wrote:
> >> The mm-of-the-moment snapshot 2010-12-23-16-58 has been uploaded to
> > 
> > Hi, this kernel regresses with respect to suspend to ram in comparison
> > with mmotm 2010-12-16-14-56.
> > 
> > This is OK:
> > echo devices > /sys/power/pm_test
> > pm-suspend
> > This hangs at suspend phase:
> > echo platform > /sys/power/pm_test
> > pm-suspend

Hmm.  So it looks like _PTS hangs?

> > Note that this kernel is based on next-20101221. Should I try newer (and
> > clean) -next?
> 
> Ok, bisected down to:
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
> 
>     Reported-by: Jack Steiner <steiner@sgi.com>
>     Signed-off-by: Len Brown <len.brown@intel.com>
> 
> :040000 040000 be35c5e8f214f10f94688c1a27f33ecfb8505220
> 52581222d0edf190f160f3e5aa5d2c1af8e76988 M      arch
> :040000 040000 ccdca0d41938b8312e946cde3c01c59b32d1c17c
> 96ccf2357f2ac4a31d19cc41f5728d9f87b6cac0 M      drivers
> 
> Revert of that patch fixes the problem.

Can you send a dmesg output and acpidump output from the failing system, please?

Rafael
