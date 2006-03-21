From: "Gross, Mark" <mark.gross@intel.com>
Subject: RE: CE Linux Forum PM Requierments WiKi is available for
	review and comment.
Date: Tue, 21 Mar 2006 15:49:38 -0800
Message-ID: <5389061B65D50446B1783B97DFDB392D2042B3@orsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============86846984806114835=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: linux-pm@osdl.org, PMWG@LIST.CELINUXFORUM.ORG, mli_tech@groups.osdl.org, celinux-dev@tree.celinuxforum.org
List-Id: linux-pm@vger.kernel.org

--===============86846984806114835==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit



>-----Original Message-----
>From: Pavel Machek [mailto:pavel@suse.cz]
>Sent: Tuesday, March 21, 2006 12:36 PM
>To: Gross, Mark
>Cc: linux-pm@osdl.org; mli_tech@groups.osdl.org; celinux-
>dev@tree.celinuxforum.org; PMWG@LIST.CELINUXFORUM.ORG
>Subject: Re: [linux-pm] CE Linux Forum PM Requierments WiKi is
available
>for review and comment.
>
>Hi!
>
>> >4. device power management seems to be missing. What is "OS
>> >throttling"?
>> >
>>
>> I'll add some stuff on device power management.
>>
>> OS throttling is the pacing of work the OS is allowed to do to
maintain
>> some power or thermal budget constraints.
>
>Hmm, okay, yes, that would be useful for machines that can't do
>throttling in hardware.

Even platforms that can throttle in hardware, it could make sense for to
throttle the OS.  

I think a person may want to throttle what work a laptop is doing as a
function of being tethered or remaining battery life.  If all you want
to do is finish those last few edits to a file before your battery cuts
you off for the rest of a long flight, you will be very willing to shut
down most (all?) processing that's not related to what you are editing.
Cron jobs, automatic spell checking, sound subsystems, screen savers,
pretty much anything not related to your editing will pull down your
battery.  Most of these can be shut down from user mode, some things may
be easier to implement robustly with some kernel support.  

One idea is to extend the SCHED_BATCH idea to know about power state to
avoid running some things when un-tethered or under low battery
conditions.

>
>> >7.1 if your hardware can damage itself or hurt user *FIX YOUR
>> >HARDWARE*! Will you argue that overcharging li-ion to explosion is
also
>> ok?
>>
>> Having your hardware catch on fire or exploding is not ok.  I'll
>> re-write this a bit to avoid the inference of buggy hardware.   The
>> point is that software support is needed to do a good job for some of
>> these applications.
>>
>> However; Having the OS help avoid deep discharging your cell phone or
>> I-Pod battery because of some bug would not be unreasonable.
>
>Do li-ion batteries really care about deep discharging in
>cellphone/ipod applications? I thought single-li-ion solutions don't
>mind being deeply discharged.
>

Your correct, see halfway down
http://www.buchmann.ca/article23-page1.asp

>(In fact, that's what I'm now doing with li-ion in sharp sl-5500 --
>collie; I'm running without any powermanagement, so it dies when
>battery can no longer support CPU. I guess that's counts as deep
>discharge.)
>
>> Neither is having OS support running on hardware that is built
without
>> active cooling that avoids the HW doing an emergency power off and
>> loosing the users data.
>
>NMI watchdog / SMM comes to mind. But SMM is unlikely to be option on
>Arm machines.
>

Yup.  That's one of the troubles with ACPI on CE platforms.

>> >--
>> >Thanks, Sharp!
>>
>> Who the heck is Sharp, and why do you always thank him?
>
>That's a signature... Sharp is Japaneese firm, maybe you've heard
>about them :-). Send me handheld computer, and that line becomes
>"Thanks, Intel" ;-).

Oh! Ok, that makes sense.  BTW careful what you wish for....

--mgross


--===============86846984806114835==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============86846984806114835==--
