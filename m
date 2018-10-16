From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: conservative: Take limits changes into account
 properly
Date: Tue, 16 Oct 2018 15:22:25 +0530
Message-ID: <20181016095225.snxu3dafz4x3w7ch@vireshk-i7>
References: <20181008150901.19667-1-waldemar.rymarkiewicz@gmail.com>
 <CAHKzcEOECQP8j6q=NKzuEjF+mc0s80fr6xWw-=NXsTtzCGGg_w@mail.gmail.com>
 <CAJZ5v0gFjBoFi=cpC2gPkZTDZof8dxdCCVx0XoAv2XuPmTfWPA@mail.gmail.com>
 <5406371.vuaACy5i7F@aspire.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <5406371.vuaACy5i7F@aspire.rjw.lan>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Linux PM <linux-pm@vger.kernel.org>, Waldemar Rymarkiewicz <waldemar.rymarkiewicz@gmail.com>, Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, t.bartholomae@intel.com
List-Id: linux-pm@vger.kernel.org

On 15-10-18, 23:21, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> If the policy limits change between invocations of cs_dbs_update(),
> the requested frequency value stored in dbs_info may not be updated
> and the function may use a stale value of it next time.  Moreover, if
> idle periods are takem into account by cs_dbs_update(), the requested
> frequency value stored in dbs_info may be below the min policy limit,
> which is incorrect.
> 
> To fix these problems, always update the requested frequency value
> in dbs_info along with the local copy of it when the previous
> requested frequency is beyond the policy limits and avoid decreasing
> the requested frequency below the min policy limit when taking
> idle periods into account.
> 
> Reported-by: Waldemar Rymarkiewicz <waldemarx.rymarkiewicz@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/cpufreq/cpufreq_conservative.c |    6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
