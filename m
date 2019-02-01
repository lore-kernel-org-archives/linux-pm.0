From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH V2] cpuidle: dt: bail out if the idle-state DT node is
 not compatible
Date: Fri, 1 Feb 2019 11:48:38 +0000
Message-ID: <20190201114838.GA10042@e107155-lin>
References: <20190201021639.27245-1-josephl@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20190201021639.27245-1-josephl@nvidia.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Joseph Lo <josephl@nvidia.com>
Cc: linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Sudeep Holla <sudeep.holla@arm.com>, linux-tegra@vger.kernel.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Fri, Feb 01, 2019 at 10:16:39AM +0800, Joseph Lo wrote:
> Currently, the DT of the idle states will be parsed first whether it's
> compatible or not. This could cause a warning message that comes from if
> the CPU doesn't support identical idle states. E.g. Tegra186 can run
> with 2 Cortex-A57 and 2 Denver cores with different idle states on
> different types of these cores.
> 
> So fix it by checking the match node earlier, then it can make sure it
> only goes through the idle states that the CPU supported.
> 
> Signed-off-by: Joseph Lo <josephl@nvidia.com>
> ---
> v2:
>  * fix it by moving of_match_node earlier, so we don't need to match the
>    node twice like the v1 did.

Neat, thanks for the quick patch. FWIW,

Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

--
Regards,
Sudeep
