From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [RFC V2 1/6] cpufreq: Replace "max_transition_latency" with "dynamic_switching"
Date: Thu, 13 Jul 2017 18:19:53 +0200
Message-ID: <CAJZ5v0g-DgV6G-J9pkAYKooqgbJDV_ML8cR8wquKksN=x_JpoQ@mail.gmail.com>
References: <cover.1499853492.git.viresh.kumar@linaro.org> <4b9ff9a3f546b2269ddb2da27c9e5be5f106a70f.1499853492.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <4b9ff9a3f546b2269ddb2da27c9e5be5f106a70f.1499853492.git.viresh.kumar@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Rafael Wysocki <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vincent Guittot <vincent.guittot@linaro.org>, Dominik Brodowski <linux@dominikbrodowski.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Jul 13, 2017 at 7:40 AM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> There is no limitation in the ondemand or conservative governors which
> disallow the transition_latency to be greater than 10 ms.
>
> The max_transition_latency field is rather used to disallow automatic
> dynamic frequency switching for platforms which didn't wanted these
> governors to run.
>
> Replace max_transition_latency with a boolean (dynamic_switching) and
> check for transition_latency == CPUFREQ_ETERNAL along with that. This
> makes it pretty straight forward to read/understand now.

Well, using CPUFREQ_ETERNAL for that on the driver side is still not
particularly straightforward IMO, so maybe add a
"no_dynamic_switching" to the driver structure and set it to "true"
for the one driver in question?

Thanks,
Rafael
