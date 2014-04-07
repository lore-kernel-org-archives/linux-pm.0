From: =?utf-8?B?U8O2cmVu?= Brinkmann <soren.brinkmann@xilinx.com>
Subject: Re: [PATCH] cpufreq: remove sysfs link when a cpu != policy->cpu, is
 removed
Date: Mon, 7 Apr 2014 10:15:04 -0700
Message-ID: <5b6a0eb5-59d7-43ca-9adc-35c7acd58424@VA3EHSMHS022.ehs.local>
References: <324f43fc664f51eec355b08b6c2d4cedd2140b4c.1392628861.git.viresh.kumar@linaro.org>
 <1848612.IZFZXgfmHj@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1848612.IZFZXgfmHj@vostro.rjw.lan>
Sender: cpufreq-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, swarren@nvidia.com, linaro-kernel@lists.linaro.org, cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Michal Simek <michal.simek@xilinx.com>
List-Id: linux-pm@vger.kernel.org

On Mon, 2014-02-17 at 11:03PM +0100, Rafael J. Wysocki wrote:
> On Monday, February 17, 2014 02:52:11 PM Viresh Kumar wrote:
> > Earlier patch tried to do this but missed this piece of code to fix=
=2E
> >=20
> > 42f921a cpufreq: remove sysfs files for CPUs which failed to come b=
ack after
> > resume
> >=20
> > Currently we are getting this on suspend/resume:
> >=20
> > ------------[ cut here ]------------
> > WARNING: CPU: 0 PID: 877 at fs/sysfs/dir.c:52 sysfs_warn_dup+0x68/0=
x84()
> > sysfs: cannot create duplicate filename '/devices/system/cpu/cpu1/c=
pufreq'
> > Modules linked in: brcmfmac brcmutil
> > CPU: 0 PID: 877 Comm: test-rtc-resume Not tainted 3.14.0-rc2-00259-=
g9398a10cd964 #12
> > [<c0015bac>] (unwind_backtrace) from [<c0011850>] (show_stack+0x10/=
0x14)
> > [<c0011850>] (show_stack) from [<c056e018>] (dump_stack+0x80/0xcc)
> > [<c056e018>] (dump_stack) from [<c0025e44>] (warn_slowpath_common+0=
x64/0x88)
> > [<c0025e44>] (warn_slowpath_common) from [<c0025efc>] (warn_slowpat=
h_fmt+0x30/0x40)
> > [<c0025efc>] (warn_slowpath_fmt) from [<c012776c>] (sysfs_warn_dup+=
0x68/0x84)
> > [<c012776c>] (sysfs_warn_dup) from [<c0127a54>] (sysfs_do_create_li=
nk_sd+0xb0/0xb8)
> > [<c0127a54>] (sysfs_do_create_link_sd) from [<c038ef64>] (__cpufreq=
_add_dev.isra.27+0x2a8/0x814)
> > [<c038ef64>] (__cpufreq_add_dev.isra.27) from [<c038f548>] (cpufreq=
_cpu_callback+0x70/0x8c)
> > [<c038f548>] (cpufreq_cpu_callback) from [<c0043864>] (notifier_cal=
l_chain+0x44/0x84)
> > [<c0043864>] (notifier_call_chain) from [<c0025f60>] (__cpu_notify+=
0x28/0x44)
> > [<c0025f60>] (__cpu_notify) from [<c00261e8>] (_cpu_up+0xf0/0x140)
> > [<c00261e8>] (_cpu_up) from [<c0569eb8>] (enable_nonboot_cpus+0x68/=
0xb0)
> > [<c0569eb8>] (enable_nonboot_cpus) from [<c006339c>] (suspend_devic=
es_and_enter+0x198/0x2dc)
> > [<c006339c>] (suspend_devices_and_enter) from [<c0063654>] (pm_susp=
end+0x174/0x1e8)
> > [<c0063654>] (pm_suspend) from [<c00624e0>] (state_store+0x6c/0xbc)
> > [<c00624e0>] (state_store) from [<c01fc200>] (kobj_attr_store+0x14/=
0x20)
> > [<c01fc200>] (kobj_attr_store) from [<c0126e50>] (sysfs_kf_write+0x=
44/0x48)
> > [<c0126e50>] (sysfs_kf_write) from [<c012a274>] (kernfs_fop_write+0=
xb4/0x14c)
> > [<c012a274>] (kernfs_fop_write) from [<c00d4818>] (vfs_write+0xa8/0=
x180)
> > [<c00d4818>] (vfs_write) from [<c00d4bb8>] (SyS_write+0x3c/0x70)
> > [<c00d4bb8>] (SyS_write) from [<c000e620>] (ret_fast_syscall+0x0/0x=
30)
> > ---[ end trace 76969904b614c18f ]---
> >=20
> > Fix this by removing sysfs link for cpufreq directory when cpu remo=
ved isn't
> > policy->cpu.
> >=20
> > Reported-by: Stephen Warren <swarren@nvidia.com>
> > Signed-off-by: Viresh Kumar <viresh.kumar@linaro.org>
> > ---
> >=20
> > Fix for 3.14 only.
>=20
> Queued up for 3.14, thanks!

I see this on 3.13 too (in our vendor tree, but I think mainline would
show the behavior as well). It probably worth to add it into the 3.13
stable kernel.

	S=C3=B6ren
>=20
> >  drivers/cpufreq/cpufreq.c | 3 +--
> >  1 file changed, 1 insertion(+), 2 deletions(-)
> >=20
> > diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> > index 08ca8c9..cb003a6 100644
> > --- a/drivers/cpufreq/cpufreq.c
> > +++ b/drivers/cpufreq/cpufreq.c
> > @@ -1323,8 +1323,7 @@ static int __cpufreq_remove_dev_prepare(struc=
t device *dev,
> >  	up_read(&policy->rwsem);
> > =20
> >  	if (cpu !=3D policy->cpu) {
> > -		if (!frozen)
> > -			sysfs_remove_link(&dev->kobj, "cpufreq");
> > +		sysfs_remove_link(&dev->kobj, "cpufreq");
> >  	} else if (cpus > 1) {
> >  		new_cpu =3D cpufreq_nominate_new_policy_cpu(policy, cpu);
> >  		if (new_cpu >=3D 0) {
> >=20
>=20
> --=20
> I speak only for myself.
> Rafael J. Wysocki, Intel Open Source Technology Center.
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20

