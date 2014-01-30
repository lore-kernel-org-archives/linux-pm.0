From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2 5/6] X86: remove redundant cpuidle_idle_call()
Date: Thu, 30 Jan 2014 10:24:38 +0100
Message-ID: <20140130092438.GK11314@laptop.programming.kicks-ass.net>
References: <1391017513-12995-1-git-send-email-nicolas.pitre@linaro.org>
 <1391017513-12995-6-git-send-email-nicolas.pitre@linaro.org>
 <CAOesGMjvOkuxCopog91SAV1-gB9GaEYXpuXwhV1EJQor_pKjBA@mail.gmail.com>
 <alpine.LFD.2.11.1401291434120.1652@knanqh.ubzr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.11.1401291434120.1652@knanqh.ubzr>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Nicolas Pitre <nicolas.pitre@linaro.org>
Cc: "linaro-kernel@lists.linaro.org" <linaro-kernel@lists.linaro.org>, Russell King <linux@arm.linux.org.uk>, Linux-sh list <linux-sh@vger.kernel.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Preeti U Murthy <preeti@linux.vnet.ibm.com>, Paul Mundt <lethal@linux-sh.org>, Olof Johansson <olof@lixom.net>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@redhat.com>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>
List-Id: linux-pm@vger.kernel.org

On Wed, Jan 29, 2014 at 03:14:40PM -0500, Nicolas Pitre wrote:
> Looking into some cpuidle drivers for x86 I found at least one that 
> doesn't respect this convention.  Damn.

Which one? We should probably fix it :-)
