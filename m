From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 00/35] CPUFreq: Implement light weight ->target(): for
 3.13
Date: Wed, 14 Aug 2013 10:59:22 +0530
Message-ID: <CAKohpo=Kg9+68_aOpt-=YgNUvT_Srvgpd9t629X7DenrngNrKQ@mail.gmail.com>
References: <cover.1376392602.git.viresh.kumar@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <cover.1376392602.git.viresh.kumar@linaro.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Lunn <andrew@lunn.ch>, Steven Miao <realmz6@gmail.com>, Viresh Kumar <viresh.kumar@linaro.org>, Linus Walleij <linus.walleij@linaro.org>, Sekhar Nori <nsekhar@ti.com>, sparclinux@vger.kernel.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jesper Nilsson <jesper.nilsson@axis.com>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@nvidia.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, Patch Tracking <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Mikael Starvik <starvik@axis.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, John Crispin <blogic@openwrt.org>, Tony Luck <tony.luck@intel.com>, Eric Miao <eric.y.miao@gmail.com>, linux-cris-kernel@axis.com, Linux
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
>
> So, it makes sense to just do this work in cpufreq core before calling
> cpufreq_frequency_table_target() and simply pass index instead. But this can be
> done only with drivers which expose their frequency table with cpufreq core. For
> others we need to stick with the old prototype of target() until those drivers
> are converted to expose frequency tables.
>
> There are 7 drivers after this patchset which still use the heavy weight
> version, i.e. target() and 44 drivers have adopted this new approach, i.e.
> target_index().
>
> Once those 7 drivers are also moved to use .target_index(), .target() will be
> removed completely.

At a quick look at the status of drivers using target_index() it looks there is
scope of more optimizations around that part..

We can actually get rid of cpufreq_notify_transition() from those cpufreq
drivers and do that in core.. And that would cut down size of ->target_index()
routines even more :)

I will give it a try soon.
