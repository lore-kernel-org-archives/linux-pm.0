From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: Attempted summary of suspend-blockers LKML thread
Date: Fri, 6 Aug 2010 13:30:48 +0100
Message-ID: <20100806123047.GE31326__12445.8913262517$1281098055$gmane$org@sirena.org.uk>
References: <AANLkTi=Yyyc-hOPbkJtsnKCVzncnFq8DPnonmyckekwm@mail.gmail.com>
	<20100805203102.GN2447@linux.vnet.ibm.com>
	<AANLkTimaaLSwVusJ=w5-QptoauBnHH0JvCvmWUr0y+KD@mail.gmail.com>
	<alpine.DEB.2.00.1008051453450.30632@asgard.lang.hm>
	<AANLkTikCCeMG=DAQ04xqkvqH9tngBWyBA5VQTD4_15xU@mail.gmail.com>
	<20100805230304.GQ2447@linux.vnet.ibm.com>
	<AANLkTinatKEBfHhMnKc5wbys13P81PKWSc+nxccgHe-Y@mail.gmail.com>
	<alpine.DEB.2.00.1008051715520.30632@asgard.lang.hm>
	<AANLkTikOuY-q42mDRmxc-9W0uLeJeW-hiFG26WrV7CfU@mail.gmail.com>
	<alpine.DEB.2.00.1008051800360.25170@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1008051800360.25170@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: paulmck@linux.vnet.ibm.com, peterz@infradead.org, Brian Swetland <swetland@google.com>, linux-kernel@vger.kernel.org, florian@mickler.org, linux-pm@lists.linux-foundation.org, kevin granade <kevin.granade@gmail.com>, tglx@linutronix.de, alan@lxorguk.ukuu.org.uk, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Aug 05, 2010 at 06:01:24PM -0700, david@lang.hm wrote:
> On Thu, 5 Aug 2010, Brian Swetland wrote:

>> Obviously not all clocks are stopped (the DSP and codec are powered
>> and clocked, for example), but yeah we can clock gate and power gate
>> the cpu and most other peripherals while audio is playing on a number
>> of ARM SoC designs available today (and the past few years).

> does this then mean that you have multiple variations of suspend?

> for example, one where the audio stuff is left powered, and one where it  
> isn't?

This was the core of the issue I was raising in the last thread about
this (the one following the rename to suspend blockers).  Essentially
what happens in a mainline context is that some subsystems can with
varying degress of optionality ignore some or all of the instruction to
suspend and keep bits of the system alive during suspend.

Those that stay alive will either have per subsystem handling or will be
outside the direct control of the kernel entirely (the modem is a good
example of the latter case in many systems - in terms of the software
it's essentially a parallel computer that's sitting in the system rather
than a perhiperal of the AP).
