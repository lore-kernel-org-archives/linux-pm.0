From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [GIT PULL] DT/core: cpu_ofnode updates for v3.12
Date: Wed, 14 Aug 2013 07:07:04 +1000
Message-ID: <1376428024.4255.14.camel@pasglop>
References: <5208E2D3.7060005@arm.com> <3356439.a21MloFP7n@vostro.rjw.lan>
 <520A536C.3030600@arm.com> <520A7B00.8060405@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <520A7B00.8060405@arm.com>
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

On Tue, 2013-08-13 at 19:29 +0100, Sudeep KarkadaNagesha wrote:
> I don't understand completely the use of ibm,ppc-interrupt-server#s and
> its implications on generic of_get_cpu_node implementation.
> I see the PPC specific definition of of_get_cpu_node uses thread id only
> in 2 instances. Based on that, I have tried to move all the other
> instances to use generic definition.
> 
> Let me know if the idea is correct.

No. The device-tree historically only represents cores, not HW threads, so
it makes sense to retrieve also the thread number corresponding to the CPU.

However, the mechanism to represent HW threads in the device-tree is currently
somewhat platform specific (the ibm,ppc-interrupt-server#s).

So what you could do for now is:

 - Have a generic version that always returns 0 as the thread, which is weak

 - powerpc keeps its own implementation

 - Start a discussion on the bindings (if not already there) to define threads
in a better way at which point the generic function can be updated.

Cheers,
Ben.
