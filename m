From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] Documentation: cpufreq: Update supported powernv
 processors
Date: Mon, 2 Jan 2017 12:38:15 +0530
Message-ID: <20170102070815.GB8588@vireshk-i7>
References: <1481887062-25522-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-doc-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1481887062-25522-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Sender: linux-doc-owner@vger.kernel.org
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Cc: rjw@rjwysocki.net, corbet@lwn.net, linux-pm@vger.kernel.org, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 16-12-16, 16:47, Shilpasri G Bhat wrote:
> Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
> ---
>  Documentation/cpu-freq/user-guide.txt | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/cpu-freq/user-guide.txt b/Documentation/cpu-freq/user-guide.txt
> index 109e97b..5e10d5f 100644
> --- a/Documentation/cpu-freq/user-guide.txt
> +++ b/Documentation/cpu-freq/user-guide.txt
> @@ -87,7 +87,9 @@ UltraSPARC-III
>  -------
>  
>  Several "PowerBook" and "iBook2" notebooks are supported.
> -
> +The following POWER processors are supported in powernv mode:
> +POWER8
> +POWER9
>  
>  1.5 SuperH
>  ----------

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
