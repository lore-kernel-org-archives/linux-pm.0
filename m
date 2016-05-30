From: Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: Re: [PATCH] tools/power: turbostat: Allocate correct amount of fd
 and irq entries
Date: Mon, 30 May 2016 13:53:23 +0300
Message-ID: <20160530105323.GA21280@lahna.fi.intel.com>
References: <1461312803-45678-1-git-send-email-mika.westerberg@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga03.intel.com ([134.134.136.65]:51826 "EHLO mga03.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932065AbcE3Kxp (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Mon, 30 May 2016 06:53:45 -0400
Content-Disposition: inline
In-Reply-To: <1461312803-45678-1-git-send-email-mika.westerberg@linux.intel.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: Len Brown <len.brown@intel.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-pm@vger.kernel.org

Ping?

On Fri, Apr 22, 2016 at 11:13:23AM +0300, Mika Westerberg wrote:
> The tool uses topo.max_cpu_num to determine number of entries needed for
> fd_percpu[] and irqs_per_cpu[]. For example on a system with 4 CPUs
> topo.max_cpu_num is 3 so we get too small array for holding per-CPU items.
> 
> Fix this to use right number of entries, which is topo.max_cpu_num + 1.
> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  tools/power/x86/turbostat/turbostat.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/power/x86/turbostat/turbostat.c b/tools/power/x86/turbostat/turbostat.c
> index acbf7ff2ee6e..fb70a6ce3e52 100644
> --- a/tools/power/x86/turbostat/turbostat.c
> +++ b/tools/power/x86/turbostat/turbostat.c
> @@ -1638,7 +1638,7 @@ void free_fd_percpu(void)
>  {
>  	int i;
>  
> -	for (i = 0; i < topo.max_cpu_num; ++i) {
> +	for (i = 0; i < topo.max_cpu_num + 1; ++i) {
>  		if (fd_percpu[i] != 0)
>  			close(fd_percpu[i]);
>  	}
> @@ -3598,7 +3598,7 @@ void allocate_output_buffer()
>  }
>  void allocate_fd_percpu(void)
>  {
> -	fd_percpu = calloc(topo.max_cpu_num, sizeof(int));
> +	fd_percpu = calloc(topo.max_cpu_num + 1, sizeof(int));
>  	if (fd_percpu == NULL)
>  		err(-1, "calloc fd_percpu");
>  }
> @@ -3608,9 +3608,9 @@ void allocate_irq_buffers(void)
>  	if (irq_column_2_cpu == NULL)
>  		err(-1, "calloc %d", topo.num_cpus);
>  
> -	irqs_per_cpu = calloc(topo.max_cpu_num, sizeof(int));
> +	irqs_per_cpu = calloc(topo.max_cpu_num + 1, sizeof(int));
>  	if (irqs_per_cpu == NULL)
> -		err(-1, "calloc %d", topo.max_cpu_num);
> +		err(-1, "calloc %d", topo.max_cpu_num + 1);
>  }
>  void setup_all_buffers(void)
>  {
> -- 
> 2.8.0.rc3
