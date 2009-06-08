From: Ingo Molnar <mingo@elte.hu>
Subject: Re: Run-time PM idea (was: Re: [RFC][PATCH 0/2]
	PM:	Rearrange core suspend code)
Date: Mon, 8 Jun 2009 16:21:54 +0200
Message-ID: <20090608142154.GD14234__41098.1891597205$1244470976$gmane$org@elte.hu>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org>
	<20090608131159.GA15100@srcf.ucam.org>
	<20090608132235.GC13214@elte.hu>
	<200906081539.20459.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200906081539.20459.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org


* Oliver Neukum <oliver@neukum.org> wrote:

> Am Montag, 8. Juni 2009 15:22:35 schrieb Ingo Molnar:
> 
> > What will the 'user space policy' bit do what the kernel cannot?
> >
> > If you mean the user has to configure something manually - that 
> > wont really happen in practice. We are happy if they know where 
> > to put those USB sticks in ;-)
> 
> User space need not be the user. Currently user space doesn't tell 
> the kernel how much functionality it needs. open/close give a 
> binary opposition which badly maps onto the graduated capabilities 
> devices have.

If the kernel isnt told what capabilities are used that's buggy code 
then.

> For example do you really need every key pressed while the screen 
> saver is running or is it enough for the keyboard to be able to 
> generate a wakeup event?

The sane default here is to suspend the keyboard, except if an audio 
app is running that binds to the volume keys of the keyboard.

If the 'keyboard' is properly abstracted in the kernel and the 
kernel driver _knows_ that the volume keys are in use, this is not a 
problem.

Arguing otherwise is just saying the equivalent of: "we have a 
broken model to utilize hardware, and instead of fixing it properly, 
introduce an _even more broken_ model, because in the current model 
things cannot be made to work".

The kernel _needs_ to have precise information about whether a piece 
of hardware is in use or not.

	Ingo
