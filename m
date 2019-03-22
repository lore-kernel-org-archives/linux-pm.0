From: "Rafael J. Wysocki" <rafael@kernel.org>
Subject: Re: [PATCH 1/2] cpuidle : auto-promotion for cpuidle states
Date: Fri, 22 Mar 2019 10:45:55 +0100
Message-ID: <CAJZ5v0gY-theHng=bQQpw-33jHGe++iEigEM5j6Ls7vEuewuSQ@mail.gmail.com>
References: <20190322072942.8038-1-huntbag@linux.vnet.ibm.com> <20190322072942.8038-2-huntbag@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190322072942.8038-2-huntbag@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Abhishek Goel <huntbag@linux.vnet.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux PM <linux-pm@vger.kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Daniel Lezcano <daniel.lezcano@linaro.org>, Michael Ellerman <mpe@ellerman.id.au>
List-Id: linux-pm@vger.kernel.org

On Fri, Mar 22, 2019 at 8:31 AM Abhishek Goel
<huntbag@linux.vnet.ibm.com> wrote:
>
> Currently, the cpuidle governors (menu /ladder) determine what idle state
> an idling CPU should enter into based on heuristics that depend on the
> idle history on that CPU. Given that no predictive heuristic is perfect,
> there are cases where the governor predicts a shallow idle state, hoping
> that the CPU will be busy soon. However, if no new workload is scheduled
> on that CPU in the near future, the CPU will end up in the shallow state.
>
> In case of POWER, this is problematic, when the predicted state in the
> aforementioned scenario is a lite stop state, as such lite states will
> inhibit SMT folding, thereby depriving the other threads in the core from
> using the core resources.
>
> To address this, such lite states need to be autopromoted. The cpuidle-
> core can queue timer to correspond with the residency value of the next
> available state. Thus leading to auto-promotion to a deeper idle state as
> soon as possible.

Isn't the tick stopping avoidance sufficient for that?
