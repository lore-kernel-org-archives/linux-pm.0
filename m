From: Len Brown <lenb@kernel.org>
Subject: Re: turbostat-17.06.23 floating point exception
Date: Fri, 12 Oct 2018 19:03:41 -0400
Message-ID: <CAJvTdKmQUomRnZnPD3O0-Wq0Tp+9PKewBEqQnn4OUg=0Fpzh5w@mail.gmail.com>
References: <20181012182630.GA13352@ssarabia-MOBL7.amr.corp.intel.com> <20181012222743.GA14100@ssarabia-MOBL7.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181012222743.GA14100@ssarabia-MOBL7.amr.corp.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: solio.sarabia@intel.com
Cc: linux-kernel@vger.kernel.org, Linux PM list <linux-pm@vger.kernel.org>, "Brown, Len" <len.brown@intel.com>, shiny.sebastian@intel.com
List-Id: linux-pm@vger.kernel.org

> Why would the cpu topology report 0 cpus?  I added a debug entry to
> cpu_usage_stat and /proc/stat showed it as an extra column.  Then
> fscanf parsing in for_all_cpus() failed, causing the SIGFPE.
>
> This is not an issue. Thanks.

Yes, it is true that turbostat doesn't check for systems with 0 cpus.
I'm curious how you provoked the kernel to claim that.  If it is
something others might do, we can have check for it and gracefully
exit.

thanks,
-Len




-- 
Len Brown, Intel Open Source Technology Center
