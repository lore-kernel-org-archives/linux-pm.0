From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 00/35] CPUFreq: Implement light weight ->target(): for 3.13
Date: Tue, 13 Aug 2013 19:16:00 +0530
Message-ID: <CAKohpo=-PWt23aLiVW3MxU6gZ-_Db=QKYaaKO-f+e+u8hirpJQ@mail.gmail.com>
References: <cover.1376392602.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <cover.1376392602.git.viresh.kumar@linaro.org>
Sender: sparclinux-owner@vger.kernel.org
To: rjw@sisk.pl, Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: linaro-kernel@lists.linaro.org, patches@linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, Viresh Kumar <viresh.kumar@linaro.org>, Andrew Lunn <andrew@lunn.ch>, "David S. Miller" <davem@davemloft.net>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Eric Miao <eric.y.miao@gmail.com>, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jesper Nilsson <jesper.nilsson@axis.com>, John Crispin <blogic@openwrt.org>, Kukjin Kim <kgene.kim@samsung.com>, Linus Walleij <linus.walleij@linaro.org>, linux-cris-kernel@axis.com, Mikael Starvik <starvik@axis.com>, Santosh Shilimkar <santosh.shilimkar@ti.com>, Sekhar Nori <nsekhar@ti.com>, Shawn Guo <shawn.guo@linaro.org>, sparclinux@vger.kernel.org, Stephen Warren <swarren@nvidia.com>, Steven Miao <realmz6@gmail.com>, Tony Luck <tony.luck@intel.com>
List-Id: linux-pm@vger.kernel.org

On 13 August 2013 19:02, Viresh Kumar <viresh.kumar@linaro.org> wrote:
> Currently prototype of cpufreq_drivers target routines is:
>
> int target(struct cpufreq_policy *policy, unsigned int target_freq,
>         unsigned int relation);
>
> And most of the drivers call cpufreq_frequency_table_target() to get a valid
> index of their frequency table which is closest to the target_freq. And they
> don't use target_freq and relation after it.

I just came to know from a friend that I have written "covert" instead of
"convert" in subjects of all the patches.

Will fix it in my repo for now.

Thanks Sudeep :)

--
viresh
