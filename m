From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH v14 03/10] qcom: spm: Add Subsystem Power Manager driver
Date: Tue, 16 Dec 2014 15:12:22 +0100
Message-ID: <54903DC6.8010308@linaro.org>
References: <1417541958-56907-1-git-send-email-lina.iyer@linaro.org> <8625951.Wbs2MxLnhi@wuerfel> <20141204162834.GA2995@linaro.org> <2519415.GklIQeMgWR@wuerfel>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-arm-msm-owner@vger.kernel.org>
In-Reply-To: <2519415.GklIQeMgWR@wuerfel>
Sender: linux-arm-msm-owner@vger.kernel.org
To: Arnd Bergmann <arnd@arndb.de>, Lina Iyer <lina.iyer@linaro.org>
Cc: khilman@linaro.org, sboyd@codeaurora.org, galak@codeaurora.org, linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org, lorenzo.pieralisi@arm.com, msivasub@codeaurora.org, devicetree@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 12/04/2014 07:20 PM, Arnd Bergmann wrote:
> On Thursday 04 December 2014 09:28:34 Lina Iyer wrote:
>> On Thu, Dec 04 2014 at 02:02 -0700, Arnd Bergmann wrote:
>>> On Thursday 04 December 2014 09:52:39 Daniel Lezcano wrote:
>>>> On 12/03/2014 09:35 PM, Arnd Bergmann wrote:
>>>>> On Wednesday 03 December 2014 07:31:22 Lina Iyer wrote:
>>>>>>>>> +static int __init qcom_spm_init(void)
>>>>>>>>> +{
>>>>>>>>> +    int ret;
>>>>>>>>> +
>>>>>>>>> +    /*
>>>>>>>>> +     * cpuidle driver need to registered before the cpuidle =
device
>>>>>>>>> +     * for any cpu. Register the device for the the cpuidle =
driver.
>>>>>>>>> +     */
>>>>>>>>> +    ret =3D platform_device_register(&qcom_cpuidle_drv);
>>>>>>>>> +    if (ret)
>>>>>>>>> +        return ret;
>>>>>>>> Stephen pointed out that we would have the platform device lyi=
ng around
>>>>>>>> on a non-QCOM device when using multi_v7_defconfig.
>>>>>>>
>>>>>>> Perhaps I am missing the point, but this is not supposed to hap=
pen, no ?
>>>>>>>
>>>>>> This would happen, since the file would compile on multi_v7 and =
we would
>>>>>> initialize and register this device regardless. The cpuidle-qcom=
=2Ec
>>>>>> driver probe would bail out looking for a matching compatible pr=
operty.
>>>>>> So we would not register a cpuidle driver but the device would l=
ay
>>>>>> around.
>>>>>
>>>>> I think the problem is registering a platform_device. I've compla=
ined
>>>>> about this before, but it still seems to get copied all over the
>>>>> place. Please don't do this but have a driver that looks at DT to
>>>>> figure out whether to access hardware or not.
>>>>
>>>> We did this approach but, I can remember why, someone was complain=
ing
>>>> about it also
>>>>
>>>> The platform device/driver paradigm allowed us to split the arch
>>>> specific parts by passing the pm ops through the platform data.
>>>>
>>>> Would make sense to have a single common place for the ARM arch wh=
ere we
>>>> initialize the platform device for cpuidle ?
>>>
>>> No. It's really not a device, and if you pretend that it is, you ge=
t
>>> into problems like this.
>>
>> Arnd, the problem is that the provides function pointers to the SoC =
code
>> that the cpuilde driver uses to call based on the idle state.
>>
>> After much discussions, we came down to using function pointers from
>> translating from DT strings, other than using that again, I dont see=
 a
>> good way of achieving the ability of cpuidle driver staying a separa=
te
>> driver from the SPM driver.
>>
>> Daniel, thoughts?
>
> Maybe the problem is trying too hard to separate two things that real=
ly
> belong together then. In general, the strategy of coming up with subs=
ystems
> for a class of devices and them turning platform code into drivers fo=
r
> that subsystem has worked out really well, but I think for cpufreq, c=
puidle
> and smp, it really hasn't, and in the third case we haven't even trie=
d
> coming up with a subsystem for that reason.
>
> Having all cpuidle code generally live in drivers/cpuidle is still a =
good
> idea IMO, but using a platform device just for the purpose of passing
> data between some platform specific code and another platform specifi=
c
> driver hasn't worked out that well here.

At the beginning, all that become from not including mach files from th=
e=20
drivers directory which make sense.

Perhaps it is time to write a similar mechanism for the cpuidle drivers=
=20
where we can still separate the low level PM code from the generic=20
cpuidle code.

Something like (very roughly):

Index: cpuidle-next/drivers/cpuidle/driver.c
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- cpuidle-next.orig/drivers/cpuidle/driver.c	2014-12-16=20
14:04:51.750861310 +0100
+++ cpuidle-next/drivers/cpuidle/driver.c	2014-12-16 15:09:52.202706756=
=20
+0100
@@ -178,6 +178,45 @@ static void __cpuidle_driver_init(struct
  	}
  }

