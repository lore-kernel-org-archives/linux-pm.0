From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 0/2] Revert explicit support for Renesas R-Car Gen 3
 r8a779[56] SoCs
Date: Thu, 10 May 2018 11:51:38 +0200
Message-ID: <2473510.IAjYrYimeR@aspire.rjw.lan>
References: <20180502095806.30341-1-horms+renesas@verge.net.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20180502095806.30341-1-horms+renesas@verge.net.au>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Simon Horman <horms+renesas@verge.net.au>
Cc: linux-renesas-soc@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, May 2, 2018 11:58:04 AM CEST Simon Horman wrote:
> Revert commits that added explicit support for Renesas R-Car Gen 3
> r8a779[56] SoCs to the generic cpufreq driver.
> 
> This is no longer needed since the flowing commit and to the best of my
> knowledge is not relied on by any upstream DTS: edeec420de24 ("cpufreq:
> dt-platdev: Automatically create cpufreq device with OPP v2")
> 
> Simon Horman (2):
>   Revert "cpufreq: dt: Add r8a7796 support to to use generic cpufreq
>     driver"
>   Revert "cpufreq: rcar: Add support for R8A7795 SoC"
> 
>  drivers/cpufreq/cpufreq-dt-platdev.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> 

Am I expected to pick up this series?

Thanks,
Rafael
