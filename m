From: Darren Hart <dvhart@infradead.org>
Subject: Re: RFC: WMI Enhancements
Date: Tue, 18 Apr 2017 15:49:31 -0700
Message-ID: <20170418224931.GA21569@fury>
References: <20170412230854.GA11963@fury>
 <3317007.TCiWpp4m4U@aspire.rjw.lan>
 <20170418163325.GC25405@fury>
 <201704182128.36169@pali>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <platform-driver-x86-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <201704182128.36169@pali>
Sender: platform-driver-x86-owner@vger.kernel.org
To: Pali =?iso-8859-1?Q?Roh=E1r?= <pali.rohar@gmail.com>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Andy Lutomirski <luto@amacapital.net>, Len Brown <len.brown@intel.com>, Corentin Chary <corentin.chary@gmail.com>, Mario Limonciello <Mario_Limonciello@dell.com>, Andy Lutomirski <luto@kernel.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, LKML <linux-kernel@vger.kernel.org>, platform-driver-x86@vger.kernel.org, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, Apr 18, 2017 at 09:28:36PM +0200, Pali Rohár wrote:
> On Tuesday 18 April 2017 18:33:25 Darren Hart wrote:
> > On Tue, Apr 18, 2017 at 03:07:06PM +0200, Rafael Wysocki wrote:
> > > On Monday, April 17, 2017 04:10:51 PM Darren Hart wrote:
> > > > On Mon, Apr 17, 2017 at 03:03:29PM -0700, Andy Lutomirski wrote:
> > > > > On Fri, Apr 14, 2017 at 4:05 PM, Darren Hart
> > > > > <dvhart@infradead.org> wrote:
> > > > > > On Sat, Apr 15, 2017 at 12:45:30AM +0200, Rafael Wysocki
> > > > > > wrote:
> > > > > >> On Wednesday, April 12, 2017 04:08:54 PM Darren Hart wrote:
> > > > > >> > Hi All,
> > > > > >> > 
> > > > > >> > There are a few parallel efforts involving the Windows
> > > > > >> > Management Instrumentation (WMI)[1] and dependent/related
> > > > > >> > drivers. I'd like to have a round of discussion among
> > > > > >> > those of you that have been involved in this space before
> > > > > >> > we decide on a direction.
> > > > > >> > 
> > > > > >> > The WMI support in the kernel today fairly narrowly
> > > > > >> > supports a handful of systems. Andy L. has a
> > > > > >> > work-in-progress series [2] which converts wmi into a
> > > > > >> > platform device and a proper bus, providing devices for
> > > > > >> > dependent drivers to bind to, and a mechanism for sibling
> > > > > >> > devices to communicate with each other. I've reviewed the
> > > > > >> > series and feel like the approach is sound, I plan to
> > > > > >> > carry this series forward and merge it (with Andy L's
> > > > > >> > permission).
> > > > > >> > 
> > > > > >> > Are there any objections to this?
> > > > > >> > 
> > > > > >> > In Windows, applications interact with WMI more or less
> > > > > >> > directly. We don't do this in Linux currently, although
> > > > > >> > it has been discussed in the past [3]. Some vendors will
> > > > > >> > work around this by performing SMI/SMM, which is
> > > > > >> > inefficient at best. Exposing WMI methods to userspace
> > > > > >> > would bring parity to WMI for Linux and Windows.
> > > > > >> > 
> > > > > >> > There are two principal concerns I'd appreciate your
> > > > > >> > thoughts on:
> > > > > >> > 
> > > > > >> > a) As an undiscoverable interface (you need to know the
> > > > > >> > method signatures ahead of time), universally exposing
> > > > > >> > every WMI "device" to userspace seems like "a bad idea"
> > > > > >> > from a security and stability perspective. While access
> > > > > >> > would certainly be privileged, it seems more prudent to
> > > > > >> > make this exposure opt-in. We also handle some of this
> > > > > >> > with kernel drivers and exposing those "devices" to
> > > > > >> > userspace would enable userspace and the kernel to fight
> > > > > >> > over control. So - if we expose WMI devices to userspace,
> > > > > >> > I believe this should be done on a case by case basis,
> > > > > >> > opting in, and not by default as part of the WMI driver
> > > > > >> > (although it can provide the mechanism for a sub-driver
> > > > > >> > to use), and possibly a devmode to do so by default.
> > > > > >> 
> > > > > >> A couple of loose thoughts here.
> > > > > >> 
> > > > > >> In principle there could be a "generic default WMI driver"
> > > > > >> or similar that would "claim" all WMI "devices" that have
> > > > > >> not been "claimed" by anyone else and would simply expose
> > > > > >> them to user space somehow (e.g. using a chardev
> > > > > >> interface).
> > > > > >> 
> > > > > >> Then, depending on how that thing is implemented, opt-in etc
> > > > > >> should be possible too.
> > > > > > 
> > > > > > I think we agree this would be an ideal approach.
> > > > > > 
> > > > > > As we look into this more, it is becoming clear that the
> > > > > > necessary functionality is not nicely divided into GUIDs for
> > > > > > what is necessary in userspace and what is handled in the
> > > > > > kernel. A single WMI METHOD GUID may be needed by userspace
> > > > > > for certain functionality, while the kernel drivers may use
> > > > > > it for something else.
> > > > > > 
> > > > > > :-(
> > > > > > 
> > > > > > The input to a WMI method is just a buffer, so it is very
> > > > > > free form. One approach Mario has mentioned was to audit the
> > > > > > user space WMI METHOD calls in the kernel platform drivers
> > > > > > and reject those calls with arguments matching those issued
> > > > > > by the kernel driver. This is likely to be complex and error
> > > > > > prone in my opinion. However, I have not yet thought of
> > > > > > another means to meet the requirement of having disjoint
> > > > > > feature sets for userspace and kernel space via a mechanism
> > > > > > that was effectively designed to be used solely from user
> > > > > > space with vendor defined method signatures.
> > > > > > 
> > > > > > Next step is to look at just how complex it would be to audit
> > > > > > the method calls the kernel currently uses.
> > > > > 
> > > > > I'm wondering whether it's really worth it.  We already allow
> > > > > doing darned near anything using dcdbas.  Maybe the world
> > > > > won't end if we expose a complete-ish ioctl interface to WMI.
> > > 
> > > I guess the world wouldn't end then (it has not ended for far more
> > > serious reasons so far after all), but this also doesn't feel
> > > entirely right.
> > > 
> > > For one, if something is used inside of the kernel (by drivers
> > > etc), then allowing user space to use the same thing directly is a
> > > recipe for unsupportable mess IMO.
> > 
> > I don't disagree. Unforuntately, the mechanism wasn't designed for
> > this kind of mixed usage from what I can determine, so it doesn't
> > lend itself to separation.
> 
> Yes, and this is reason why abstract generic interface has problems and 
> cannot be really generic.
> 
> > We could kick out all the WMI drivers and
> > encourage vendor/platform specific system daemons which read WMI and
> > injected events and configured LEDs through sysfs, thus eliminating
> > the user/kernel conflict - but it would only leave us with the
> > problem of multiple userspace daemons competing for the same WMI
> > METHODs -- and yeah, nobody's going for that :-D
> 
> IMO, this will only results in more problems as we already have and does 
> not bring any value. Just anarchy, like in windows world.
> 
> > > > > Also, dcdbas is, to put it mildly, a bit ridiculous.  It seems
> > > > > to be a seriously awkward sysfs interface that allows you to,
> > > > > drumroll please, issue outb and inb instructions.  It doesn't
> > > > > even check that it's running on a Dell system.  It might be
> > > > > nice to deprecate it some day in favor of a real interface. 
> > > > > I'd consider a low-level WMI ioctl interface to be a vast
> > > > > improvement.
> > > > 
> > > > I've been reluctantly arriving here as well. Given that every WMI
> > > > interface will be vendor specific, and non-discoverable, it
> > > > seems unlikely developers will eagerly duplicate kernel
> > > > functionality in user-space. And if they do, it will affect very
> > > > few platforms.
> > > > 
> > > > I still think it makes sense to only expose a WMI interface by
> > > > default on some matching criteria. It could be DMI related, but
> > > > I'd like to know if the UID is possible as well (it depends on
> > > > how vendors use the UID, if consistently, not at all, etc.)
> > > > Otherwise, the interface would not be enabled unless the user
> > > > explicitly requests it via a module parameter or similar.
> > > 
> > > To me, that should be the bare minimum, but I really think that
> > > mutual exclusion between user space and the kernel needs to be
> > > ensured somehow when the interface is enabled too.
> > > 
> > > This looks similar to exposing _DSM functionality for certain
> > > device to user space where some functions of the _DSM in question
> > > are already in use by kernel code.  In that case I would think
> > > about an interface with a function granularity (so it would check
> > > the GUID and the function and possibly the ordering with respect
> > > to the other functions too before invoking the _DSM on behalf of
> > > user space).
> > 
> > This is also what I would consider to be ideal, but the mechanism
> > doesn't lend itself to that level of granularity. WMI methods are
> > not guaranteed to be broken up into sufficiently granular
> > functionality that we can filter based on method ID. We would most
> > likely end up in the position of having to audit the input buffer of
> > every WMI call.
> 
> And still, if write audit filters for every one existing wmi driver in 
> kernel, there still audit filter can say to userspace that current 
> request cannot be accepted and sent to firmware.

