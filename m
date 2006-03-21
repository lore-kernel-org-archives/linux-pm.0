From: "Gross, Mark" <mark.gross@intel.com>
Subject: RE: CE Linux Forum PM Requierments WiKi is available for
	review and comment.
Date: Tue, 21 Mar 2006 12:09:19 -0800
Message-ID: <5389061B65D50446B1783B97DFDB392D13D1B6@orsmsx411.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============33131309715672219=="
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
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@osdl.org, PMWG@LIST.CELINUXFORUM.ORG, mli_tech@groups.osdl.org, celinux-dev@tree.celinuxforum.org
List-Id: linux-pm@vger.kernel.org

--===============33131309715672219==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

Thanks for taking the time to look at it and provide a response.

>-----Original Message-----
>From: Pavel Machek [mailto:pavel@ucw.cz]
>Sent: Sunday, March 19, 2006 11:22 AM
>To: Gross, Mark
>Cc: linux-pm@osdl.org; mli_tech@groups.osdl.org; celinux-
>dev@tree.celinuxforum.org; PMWG@LIST.CELINUXFORUM.ORG
>Subject: Re: [linux-pm] CE Linux Forum PM Requierments WiKi is
available
>for review and comment.
>
>Hi!
>
>Please do not post html to the lists.

Yeah, I know that's why I re-sent a non-HTML version.  
My bad....

>
>> Please visit
>> http://tree.celinuxforum.org/CelfPubWiki/CELFPmRequirements2006
>>
>>
>>
>> This is a simple draft requirements document listing the candidate
items
>> that may be included in a final PM requirements PDF document.  The
CELF
>> PM Working group is trying to define a set of requirements from which
>> some projects and investigations will be derived.  We very much
welcome
>> input and ideas from the larger development community.
>...
>> All public comments, private comments, and WiKi edits are welcome.
>
>
>4. device power management seems to be missing. What is "OS
>throttling"?
>

I'll add some stuff on device power management.  

OS throttling is the pacing of work the OS is allowed to do to maintain
some power or thermal budget constraints.

>You seem to want to do device throttling. Device powering off should
>be there, too.

Yes.  I'll add device power control to the list.

>
>5.1 you seem to dislike ACPI, but I guess you should add proposal to
>new /sys interface.
>

I LOVE ACPI!  Doesn't everyone? :)

However; many CE platforms don't have the platform FW / BIOS
infrastructure needed to make ACPI operate.  ACPI is just not an option
for most CE platforms.

Yes new /sys interfaces will likely be needed.  We haven't drilled down
on what they should be just yet.  

>6.1 "UI responsiveness governor"? That sounds more like usermode
>governor, and we have that one already. Thermal governor should not be
>needed, it should be included in *every* governor.
>

Actually to do a good job at this you need to know the latency from
interrupt to scheduling the process responding to the event.  You can't
do this type of control from the user mode governor without some kernel
support.


>7.1 if your hardware can damage itself or hurt user *FIX YOUR
>HARDWARE*! Will you argue that overcharging li-ion to explosion is also
ok?
>

Having your hardware catch on fire or exploding is not ok.  I'll
re-write this a bit to avoid the inference of buggy hardware.   The
point is that software support is needed to do a good job for some of
these applications.

However; Having the OS help avoid deep discharging your cell phone or
I-Pod battery because of some bug would not be unreasonable.

Neither is having OS support running on hardware that is built without
active cooling that avoids the HW doing an emergency power off and
loosing the users data.

>9 uswsusp should be able to suspend-to-flash.
>
>9.2 yep, I'm telling you this is easy to do. No need to change kernel,
>even, just needs recent -mm.

This is good.

>
>								Pavel
>--
>Thanks, Sharp!

Who the heck is Sharp, and why do you always thank him?


--===============33131309715672219==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============33131309715672219==--
