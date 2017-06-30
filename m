From: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH] cpuidle: menu: allow state 0 to be disabled
Date: Fri, 30 Jun 2017 18:35:17 +1000
Message-ID: <20170630183517.4852583d@roar.ozlabs.ibm.com>
References: <20170626053815.11845-1-npiggin@gmail.com>
        <CAJZ5v0iSX9yweQNiQ1UnnHVLt-iFZ3gJ1VyRxSOvq2+DEkWa6g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJZ5v0iSX9yweQNiQ1UnnHVLt-iFZ3gJ1VyRxSOvq2+DEkWa6g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: "Rafael J . Wysocki" <rjw@rjwysocki.net>, Linux PM <linux-pm@vger.kernel.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>, "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>, Daniel Lezcano <daniel.lezcano@linaro.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 29 Jun 2017 22:57:33 +0200
"Rafael J. Wysocki" <rafael@kernel.org> wrote:

> On Mon, Jun 26, 2017 at 7:38 AM, Nicholas Piggin <npiggin@gmail.com> wrote:
> > The menu driver does not allow state0 to be disabled completely.
> > If it is disabled but other enabled states don't meet latency
> > requirements, it is still used.
> >
> > Fix this by starting with the first enabled idle state. Fall back
> > to state 0 if no idle states are enabled (arguably this should be
> > -EINVAL if it is attempted, but this is the minimal fix).
> >
> > Acked-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >
> > Hi Rafael,  
> 
> Hi Nick,
> 
> > This patch is helpful when measuring power draw of polling,
> > latency cost of idle states, etc. Please consider merging if
> > you agree.  
> 
> I have a slight concern about x86 where state0 is mapped to polling
> and the way it is used in general stems from that.
> 
> Still, I guess we can try and see if this causes any problems to
> happen in practice, so I'm going to apply it.

Hi Rafael,

I tried to avoid changing the logic for x86, but let me know if you
spot anything or run into a problem, I will try to help fix it.

I still think it may be worth investigating whether x86 can be fixed
instead of with this special case then by adjusting its idle state
parameters (e.g., in the case of Atom). Anyway that's for another
time and doesn't affect powerpc.

Thanks,
Nick
