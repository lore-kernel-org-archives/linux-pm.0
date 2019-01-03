From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v10 00/27] PM / Domains: Support hierarchical CPU
 arrangement (PSCI/ARM)
Date: Thu, 3 Jan 2019 12:06:12 +0000
Message-ID: <20190103120612.GC23511@e107155-lin>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: Mark Rutland <mark.rutland@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, linux-pm@vger.kernel.org, Stephen Boyd <sboyd@kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, linux-arm-msm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, linux-kernel@vger.kernel.org, Tony Lindgren <tony@atomide.com>, Sudeep Holla <sudeep.holla@arm.com>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Thu, Nov 29, 2018 at 06:46:33PM +0100, Ulf Hansson wrote:
> Over the years this series have been iterated and discussed at various Linux
> conferences and LKML. In this new v10, a quite significant amount of changes
> have been made to address comments from v8 and v9. A summary is available
> below, although let's start with a brand new clarification of the motivation
> behind this series.

I would like to raise few points, not blockers as such but need to be
discussed and resolved before proceeding further.
1. CPU Idle Retention states
	- How will be deal with flattening (which brings back the DT bindings,
	  i.e. do we have all we need) ? Because today there are no users of
	  this binding yet. I know we all agreed and added after LPC2017 but
	  I am not convinced about flattening with only valid states.
	- Will domain governor ensure not to enter deeper idles states based
	  on its sub-domain states. E.g.: when CPUs are in retention, so
	  called container/cluster domain can enter retention or below and not
	  power off states.
	- Is the case of not calling cpu_pm_{enter,exit} handled now ?

2. Now that we have SDM845 which may soon have platform co-ordinated idle
   support in mainline, I *really* would like to see some power comparison
   numbers(i.e. PC without cluster idle states). This has been the main theme
   for most of the discussion on this topic for years and now we are close
   to have some platform, we need to try.

3. Also, after adding such complexity, we really need a platform with an
   option to build and upgrade firmware easily. This will help to prevent
   this being not maintained for long without a platform to test, also
   avoid adding lots of quirks to deal with broken firmware so that newer
   platforms deal those issues in the firmware correctly.

--
Regards,
Sudeep
