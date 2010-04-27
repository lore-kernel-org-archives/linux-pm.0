From: Michal Hocko <mhocko@suse.cz>
Subject: Re: commit 9630bdd9 changes behavior of the poweroff -
	bug?
Date: Tue, 27 Apr 2010 09:04:05 +0200
Message-ID: <20100427070405.GA6170__34885.9249883846$1272351904$gmane$org@tiehla.suse.cz>
References: <20100401133923.GA4104@tiehlicka.suse.cz>
	<20100419115942.GC5160@tiehlicka.suse.cz>
	<201004191719.53602.rjw@sisk.pl> <201004250435.42779.rjw@sisk.pl>
	<20100426150503.GA4005@tiehlicka.suse.cz>
	<alpine.LFD.2.00.1004261130090.3999@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.00.1004261130090.3999@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Tony Vroon <tony@linx.net>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Hi Len,

On Mon 26-04-10 12:22:58, Len Brown wrote:
> Michal,
> 
> > my laptop changed behavior during poweroff recently (after upgrading
> > from .33 to .34-rc1). The system seems to be powered off (status display
> > is off) at first glance but when I close the lid then I can hear a noise
> > which sounds like HDD parking and when I open lid again it starts
> > booting without poweroff button (same like when I suspend to RAM).
> 
> Tony,
> 
> > I have the exact same "lid close = powering back on" regression on a
> > Fujitsu-Siemens Lifebook S6420.
> 
> Perhaps you can review this description and help me
> better understand the symptoms?
> 
> Michal,
> Re: poweroff
> 
> Before the regression you could hear the HDD park as a result of the

It is hard to tell whether this sound comes from HDD and I think that it
is actually something different as I've realized that I've heard this
kind of sound only when system was suspended to RAM and lid was closed.
Never during poweroff.

> "poweroff" command without touching the lid, and after the regression
> you don't hear that sound until after you close the lid -- no matter
> how long you wait to close the lid?

Yes. Also the main difference is that the laptop turns on automatically
after lid is open which did not happen before.

> 
> During this period after poweroff and LCD goes out, but before
> lid close, are there any other signs of life?  eg. does caps
> lock button light the caps LED?

No signs of life at all. The small display which shows the status
(charging, battery status, caps lock, num lock, etc.) is turned off.
No reaction to any key press.

> 
> How about during this period if you press the power button and
> hold it for 5 seconds, does that cause the HDD parking sound?

No sound. Even when I closed the lid. Nevertheless, laptop doesn't
start automatically after lid is open.

> 
> If yes, then the regression is that poweroff never completes,
> though perhaps a lid event allows it to complete.
> 
> When you say 'when I open the lid again i starts booting'.
> Is that a cold boot from scratch, or a resume from suspend?

Cold boot.

> 
> Does the new boot start when the lid is closed, or when it is
> subsequently opened?

I have not seen start during lid being closed. As I already said, the
system starts up automatically when I open the lid.

> 
> Thanks for sending your /proc/acpi/wakeup, it shows that
> 
> LID       S4    *enabled  
> 
> which means that the LID is not an S5 wakeup device.
> So if you really do get down to S5, the LID should
> not be able to wake the system.  So if it is, then
> we are never getting to S5.
> 
> Tony,
> Please send the /proc/acpi/wakeup file before and after
> the regression.  Does the system reach a complete poweroff
> before the lid is closed?  If yes, what happens when
> you press the power button w/o closing the lid?
> If you reached S5, it should give you a cold boot.
> If you did not reach S5, it will have no effect.
> 
> thanks,
> Len Brown, Intel Open Source Technology Center
> 

Thanks!
-- 
Michal Hocko
L3 team 
SUSE LINUX s.r.o.
Lihovarska 1060/12
190 00 Praha 9    
Czech Republic
