From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [PATCH 2/8] cpufreq: add driver for Armada XP
Date: Fri, 4 Jul 2014 15:25:35 +0530
Message-ID: <CAKohponuvPd1kWDdB66kxd8TxxYqQ219jCq2D2RGhMHAuZTSWA@mail.gmail.com>
References: <1404467103-29644-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1404467103-29644-3-git-send-email-thomas.petazzoni@free-electrons.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <1404467103-29644-3-git-send-email-thomas.petazzoni@free-electrons.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
Cc: Lior Amsalem <alior@marvell.com>, Andrew Lunn <andrew@lunn.ch>, Mike Turquette <mturquette@linaro.org>, Jason Cooper <jason@lakedaemon.net>, Tawfik Bayouk <tawfik@marvell.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nadav Haklai <nadavh@marvell.com>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>, Gregory Clement <gregory.clement@free-electrons.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
List-Id: linux-pm@vger.kernel.org

On 4 July 2014 15:14, Thomas Petazzoni
<thomas.petazzoni@free-electrons.com> wrote:
> This commit adds a simple cpufreq driver for the Armada XP SoC, which
> has one separately controllable clock for each CPU. For this reason,
> the existing cpufreq-cpu0 generic driver cannot be used because it
> currently assumes that there is only one clock controlling the
> frequency of all CPUs.
>
> There are on-going discussions on extending the cpufreq-cpu0 to cover
> the case of having one clock for each CPU, but there are still some
> unresolved issues to get this extended cpufreq-cpu0 driver merged.

Exactly, and those changes would get merged in one form or the other.
Surely in 3.17 atleast, if not 3.16 as we are already reaching rc4..

So, it would be great if you can test on top of those changes to see if
something isn't solved for your platform yet?

git://git.linaro.org/people/viresh.kumar/linux.git cpufreq/cpu0-krait-v3

--
viresh
