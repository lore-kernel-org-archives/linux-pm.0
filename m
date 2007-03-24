From: Dmitry Krivoschekov <dmitry.krivoschekov@gmail.com>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Sat, 24 Mar 2007 03:41:45 +0300
Message-ID: <460473C9.4080402@gmail.com>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>	<200703231443.19536.rjw@sisk.pl>	<200703231057.16539.david-b@pacbell.net>
	<200703232139.38721.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200703232139.38721.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: alexey.y.starikovskiy@intel.com, dirk.behme@de.bosch.com, johannes@sipsolutions.net, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, nico@cam.org, ben@simtec.co.uk, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Friday, 23 March 2007 18:57, David Brownell wrote:
>> On Friday 23 March 2007 6:43 am, Rafael J. Wysocki wrote:
>>> On Friday, 23 March 2007 00:55, David Brownell wrote:
>>>> You said that if the hardware doesn't support a "turn CPU off" mode, t=
hen
>>>> you'd define that as being incapable of implementing suspend-to-RAM.
>>> That's _if_ the suspend-to-RAM is defined as the state in which the CPU
>>> is off, which I _think_ would be a reasonable definition.  =

>> I disagree.
>
> Fine, this only is a matter of opinion. :-)
>  =

>>> I don't mean the =

>>> platforms incapable of doing this should be restricted from entering any
>>> system-wide low-power states, but perhaps we can call these states
>>> differently.
>> Well, we have ** ONLY TWO LABELS TO APPLY ** and you're saying that
>> one of them should be restricted to systems where the CPU can go into
>> an "off" state.  =

>
> As long as you insist on using two lables only and these two labels in
> particular, then fine.  [Well, in such a case I'd change them to something
> different (like "suspend level 1", "suspend level 2").]
>
> Still, technically it doesn't really matter.  What matters is that we nee=
d to
> tell drivers what we expect them to do with the devices when we're
> transitioning from one state to another system-wide.  And that, IMO, shou=
ld
> be defined.

just my 2 cents...

The following system-wide low power states seem reasonable to me,
at least from embedded system perspective, at least as a reasonable
compromise for now...


Wait          -  CPU is inactive (idle, WFI or whatever lowpower state
                 it can leave immediately (the fastest from supported
mods)),
                 all drivers are active to be immediately ready
                 after CPU gets run

Doze          - The same as Wait mode but devices that pre-configured
                as "must_disable" should  be switched off
                (flag must_disable slould be added to dev_pm_info,
                and maybe appropriate sysfs interface as well)

Sleep         - CPU is in low power state that do not require
                restoring of registers, RAM is
                in self-refresh mode only devices configured
                via "may_wakeup" stay capable to wakeup
                (on various system it depends,
                i.e. the devices should be left active, or may
                be capable to wakeup even in lowpower state ),
                other devices are switched off.


DeepSleep     - the same as sleep but CPU is in the lowest of supported
                power states, RAM is switched off data should be saved
                (to disk,to flash)


Considering system-wide states, I don't think we should take care
of saying to devices which lowpower state they should go to, perhaps
it should be the lowest state (or in "DeepSleep" and "Sleep"
it is the lowest but in "Doze" it is medium).
This system wide states is pretty rough way to control system power,
if fine-grained PM is required then  we should think of another
ways to control it, /sys/power/state seems not the best interface
for this.



Regards,
Dmitry
