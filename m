From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH] PM / QoS: unconditionally build the feature
Date: Mon, 13 Feb 2012 16:40:01 +0100
Message-ID: <CAORVsuVo99n+2tXpoUwKoJ8L9u7Pjv9ku=RxRxhkt0Xf=DQduA@mail.gmail.com>
References: <1328603646-2714-2-git-send-email-j-pihet@ti.com>
	<1329141059-16554-1-git-send-email-j-pihet@ti.com>
	<201202131641.10535.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201202131641.10535.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Venkatesh Pallipadi <venki@google.com>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jean Pihet <j-pihet@ti.com>, linux-kernel@vger.kernel.org, Mark Gross <markgross@thegnar.org>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

2012/2/13 Rafael J. Wysocki <rjw@sisk.pl>:
> On Monday, February 13, 2012, Jean Pihet wrote:
>> The PM QoS feature depends on CONFIG_PM which depends on
>> PM_SLEEP || PM_RUNTIME. This breaks CPU C-states with kernels
>> not having these CONFIGs.
>>
>> This patch allows the feature in all cases.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> Reported-by: Venkatesh Pallipadi <venki@google.com>
>> Cc: Rafael J. Wysocki <rjw@sisk.pl>
>> Cc: Mark Gross <markgross@thegnar.org>
>
> Applied, but I modified the changelog (please have a look at the
> linux-pm/pm-qos branch for details).
Ok thanks! Will look at it as soon as the changes are propagated to linux-p=
m.

>
> Thanks,
> Rafael
>

Jean

>
>> ---
>> =A0include/linux/pm_qos.h | =A0 41 +------------------------------------=
----
>> =A0kernel/power/Makefile =A0| =A0 =A03 ++-
>> =A02 files changed, 3 insertions(+), 41 deletions(-)
>>
>> diff --git a/include/linux/pm_qos.h b/include/linux/pm_qos.h
>> index 4d99e4e..105be69 100644
>> --- a/include/linux/pm_qos.h
>> +++ b/include/linux/pm_qos.h
>> @@ -63,7 +63,6 @@ static inline int dev_pm_qos_request_active(struct dev=
_pm_qos_request *req)
>> =A0 =A0 =A0 return req->dev !=3D 0;
>> =A0}
>>
>> -#ifdef CONFIG_PM
>> =A0int pm_qos_update_target(struct pm_qos_constraints *c, struct plist_n=
ode *node,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0enum pm_qos_req_action ac=
tion, int value);
>> =A0void pm_qos_add_request(struct pm_qos_request *req, int pm_qos_class,
>> @@ -78,6 +77,7 @@ int pm_qos_remove_notifier(int pm_qos_class, struct no=
tifier_block *notifier);
>> =A0int pm_qos_request_active(struct pm_qos_request *req);
>> =A0s32 pm_qos_read_value(struct pm_qos_constraints *c);
>>
>> +#ifdef CONFIG_PM
>> =A0s32 __dev_pm_qos_read_value(struct device *dev);
>> =A0s32 dev_pm_qos_read_value(struct device *dev);
>> =A0int dev_pm_qos_add_request(struct device *dev, struct dev_pm_qos_requ=
est *req,
>> @@ -95,45 +95,6 @@ void dev_pm_qos_constraints_destroy(struct device *de=
v);
>> =A0int dev_pm_qos_add_ancestor_request(struct device *dev,
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 stru=
ct dev_pm_qos_request *req, s32 value);
>> =A0#else
>> -static inline int pm_qos_update_target(struct pm_qos_constraints *c,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0struct plist_node *node,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0enum pm_qos_req_action action,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0int value)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { return 0; }
>> -static inline void pm_qos_add_request(struct pm_qos_request *req,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 in=
t pm_qos_class, s32 value)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { return; }
>> -static inline void pm_qos_update_request(struct pm_qos_request *req,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0s32 new_value)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { return; }
>> -static inline void pm_qos_remove_request(struct pm_qos_request *req)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { return; }
>> -
>> -static inline int pm_qos_request(int pm_qos_class)
>> -{
>> - =A0 =A0 switch (pm_qos_class) {
>> - =A0 =A0 case PM_QOS_CPU_DMA_LATENCY:
>> - =A0 =A0 =A0 =A0 =A0 =A0 return PM_QOS_CPU_DMA_LAT_DEFAULT_VALUE;
>> - =A0 =A0 case PM_QOS_NETWORK_LATENCY:
>> - =A0 =A0 =A0 =A0 =A0 =A0 return PM_QOS_NETWORK_LAT_DEFAULT_VALUE;
>> - =A0 =A0 case PM_QOS_NETWORK_THROUGHPUT:
>> - =A0 =A0 =A0 =A0 =A0 =A0 return PM_QOS_NETWORK_THROUGHPUT_DEFAULT_VALUE;
>> - =A0 =A0 default:
>> - =A0 =A0 =A0 =A0 =A0 =A0 return PM_QOS_DEFAULT_VALUE;
>> - =A0 =A0 }
>> -}
>> -
>> -static inline int pm_qos_add_notifier(int pm_qos_class,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 st=
ruct notifier_block *notifier)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { return 0; }
>> -static inline int pm_qos_remove_notifier(int pm_qos_class,
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0struct notifier_block *notifier)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { return 0; }
>> -static inline int pm_qos_request_active(struct pm_qos_request *req)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { return 0; }
>> -static inline s32 pm_qos_read_value(struct pm_qos_constraints *c)
>> - =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { return 0; }
>> -
>> =A0static inline s32 __dev_pm_qos_read_value(struct device *dev)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 { return 0; }
>> =A0static inline s32 dev_pm_qos_read_value(struct device *dev)
>> diff --git a/kernel/power/Makefile b/kernel/power/Makefile
>> index 07e0e28..66d808e 100644
>> --- a/kernel/power/Makefile
>> +++ b/kernel/power/Makefile
>> @@ -1,7 +1,8 @@
>>
>> =A0ccflags-$(CONFIG_PM_DEBUG) =A0 :=3D -DDEBUG
>>
>> -obj-$(CONFIG_PM) =A0 =A0 =A0 =A0 =A0 =A0 +=3D main.o qos.o
>> +obj-y =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=
=3D qos.o
>> +obj-$(CONFIG_PM) =A0 =A0 =A0 =A0 =A0 =A0 +=3D main.o
>> =A0obj-$(CONFIG_VT_CONSOLE_SLEEP) =A0 =A0 =A0 +=3D console.o
>> =A0obj-$(CONFIG_FREEZER) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D process.o
>> =A0obj-$(CONFIG_SUSPEND) =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0+=3D suspend.o
>>
>
