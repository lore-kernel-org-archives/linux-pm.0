From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 1/9] ARM: get rid of arch_cpu_idle_prepare()
Date: Mon, 27 Jan 2014 18:35:57 +0100
Message-ID: <20140127173557.GE4941@twins.programming.kicks-ass.net>
References: <1390802904-28399-1-git-send-email-nicolas.pitre@linaro.org>
 <1390802904-28399-2-git-send-email-nicolas.pitre@linaro.org>
 <52E6175F.1050401@linaro.org>
 <20140127160736.GP15937@n2100.arm.linux.org.uk>
 <52E69395.9020004@linaro.org>
 <20140127172110.GR15937@n2100.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140127172110.GR15937@n2100.arm.linux.org.uk>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Russell King - ARM Linux <linux@arm.linux.org.uk>
Cc: Nicolas Pitre <nicolas.pitre@linaro.org>, linaro-kernel@lists.linaro.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Paul Mundt <lethal@linux-sh.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@redhat.com>, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

On Mon, Jan 27, 2014 at 05:21:10PM +0000, Russell King - ARM Linux wrote:
> A reviewed-by tag on its own doesn't mean much, as it could mean that
> you've just glanced over the code and decided "yea, it looks okay", or
> it could mean that you've spent all day verifying that the code change
> is indeed correct.

One should use Acked-by for the 'yea, it looks okay' thing.
