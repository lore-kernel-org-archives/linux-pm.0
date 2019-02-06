From: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH V2] cpuidle: dt: bail out if the idle-state DT node is not
 compatible
Date: Wed, 06 Feb 2019 11:25:57 +0100
Message-ID: <2111013.byp0gTo4u7@aspire.rjw.lan>
References: <20190201021639.27245-1-josephl@nvidia.com>
 <20190201114838.GA10042@e107155-lin>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <20190201114838.GA10042@e107155-lin>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep Holla <sudeep.holla@arm.com>, Joseph Lo <josephl@nvidia.com>
Cc: linux-tegra@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, linux-arm-kernel@lists.infradead.org, linux-pm@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Friday, February 1, 2019 12:48:38 PM CET Sudeep Holla wrote:
> On Fri, Feb 01, 2019 at 10:16:39AM +0800, Joseph Lo wrote:
> > Currently, the DT of the idle states will be parsed first whether it's
> > compatible or not. This could cause a warning message that comes from if
> > the CPU doesn't support identical idle states. E.g. Tegra186 can run
> > with 2 Cortex-A57 and 2 Denver cores with different idle states on
> > different types of these cores.
> > 
> > So fix it by checking the match node earlier, then it can make sure it
> > only goes through the idle states that the CPU supported.
> > 
> > Signed-off-by: Joseph Lo <josephl@nvidia.com>
> > ---
> > v2:
> >  * fix it by moving of_match_node earlier, so we don't need to match the
> >    node twice like the v1 did.
> 
> Neat, thanks for the quick patch. FWIW,
> 
> Reviewed-by: Sudeep Holla <sudeep.holla@arm.com>

Patch applied, thanks!
