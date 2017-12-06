From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] cpufreq: powernv: Define methods to parse positive &
 negative pstates
Date: Wed, 06 Dec 2017 21:54:27 +1100
Message-ID: <87r2s8dt3w.fsf@concordia.ellerman.id.au>
References: <1512017018-4857-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
In-Reply-To: <1512017018-4857-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Errors-To: linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+glppd-linuxppc64-dev=m.gmane.org@lists.ozlabs.org>
To: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, linux-pm@vger.kernel.org
Cc: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>, viresh.kumar@linaro.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, huntbag@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, akshay.adiga@linux.vnet.ibm.com
List-Id: linux-pm@vger.kernel.org

Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com> writes:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
>
> Pstates are 8bit values but on POWER8 they are negative and on POWER9
> they are positive. This patch adds helper routines to differentiate
> the sign to read the correct pstate value.

This sounds like it could be a bad bug, but I can't really tell from the
change log. What is the actual impact of not having this patch?

Should it have a Fixes/Cc-stable tag?

cheers
