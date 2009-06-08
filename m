From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Run-time PM idea (was: Re: [RFC][PATCH 0/2]
	PM:	Rearrange core suspend code)
Date: Mon, 8 Jun 2009 16:11:56 +0100
Message-ID: <20090608151156.GA17805__5981.48457143015$1244473975$gmane$org@srcf.ucam.org>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org>
	<20090608131159.GA15100@srcf.ucam.org>
	<20090608132235.GC13214@elte.hu>
	<200906081539.20459.oliver@neukum.org>
	<20090608142154.GD14234@elte.hu>
	<20090608143023.GA16752@srcf.ucam.org>
	<20090608150603.GB20905@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
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

On Mon, Jun 08, 2009 at 05:06:03PM +0200, Ingo Molnar wrote:

> But if you think that tracking the usage state of the hardware is 
> 'complexity', then you very much dont know what you are talking 
> about. The main task of the kernel is to track hardware usage and to 
> abstract away the fact that the same hardware is used by multiple 
> tasks, and to do it safely. It's what the kernel does all day.

What I'm saying is that you don't *know* what the usage state of the 
hardware is, and in many cases you can't know. A given user may be happy 
to sacrifice their SATA hotplug support. Another with identical hardware 
may not. A given network application may be mission critical and 
intolerant of the network interface being shut down. The same 
application in a different context may not. We'd need to provide a 
bewildering array of interfaces to distinguish between these situations, 
and we'd be unable to turn on autosuspend until the entirity of 
userspace had been ported to them.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
