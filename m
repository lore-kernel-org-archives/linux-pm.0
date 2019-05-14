From: Ulf Hansson <ulf.hansson@linaro.org>
Subject: Re: [PATCH 00/18] ARM/ARM64: Support hierarchical CPU arrangement for PSCI
Date: Tue, 14 May 2019 10:58:04 +0200
Message-ID: <CAPDyKFpU3u248Gi+FnrVdY-EWXJQuu14uNV9d3Xs0W-K-EMEhg@mail.gmail.com>
References: <20190513192300.653-1-ulf.hansson@linaro.org> <CAJZ5v0gbK3AFCVC1b9LyXeMOM8fKR1=ECXZwaeSYRSqcK0UgYA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0gbK3AFCVC1b9LyXeMOM8fKR1=ECXZwaeSYRSqcK0UgYA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Sudeep Holla <sudeep.holla@arm.com>, Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, Mark Rutland <mark.rutland@arm.com>, Linux ARM <linux-arm-kernel@lists.infradead.org>, "Rafael J . Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>, Amit Kucheria <amit.kucheria@linaro.org>, Bjorn Andersson <bjorn.andersson@linaro.org>, Stephen Boyd <sboyd@kernel.org>, Niklas Cassel <niklas.cassel@linaro.org>, Tony Lindgren <tony@atomide.com>, Kevin Hilman <khilman@kernel.org>, Lina Iyer <ilina@codeaurora.org>, Viresh Kumar <viresh.kumar@linaro.org>, Vincent Guittot <vincent.guittot@linaro.org>, Geert Uytterhoeven <geert+renesas@glider.be>, Souvik Chakravarty <souvik.chakravarty@arm.com>
List-Id: linux-pm@vger.kernel.org

On Tue, 14 May 2019 at 10:08, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
> On Mon, May 13, 2019 at 9:23 PM Ulf Hansson <ulf.hansson@linaro.org> wrote:
> >
> > This series enables support for hierarchical CPU arrangement, managed by PSCI
> > for ARM/ARM64. It's based on using the generic PM domain (genpd), which
> > recently was extended to manage devices belonging to CPUs.
>
> ACK for the patches touching cpuidle in this series (from the
> framework perspective), but I'm assuming it to be taken care of by
> ARM/ARM64 maintainers.

Thanks for the ack! Yes, this is for PSCI/ARM maintainers.

BTW, apologize for sending this in the merge window, but wanted to
take the opportunity for people to have a look before OSPM Pisa next
week.

Kind regards
Uffe
