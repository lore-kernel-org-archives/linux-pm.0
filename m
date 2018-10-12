From: Solio Sarabia <solio.sarabia@intel.com>
Subject: Re: turbostat-17.06.23 floating point exception
Date: Fri, 12 Oct 2018 15:27:44 -0700
Message-ID: <20181012222743.GA14100@ssarabia-MOBL7.amr.corp.intel.com>
References: <20181012182630.GA13352@ssarabia-MOBL7.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181012182630.GA13352@ssarabia-MOBL7.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, len.brown@intel.com
Cc: solio.sarabia@intel.com, shiny.sebastian@intel.com
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 12, 2018 at 11:26:30AM -0700, Solio Sarabia wrote:
> Hi --
> 
> turbostat 17.06.23 is throwing an exception on a custom linux-4.16.12
> kernel, on Xeon E5-2699 v4 Broadwell EP, 2S, 22C/S, 44C total, HT off,
> VTx off.
> 
> Initially the system had 4.4.0-137. Then I built and installed
> linux-4.16.12-default.  turbostat works fine for these two versions.
> After building linux-4.16.12 for a second time, the older kernel is
> renamed and now `ls -l /boot/` (I'm using version without .old suffix):
> 
> 	vmlinuz-4.16.12-default+
> 	vmlinuz-4.16.12-default+.old
> 
> grep -i 'turbostat' /var/log/kern.log
> 
> kernel: [  159.140836] capability: warning: `turbostat' uses 32-bit
> 	capabilities (legacy support in use)
> kernel: [  164.149264] traps: turbostat[1801] trap divide error
> 	ip:407625 sp:7ffe4b0df000 error:0 in turbostat[400000+17000]
> 
> (gdb)
> cpu22: MSR_PKGC3_IRTL: 0x00000000 (NOTvalid, 0 ns)
> cpu22: MSR_PKGC6_IRTL: 0x00000000 (NOTvalid, 0 ns)
> cpu22: MSR_PKGC7_IRTL: 0x00000000 (NOTvalid, 0 ns)
> 
> Program received signal SIGFPE, Arithmetic exception.
> 0x0000000000407625 in compute_average (t=0x61a3b0, c=0x61a3d0, p=0x61a480) at turbostat.c:1378
> 1378            average.threads.tsc /= topo.num_cpus;
> 
Why would the cpu topology report 0 cpus?  I added a debug entry to
cpu_usage_stat and /proc/stat showed it as an extra column.  Then
fscanf parsing in for_all_cpus() failed, causing the SIGFPE.

This is not an issue. Thanks.

> Let me know if you need more details.
> 
> Thanks,
> -SS
