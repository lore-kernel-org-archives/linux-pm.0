From: Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH v8 09/26] kernel/cpu_pm: Manage runtime PM in the idle
 path for CPUs
Date: Thu, 9 Aug 2018 10:58:44 +0100
Message-ID: <20180809095844.GA3444@e107155-lin>
References: <20180620172226.15012-1-ulf.hansson@linaro.org>
 <2056372.NMt4aPaF4h@aspire.rjw.lan>
 <2205807.cU2puvubpP@aspire.rjw.lan>
 <1726374.375PCQfjLZ@aspire.rjw.lan>
 <CAPDyKFrmP15+_hyRp44Jw-wsTmsNFKORdCeGJEgW8o0OoKiHhA@mail.gmail.com>
 <CAJZ5v0hk1wfm10fyycmddKF6wR4D51r30fD_-J5UDMbtB3+V-Q@mail.gmail.com>
 <20180808105619.GB25150@e107981-ln.cambridge.arm.com>
 <20180808180248.GC27850@codeaurora.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20180808180248.GC27850@codeaurora.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Lina Iyer <ilina@codeaurora.org>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Ulf Hansson <ulf.hansson@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Mark Rutland <mark.rutland@arm.com>, Linux PM <linux-pm@vger.kernel.org>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <lina.iyer@linaro.org>, Rob Herring <robh+dt@kernel.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>, Vincent Guittot <vincent.guittot@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Juri Lelli <juri.lelli@arm.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Linux ARM <linux-arm-kernel@lists.infradead.org>, linux-arm-msm <linux-arm-msm@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Sudeep
List-Id: linux-pm@vger.kernel.org

On Wed, Aug 08, 2018 at 12:02:48PM -0600, Lina Iyer wrote:

[...]

> I will not speak to any comparison of benchmarks between OSI and PC.
> AFAIK, there are no platforms supporting both.
>

That's the fundamental issue here. So we have never ever done a proper
comparison.

> But, the OSI feature is critical for QCOM mobile platforms. The
> last man activities during cpuidle save quite a lot of power. Powering
> off the clocks, busses, regulators and even the oscillator is very
> important to have a reasonable battery life when using the phone.
> Platform coordinated approach falls quite short of the needs of a
> powerful processor with a desired battery efficiency.
>

As mentioned above, without the actual comparison it's hard to justify
that. While there are corner cases where OSI is able to make better
judgement, may be we can add ways to deal with that in the firmware
with PC mode, have we explored that before adding complexity to the OSPM ?
Since the firmware complexity with OSI remains same as PC mode, isn't it
worth checking if the corner case we are talking here can be handled in
the firmware.

--
Regards,
Sudeep
