From: Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: Re: [Query] CPUFreq: Does these machines have separate clock domains
 for CPUs?
Date: Fri, 30 Aug 2013 01:41:28 +0300
Message-ID: <20130829224127.GA15841@blackmetal.musicnaut.iki.fi>
References: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <sparclinux-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
Sender: sparclinux-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Eric Miao <eric.y.miao@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, John Crispin <blogic@openwrt.org>, linux-cris-kernel@axis.com, linux-sh@vger.kernel.org, Mikael Starvik <starvik@axis.com>, Paul Mundt <lethal@linux-sh.org>, Sekhar Nori <nsekhar@ti.com>, sparclinux@vger.kernel.org, Miao Steven <realmz6@gmail.com>, Dave Jones <davej@redhat.com>
List-Id: linux-pm@vger.kernel.org

Hi,

On Thu, Aug 29, 2013 at 03:45:58PM +0530, Viresh Kumar wrote:
> I have been doing some CPUFreq cleanup work and
> wanted to know if the below mentioned machines have separate
> clock domains for their CPUs or all share the same domain?
[...]
> drivers/cpufreq/loongson2_cpufreq.c

Loongson2 is UP only.

A.