For the vast majority of platforms, the WMI interface would not be exported, and
we would not attempt to write audit filters. As a rule, I would expect this
effort to be triggered by a request from the vendor, and done only with their
explicit involvement after providing complete documentation of the WMI
interface.

However, we would expect those filters to deny as few calls as possible for the
platforms that choose to export the WMI interface to userspace.

For example, dell-wmi.c would be largely unaffected as the EVENT_GUID is not
interesting for userspace (per Mario) and would not be exported. The Descriptor
GUID should be safe to share with userspace, at least for the way we use it in
the kernel. Similar for dell-wmi-aio.c

For dell-wmi-led.c, we could most likely not export the GUID at all, but if we
did, we could choose to filter on device_id or command from the bios_args used
in the input buffer.

I don't think I've seen exactly what the WMI interface for the existing SMBIOS
stuff will look like, but we seem to have a fairly structured way of accessing it
today, which should allow us to filter out those specific usages (such as
rfkill). Additionally, the concern that userspace can make use of the same
mechanism as the kernel is where we are today with libsmbios.

With WMI filters, we could, for example, deny all DELL_SMBIOS_WMI GUID calls
equivalent to "class 17, select 11" (Wireless control), since that is handled
internally. Similarly for "4,11" (KBD ALS).

> 
> This would mean that userspace application would not be able to do ANY 
> WMI method call (as e.g. on windows) and so for some vendors it can be 
> useless.

