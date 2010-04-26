From: Len Brown <lenb@kernel.org>
Subject: Re: commit 9630bdd9 changes behavior of the poweroff -
	bug?
Date: Mon, 26 Apr 2010 12:22:58 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.1004261130090.3999__26835.774703841$1272299234$gmane$org@localhost.localdomain>
References: <20100401133923.GA4104@tiehlicka.suse.cz>
	<20100419115942.GC5160@tiehlicka.suse.cz>
	<201004191719.53602.rjw@sisk.pl> <201004250435.42779.rjw@sisk.pl>
	<20100426150503.GA4005@tiehlicka.suse.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <20100426150503.GA4005@tiehlicka.suse.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Michal Hocko <mhocko@suse.cz>
Cc: Tony Vroon <tony@linx.net>, linux-kernel@vger.kernel.org, Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

Michal,

> my laptop changed behavior during poweroff recently (after upgrading
> from .33 to .34-rc1). The system seems to be powered off (status display
> is off) at first glance but when I close the lid then I can hear a noise
> which sounds like HDD parking and when I open lid again it starts
> booting without poweroff button (same like when I suspend to RAM).

Tony,

> I have the exact same "lid close = powering back on" regression on a
> Fujitsu-Siemens Lifebook S6420.

Perhaps you can review this description and help me
better understand the symptoms?

Michal,
Re: poweroff

Before the regression you could hear the HDD park as a result of the
"poweroff" command without touching the lid, and after the regression
you don't hear that sound until after you close the lid -- no matter
how long you wait to close the lid?

During this period after poweroff and LCD goes out, but before
lid close, are there any other signs of life?  eg. does caps
lock button light the caps LED?

How about during this period if you press the power button and
hold it for 5 seconds, does that cause the HDD parking sound?

If yes, then the regression is that poweroff never completes,
though perhaps a lid event allows it to complete.

When you say 'when I open the lid again i starts booting'.
Is that a cold boot from scratch, or a resume from suspend?

Does the new boot start when the lid is closed, or when it is
subsequently opened?

Thanks for sending your /proc/acpi/wakeup, it shows that

LID       S4    *enabled  

which means that the LID is not an S5 wakeup device.
So if you really do get down to S5, the LID should
not be able to wake the system.  So if it is, then
we are never getting to S5.

Tony,
Please send the /proc/acpi/wakeup file before and after
the regression.  Does the system reach a complete poweroff
before the lid is closed?  If yes, what happens when
you press the power button w/o closing the lid?
If you reached S5, it should give you a cold boot.
If you did not reach S5, it will have no effect.

thanks,
Len Brown, Intel Open Source Technology Center
