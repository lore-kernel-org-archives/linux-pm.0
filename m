From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: ACPI: S4 disappeared [mmotm 2009-02-10-16-35]
Date: Wed, 11 Feb 2009 16:43:09 +0100
Message-ID: <200902111643.10191.rjw__41073.1030432091$1234367192$gmane$org@sisk.pl>
References: <200902110036.n1B0aBZs013975@imap1.linux-foundation.org>
	<499291A3.9070501@gmail.com> <4992A59F.5090502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4992A59F.5090502@gmail.com>
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
To: Jiri Slaby <jirislaby@gmail.com>
Cc: mm-commits@vger.kernel.org, linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Pavel Machek <pavel@suse.cz>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Wednesday 11 February 2009, Jiri Slaby wrote:
> On 02/11/2009 09:51 AM, Jiri Slaby wrote:
> > On 02/11/2009 01:36 AM, akpm@linux-foundation.org wrote:
> >> The mm-of-the-moment snapshot 2009-02-10-16-35 has been uploaded
> > 
> > Hi,
> > 
> > I've found out, that S4 disappeared in this release, in comparison to mmotm
> > based on 2.6.29-rc2:
> > -ACPI: (supports S0 S1 S3 S4 S5)
> > +ACPI: (supports S0 S1 S3 S5)
> > 
> > Any ideas what could have caused this?
> 
> I think this one
> ARCH_HIBERNATION_POSSIBLE=n
> because
> SMP=y
> since
>  config ARCH_HIBERNATION_POSSIBLE
>         def_bool y
> -       depends on !SMP || !X86_VOYAGER
> +       depends on !SMP
> 
> The condition was wrong, ok, anyway it worked. Would
> depends on !SMP || EXPERIMENTAL
> make sense? The smp is handled in disable_nonboot_cpus manner, right?

Ah, someone removed X86_VOYAGER and left this gem.  I guess that went in
through -tip (Ingo CCed).

After removing X86_VOYAGER, ARCH_HIBERNATION_POSSIBLE should always be set
on x86.  Just make it

config ARCH_HIBERNATION_POSSIBLE
         def_bool y

Thanks,
Rafael
