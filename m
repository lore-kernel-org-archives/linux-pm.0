From: Viresh Kumar <viresh.kumar@linaro.org>
Subject: Re: [Query] CPUFreq: Does these machines have separate clock domains
 for CPUs?
Date: Thu, 29 Aug 2013 16:00:06 +0530
Message-ID: <CAKohponHDZB37UsacYpmaJPb2-P3b_CJ51e7o=X+D3M68GcdEQ@mail.gmail.com>
References: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
	<521F2112.5070501@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <sparclinux-owner@vger.kernel.org>
In-Reply-To: <521F2112.5070501@ti.com>
Sender: sparclinux-owner@vger.kernel.org
To: Sekhar Nori <nsekhar@ti.com>
Cc: "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, David Miller <davem@davemloft.net>, Eric Miao <eric.y.miao@gmail.com>, Jesper Nilsson <jesper.nilsson@axis.com>, John Crispin <blogic@openwrt.org>, linux-cris-kernel@axis.com, linux-sh@vger.kernel.org, Mikael Starvik <starvik@axis.com>, Paul Mundt <lethal@linux-sh.org>, sparclinux@vger.kernel.org, Miao Steven <realmz6@gmail.com>, Dave Jones <davej@redhat.com>
List-Id: linux-pm@vger.kernel.org

On 29 August 2013 15:53, Sekhar Nori <nsekhar@ti.com> wrote:
> On DaVinci (DA850), there is an async domain available to keep some
> peripheral clocks insulated from cpu frequency changes. But there are a
> bunch of other clocks which do get affected by CPU frequency change
> (they need to run at a fixed ratio to CPU frequency).

My question wasn't about how peripherals are getting clocks.. but how
CPUs are getting them..

Does all CPUs share clock line in Davinci? i.e. if we change freq of one
cpu then freq of other one also gets changed?

Or they are capable of running at different frequencies?

--
viresh
