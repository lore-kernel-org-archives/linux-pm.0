From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 1/6] OMAP2+: powerdomain: control power
	domains next state
Date: Tue, 22 Nov 2011 20:44:34 +0100
Message-ID: <CAORVsuV2dEf=P1uR9bG1tg+wFN2CkBO-BGrqO7AThW0VMWFtWA__24878.3300201923$1321992513$gmane$org@mail.gmail.com>
References: <1319032263-22699-1-git-send-email-j-pihet@ti.com>
	<1319032263-22699-2-git-send-email-j-pihet@ti.com>
	<87obwa30vx.fsf@ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <87obwa30vx.fsf@ti.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/linux-pm/>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kevin Hilman <khilman@ti.com>
Cc: linux-omap@vger.kernel.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

Kevin,

On Thu, Nov 17, 2011 at 10:16 PM, Kevin Hilman <khilman@ti.com> wrote:
> jean.pihet@newoldbits.com writes:
>
>> From: Jean Pihet <j-pihet@ti.com>
>>
>> When a PM QoS device latency constraint is requested or removed the
>> PM QoS layer notifies the underlying layer with the updated aggregated
>> constraint value. The constraint is stored in the powerdomain constraints
>> list and then applied to the corresponding power domain.
>> The power domains get the next power state programmed directly in the
>> registers via pwrdm_wakeuplat_update_pwrst.
>>
>> Tested on OMAP3 Beagleboard and OMAP4 Pandaboard in RET/OFF using
>> wake-up latency constraints on MPU, CORE and PER.
>>
>> Signed-off-by: Jean Pihet <j-pihet@ti.com>
>> ---
...

>> @@ -104,6 +106,12 @@ static int _pwrdm_register(struct powerdomain *pwrd=
m)
>> =A0 =A0 =A0 for (i =3D 0; i < pwrdm->banks; i++)
>> =A0 =A0 =A0 =A0 =A0 =A0 =A0 pwrdm->ret_mem_off_counter[i] =3D 0;
>>
>> + =A0 =A0 /* Initialize the per-od wake-up constraints data */
>
> This comment needs an update (they are not per-od, but per pwrdm), or
> could probably be removed, since it doesn't add any value over the code.
Ok to remove it

>
>> + =A0 =A0 spin_lock_init(&pwrdm->wkup_lat_plist_lock);
>> + =A0 =A0 plist_head_init(&pwrdm->wkup_lat_plist_head);
>> + =A0 =A0 pwrdm->wkup_lat_next_state =3D PWRDM_POWER_OFF;
>> +
>> + =A0 =A0 /* Initialize the pwrdm state */
>> =A0 =A0 =A0 pwrdm_wait_transition(pwrdm);
>> =A0 =A0 =A0 pwrdm->state =3D pwrdm_read_pwrst(pwrdm);
>> =A0 =A0 =A0 pwrdm->state_counter[pwrdm->state] =3D 1;
...

>> +int pwrdm_set_wkup_lat_constraint(struct powerdomain *pwrdm, void *cook=
ie,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 long min_l=
atency)
>> +{
>> + =A0 =A0 struct pwrdm_wkup_constraints_entry *user =3D NULL, *new_user =
=3D NULL;
>> + =A0 =A0 int ret =3D 0, free_new_user =3D 0, free_node =3D 0;
>> + =A0 =A0 long value =3D PM_QOS_DEV_LAT_DEFAULT_VALUE;
>> + =A0 =A0 unsigned long flags;
>> +
>> + =A0 =A0 pr_debug("powerdomain: %s: pwrdm %s, cookie=3D0x%p, min_latenc=
y=3D%ld\n",
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0__func__, pwrdm->name, cookie, min_latency);
>> +
>> + =A0 =A0 if (min_latency !=3D PM_QOS_DEV_LAT_DEFAULT_VALUE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 new_user =3D kzalloc(sizeof(struct pwrdm_wkup_=
constraints_entry),
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0GFP_KER=
NEL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!new_user) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pr_err("%s: FATAL ERROR: kzall=
oc failed\n", __func__);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return -ENOMEM;
>> + =A0 =A0 =A0 =A0 =A0 =A0 }
>> + =A0 =A0 =A0 =A0 =A0 =A0 free_new_user =3D 1;
>> + =A0 =A0 }
>> +
>> + =A0 =A0 spin_lock_irqsave(&pwrdm->wkup_lat_plist_lock, flags);
>> +
>> + =A0 =A0 /* Manage the constraints list */
>> + =A0 =A0 ret =3D _pwrdm_update_wakeuplat_list(pwrdm, cookie, min_latenc=
y,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0user, new_user,
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =
=A0 =A0 =A0&free_new_user, &free_node);
>> +
>> + =A0 =A0 /* Find the aggregated constraint value from the list */
>> + =A0 =A0 if (!ret)
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (!plist_head_empty(&pwrdm->wkup_lat_plist_h=
ead))
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 value =3D plist_first(&pwrdm->=
wkup_lat_plist_head)->prio;
>> +
>> + =A0 =A0 spin_unlock_irqrestore(&pwrdm->wkup_lat_plist_lock, flags);
>> +
>> + =A0 =A0 if (free_node)
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(user);
>> +
>> + =A0 =A0 if (free_new_user)
>> + =A0 =A0 =A0 =A0 =A0 =A0 kfree(new_user);
>
> The alloc/free of these buffers is not terribly obvious when reading. =A0I
Agreed.

> think the code/changelog needs some comments describing the logic
> behind how/when these nodes are allocated and freed.
Ok I will add it.

...

>
> Kevin
>

Thanks,
Jean