+struct cpuidle_ops_reg {
+	const char *name;
+	struct cpuidle_ops *ops;
+	struct list_head *list;
+};
+
+static LIST_HEAD(ops_list);
+
+static struct cpuidle_ops *cpuidle_find_ops(const char *name)
+{
+	struct cpuidle_ops_reg *ops_reg;
+
+	list_for_each_entry(ops_reg, &ops_list, list) {
+		if (!strcmp(ops_reg->name, name))
+			return ops_reg->ops;
+	}
+
+	return NULL;
+}
+
+int cpuidle_register_ops(const char *name, struct cpuidle_ops *ops)
+{
+	struct cpuidle_ops_reg *reg;
+
+	reg =3D kmalloc(sizeof(*reg), GFP_KERNEL);
+	if (!reg)
+		return -ENOMEM;
+
+	reg->name =3D name;
+	reg->ops =3D ops;
+	INIT_LIST_HEAD(&reg->list);
+
+	spin_lock(&cpuidle_driver_lock);
+	list_add(&ops_list, &reg->list);
+	spin_unlock(&cpuidle_driver_lock);
+
+	return 0;
+}
+
  /**
   * __cpuidle_register_driver: register the driver
   * @drv: a valid pointer to a struct cpuidle_driver
@@ -194,6 +233,7 @@ static void __cpuidle_driver_init(struct
  static int __cpuidle_register_driver(struct cpuidle_driver *drv)
  {
  	int ret;
+	struct cpuidle_ops *ops;

  	if (!drv || !drv->state_count)
  		return -EINVAL;
@@ -201,6 +241,10 @@ static int __cpuidle_register_driver(str
  	if (cpuidle_disabled())
  		return -ENODEV;

+	ops =3D cpuidle_find_ops(drv->name);
+	if (ops)
+		drv->ops =3D ops;
+
  	__cpuidle_driver_init(drv);

  	ret =3D __cpuidle_set_driver(drv);
Index: cpuidle-next/include/linux/cpuidle.h
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
--- cpuidle-next.orig/include/linux/cpuidle.h	2014-12-16=20
14:06:09.442858231 +0100
+++ cpuidle-next/include/linux/cpuidle.h	2014-12-16 14:59:46.594730753 =
+0100
@@ -109,11 +109,21 @@ static inline int cpuidle_get_last_resid
   * CPUIDLE DRIVER INTERFACE *
   ****************************/

+struct cpuidle_ops {
+	int (*standby)(struct cpuidle_driver *drv,
+		       struct cpuidle_device *dev);
+	int (*retention)(struct cpuidle_driver *drv,
+			 struct cpuidle_device *dev);
+	int (*poweroff)(struct cpuidle_driver *drv,
+			struct cpuidle_device *dev);
+};
+
  struct cpuidle_driver {
  	const char		*name;
  	struct module 		*owner;
  	int                     refcnt;

+	struct cpuidle_ops      *ops;
          /* used by the cpuidle framework to setup the broadcast timer=
 */
  	unsigned int            bctimer:1;
  	/* states array must be ordered in decreasing power consumption */

--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
