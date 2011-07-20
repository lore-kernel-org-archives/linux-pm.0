From: Jean Pihet <jean.pihet@newoldbits.com>
Subject: Re: [PATCH 01/11] PM: add a per-device wake-up latency
	constraints plist
Date: Wed, 20 Jul 2011 10:57:59 +0200
Message-ID: <CAORVsuW0JkAv=Oqk62JTR4Ad63xP8J7mbso_g8cN4N4w-Jai5g__41907.4746234857$1311152524$gmane$org@mail.gmail.com>
References: <1309446685-17502-1-git-send-email-j-pihet@ti.com>
	<1309446685-17502-2-git-send-email-j-pihet@ti.com>
	<201107022139.51579.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107022139.51579.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: markgross@thegnar.org, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-omap@vger.kernel.org, Jean Pihet <j-pihet@ti.com>
List-Id: linux-pm@vger.kernel.org

Hi Rafael,

2011/7/2 Rafael J. Wysocki <rjw@sisk.pl>:
> Hi,
>
> On Thursday, June 30, 2011, jean.pihet@newoldbits.com wrote:
...

>> @@ -462,6 +463,7 @@ struct dev_pm_info {
>> =A0 =A0 =A0 unsigned long =A0 =A0 =A0 =A0 =A0 accounting_timestamp;
>> =A0 =A0 =A0 void =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0*subsys_data; =
=A0/* Owned by the subsystem. */
>> =A0#endif
>> + =A0 =A0 struct plist_head =A0 =A0 =A0 wakeup_lat_plist_head;
>> =A0};
>
> Please use a better name. =A0I mean, relly, the type implies that this is=
 a
> plist head, so that doesn't need to appear in the field name too. =A0Also,
> the name is confusing, because "wakeup" may mean a couple of different th=
ings
> and it's not entirely clear what "lat" stands for. =A0So, I'd prefer some=
thing
> like
>
> + =A0 =A0 =A0 struct plist_head =A0 =A0 =A0 latency_constraints;
>
> or perhaps you can invent something even better.
I am OK with your suggestion and I will update the naming.

>
>>
>> =A0extern void update_pm_runtime_accounting(struct device *dev);
>>
>
> Thanks,
> Rafael

Thanks,
Jean

> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
>
