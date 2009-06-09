From: Jiri Kosina <jkosina@suse.cz>
Subject: Re: Run-time PM idea (was: Re: [RFC][PATCH 0/2] PM:
 Rearrange core suspend code)
Date: Wed, 10 Jun 2009 00:44:58 +0200 (CEST)
Message-ID: <alpine.LRH.2.00.0906100039370.31685__45263.091082643$1244655405$gmane$org@twin.jikos.cz>
References: <Pine.LNX.4.44L0.0906071651060.25203-100000@netrider.rowland.org>
	<20090608131159.GA15100@srcf.ucam.org>
	<20090608132235.GC13214@elte.hu>
	<200906081539.20459.oliver@neukum.org>
	<20090608142154.GD14234@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090608142154.GD14234@elte.hu>
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

On Mon, 8 Jun 2009, Ingo Molnar wrote:

> > For example do you really need every key pressed while the screen 
> > saver is running or is it enough for the keyboard to be able to 
> > generate a wakeup event?
> The sane default here is to suspend the keyboard, except if an audio 
> app is running that binds to the volume keys of the keyboard.
> If the 'keyboard' is properly abstracted in the kernel and the 
> kernel driver _knows_ that the volume keys are in use, this is not a 
> problem.

So, if you want to abstract this properly, you are proposing that the 
application should in some sense "bind to keyboard keys"?

That has several drawbacks:

- applications in the current universe don't do that
- it's awful overhead: 
  + it apparently wouldn't have any other use than for waking up from 
    autosuspended mode (possibly while screensaver is running)
  + I believe that application writers will find it a little boring to 
    have to start all their main() functions with explicit eunumeration of 
    the keys the application is expecting :)
- even if we require applications to do so, there will be ones violating 
  this rule (i.e. kernel only knows what userspace tells him, in this 
  situation ... is this reliable enough?)

To sum it up -- I don't think that what you are proposing will work.

Thanks,

-- 
Jiri Kosina
SUSE Labs
