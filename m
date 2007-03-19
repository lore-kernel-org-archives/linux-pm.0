From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] dynamic device power management proposal
Date: Mon, 19 Mar 2007 11:44:55 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0703191135360.14222-100000@iolanthe.rowland.org>
References: <1174295302.31250.1.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174295302.31250.1.camel@sli10-conroe.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 19 Mar 2007, Shaohua Li wrote:

> Runtime device power management or dynamic device power management
> (dpm).
> =

> Why dpm: =

>      1. put an idle device into low power state to save power =

>      2. speed up S3/S4. In resume time, we could resume devices only as
>         the devices are used. In suspend time, we could skip suspended
>         devices. (suspend/resume a device equals to change device state)
> =

> Basically we need device driver support, a kernel framework and a policy
> (determine when to change a device=E2=80=99s power state).

A lot of development along these lines has already been going on in the =

USB subsystem.  It isn't complete yet, but a lot of the ideas you raise =

have already been implemented.

> I think we need answer below questions:
> 1. How to present device=E2=80=99s power info/control interface to policy.
> Unlike ACPI Dx state, a device=E2=80=99s power state might depend on seve=
ral
> parameters, like voltage/clock. We must change several parameters in the
> meantime to switch device=E2=80=99s power state.
> 2. How to handle devices dependences. For example, for a PCI endpoint
> and a pci bridge above the pci endpoint, we should suspend pci endpoint
> device first and then suspend pci bridge and vice versa in resume. On
> the other hand, two devices might not have such relationship. Two
> devices might haven=E2=80=99t any bus relationship. Eg, in embedded syste=
m, a
> clock might drive several devices under different buses.
> 3. How to detect if a device is idle.

These issues are where you are liable to run into trouble.  There are =

extremely dependent on the type of platform, bus, and device.  USB is =

particularly simple in this respect.

> 4. where should policy be, kernel/userspace. Userspace policy is
> flexible, but userspace policy has some limitations like being swapped
> out. The limitations don=E2=80=99t impact suspend device, but resume devi=
ce
> should be quick, eg suspended device should be resumed quickly soon
> after new service request is coming.
> =

> My proposal: =

>      1. device=E2=80=99s power parameters. If a device=E2=80=99s power st=
ate depends on
>         several parameters, we can map different parameters combining
>          to a single index, which looks like ACPI Dx state. In this way,
>         dpm framework and policy have a generic interface to get/set
>         device=E2=80=99s state. Each state exports some info, including t=
his
>         state=E2=80=99s power consumption/latency. Device driver can expo=
rt
>         extra info to policy, dpm framework doesn=E2=80=99t handle the ex=
tra
>         info, but policy can. =

>      2. The device dependence varies from different systems especially
>         for embedded system. The idea is dpm framework handles device
>         dependence (like, resume a device=E2=80=99s parent before resume =
the
>         device itself), and policy inputs the dependence data to dpm
>         framework. As device dependence exists, device driver shouldn=E2=
=80=99t
>         directly resume a device. Instead, let dpm framework resumes the
>         device and handle dependence in the meantime. To input
>         dependence data, policy should know device=E2=80=99s unique name =
and dpm
>         framework can get corresponding dpm device from the name.
>         Different buses have different device naming methods. To assign
>         a unified name to each device, I just give each device an id
>         regardless which bus the device is on. =

>      3. detect if a device is idle. The idea is each device has a busy
>         timestamp. Every time the driver wants to handle the device,
>         driver will update the timestamp. Policy can poll the timestamp
>         to determine if the device is idle. =


That's not how the USB implementation works.  Although a timestamp like =

the one you describe is going to be added.

>      4. policy position. The idea is policy resides on userspace. Dpm
>         framework exports device=E2=80=99s busy timestamp, state info,
>         dependence setting to userspace. According to the info, policy
>         suspends a device in specific time. Resuming a device is
>         directly done by dpm framework in kernel.

In USB, we export the idle-time delay value (device is autosuspended =

when it has been idle longer than this) and an administrative power-level =

atttribute: on, auto, or suspend.  When set to "on" the device will not =

autosuspend; when set to "auto" the device will autosuspend and autoresume =

according to the delay setting; when set to "suspend" the device will be =

suspended and will not autoresume.

(This is cutting-edge stuff, not all present even in the development
trees.  But we're getting there.)

The API design is documented, so far as it exists, by the kerneldoc in =

drivers/usb/core/driver.c.

Alan Stern
