From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH] cpufreq: Add ARM_MT8173_CPUFREQ dependencyon THERMAL
Date: Thu, 3 Sep 2015 21:20:29 +0530
Message-ID: <20150903155029.GB5332@linux>
References: <1441293658-18199-1-git-send-email-linux@roeck-us.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1441293658-18199-1-git-send-email-linux@roeck-us.net>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, Matthias Brugger <matthias.bgg@gmail.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On 03-09-15, 08:20, Guenter Roeck wrote:
> If ARM_MT8173_CPUFREQ is configured, and THERMAL is configured as module,
> the following build error is seen for arm:allmodconfig and
> arm64:allmodconfig.
> 
> drivers/built-in.o: In function `mtk_cpufreq_ready':
> :(.text+0x32a20c): undefined reference to `of_cpufreq_cooling_register'
> drivers/built-in.o: In function `mtk_cpufreq_exit':
> :(.text+0x32a420): undefined reference to `cpufreq_cooling_unregister'
> 
> The fix is similar to CPUFREQ_DT, but more restrictive since
> ARM_MT8173_CPUFREQ can not be built as module.
> 
> Fixes: 1453863fb02a ("cpufreq: mediatek: Add MT8173 cpufreq driver")
> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> ---
> It might also make sense to declare ARM_MT8173_CPUFREQ as tristate
> and relax the conditions, but I don't know if that is feasible.
> 
>  drivers/cpufreq/Kconfig.arm | 1 +
>  1 file changed, 1 insertion(+)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
