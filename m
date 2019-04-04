From: Gautham R Shenoy <ego.lkml@gmail.com>
Subject: Re: [PATCH 1/2] cpuidle : auto-promotion for cpuidle states
Date: Thu, 4 Apr 2019 16:24:37 +0530
Message-ID: <CAHZ_5WzRn-Q-E8X-_dmyn14gp1Go2LNbceNNuYnbpEcgpM-1Hw@mail.gmail.com>
References: <20190322072942.8038-1-huntbag@linux.vnet.ibm.com>
 <20190322072942.8038-2-huntbag@linux.vnet.ibm.com> <CAJZ5v0gY-theHng=bQQpw-33jHGe++iEigEM5j6Ls7vEuewuSQ@mail.gmail.com>
 <cfb0076f-0b56-f12c-a736-469a3d11ab83@linaro.org> <50f62972-dfce-52bf-d26b-32e6d2a367e2@linux.vnet.ibm.com>
 <9e542011-df6d-9b84-823b-2af6a6ef9e94@linaro.org>
Reply-To: ego@linux.vnet.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <9e542011-df6d-9b84-823b-2af6a6ef9e94@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Abhishek <huntbag@linux.vnet.ibm.com>, "Rafael J. Wysocki" <rafael@kernel.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, ego@linux.vnet.ibm.com, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
List-Id: linux-pm@vger.kernel.org

Hello Daniel,

On Thu, Apr 4, 2019 at 3:52 PM Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>
>
> Hi Abhishek,
>
> thanks for taking the time to test the different scenario and give us
> the numbers.
>
> On 01/04/2019 07:11, Abhishek wrote:
> >

[.. snip..]

>
> >>>> In case of POWER, this is problematic, when the predicted state in the
> >>>> aforementioned scenario is a lite stop state, as such lite states will
> >>>> inhibit SMT folding, thereby depriving the other threads in the core
> >>>> from
> >>>> using the core resources.
>
> I can understand an idle state can prevent other threads to use the core
> resources. But why a deeper idle state does not prevent this also?

On POWER9, we have the following classes of platform idle states
(called stop states)

lite    : These do not lose any context including the user context. In
this state
           GPRs are also preserved (stop0_lite)

shallow : These lose user context,but not the hypervisor context. So
GPRs are lost but
               not SPRs. (stop0, stop1, stop2)

deep: These lose hypervisor context. (stop4, stop5)

In the case of lite stop state, only instruction dispatch on the CPU thread
is paused. The thread does not  give up its registers set in this state for the
use of its busy sibling threads in the core.  Hence, SMT folding does not
happen in this state.

With respect to shallow and deep states, not only is the instruction dispatch
paused, it also gives up its registers set for the other siblings to use
These stop states are beneficial for SMT folding.

Hence, if a CPU thread remains in a lite state for too long,
its siblings in the core would not be able to utilize the full resources
of the core for that duration, thereby inhibiting single
thread performance. This is not the case with non-lite states.

-- 
Thanks and Regards
gautham.
