From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH v2] cpufreq: qoriq: enhance bus frequency calculation
Date: Fri, 10 Mar 2017 15:44:52 +0530
Message-ID: <20170310101452.GA26510@vireshk-i7>
References: <1489109323-11424-1-git-send-email-andy.tang@nxp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1489109323-11424-1-git-send-email-andy.tang@nxp.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Yuantian Tang <andy.tang@nxp.com>
Cc: rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 10-03-17, 09:28, Yuantian Tang wrote:
> On some platforms, property device-type may be missed in soc node
> in dts which caused the bus-frequency can not be obtained correctly.
> 
> This patch enhanced the bus-frequency calculation. When property
> device-type is missed in dts, bus-frequency will be obtained by
> looking up clock table to get platform clock and hence get its
> frequency.
> 
> Signed-off-by: Tang Yuantian <andy.tang@nxp.com>
> ---
> v2: -- fix alignment issue
> 
>  drivers/cpufreq/qoriq-cpufreq.c | 24 +++++++++++++++++-------
>  1 file changed, 17 insertions(+), 7 deletions(-)

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
