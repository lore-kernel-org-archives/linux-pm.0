From: Solio Sarabia <solio.sarabia@intel.com>
Subject: Re: turbostat-17.06.23 floating point exception
Date: Thu, 18 Oct 2018 18:27:52 -0700
Message-ID: <20181019012751.GA11600@ssarabia-MOBL7.amr.corp.intel.com>
References: <20181012182630.GA13352@ssarabia-MOBL7.amr.corp.intel.com>
 <20181012222743.GA14100@ssarabia-MOBL7.amr.corp.intel.com>
 <CAJvTdKmQUomRnZnPD3O0-Wq0Tp+9PKewBEqQnn4OUg=0Fpzh5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAJvTdKmQUomRnZnPD3O0-Wq0Tp+9PKewBEqQnn4OUg=0Fpzh5w@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, shiny.sebastian@intel.com
List-Id: linux-pm@vger.kernel.org

On Fri, Oct 12, 2018 at 07:03:41PM -0400, Len Brown wrote:
> > Why would the cpu topology report 0 cpus?  I added a debug entry to
> > cpu_usage_stat and /proc/stat showed it as an extra column.  Then
> > fscanf parsing in for_all_cpus() failed, causing the SIGFPE.
> >
> > This is not an issue. Thanks.
> 
> Yes, it is true that turbostat doesn't check for systems with 0 cpus.
> I'm curious how you provoked the kernel to claim that.  If it is
> something others might do, we can have check for it and gracefully
> exit.

source/tools/power/x86/turbostat/turbostat.c
int for_all_proc_cpus(int (func)(int))
{
    retval = fscanf(fp, "cpu %*d %*d %*d %*d %*d %*d %*d %*d %*d %*d\n");
    ^
    This fails due to an extra debug entry in /proc/stat
    (total of 11 columns).  I was measuring time in a hot
    function and decided to add this time in an extra
    cpu_usage_stat. This was an experiment though.

Thanks,
-S.
