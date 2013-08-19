From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH V2 01/35] cpufreq: Implement light weight ->target_index()
 routine
Date: Mon, 19 Aug 2013 10:07:37 +0530
Message-ID: <CAKohpokeJZq5Y9PpQCiEqVFqZq0U266rqLEQeEh4ZszWEM6_XA@mail.gmail.com>
References: <cover.1376392602.git.viresh.kumar@linaro.org>
 <eb988fc9e72b90b7ba99f16405f5dcb072da7840.1376392602.git.viresh.kumar@linaro.org>
 <CADGdYn4=si46x7b5Qa0EJ1vUDKrP3maXBqWwQ6s7gkep-8MxFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CADGdYn4=si46x7b5Qa0EJ1vUDKrP3maXBqWwQ6s7gkep-8MxFg@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: amit daniel kachhap <amit.daniel@samsung.com>
Cc: Andrew Lunn <andrew@lunn.ch>, Steven Miao <realmz6@gmail.com>, Linus Walleij <linus.walleij@linaro.org>, Sekhar Nori <nsekhar@ti.com>, sparclinux@vger.kernel.org, Hans-Christian Egtvedt <egtvedt@samfundet.no>, Jesper Nilsson <jesper.nilsson@axis.com>, Kukjin Kim <kgene.kim@samsung.com>, Stephen Warren <swarren@nvidia.com>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, "patches@linaro.org" <patches@linaro.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Lists linaro-kernel <linaro-kernel@lists.linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, LAK <linux-arm-kernel@lists.infradead.org>, John Crispin <blogic@openwrt.org>, Mikael Starvik <starvik@axis.com>, Tony Luck <tony.luck@intel.com>, Eric Miao <eric.y.miao@gmail.com>, linux-cris-kernel@axis.com, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.or>
List-Id: linux-pm@vger.kernel.org

Hi Amit,

Thanks for your feedback :)

On 18 August 2013 16:11, amit daniel kachhap <amit.daniel@samsung.com> wrote:
> This new API is fine but I have another idea.

good.

> Say During the registration of the frequency table cpufreq_policy can
> be registered as SCALE_DIRECT or SCALE_STEPS. With SCALE_DIRECT flag,
> valid frequency will be requested. With this flags the governor itself
> can  can figure out if frequency scaling is required or not and very
> few calls to __cpufreq_driver_target will happen.

Honestly speaking I couldn't get what your idea is :) ... but governor is
in no position to make this direct call to drivers.. Taking such stuff to
governors will replicate this code again.. Its better all governors call
some common part of cpufreq.c which then decides what to do..

> But i agree that in this approach cpufreq_frequency_table_target is
> still required but again it can be optimized by binary search as
> currently the search is linear.

Frequencies in this table aren't required to be in ascending order :)
