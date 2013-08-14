From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [GIT PULL] DT/core: cpu_ofnode updates for v3.12
Date: Wed, 14 Aug 2013 21:37:07 +1000
Message-ID: <1376480227.4255.66.camel@pasglop>
References: <5208E2D3.7060005@arm.com> <3356439.a21MloFP7n@vostro.rjw.lan>
 <520A536C.3030600@arm.com> <520A7B00.8060405@arm.com>
 <1376428024.4255.14.camel@pasglop> <520B5584.7030608@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <520B5584.7030608@arm.com>
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

On Wed, 2013-08-14 at 11:01 +0100, Sudeep KarkadaNagesha wrote:
> Yes this doesn't cover the historical "ibm,ppc-interrupt-server#s",
> for
> which we can have PPC specific wrapper above the generic one i.e. get
> the cpu node and then parse for thread id under custom property.

A wrapper is wrong. I don't want to have to have all ppc callers to use
a different function.

As I said, just make a generic one that returns a thread ID, ie, same
signature as the powerpc one. Make it weak, we can override it in
powerpc-land, or we can move the ibm,ppc-interrupt-server#s handling
into the generic one, it won't hurt, but leave the thread_id return
there, it doesn't hurt it will come in handy in a few cases without
causing code duplication.

Cheers,
Ben.
