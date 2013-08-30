From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Query] CPUFreq: Does these machines have separate clock
 domains for CPUs?
Date: Fri, 30 Aug 2013 18:49:24 +1000
Message-ID: <1377852564.3978.0.camel@pasglop>
References: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAKohponWn-RN7-6sdhghd6RGCOd357G+TKLsxHfqnSCuMD7xxw@mail.gmail.com>
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
Cc: Jesper Nilsson <jesper.nilsson@axis.com>, Eric Miao <eric.y.miao@gmail.com>, linux-cris-kernel@axis.com, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Miao Steven <realmz6@gmail.com>, linux-sh@vger.kernel.org, Sekhar Nori <nsekhar@ti.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, Mikael Starvik <starvik@axis.com>, Paul Mundt <lethal@linux-sh.org>, sparclinux@vger.kernel.org, Dave Jones <davej@redhat.com>, David Miller <davem@davemloft.net>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, John Crispin <blogic@openwrt.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 2013-08-29 at 15:45 +0530, Viresh Kumar wrote:
> drivers/cpufreq/pmac32-cpufreq.c

This is always UP.

Cheers,
Ben.
