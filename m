From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH] cpufreq: fix garbage kobj on errors during suspend/resume
Date: Wed, 04 Dec 2013 11:53:34 +0530
Message-ID: <529ECA66.2090607@linux.vnet.ibm.com>
References: <1386069272-9250-1-git-send-email-bjorn@mork.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <cpufreq-owner@vger.kernel.org>
In-Reply-To: <1386069272-9250-1-git-send-email-bjorn@mork.no>
Sender: cpufreq-owner@vger.kernel.org
To: =?UTF-8?B?QmrDuHJuIE1vcms=?= <bjorn@mork.no>
Cc: cpufreq@vger.kernel.org, linux-pm@vger.kernel.org, Viresh Kumar <viresh.kumar@linaro.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, "Jarzmik, Robert" <robert.jarzmik@intel.com>, "R, Durgadoss" <durgadoss.r@intel.com>
List-Id: linux-pm@vger.kernel.org

On 12/03/2013 04:44 PM, Bj=C3=B8rn Mork wrote:
> This is effectively a revert of commit 5302c3fb2e62 ("cpufreq: Perfor=
m
> light-weight init/teardown during suspend/resume"), which enabled
> suspend/resume optimizations leaving the sysfs files in place.
>=20
> Errors during suspend/resume are not handled properly, leaving
> dead sysfs attributes in case of failures.  There are are number of
> functions with special code for the "frozen" case, and all these
> need to also have special error handling.
>=20
> The problem is easy to demonstrate by making cpufreq_driver->init()
> or cpufreq_driver->get() fail during resume.
>=20
> The code is too complex for a simple fix, with split code paths
> in multiple blocks within a number of functions.

Yes, unfortunately. It was hard enough to get it into shape to make
suspend/resume preserve sysfs files. I definitely don't expect it to
be simple to fix error handling on top of that.=20

>  It is therefore
> best to revert the patch enabling this code until the error handling
> is in place.

I agree, that's a good decision. I'll take a look at it later to see
if we can restructure the code to include proper error handling in all
the failure paths. If that gets way out of control in terms of complexi=
ty,
then its probably best to drop this "feature" altogether. It has caused
enough problems already, and the initial motivation behind doing that
doesn't seem to be that strong now (CC'ing Robert and Durga).

Thanks for the debugging and the fix!

Regards,
Srivatsa S. Bhat

>=20
> Examples of problems resulting from resume errors:
>=20
> Dec  2 09:54:38 nemi kernel: [  930.162476] ------------[ cut here ]-=
-----------
> Dec  2 09:54:38 nemi kernel: [  930.162489] WARNING: CPU: 0 PID: 6055=
 at fs/sysfs/file.c:343 sysfs_open_file+0x77/0x212()
