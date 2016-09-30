From: MyungJoo Ham <myungjoo.ham@samsung.com>
Subject: Re: [PATCH] PM / devfreq: exynos-ppmu: ppmu_events array should not
 be NULL terminated
Date: Fri, 30 Sep 2016 23:06:38 +0900
Message-ID: <CAJ0PZbSoNwXSTECZE6voi=9ETYRm=RKow8+ES7kaXq07t97UnA@mail.gmail.com>
References: <CGME20160921003108epcas1p13c13f6dbfbcf86c22d88e33606e8fc97@epcas1p1.samsung.com>
 <1474417840-7999-1-git-send-email-axel.lin@ingics.com> <57E37992.2030500@samsung.com>
Reply-To: myungjoo.ham@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-samsung-soc-owner@vger.kernel.org>
In-Reply-To: <57E37992.2030500@samsung.com>
Sender: linux-samsung-soc-owner@vger.kernel.org
To: Chanwoo Choi <cw00.choi@samsung.com>
Cc: Axel Lin <axel.lin@ingics.com>, "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>, Kyungmin Park <kyungmin.park@samsung.com>, Linux PM list <linux-pm@vger.kernel.org>, Linux Samsung SoC <linux-samsung-soc@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, Sep 22, 2016 at 3:26 PM, Chanwoo Choi <cw00.choi@samsung.com> wrote=
:
> Hello,
>
> On 2016=EB=85=84 09=EC=9B=94 21=EC=9D=BC 09:30, Axel Lin wrote:
>> The rest of the code uses ARRAY_SIZE to count the number of entries in
>> ppmu_events array. The NULL terminated entry makes ARRAY_SIZE return
>> off-by-one value.
>>
>> Signed-off-by: Axel Lin <axel.lin@ingics.com>
>> ---
>>  drivers/devfreq/event/exynos-ppmu.c | 2 --
>>  1 file changed, 2 deletions(-)
>>
>> diff --git a/drivers/devfreq/event/exynos-ppmu.c b/drivers/devfreq/event=
/exynos-ppmu.c
>> index f55cf0e..c9ffaf0 100644
>> --- a/drivers/devfreq/event/exynos-ppmu.c
>> +++ b/drivers/devfreq/event/exynos-ppmu.c
>> @@ -90,8 +90,6 @@ struct __exynos_ppmu_events {
>>       PPMU_EVENT(d1-cpu),
>>       PPMU_EVENT(d1-general),
>>       PPMU_EVENT(d1-rt),
>> -
>> -     { /* sentinel */ },
>>  };
>>
>>  static int exynos_ppmu_find_ppmu_id(struct devfreq_event_dev *edev)
>>
>
> Acked-by: Chanwoo Choi <cw00.choi@samsung.com>

Chanwoo, do you feel comfortable with removing this sentinel? (you are
never going to rely on the sentinel in the future or in external codes
as well?)
Actually, although ppmu-event is using ARRAY_SIZE, because the loops
are looking for valid name, the correctness is not damaged.

Assuming yes, Acked-by: MyungJoo Ham <myungjoo.ham@samsung.com>

>
> --
> Best Regards,
> Chanwoo Choi
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-s=
oc" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
MyungJoo Ham, Ph.D.
Frontier CS Lab, S/W Center, Samsung Electronics
