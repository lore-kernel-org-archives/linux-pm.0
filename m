From: Catalin Marinas <catalin.marinas@arm.com>
Subject: Re: [PATCH v7 1/8] arm64: kernel: refactor the CPU suspend API for
 retention states
Date: Mon, 18 Aug 2014 15:20:30 +0100
Message-ID: <20140818142030.GB20043@localhost>
References: <1407945127-27554-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1407945127-27554-2-git-send-email-lorenzo.pieralisi@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <1407945127-27554-2-git-send-email-lorenzo.pieralisi@arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, Tomasz Figa <t.figa@samsung.com>, Lina Iyer <lina.iyer@linaro.org>, Chander Kashyap <k.chander@samsung.com>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Geoff Levand <geoff@infradead.org>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Amit Kucheria <amit.ku>
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 13, 2014 at 04:52:00PM +0100, Lorenzo Pieralisi wrote:
> CPU suspend is the standard kernel interface to be used to enter
> low-power states on ARM64 systems. Current cpu_suspend implementation
> by default assumes that all low power states are losing the CPU context,
> so the CPU registers must be saved and cleaned to DRAM upon state
> entry. Furthermore, the current cpu_suspend() implementation assumes
> that if the CPU suspend back-end method returns when called, this has
> to be considered an error regardless of the return code (which can be
> successful) since the CPU was not expected to return from a code path that
> is different from cpu_resume code path - eg returning from the reset vector.
> 
> All in all this means that the current API does not cope well with low-power
> states that preserve the CPU context when entered (ie retention states),
> since first of all the context is saved for nothing on state entry for
> those states and a successful state entry can return as a normal function
> return, which is considered an error by the current CPU suspend
> implementation.
> 
> This patch refactors the cpu_suspend() API so that it can be split in
> two separate functionalities. The arm64 cpu_suspend API just provides
> a wrapper around CPU suspend operation hook. A new function is
> introduced (for architecture code use only) for states that require
> context saving upon entry:
> 
> __cpu_suspend(unsigned long arg, int (*fn)(unsigned long))
> 
> __cpu_suspend() saves the context on function entry and calls the
> so called suspend finisher (ie fn) to complete the suspend operation.
> The finisher is not expected to return, unless it fails in which case
> the error is propagated back to the __cpu_suspend caller.
> 
> The API refactoring results in the following pseudo code call sequence for a
> suspending CPU, when triggered from a kernel subsystem:
> 
> /*
>  * int cpu_suspend(unsigned long idx)
>  * @idx: idle state index
>  */
> {
> -> cpu_suspend(idx)
> 	|---> CPU operations suspend hook called, if present
> 		|--> if (retention_state)
> 			|--> direct suspend back-end call (eg PSCI suspend)
> 		     else
> 			|--> __cpu_suspend(idx, &back_end_finisher);
> }
> 
> By refactoring the cpu_suspend API this way, the CPU operations back-end
> has a chance to detect whether idle states require state saving or not
> and can call the required suspend operations accordingly either through
> simple function call or indirectly through __cpu_suspend() which carries out
> state saving and suspend finisher dispatching to complete idle state entry.
> 
> Signed-off-by: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> ---
>  arch/arm64/include/asm/suspend.h |  1 +
>  arch/arm64/kernel/sleep.S        | 47 +++++++++++++++++++++++++++++-----------
>  arch/arm64/kernel/suspend.c      | 47 ++++++++++++++++++++++++----------------
>  3 files changed, 63 insertions(+), 32 deletions(-)

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
