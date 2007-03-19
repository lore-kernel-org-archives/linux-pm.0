From: Shaohua Li <shaohua.li@intel.com>
Subject: [RFC] dynamic device power management proposal
Date: Mon, 19 Mar 2007 17:08:22 +0800
Message-ID: <1174295302.31250.1.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-YM/nkzFVtgWe9QMezLFF"
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org


--=-YM/nkzFVtgWe9QMezLFF
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-MIME-Autoconverted: from 8bit to quoted-printable by smtp.osdl.org id l2J9BFcD016011

Runtime device power management or dynamic device power management
(dpm).

Why dpm:=20
     1. put an idle device into low power state to save power=20
     2. speed up S3/S4. In resume time, we could resume devices only as
        the devices are used. In suspend time, we could skip suspended
        devices. (suspend/resume a device equals to change device state)

Basically we need device driver support, a kernel framework and a policy
(determine when to change a device=E2=80=99s power state).

I think we need answer below questions:
1. How to present device=E2=80=99s power info/control interface to policy.
Unlike ACPI Dx state, a device=E2=80=99s power state might depend on seve=
ral
parameters, like voltage/clock. We must change several parameters in the
meantime to switch device=E2=80=99s power state.
2. How to handle devices dependences. For example, for a PCI endpoint
and a pci bridge above the pci endpoint, we should suspend pci endpoint
device first and then suspend pci bridge and vice versa in resume. On
the other hand, two devices might not have such relationship. Two
devices might haven=E2=80=99t any bus relationship. Eg, in embedded syste=
m, a
clock might drive several devices under different buses.
3. How to detect if a device is idle.
4. where should policy be, kernel/userspace. Userspace policy is
flexible, but userspace policy has some limitations like being swapped
out. The limitations don=E2=80=99t impact suspend device, but resume devi=
ce
should be quick, eg suspended device should be resumed quickly soon
after new service request is coming.

My proposal:=20
     1. device=E2=80=99s power parameters. If a device=E2=80=99s power st=
ate depends on
        several parameters, we can map different parameters combining
         to a single index, which looks like ACPI Dx state. In this way,
        dpm framework and policy have a generic interface to get/set
        device=E2=80=99s state. Each state exports some info, including t=
his
        state=E2=80=99s power consumption/latency. Device driver can expo=
rt
        extra info to policy, dpm framework doesn=E2=80=99t handle the ex=
tra
        info, but policy can.=20
     2. The device dependence varies from different systems especially
        for embedded system. The idea is dpm framework handles device
        dependence (like, resume a device=E2=80=99s parent before resume =
the
        device itself), and policy inputs the dependence data to dpm
        framework. As device dependence exists, device driver shouldn=E2=80=
=99t
        directly resume a device. Instead, let dpm framework resumes the
        device and handle dependence in the meantime. To input
        dependence data, policy should know device=E2=80=99s unique name =
and dpm
        framework can get corresponding dpm device from the name.
        Different buses have different device naming methods. To assign
        a unified name to each device, I just give each device an id
        regardless which bus the device is on.=20
     3. detect if a device is idle. The idea is each device has a busy
        timestamp. Every time the driver wants to handle the device,
        driver will update the timestamp. Policy can poll the timestamp
        to determine if the device is idle.=20
     4. policy position. The idea is policy resides on userspace. Dpm
        framework exports device=E2=80=99s busy timestamp, state info,
        dependence setting to userspace. According to the info, policy
        suspends a device in specific time. Resuming a device is
        directly done by dpm framework in kernel.

So in my proposal, dpm framework will provide some APIs for device
driver and export some info to userspace and a userspace policy
determines when to suspend a device. Attached code is my prototype to
demonstrate my idea (it even can=E2=80=99t be compiled).  With the framew=
ork,
driver/policy should do:
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Ddevice driver=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
int foo() //all service routines of the driver should do
{=20
            //wakeup the device if it=E2=80=99s suspended
            dpm_active_device();
            =E2=80=A6 //do service
            /* if necessary, mark the device busy to not suspend the
device */
            dpm_mark_device_busy();
            =E2=80=A6//do service
}

struct dpm_driver my_driver {
            .init =3D xxx_init, //initialize the dpm device, eg. the
device=E2=80=99s state info
            .get_state =3D xxx_get_state, //get current device=E2=80=99s =
power
state
            .set_state =3D xxx_set_state, //set current device=E2=80=99s =
power
state. Maybe just use .suspend/.resume here
};

driver_init()
{
            dpm_device_bind_driver(dev->dpm, &my_driver);
}

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Duser interface=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
Dpm framework will export below sysfs info for every dpm device:
            ../dpm/
                        `id      /*dpm device=E2=80=99s unique id*/
                        `state0     /*all device states=E2=80=99 info*/
                                    `power
                                    `latency
                        `stateX
                                    `power
                                    `latency
                        `state       /* get/set device state */
                        `busy_timestamp   /* device=E2=80=99s busy timest=
amp */
                        `set_dependence  /* interface to set device
dependence */
                        `status        /* device=E2=80=99s status */
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dpolicy=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
/* initialize device dependences */
Write one device=E2=80=99s id to other device=E2=80=99s set_dependence sy=
sfs file.

We consider two type devices:
1. for soundcard, policy does:
a. Setup a timer, the timer polls soundcard=E2=80=99s busy_timestamp sysf=
s file.
b. if the timer found soundcard is idle for a long time, write the
device=E2=80=99s state sysfs file, and sound card to low power state.
c. policy does nothing to resume soundcard. Soundcard driver=E2=80=99s se=
rvice
routine will call =E2=80=99dpm_active_device=E2=80=99 to resume the devic=
e
=20
2. For keyboard or mouse, policy does:
a. setup a timer, the timer polls keyboard=E2=80=99s busy_timestamp sysfs=
 file.
b. if the timer found keyboard is idle for a long time, write LCD=E2=80=99=
s
state sysfs file to close LCD.
c. After LCD is closed, policy polls keyboard=E2=80=99s busy_timestamp sy=
sfs
file.
d. if the content changed of the file (maybe using inotify), policy will
open LCD

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3Dsuspend/resume (S3/=
S4)=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
1. Device suspend follows current Linux scheme, but ignore suspended
device
2. in resume, don=E2=80=99t do device resume. Device will automatically r=
esume
on demand. No policy application involved in the process, as dpm
framework will be responsible for device resume.

This is my preliminary design, and I=E2=80=99d like to listen to your opi=
nions.

Thanks,
Shaohua

--=-YM/nkzFVtgWe9QMezLFF
Content-Disposition: attachment; filename=pm.tgz
Content-Type: application/x-compressed-tar; name=pm.tgz
Content-Transfer-Encoding: base64

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


--=-YM/nkzFVtgWe9QMezLFF
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


--=-YM/nkzFVtgWe9QMezLFF--
