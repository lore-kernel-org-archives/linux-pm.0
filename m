From: "Huang, Ying" <ying.huang@intel.com>
Subject: Re: [PATH 0/1] Kexec jump - v2 - the first step to kexec
	based hibernation
Date: Mon, 06 Aug 2007 10:31:26 +0800
Message-ID: <1186367486.527.5.camel__43029.1678793312$1186415609$gmane$org@caritas-dev.intel.com>
References: <1184483593.1898.98.camel@caritas-dev.intel.com>
	<20070731110458.GA1777@elf.ucw.cz>
	<1185932071.1363.13.camel@caritas-dev.intel.com>
	<20070805185558.GE1758@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070805185558.GE1758@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: david@lang.hm, nigel@nigel.suspend2.net, Kexec Mailing List <kexec@lists.infradead.org>, linux-kernel@vger.kernel.org, "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.linux-foundation.org, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Sun, 2007-08-05 at 20:55 +0200, Pavel Machek wrote:
> Did the trick, I got the kernel to load, and it even attempted
> exec... but I got doublefault (or what is it?)
> 
> Int 6: ... EIP: c4739906. Address is in reserve_bootmem_core.
> 
> Do I have to disable ACPI completely? I tried with acpi=off,
> nosmp... but problem does not seem device related.

It seems that the problem has nothing to do with device or ACPI. Can you
do a normal kexec? That is:

kexec -l <...>
kexec -e

or 

kexec -p <...>
ALT-SysRq-c to trigger a crash dump.

Best Regards,
Huang Ying
