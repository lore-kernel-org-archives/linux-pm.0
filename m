From: Ray Lee <ray-lk@madrabbit.org>
Subject: Re: Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM:
	Rearrange core suspend code)
Date: Mon, 8 Jun 2009 09:29:34 -0700
Message-ID: <2c0942db0906080929r31e39fe5w673ed877bb5f4966__30732.7788942077$1244481373$gmane$org@mail.gmail.com>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org>
	<20090608131159.GA15100@srcf.ucam.org>
	<20090608132235.GC13214@elte.hu>
	<200906081539.20459.oliver@neukum.org> <20090608142154.GD14234@elte.hu>
	<20090608143023.GA16752@srcf.ucam.org> <20090608150603.GB20905@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090608150603.GB20905@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, Jun 8, 2009 at 8:06 AM, Ingo Molnar<mingo@elte.hu> wrote:
>
> * Matthew Garrett <mjg59@srcf.ucam.org> wrote:

>> I'd like the kernel to expose this functionality but leave the
>> policy decisions to userland.
>
> The thing is, suspending something that is being used and relied on
> by an app is a _bug_. This is rather fundamental: hardware state and
> usage tracking is _NOT POLICY_.

Yes. But, actual example time: what about the case where completely
turning off a laptop's DVD drive saves extra power, but then also
turns off kernel and userspace notification of a disc being inserted?

One of the Other OS's handles this by having a popup when the battery
gets low, asking if it's okay to turn the drive off. This is part of
what Matthew is talking about here.
