From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH V2 12/21] cpufreq: tegra124: do not handle the CPU rail
Date: Thu, 13 Dec 2018 11:49:41 +0100
Message-ID: <CAJZ5v0jVFGe6UXsqFEwRL58jAaAp-_FHrkjYkLwtSkSLLOKetg@mail.gmail.com>
References: <20181213093438.29621-1-josephl@nvidia.com>
 <20181213093438.29621-13-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20181213093438.29621-13-josephl@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: josephl@nvidia.com
Cc: Linux PM <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Jon Hunter <jonathanh@nvidia.com>, Thierry Reding <thierry.reding@gmail.com>, linux-tegra@vger.kernel.org, linux-clk <linux-clk@vger.kernel.org>, Linux ARM <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Dec 13, 2018 at 10:35 AM Joseph Lo <josephl@nvidia.com> wrote:
>
> The Tegra124 cpufreq driver has no information to handle the Vdd-CPU
> rail. So this driver shouldn't handle for the CPU clock switching from
> DFLL to other PLL clocks. It was designed to work on DFLL clock only,
> which handle the frequency/voltage scaling in the background.
>
> This patch removes the driver dependency of the CPU rail, as well as not
> allow it to be built as a module and remove the removal function. So it
> can keep working on DFLL clock.

I assume this entire series to go in via arm-soc, so I won't be
picking up cpufreq changes from it.

Thanks,
Rafael
