From: Sekhar Nori <nsekhar@ti.com>
Subject: Re: [Query] CPUFreq: Does these machines have separate clock domains
 for CPUs?
Date: Thu, 29 Aug 2013 15:57:44 +0530
Message-ID: <521F2220.5030403@ti.com>
References: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
 <521F2112.5070501@ti.com>
 <CAKohponHDZB37UsacYpmaJPb2-P3b_CJ51e7o=X+D3M68GcdEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKohponHDZB37UsacYpmaJPb2-P3b_CJ51e7o=X+D3M68GcdEQ@mail.gmail.com>
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
Cc: Jesper Nilsson <jesper.nilsson@axis.com>, Eric Miao <eric.y.miao@gmail.com>, linux-cris-kernel@axis.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-sh@vger.kernel.org, Miao Steven <realmz6@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Mikael Starvik <starvik@axis.com>, Paul Mundt <lethal@linux-sh.org>, sparclinux@vger.kernel.org, Dave Jones <davej@redhat.com>, David Miller <davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, John Crispin <blogic@openwrt.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 29 August 2013 04:00 PM, Viresh Kumar wrote:
> On 29 August 2013 15:53, Sekhar Nori <nsekhar@ti.com> wrote:
>> On DaVinci (DA850), there is an async domain available to keep some
>> peripheral clocks insulated from cpu frequency changes. But there are a
>> bunch of other clocks which do get affected by CPU frequency change
>> (they need to run at a fixed ratio to CPU frequency).
> 
> My question wasn't about how peripherals are getting clocks.. but how
> CPUs are getting them..
> 
> Does all CPUs share clock line in Davinci? i.e. if we change freq of one
> cpu then freq of other one also gets changed?
> 
> Or they are capable of running at different frequencies?

I get it now. All DaVinci devices are UP only.

Thanks,
Sekhar
