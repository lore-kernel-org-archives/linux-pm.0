From: Paul Burton <paul.burton@imgtec.com>
Subject: Re: [PATCH v4 3/6] drivers: cpuidle: implement OF based idle states
 infrastructure
Date: Sun, 6 Jul 2014 11:01:08 +0100
Message-ID: <20140706100108.GE804@pburton-laptop>
References: <1402503520-8611-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1402503520-8611-4-git-send-email-lorenzo.pieralisi@arm.com>
 <CAJZ5v0gE2Jq709SXLpfrxXnHxmqcDV1FbrPPX1JYUUdHJFL_Dg@mail.gmail.com>
 <20140612090339.GB29295@e102568-lin.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
Content-Disposition: inline
In-Reply-To: <20140612090339.GB29295@e102568-lin.cambridge.arm.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Mark Rutland <Mark.Rutland@arm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, Catalin Marinas <Catalin.Marinas@arm.com>, Tomasz Figa <t.figa@samsung.com>, Chander Kashyap <chander.kashyap@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Nicolas Pitre <nico@linaro.org>, Daniel Lezcano <daniel.lezcano@linaro.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "grant.likely@linaro.org" <grant.likely@linaro.org>, Charles Garcia-Tobin <Charles.Garcia-Tobin@arm.com>, "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, Kevin Hilman <khilman@linaro.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, Sebastian Capella <sebcape@gmail.com>, Mark Brown <broonie@kernel.org>, Antti Miettinen <ananaza@iki.fi>, Paul Walmsley <paul@pwsan.com>, Peter De Schrijver <pdeschrijver@nvidia.com>, Stephen Boyd <sboyd@codeaurora.org>, Am
List-Id: linux-pm@vger.kernel.org

On Thu, Jun 12, 2014 at 10:03:39AM +0100, Lorenzo Pieralisi wrote:
> [CC'ing Preeti and Paul to check their opinions]
> 
> Hi Rafael,

snip

> > One question here.
> > 
> > Do you want this to be generally useful or is it just ARM-specific?
> 
> The first series was targeting ARM64, then I noticed that it might be
> used for ARM too (Daniel is working on that). Actually, I discovered
> that Power and MIPS can reuse at least the code that initializes the
> states data too, but I have to point out three things:
> 
> 1) state enter function method: in my bindings it is common for all
>    idle states, need to check if it applies to Power and MIPS too.
> 2) CPUIDLE_FLAG_TIMER_STOP and how to set it. It is non-trivial to
>    add code that detects what idle states lose the tick device context.
>    At the moment I am adding the flag by default to all idle states
>    apart from standbywfi on ARM, but that can be optimised. Unless we
>    resort to power domains (but that's not trivial), we can add a flag
>    to the idle states in DT (ie local-timer-stop or suchlike) to support
>    that. I think that it will be frowned upon but it is worth trying, would
>    like to know what other people think about this.
> 3) idle states bindings should be reviewed, I expect them to be valid
>    on other architectures too, but I need acknowledgments.
> 
> I think this series is not far from being ready to be upstreamed, I
> would be certainly happy if it can be reused for other archs too so
> just let me know.
> 
> Thanks !
> Lorenzo

Sorry for the delayed reply, I'm still catching up with mail after some
time off.

On the MIPS CPS systems I'm working with we are able to detect which
states are supported by reading config registers, so there's no need
for these systems to have available states described in DT.

Thanks,
    Paul
