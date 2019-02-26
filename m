From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 07/14] powercap/intel_rapl: Simplify rapl_find_package()
Date: Tue, 26 Feb 2019 20:06:58 +0100
Message-ID: <20190226190658.GS2861@worktop.programming.kicks-ass.net>
References: <e2810a5317d3a109a98204e883fd1461f77b9339.1551160674.git.len.brown@intel.com>
 <4dd94a34999d6db4ced7a0759c02f7cd93729dc4.1551160674.git.len.brown@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <4dd94a34999d6db4ced7a0759c02f7cd93729dc4.1551160674.git.len.brown@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, Zhang Rui <rui.zhang@intel.com>, Len Brown <len.brown@intel.com>, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 26, 2019 at 01:20:05AM -0500, Len Brown wrote:
> -static struct rapl_package *find_package_by_id(int id)
> +static struct rapl_package *rapl_find_package(int cpu)
>  {
> +	int id = topology_physical_package_id(cpu);
>  	struct rapl_package *rp;

Which you'll change to topology_physical_die_id() in the next patch.

If you respin the series again, could we pick a better name?
