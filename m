From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [PATCH 05/13] PM: Add option to disable
	/sys/power/state interface
Date: Sun, 8 Feb 2009 17:35:10 -0800
Message-ID: <d6200be20902081735l734ac6c9h811b8ad6f40e2562@mail.gmail.com>
References: <1233802226-23386-1-git-send-email-arve@android.com>
	<200902090040.22364.rjw@sisk.pl>
	<d6200be20902081558r272e13b1q28692eaba758878b@mail.gmail.com>
	<200902090126.17899.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200902090126.17899.rjw@sisk.pl>
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
Cc: ncunningham@crca.org.au, u.luckas@road.de, Brian Swetland <swetland@google.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Sun, Feb 8, 2009 at 4:26 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Monday 09 February 2009, Arve Hj=F8nnev=E5g wrote:
>> On Sun, Feb 8, 2009 at 3:40 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>> > On Sunday 08 February 2009, Brian Swetland wrote:
>> >> Out of curiosity, do these changes provide a model where the system c=
an
>> >> be in suspend 99+% of the time, waking up for specific events
>> >> (voice/data telephony, user interaction, etc), and rapidly returning =
to
>> >> suspend when the processing required is complete?
>> >
>> > The changes I was referring to above were rather related to the "norma=
l"
>> > suspend (ie. the one happening as a result of writing "mem" into
>> > /sys/power/state).  Namely, we believe that for some devices it is not
>> > necessary or even desirable to allow the driver to perform all of the =
power
>> > management operations by itself.  For example, we are going to make th=
e PCI
>> > PM core (which in fact is the PCI bus type driver) handle the saving a=
nd
>> > restoration of PCI devices' configuration registers as well as putting=
 the
>> > devices into low power states and back into the full power state.  We =
can do
>> > that, because in the "normal" suspend code path the suspend routines o=
f a
>> > driver are executed by the appropriate bus type's suspend routines and=
 not
>> > directly by the PM core.  The "early suspend" mechanism seems to go ro=
und this
>> > by calling directly into device drivers.
>>
>> How do you handle devices that should be in a low power mode when
>> closed, and a high(er) power mode when open. While adding
>> early-suspend hooks to a driver may be ugly, it does not need any more
>> support than open and close does.
>
> I don't really see how the early-suspend helps here.  Can you please expl=
ain?

It does not. I was asking if your bus framework allows a driver to
power down a device when it is closed. If it does, an early suspend
hook could use the same api.

>
>> > Also, please observe that if there is a mechanism allowing us to put i=
ndividual
>> > devices, or entire subsystems (such as a bus with devices attached to =
it), into
>> > low power states at run time, without placing the entire system in a s=
leep
>> > state, and put them back into the full power state as needed, we won't=
 need
>> > anything like the "early suspend" introduced by this series of patches.
>>
>> While early-suspend is not needed, it is still convenient on an
>> embedded device where some drivers are clearly only used when the
>> screen is on.
>
> Ah, that's interesting.  So in fact you want some devices to go into low =
power
> states as soon as the screen is off and that's why you fint the early-sus=
pend
> useful.  Is this correct?

Yes. We turn off the touchscreen and trackball when the screen turns
off since both these devices use additional power when enabled.
Neither of these devices can be turned off (after a timeout) while the
screen is on.

> Still, I'm very much interested in your reply to the last paragraph of my
> message, the one that you removed.

Yes we need access to wakelocks from user space. We also allow third
party apps to use wakelocks if they request the right permission. This
could include a music player keeping the device on while playing a
song, or an pop email client using an alarm to download email every
hour.

-- =

Arve Hj=F8nnev=E5g
