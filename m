From: Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [Resend][PATCH] tracing / PM: Replace CONFIG_PM_RUNTIME with
 CONFIG_PM
Date: Fri, 12 Dec 2014 20:18:27 -0500
Message-ID: <1418433507.3683.0.camel@goodmis.org>
References: <1729515.GUkTny2h5Y@vostro.rjw.lan>
	 <2199353.4ffnTtchId@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <2199353.4ffnTtchId@vostro.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Ingo Molnar <mingo@redhat.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM list <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sat, 2014-12-13 at 02:34 +0100, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> After commit b2b49ccbdd54 (PM: Kconfig: Set PM_RUNTIME if PM_SLEEP is
> selected) PM_RUNTIME is always set if PM is set, so files that are
> build conditionally if CONFIG_PM_RUNTIME is set may now be build
> if CONFIG_PM is set.
> 
> Replace CONFIG_PM_RUNTIME with CONFIG_PM in kernel/trace/Makefile
> for this reason.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
> 
> Please let me know if there are any objections against this.  If not, I'll
> take it through the linux-pm tree, as I'm going to remove CONFIG_PM_RUNTIME
> entirely shortly.

Feel free to take it.

Acked-by: Steven Rostedt <rostedt@goodmis.org.

-- Steve

> 
> ---
>  kernel/trace/Makefile |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Index: linux-pm/kernel/trace/Makefile
> ===================================================================
> --- linux-pm.orig/kernel/trace/Makefile
> +++ linux-pm/kernel/trace/Makefile
> @@ -55,7 +55,7 @@ obj-$(CONFIG_EVENT_TRACING) += trace_eve
>  obj-$(CONFIG_EVENT_TRACING) += trace_events_trigger.o
>  obj-$(CONFIG_KPROBE_EVENT) += trace_kprobe.o
>  obj-$(CONFIG_TRACEPOINTS) += power-traces.o
> -ifeq ($(CONFIG_PM_RUNTIME),y)
> +ifeq ($(CONFIG_PM),y)
>  obj-$(CONFIG_TRACEPOINTS) += rpm-traces.o
>  endif
>  ifeq ($(CONFIG_TRACING),y)
