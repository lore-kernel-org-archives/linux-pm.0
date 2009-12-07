From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 6 Dec 2009 22:15:49 -0800
Message-ID: <20091207061548.GB21451__33340.8926883296$1260166621$gmane$org@core.coreip.homeip.net>
References: <alpine.LFD.2.00.0912051635330.3560@localhost.localdomain>
	<200912060254.10081.rjw@sisk.pl>
	<alpine.LFD.2.00.0912051758190.3560@localhost.localdomain>
	<20091206113555.5a646713@infradead.org>
	<alpine.LFD.2.00.0912061144100.3560@localhost.localdomain>
	<20091206121803.70385c33@infradead.org>
	<7AB497C7-8495-4535-9E83-81307E008BF4@gmail.com>
	<20091206171856.394ce6d8@infradead.org>
	<20091207022706.GA20770@core.coreip.homeip.net>
	<20091206213112.568c602b@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091206213112.568c602b@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 06, 2009 at 09:31:12PM -0800, Arjan van de Ven wrote:
> On Sun, 6 Dec 2009 18:27:07 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > On Sun, Dec 06, 2009 at 05:18:56PM -0800, Arjan van de Ven wrote:
> > > On Sun, 6 Dec 2009 14:54:48 -0800
> > > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > > 
> > > > Yes, that's your PS/2 mouse (rather touchpad) and the delay comes
> > > > from device reset (needed by some keyboard controllers - I
> > > > remember HP -or it and keyboard will be dead at resume).
> > > > 
> > > 
> > > btw could we do this reset in an async function call (as long as we
> > > wait for it to complete before we pull the plug finally) ?
> > 
> > It has to complete before we start shutting down i8042, so there are
> > dependencies involved...
> 
> async function calls have 2 methods for synchronization:
> 
> * inside an async function, you can wait for all "earlier" async
>   functions to complete  (async_synchronize_cookie)
> * outside an async function, you can wait for all scheduled async
>   functions to complete (async_synchronize_full)
> 
> so there's two options to use the async code to cut down this time:
> 
> 1) Make both the mouse, keyboard AND the i8042 suspend functions async,
>    and in the i8042 function the code first synchronizes on all previous
>    async work
> 2) only make the mouse and keyboard suspend async, and just wait for all
>    async work in i8042 suspend
> 
> I strongly prefer number 1, in terms of getting the best suspend speed.
> It means that all other suspend code can run in parallel to the whole
> serio/i8042 suspend.
> Option two is simpler, but the delay is in the normal, synchronous path,
> so other suspend code will not run in parallel.
> 
> The good news is that neither is hard for someone familiar with the
> code...
> 

And the bad thing is that violates multiple layers in the kernel.  Atkbd
driver does not have to be using i8042; neither does psmouse. Althtough
they do in 99% of the cases there are other controllers providing the
i8042-style ports. Just grep for SERIO_8042 in drivers/input/serio.

I do not want to hard-code the i8042-psmouse-atkbd dependency.

-- 
Dmitry
