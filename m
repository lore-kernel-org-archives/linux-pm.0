From: Pan Xinhui <xinhuix.pan@intel.com>
Subject: Re: [PATCH] cpufreq: Add scaling frequency range support
Date: Wed, 29 Jul 2015 17:59:14 +0800
Message-ID: <55B8A3F2.8030809@intel.com>
References: <55B6F7C3.8040405@intel.com> <20150728042945.GE1229@linux> <55B70ACD.9010402@intel.com> <15808229.KgKF05ecju@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:56833 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751330AbbG2KBo (ORCPT <rfc822;linux-pm@vger.kernel.org>);
	Wed, 29 Jul 2015 06:01:44 -0400
In-Reply-To: <15808229.KgKF05ecju@vostro.rjw.lan>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>
Cc: Viresh Kumar <viresh.kumar@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "mnipxh@163.com" <mnipxh@163.com>, "yanmin_zhang@linux.intel.com" <yanmin_zhang@linux.intel.com>

hi, Rafael
	thanks for you reply.

On 2015=E5=B9=B407=E6=9C=8829=E6=97=A5 08:18, Rafael J. Wysocki wrote:
> On Tuesday, July 28, 2015 12:53:33 PM Pan Xinhui wrote:
>> hi, Viresh
>> 	thanks for your reply :)
>> On 2015=E5=B9=B407=E6=9C=8828=E6=97=A5 12:29, Viresh Kumar wrote:
>>> On 28-07-15, 11:32, Pan Xinhui wrote:
>>>> From: Pan Xinhui <xinhuix.pan@intel.com>
>>>>
>>>> Userspace at most time do cpufreq tests very much inconveniently.
>>>> Currently they have to echo min and max cpu freq separately like b=
elow:
>>>> echo 480000  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_fr=
eq
>>>> echo 2240000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_fr=
eq
>>>>
>>>> Add scaling_freq_range cpufreq attr to support userspace's demand.
>>>> Therefore it's easier for testers to write readable scripts like b=
elow:=20
>>>> echo 480000-2240000 >
>>>> /sys/devices/system/cpu/cpu0/cpufreq/scaling_freq_range
>>>
>>> I don't think this brings any good change, we already have support =
for
>>> that with min/max freqs and I don't see how scripts can be less
>>> readable with that.
>>>
>> yes, min/max are supported, however it is inconvenient. sometime it'=
s very easy to cause obscure bugs.
>> For example, some one might write a script like below.
>> echo 480000  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_freq
>> echo 960000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
>> .....//other works
>> echo 1120000  > /sys/devices/system/cpu/cpu0/cpufreq/scaling_min_fre=
q
>> echo 2240000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
>> ...//other works
>>
>> But it did not work when we echo 112000 to min-freq, as the current =
max freq is smaller than it.
>> It's hard to figure it out in a big script... we have many such scri=
pts.
>=20
> Fix them, then, pretty please.
>=20
of course we will fix them. :)

> And adding this attribute is not going to magically fix them, is it?
>=20
yes, this patch can not fix them without changing the script. BUT I hav=
e another patch which could magically fix them. :)

These two attribute files are very tricky. they are related with each o=
ther.
Not like some other attribute file in other part of kernel, for example=
, proc/sys/fs/file-max.
As the file-min is always zero. It's very reasonable to only support fi=
le-max attribute file.

The sequence we echoing value to min/max_freq is very important. Maybe =
we can also assume they have *state*.
Just like a developer writes a buf to a file. he should do in this way =
below.
fp =3D fopen(..)
 =3D> fwrite(...)
  =3D> fclose(...)

The script I mentioned above did not follow the right sequence. when sc=
ript wants to set the min higher, we need set the max first to avoid mi=
n > max issue...
So max/min_freq have *state*. just like TCP Three-way handshake, SYN, A=
CK&SYN, ACK. the sequence(this is so-called state) is very important.

Now I want to offer a non-state attribute to user-space :)
This is a design/engineering problem. It's okay for kernel to not offer=
 such attribute. But user-space will do more work.
=46or example, In the worst case, we need system call four times.
read min/max_freq (system call two times)
might set min or max freq first to avoid min > max issue (system call o=
ne time)
set min/max a new value (system call one time)

What if we offer *set freq range* attribute? just once. :)
set freq range (system call one time)

=46rom performance point, It's a good idea to offer such attribute.

There is another reason for why it's good to apply this patch.
If cpufreg range is 480000-960000, we call it powersave, 480000-2240000=
 is normal, 1920000-2240000 is performance.
Assume current cpufreq range is powersave, then user want to set it to =
performance because user wants to play a 3D game.
BUT user have to set it to normal first, then set it to performance bec=
ause min(performance) > max(powersave).....
I don't know how people(end-user) would think about such behavior.... w=
hy we must be back to normal first, then performance?

As for the patch I mentioned above which could magically fix them.
The solution is: change store_scaling_max_freq and store_scaling_min_fr=
eq sysfs callback, let them have *state*.
Always keep the value from user-space.

patch like:
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 8772346..00e6965 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -615,6 +615,14 @@ static ssize_t show_scaling_cur_freq(struct cpufre=
q_policy *policy, char *buf)
 static int cpufreq_set_policy(struct cpufreq_policy *policy,
                                struct cpufreq_policy *new_policy);
=20
+static void
+cpufreq_get_user_policy_freq(struct cpufreq_real_policy *user_policy,
+                               struct cpufreq_policy *policy)
+{
+       policy->min =3D user_policy->min;
+       policy->max =3D user_policy->max;
+}
+
 /**
  * cpufreq_per_cpu_attr_write() / store_##file_name() - sysfs write ac=
cess
  */
@@ -622,21 +630,20 @@ static int cpufreq_set_policy(struct cpufreq_poli=
cy *policy,
 static ssize_t store_##file_name                                      =
 \
 (struct cpufreq_policy *policy, const char *buf, size_t count)        =
 \
 {                                                                     =
 \
-       int ret, temp;                                                 =
 \
+       int ret;                                                       =
 \
        struct cpufreq_policy new_policy;                              =
 \
                                                                       =
 \
        ret =3D cpufreq_get_policy(&new_policy, policy->cpu);          =
   \
        if (ret)                                                       =
 \
                return -EINVAL;                                        =
 \
                                                                       =
 \
+       cpufreq_get_user_policy_freq(&policy->user_policy, &new_policy)=
;\
        ret =3D sscanf(buf, "%u", &new_policy.object);                 =
   \
        if (ret !=3D 1)                                                =
   \
                return -EINVAL;                                        =
 \
                                                                       =
 \
-       temp =3D new_policy.object;                                    =
   \
-       ret =3D cpufreq_set_policy(policy, &new_policy);          \
-       if (!ret)                                                      =
 \
-               policy->user_policy.object =3D temp;                   =
   \
+       policy->user_policy.object =3D policy->object;                 =
   \
+       ret =3D cpufreq_set_policy(policy, &new_policy);               =
   \
                                                                       =
 \
        return ret ? ret : count;                                      =
 \
 }




Thanks
xinhui

> Thanks,
> Rafael
>=20