> Dec  2 09:54:38 nemi kernel: [  930.162493] missing sysfs attribute o=
perations for kobject: (null)
> Dec  2 09:54:38 nemi kernel: [  930.162495] Modules linked in: [strip=
ped as irrelevant]
> Dec  2 09:54:38 nemi kernel: [  930.162662] CPU: 0 PID: 6055 Comm: gr=
ep Tainted: G      D      3.13.0-rc2 #153
> Dec  2 09:54:38 nemi kernel: [  930.162665] Hardware name: LENOVO 277=
6LEG/2776LEG, BIOS 6EET55WW (3.15 ) 12/19/2011
> Dec  2 09:54:38 nemi kernel: [  930.162668]  0000000000000009 ffff880=
2327ebb78 ffffffff81380b0e 0000000000000006
> Dec  2 09:54:38 nemi kernel: [  930.162676]  ffff8802327ebbc8 ffff880=
2327ebbb8 ffffffff81038635 0000000000000000
> Dec  2 09:54:38 nemi kernel: [  930.162682]  ffffffff811823c7 ffff880=
21a19e688 ffff88021a19e688 ffff8802302f9310
> Dec  2 09:54:38 nemi kernel: [  930.162690] Call Trace:
> Dec  2 09:54:38 nemi kernel: [  930.162698]  [<ffffffff81380b0e>] dum=
p_stack+0x55/0x76
> Dec  2 09:54:38 nemi kernel: [  930.162705]  [<ffffffff81038635>] war=
n_slowpath_common+0x7c/0x96
> Dec  2 09:54:38 nemi kernel: [  930.162710]  [<ffffffff811823c7>] ? s=
ysfs_open_file+0x77/0x212
> Dec  2 09:54:38 nemi kernel: [  930.162715]  [<ffffffff810386e3>] war=
n_slowpath_fmt+0x41/0x43
> Dec  2 09:54:38 nemi kernel: [  930.162720]  [<ffffffff81182dec>] ? s=
ysfs_get_active+0x6b/0x82
> Dec  2 09:54:38 nemi kernel: [  930.162725]  [<ffffffff81182382>] ? s=
ysfs_open_file+0x32/0x212
> Dec  2 09:54:38 nemi kernel: [  930.162730]  [<ffffffff811823c7>] sys=
fs_open_file+0x77/0x212
> Dec  2 09:54:38 nemi kernel: [  930.162736]  [<ffffffff81182350>] ? s=
ysfs_schedule_callback+0x1ac/0x1ac
> Dec  2 09:54:38 nemi kernel: [  930.162742]  [<ffffffff81122562>] do_=
dentry_open+0x17c/0x257
> Dec  2 09:54:38 nemi kernel: [  930.162748]  [<ffffffff8112267e>] fin=
ish_open+0x41/0x4f
> Dec  2 09:54:38 nemi kernel: [  930.162754]  [<ffffffff81130225>] do_=
last+0x80c/0x9ba
> Dec  2 09:54:38 nemi kernel: [  930.162759]  [<ffffffff8112dbbd>] ? i=
node_permission+0x40/0x42
> Dec  2 09:54:38 nemi kernel: [  930.162764]  [<ffffffff81130606>] pat=
h_openat+0x233/0x4a1
> Dec  2 09:54:38 nemi kernel: [  930.162770]  [<ffffffff81130b7e>] do_=
filp_open+0x35/0x85
> Dec  2 09:54:38 nemi kernel: [  930.162776]  [<ffffffff8113b787>] ? _=
_alloc_fd+0x172/0x184
> Dec  2 09:54:38 nemi kernel: [  930.162782]  [<ffffffff811232ea>] do_=
sys_open+0x6b/0xfa
> Dec  2 09:54:38 nemi kernel: [  930.162787]  [<ffffffff811233a7>] SyS=
_openat+0xf/0x11
> Dec  2 09:54:38 nemi kernel: [  930.162794]  [<ffffffff8138c812>] sys=
tem_call_fastpath+0x16/0x1b
> Dec  2 09:54:38 nemi kernel: [  930.162798] ---[ end trace 48ce7fe74a=
95d4be ]---
>=20
> The failure to restore cpufreq devices on cancelled hibernation is
> not a new bug. It is caused by the ACPI _PPC call failing unless the
> hibernate is completed. This makes the acpi_cpufreq driver fail its
> init.
>=20
> Previously, the cpufreq device could be restored by offlining the
> cpu temporarily.  And as a complete hibernation cycle would do this,
> it would be automatically restored most of the time.  But after
> commit 5302c3fb2e62 the leftover sysfs attributes will block any
> device add action.  Therefore offlining and onlining CPU 1 will no
> longer restore the cpufreq object, and a complete suspend/resume
> cycle will replace it with garbage.
>=20
> Fixes: 5302c3fb2e62 ("cpufreq: Perform light-weight init/teardown dur=
ing suspend/resume")
> Cc: <stable@vger.kernel.org> # v3.12
> Signed-off-by: Bj=C3=B8rn Mork <bjorn@mork.no>
> ---
>  drivers/cpufreq/cpufreq.c |    3 ---
>  1 file changed, 3 deletions(-)
>=20
> diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
> index 02d534da22dd..b7c3b877da44 100644
> --- a/drivers/cpufreq/cpufreq.c
> +++ b/drivers/cpufreq/cpufreq.c
> @@ -2076,9 +2076,6 @@ static int cpufreq_cpu_callback(struct notifier=
_block *nfb,
>  	dev =3D get_cpu_device(cpu);
>  	if (dev) {
>=20
> -		if (action & CPU_TASKS_FROZEN)
> -			frozen =3D true;
> -
>  		switch (action & ~CPU_TASKS_FROZEN) {
>  		case CPU_ONLINE:
>  			__cpufreq_add_dev(dev, NULL, frozen);
>=20

