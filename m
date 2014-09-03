From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 2/3] smp: Adding new function wake_up_all_cpus()
Date: Wed, 3 Sep 2014 11:52:51 +0200
Message-ID: <20140903095251.GI4783@worktop.ger.corp.intel.com>
References: <1408351052-25075-1-git-send-email-chuansheng.liu@intel.com>
 <1408351052-25075-2-git-send-email-chuansheng.liu@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1408351052-25075-2-git-send-email-chuansheng.liu@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chuansheng Liu <chuansheng.liu@intel.com>
Cc: luto@amacapital.net, daniel.lezcano@linaro.org, rjw@rjwysocki.net, mingo@redhat.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, changcheng.liu@intel.com, xiaoming.wang@intel.com, souvik.k.chakravarty@intel.com
List-Id: linux-pm@vger.kernel.org

On Mon, Aug 18, 2014 at 04:37:31PM +0800, Chuansheng Liu wrote:
> Currently kick_all_cpus_sync() can break non-polling idle cpus
> thru IPI interrupts.
> 
> But sometimes we need to break the polling idle cpus immediately
> to reselect the suitable c-state, also for non-idle cpus, we need
> to do nothing if we try to wake up them.
> 
> Here adding one new function wake_up_all_cpus() to let all cpus out
> of idle based on function wake_up_if_idle().

wake_up_all_idle_cpus() ?
