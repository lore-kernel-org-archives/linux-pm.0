From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re:
 =?iso-8859-1?q?Async_suspend-resume_patch_w/_completio?=
 =?iso-8859-1?q?ns_=28was=3A_Re=3A_Async=09suspend-resume_patch_w/_rwsems?=
 =?iso-8859-1?q?=29?=
Date: Sun, 20 Dec 2009 20:25:25 +0100
Message-ID: <200912202025.25618.rjw__29021.1742315025$1261337149$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<alpine.LFD.2.00.0912191557320.3712@localhost.localdomain>
	<20091220024142.GC4073@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091220024142.GC4073@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm@lists.linux-foundation.org
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Vojtech Pavlik <vojtech@suse.cz>
List-Id: linux-pm@vger.kernel.org

On Sunday 20 December 2009, Dmitry Torokhov wrote:
> On Sat, Dec 19, 2009 at 04:09:07PM -0800, Linus Torvalds wrote:
> > 
> > That said, I still get the feeling that we'd be even better off simply 
> > trying to avoid the whole keyboard reset entirely. Apparently we do it for 
> > a few HP laptops.
> 
> I was mistaken, HP laptops do not like mouse disabled when suspending,
> not sure about the rest of the state.
> 
> > It's entirely possible that we'd be better off simply 
> > not _doing_ the slow thing in the first place.
> >
> 
> The reset appeared first in 2.5.42. I expect that some BIOSes get very
> confused when tehy find mouse speaking something that they do not
> unserstand (i.e. synaptics, ALPS or anything else that is not bare PS/2
> or intellimouse), but maybe Vojtech remembers better?
>  
> > For example, we may be _much_ better off doing that whole keyboard reset 
> > at resume time than at suspend time.
> 
> We do the reset for the different reasons - at resume we want the device
> in known state to ensure that it properly responds to the probes we
> send to it. At suspend we trying to reset things into original state so
> that the firmware will not be confused.
> 
> If we want to try to live without reset we could to PSMOUSE_CMD_RESET_DIS
> instead of PSMOUSE_CMD_RESET_BAT which is much heavier. We should
> probably not wait for .34 then because the bulk of testing will happen
> only when .33 is close to be released because that's when most of
> regular users will start using the new code and try to suspend and
> resume.
> 
> Rafael, how long does suspend take if you change call to psmouse_reset()
> in psmouse_cleanup() to ps2_command(&psmouse->ps2dev, NULL, PSMOUSE_CMD_RESET_DIS)?
> And do the same for atkbd...

On the nx6325 that appears to reduce the suspend time as much so the effect
of async is not visible any more.  On the Wind it decreases the total suspend
time almost by half!

Please push this patch to Linus. :-)

> BTW, making just serio asynchronous while keeping i8042 synchronous
> makes no sense because I serialize access to i8042 - the thing does not
> survive simultaneous [command] access to both keyboard and mouse...

OK

Rafael
