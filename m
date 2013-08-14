From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [GIT PULL] DT/core: cpu_ofnode updates for v3.12
Date: Thu, 15 Aug 2013 08:57:30 +1000
Message-ID: <1376521050.4255.82.camel@pasglop>
References: <5208E2D3.7060005@arm.com> <3356439.a21MloFP7n@vostro.rjw.lan>
 <520A536C.3030600@arm.com> <520A7B00.8060405@arm.com>
 <1376428024.4255.14.camel@pasglop> <520B5584.7030608@arm.com>
 <1376480227.4255.66.camel@pasglop> <520B8468.7050307@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <520B8468.7050307@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Sudeep KarkadaNagesha <Sudeep.KarkadaNagesha@arm.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "rob.herring@calxeda.com" <rob.herring@calxeda.com>, "Rafael J. Wysocki" <rjw@sisk.pl>, Olof Johansson <olof@lixom.net>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 2013-08-14 at 14:21 +0100, Sudeep KarkadaNagesha wrote:
> IMO moving of handling ibm,ppc-interrupt-server#s to generic code
> under
> #ifdef CONFIG_PPC seems to be cleaner approach than weak definitation.
> 
> As per my understanding each thread is a different logical cpu.
> Each logical cpu is mapped to unique physical id(either present in reg
> field or legacy ibm,ppc-interrupt-server#s field). So given a logical
> cpu id we can get the cpu node corresponding to it.
> Looking @ smp_setup_cpu_maps in arch/powerpc/kernel/setup-common.c
> and the comment in the same file: "This implementation only supports
> power of 2 number of threads.." the thread id id is implicit in the
> logical cpu id. Do we need to fetch that from DT ?

I don't want those parsing routines to make those assumptions. We have
changed our logical numbering in the past and may again.

Cheers,
Ben.
