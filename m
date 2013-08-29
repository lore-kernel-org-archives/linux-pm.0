From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [Query] CPUFreq: Does these machines have separate clock domains
 for CPUs?
Date: Thu, 29 Aug 2013 15:53:14 +0530
Message-ID: <521F2112.5070501@ti.com>
References: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
Sender: cpufreq-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Eric Miao <eric.y.miao@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, John Crispin <blogic@openwrt.org>, linux-cris-kernel@axis.com, linux-sh@vger.kernel.org, Mikael Starvik <starvik@axis.com>, Paul Mundt <lethal@linux-sh.org>, sparclinux@vger.kernel.org, Miao Steven <realmz6@gmail.com>, Dave Jones <davej@redhat.com>
List-Id: linux-pm@vger.kernel.org

On Thursday 29 August 2013 03:45 PM, Viresh Kumar wrote:
> Hi,
> 
> I have been doing some CPUFreq cleanup work and
> wanted to know if the below mentioned machines have separate
> clock domains for their CPUs or all share the same domain?

On DaVinci (DA850), there is an async domain available to keep some
peripheral clocks insulated from cpu frequency changes. But there are a
bunch of other clocks which do get affected by CPU frequency change
(they need to run at a fixed ratio to CPU frequency).

Thanks,
Sekhar
