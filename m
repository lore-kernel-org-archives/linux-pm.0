From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] cpuidle/powernv: Enter fastsleep on checking if deep
 idle states are allowed
Date: Mon, 15 Sep 2014 08:23:16 -0400
Message-ID: <1410783796.31754.85.camel@pasglop>
References: <20140912110131.7311.86417.stgit@preeti.in.ibm.com>
	 <1410764352.32643.2.camel@concordia> <5416A8B0.8040603@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <5416A8B0.8040603@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, mikey@neuling.org, linux-pm@vger.kernel.org, rjw@rjwysocki.net, linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: linux-pm@vger.kernel.org

On Mon, 2014-09-15 at 14:22 +0530, Preeti U Murthy wrote:
> > We were talking about getting rid of powersave_nap altogether, but I
> think we
> > decided we couldn't, I forget.
> 
> Isn't this a helpful knob to disable cpuidle at runtime? Currently we
> check the value of powersave_nap before entering both nap and
> fastsleep.

It's useful when diagnosing some problems that can be caused by idle
states.

Cheers,
Ben.
