From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH 2/2] powernv: Pass PSSCR value and mask to power9_idle_stop
Date: Tue, 04 Oct 2016 21:32:23 +1100
Message-ID: <87int84d6w.fsf@concordia.ellerman.id.au>
References: <cover.1475130107.git.ego@linux.vnet.ibm.com>
 <21e080ffa52f432b40750028a624aee1baebbaf7.1475130107.git.ego@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <21e080ffa52f432b40750028a624aee1baebbaf7.1475130107.git.ego@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppe-linuxppc-embedded-2=m.gmane.org@lists.ozlabs.org>
To: Stewart Smith <stewart@linux.vnet.ibm.com>, skiboot@lists.ozlabs.orgskiboot@lists.ozlabs.org
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, Michael Neuling <mikey@neuling.org>, linux-pm@vger.kernel.org, Daniel Lezcano <daniel.lezcano@linaro.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, "Shreyas B. Prabhu" <shreyasbp@gmail.com>, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> writes:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> The power9_idle_stop method currently takes only the requested stop
> level as a parameter and picks up the rest of the PSSCR bits from a
> hand-coded macro. This is not a very flexible design, especially when
> the firmware has the capability to communicate the psscr value and the
> mask associated with a particular stop state via device tree.
>
> This patch modifies the power9_idle_stop API to take as parameters the
> PSSCR value and the PSSCR mask corresponding to the stop state that
> needs to be set. These PSSCR value and mask are respectively obtained
> by parsing the "ibm,cpu-idle-state-psscr" and
> "ibm,cpu-idle-state-psscr-mask" fields from the device tree.
>
> In addition to this, the patch adds support for handling stop states
> for which ESL and EC bits in the PSSCR are zero. As per the
> architecture, a wakeup from these stop states resumes execution from
> the subsequent instruction as opposed to waking up at the System
> Vector.

That looks good.

> This patch depends on the following skiboot patch that exports the
> PSSCR values and the mask for all the stop states:
> https://lists.ozlabs.org/pipermail/skiboot/2016-September/004869.html

But we can't depend on a skiboot patch. The kernel has to cope with
running on an old skiboot.

I realise this is for Power9, and we haven't shipped any of them yet.
But skiboot has had Power9 support since May, so I don't think we want
to declare that all of those skiboot versions are unsupported because of
this.

So is there any way we can make this work on skiboot versions that don't
have the patch above?

cheers
