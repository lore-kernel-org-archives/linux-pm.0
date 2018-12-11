From: Quentin Perret <quentin.perret@arm.com>
Subject: Re: [PATCH 2/2] OPP: Fix missing debugfs supply directory for OPPs
Date: Tue, 11 Dec 2018 13:48:32 +0000
Message-ID: <20181211134829.nct4uqvofn332yxp@queper01-lin>
References: <90e3577b5feb42bac1269e16bb3d2bdd8f6df40f.1544527580.git.viresh.kumar@linaro.org>
 <46f48aca2e5aef3f430e95d1a5fb68227ec8ec85.1544527580.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <46f48aca2e5aef3f430e95d1a5fb68227ec8ec85.1544527580.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>, Rafael Wysocki <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tuesday 11 Dec 2018 at 16:56:29 (+0530), Viresh Kumar wrote:
> There is one case where we may end up with no "supply" directory for the
> OPPs in debugfs. That happens when the OPP core isn't managing the
> regulators for the device and the device's OPP do have microvolt
> property. It happens because the opp_table->regulator_count remains set
> to 0 and the debugfs routines don't add any supply directory in such a
> case.
> 
> This commit fixes that by setting opp_table->regulator_count to 1 in
> that particular case. But to make everything work nicely and not break
> other parts of the core, regulator_count is defined as "int" now instead
> of "unsigned int" and it can have different special values now. It is
> set to -1 initially to mark it "uninitialized" and later only we set it
> to 0 or positive values after checking how many supplies are there.
> 
> This also helps in finding the bugs where only few of the OPPs have the
> "opp-microvolt" property set and not all.

Tested on Juno r0 and Hikey960 successfully. The 'supply' directory is
now correctly exposed.

Feel free to add Tested-by: Quentin Perret <quentin.perret@arm.com>

Thanks,
Quentin
