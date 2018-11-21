From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: powernv: add of_node_put()
Date: Wed, 21 Nov 2018 09:32:04 +0530
Message-ID: <20181121040204.yjlnxaulet3o5u3r@vireshk-i7>
References: <20181120160530.21015-1-tiny.windzz@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20181120160530.21015-1-tiny.windzz@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Yangtao Li <tiny.windzz@gmail.com>
Cc: rjw@rjwysocki.net, benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 20-11-18, 11:05, Yangtao Li wrote:
> The of_find_node_by_path() returns a node pointer with refcount
> incremented,but there is the lack of use of the of_node_put() when
> done.Add the missing of_node_put() to release the refcount.
> 
> Signed-off-by: Yangtao Li <tiny.windzz@gmail.com>
> ---
> Changes in v2
> -update changelog
> ---
>  drivers/cpufreq/powernv-cpufreq.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
