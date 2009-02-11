From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: ACPI: S4 disappeared [mmotm 2009-02-10-16-35]
Date: Wed, 11 Feb 2009 11:17:03 +0100
Message-ID: <4992A59F.5090502__18323.4111093499$1234347745$gmane$org@gmail.com>
References: <200902110036.n1B0aBZs013975@imap1.linux-foundation.org>
	<499291A3.9070501@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <499291A3.9070501@gmail.com>
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
Cc: mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Pavel Machek <pavel@suse.cz>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 02/11/2009 09:51 AM, Jiri Slaby wrote:
> On 02/11/2009 01:36 AM, akpm@linux-foundation.org wrote:
>> The mm-of-the-moment snapshot 2009-02-10-16-35 has been uploaded
> 
> Hi,
> 
> I've found out, that S4 disappeared in this release, in comparison to mmotm
> based on 2.6.29-rc2:
> -ACPI: (supports S0 S1 S3 S4 S5)
> +ACPI: (supports S0 S1 S3 S5)
> 
> Any ideas what could have caused this?

I think this one
ARCH_HIBERNATION_POSSIBLE=n
because
SMP=y
since
 config ARCH_HIBERNATION_POSSIBLE
        def_bool y
-       depends on !SMP || !X86_VOYAGER
+       depends on !SMP

The condition was wrong, ok, anyway it worked. Would
depends on !SMP || EXPERIMENTAL
make sense? The smp is handled in disable_nonboot_cpus manner, right?
