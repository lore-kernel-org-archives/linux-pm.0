From: Santosh Shilimkar <santosh.shilimkar@ti.com>
Subject: Re: [PATCH 21/35] cpufreq: omap: use cpufreq_table_validate_and_show()
Date: Thu, 8 Aug 2013 10:19:05 -0400
Message-ID: <5203A8D9.6080901@ti.com>
References: <cover.1375964117.git.viresh.kumar@linaro.org>
 <0cc200b71d5c1584c80845a1384aef1919fd779b.1375964117.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <0cc200b71d5c1584c80845a1384aef1919fd779b.1375964117.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: linaro-kernel@lists.linaro.org, linux-pm@vger.kernel.org, patches@linaro.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, rjw@sisk.pl, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thursday 08 August 2013 09:48 AM, Viresh Kumar wrote:
> Lets use cpufreq_table_validate_and_show() instead of calling
> cpufreq_frequency_table_cpuinfo() and cpufreq_frequency_table_get_attr().
> 
> Cc: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
