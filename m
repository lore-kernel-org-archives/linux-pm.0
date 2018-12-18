From: Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCH v12 2/2] cpufreq: qcom-hw: Add support for QCOM cpufreq HW driver
Date: Tue, 18 Dec 2018 11:13:01 -0800
Message-ID: <154516038159.238328.2917665370794230521@swboyd.mtv.corp.google.com>
References: <1544687394-331-1-git-send-email-tdas@codeaurora.org> <1544687394-331-3-git-send-email-tdas@codeaurora.org> <154469510700.19322.7762676027024031719@swboyd.mtv.corp.google.com> <20181213100506.sy3haqjbxtmkthvt@vireshk-i7> <154469596755.19322.16319349046735344084@swboyd.mtv.corp.google.com> <20181218054545.k77jh5lxvmj2zott@vireshk-i7>
Mime-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20181218054545.k77jh5lxvmj2zott@vireshk-i7>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Taniya Das <tdas@codeaurora.org>, linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org, Rajendra Nayak <rnayak@codeaurora.org>, devicetree@vger.kernel.org, robh@kernel.org, skannan@codeaurora.org, linux-arm-msm@vger.kernel.org, evgreen@google.com, Matthias Kaehlcke <mka@chromium.org>, vincent.guittot@linaro.org
List-Id: linux-pm@vger.kernel.org

Quoting Viresh Kumar (2018-12-17 21:45:45)
> Hi Stephen,
>=20
> On 13-12-18, 02:12, Stephen Boyd wrote:
> > Quoting Viresh Kumar (2018-12-13 02:05:06)
> > > On 13-12-18, 01:58, Stephen Boyd wrote:
> > > > BTW, Viresh, I see a lockdep splat when cpufreq_init returns an err=
or
> > > > upon bringing the policy online the second time. I guess cpufreq_st=
ats
> > > > aren't able to be freed from there because they take locks in diffe=
rent
> > > > order vs. the normal path?
> > >=20
> > > Please share the lockdep report and the steps to reproduce it. I will
> > > see if I can simulate the failure forcefully..
> > >=20
> >=20
> > It's on a v4.19 kernel with this cpufreq hw driver backported to it. I
> > think all it takes is to return an error the second time the policy is
> > initialized when cpufreq_online() calls into the cpufreq driver.
> >=20
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> >  WARNING: possible circular locking dependency detected
> >  4.19.8 #61 Tainted: G        W
> >  ------------------------------------------------------
> >  cpuhp/5/36 is trying to acquire lock:
> >  000000003e901e8a (kn->count#326){++++}, at: kernfs_remove_by_name_ns+0=
x44/0x80
> >=20
> >  but task is already holding lock:
> >  00000000dd7f52c3 (&policy->rwsem){++++}, at: cpufreq_policy_free+0x17c=
/0x1cc
> >=20
> >  which lock already depends on the new lock.
> >=20
> >=20
> >  the existing dependency chain (in reverse order) is:
> >=20
> >  -> #1 (&policy->rwsem){++++}:
> >         down_read+0x50/0xcc
> >         show+0x30/0x78
> >         sysfs_kf_seq_show+0x17c/0x25c
> >         kernfs_seq_show+0xb4/0xf8
> >         seq_read+0x4a8/0x8f0
> >         kernfs_fop_read+0xe0/0x360
> >         __vfs_read+0x80/0x328
> >         vfs_read+0xd0/0x1d4
> >         ksys_read+0x88/0x118
> >         __arm64_sys_read+0x4c/0x5c
> >         el0_svc_common+0x124/0x1c4
> >         el0_svc_compat_handler+0x64/0x8c
> >         el0_svc_compat+0x8/0x18
>=20
> I failed to reproduce it over linux/next.
>=20
> I had the following changes over linux/next:
> https://pastebin.ubuntu.com/p/zkVm77PGdY/

I don't see any failure returned from cpufreq_dt's cpufreq_init()
function. Maybe put a static int counter =3D 0 and then fail
cpufreq_init() the second time that it's called for the same policy
pointer? I have a system with two policies, so I made it fail and return
-EINVAL when the counter =3D=3D 2 and I see the lockdep splat.

>=20
> I also did savedefconfig to show what all I changed in it. I faked multip=
le
> clusters on my hikey960 board, which is not big little..
>=20
> And here is the command list from history that I ran after boot.
>=20
>   501  grep . /sys/devices/system/cpu/cpufreq/*/*
>   502  grep . /sys/devices/system/cpu/cpufreq/*/*/*
>   503  grep . /sys/devices/system/cpu/cpufreq/*/*/*
>   504  grep . /sys/devices/system/cpu/cpufreq/*/*/*
>   505  grep . /sys/devices/system/cpu/cpufreq/*/*/*
>   506  grep . /sys/devices/system/cpu/cpufreq/*/*
>   507  grep . /sys/devices/system/cpu/cpufreq/*/*
>   508  echo 0 > /sys/devices/system/cpu/cpu4/online=20
>   509  echo 0 > /sys/devices/system/cpu/cpu5/online=20
>   510  echo 0 > /sys/devices/system/cpu/cpu6/online=20
>   511  echo 0 > /sys/devices/system/cpu/cpu7/online=20
>   512  grep . /sys/devices/system/cpu/cpufreq/*/*
>   513  grep . /sys/devices/system/cpu/cpufreq/*/*/*
>   514  grep . /sys/devices/system/cpu/cpufreq/*/*
>   515  echo 1 > /sys/devices/system/cpu/cpu4/online=20
>   516  grep . /sys/devices/system/cpu/cpufreq/*/*
>   517  grep . /sys/devices/system/cpu/cpufreq/*/*/*
>   518  dmesg=20
>=20

I did the following:

  grep . /sys/devices/system/cpu/cpufreq/*/* >/dev/null
  echo 0 > /sys/devices/system/cpu/cpu4/online=20
  echo 0 > /sys/devices/system/cpu/cpu5/online=20
  echo 0 > /sys/devices/system/cpu/cpu6/online=20
  echo 0 > /sys/devices/system/cpu/cpu7/online=20
  echo 1 > /sys/devices/system/cpu/cpu4/online=20
  dmesg

And boom, lockdep splat.
