From: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
Subject: Re: [PATCH] tools/power/x86/intel_pstate_tracer: Fix non root
 execution for post processing a trace file.
Date: Wed, 19 Dec 2018 08:55:00 -0800
Message-ID: <1159108890c3350e9478833f7564e0400b5c887e.camel@linux.intel.com>
References: <1545118444-5008-1-git-send-email-dsmythies@telus.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1545118444-5008-1-git-send-email-dsmythies@telus.net>
Sender: linux-kernel-owner@vger.kernel.org
To: Doug Smythies <doug.smythies@gmail.com>, rjw@rjwysocki.net
Cc: dsmythies@telus.net, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2018-12-17 at 23:34 -0800, Doug Smythies wrote:
> This script is supposed to be allowed to run with regular user
> privileges
> if a previously captured trace is being post processed.
> 
> Commit fbe313884d7ddd73ce457473cbdf3763f5b1d3da
> tools/power/x86/intel_pstate_tracer: Free the trace buffer memory
> introduced a bug that breaks that option.
> 
> Commit 35459105deb26430653a7299a86bc66fb4dd5773
> tools/power/x86/intel_pstate_tracer: Add optional setting of trace
> buffer memory allocation
> moved the code but kept the bug.
> 
> This patch fixes the issue.
> 
> Signed-off-by: Doug Smythies <dsmythies@telus.net>
Acked-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

> ---
>  tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git
> a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> index 84e2b64..2fa3c57 100755
> --- a/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> +++ b/tools/power/x86/intel_pstate_tracer/intel_pstate_tracer.py
> @@ -585,9 +585,9 @@ current_max_cpu = 0
>  
>  read_trace_data(filename)
>  
> -clear_trace_file()
> -# Free the memory
>  if interval:
> +    clear_trace_file()
> +    # Free the memory
>      free_trace_buffer()
>  
>  if graph_data_present == False:
