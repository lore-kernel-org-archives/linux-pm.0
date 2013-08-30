From: Mikael Starvik <mikael.starvik@axis.com>
Subject: Re: [Query] CPUFreq: Does these machines have separate clock
 domains for CPUs?
Date: Fri, 30 Aug 2013 06:21:19 +0200
Message-ID: <D9E0917B-058A-4F22-87EF-15F26ED46F35@axis.com>
References: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
Content-Language: sv-SE
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: Eric Miao <eric.y.miao@gmail.com>, linux-cris-kernel <linux-cris-kernel@axis.com>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Sekhar Nori <nsekhar@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Jesper Nilsson <jespern@axis.com>, Miao Steven <realmz6@gmail.com>, Paul Mundt <lethal@linux-sh.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, Dave Jones <davej@redhat.com>, David Miller <davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, John Crispin <blogic@openwrt.org>
List-Id: linux-pm@vger.kernel.org

Cris are also UP

29 aug 2013 kl. 12:16 skrev "Viresh Kumar" <viresh.kumar@linaro.org>:

> Hi,
> 
> I have been doing some CPUFreq cleanup work and
> wanted to know if the below mentioned machines have separate
> clock domains for their CPUs or all share the same domain?
> 
> So, that we can use some generic routines for these drivers which
> would eventually do:
> 
> cpumask_setall(policy->cpus);
> 
> And I wanted to make sure that this doesn't break them.. :)
> 
> ......
> 
> The drivers are:
> 
> drivers/cpufreq/at32ap-cpufreq.c
> drivers/cpufreq/blackfin-cpufreq.c
> drivers/cpufreq/cris-artpec3-cpufreq.c
> drivers/cpufreq/cris-etraxfs-cpufreq.c
> drivers/cpufreq/davinci-cpufreq.c
> drivers/cpufreq/e_powersaver.c
> drivers/cpufreq/elanfreq.c
> drivers/cpufreq/longhaul.c
> drivers/cpufreq/loongson2_cpufreq.c
> drivers/cpufreq/pmac32-cpufreq.c
> drivers/cpufreq/powernow-k6.c
> drivers/cpufreq/powernow-k7.c
> drivers/cpufreq/pxa2xx-cpufreq.c
> drivers/cpufreq/pxa3xx-cpufreq.c
> drivers/cpufreq/sc520_freq.c
> drivers/cpufreq/sh-cpufreq.c
> drivers/cpufreq/sparc-us2e-cpufreq.c
> drivers/cpufreq/sparc-us3-cpufreq.c
> 
> --
> Viresh