We address this with more granular filters.

> And here I'm not sure, how hard would be to write those audit filters 
> for all wmi kernel drivers and if it would be possible without wmi 
> documentation of those vendor apis (which we do not have).

As above, we won't write them for every wmi kernel driver. Only for those
vendors which engage with us to do so.

> Potential vendors can decide based on above fact, that their userspace 
> application rather rmmod wmi kernel driver for particular GUID (which 
> release occupation of wmi device) and their userspace application starts 
> working. And this is I think situation which is bad for kernel and we 
> should prevent it.

I agree we would want to avoid this. As this is off by default and only enabled
/ implemented with the cooperation of the vendor in the first place, I suspect
this kind of antagonistic interaction is unlikely.

You previously mentioned doing a vendor specific interface. This was my initial
response as well, but it doesn't meet the intent of the WMI interface, nor the
needs of vendors like Dell. That is, it requires a priori knowledge of all
current and future interfaces, and/or the continued gating on the Linux kernel
in order to allow a new method/interface. Further, by creating these interfaces,
we become more tied to them, and they will grow over time, until they are a very
large set of mostly deprecated interfaces which we can't remove for legacy
reasons.

All that said, I appreciate the concerns you've raised and they mirror many of
my own. I don't think we can just say "no, Windows Management Instrumentation is
only accessible in Linux within the kernel" as that is ultimately contrary to
the purpose of the mechanism. With those concerns in mind, I proposed the
general approach below which affords considerable freedom for vendors to manage
their systems while retaining the right to deny access to the existing Linux
kernel drivers. At the same time, it provides a general purpose interface to
userspace which won't collect legacy code we have to maintain forever.

Thanks,

> 
> > For example, we can filter things the ASUS WMI Keyboard Filter
> > method, but others are less specific, like Device Set, Bios Status,
> > Device Status, Device Policy, etc.
> > 
> > What we could do is make that the vendor's problem instead of the
> > kernel's problem. Consider:
> > 
> > * wmi.c adds method evaluation wrappers
> > * add a wmi evaluation mutex
> > * update *wmi.c drivers to use the new wrappers
> > * platform drivers (dell-wmi.c, asus-wmi.c, etc.) must explicitly
> > request wmi.c to export the wmi chardev
> > * platform drivers must explicitly whitelist each method ID to be
> > exported - they can automate this in a loop evaluating the wmi block
> > if they wish * platform drivers *may* register a wmi evaluation
> > filter which allows them to audit the method id and input buffer to
> > ensure it doesn't conflict with in-kernel usage (their usage).
> > 
> > I believe this is a reasonable compromise, and it places the burden
> > on the platform drivers, and therefor on the vendors (in the best
> > case) or the individual platform driver maintainers for less
> > cooperative vendors. This contains any resulting exposure to the
> > platforms which explicitly request it.
> 
> -- 
> Pali Rohár
> pali.rohar@gmail.com



-- 
Darren Hart
VMware Open Source Technology Center
