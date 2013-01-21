From: Sachin Kamat <sachin.kamat@linaro.org>
Subject: Re: [PATCH 1/2] cpufreq: exynos: Initialise return variable
Date: Mon, 21 Jan 2013 17:23:25 +0530
Message-ID: <CAK9yfHy=bQCtGURb5mE2cu8wiX6YELiD0UX1HzikS=fUoCRmyw@mail.gmail.com>
References: <1358764194-22753-1-git-send-email-sachin.kamat@linaro.org>
	<CAGZ6kuM3t1P1PweJrjXk3eWWkhx1qX8rCkgsyHbPBsXqO7LvcQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=EUC-KR
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-pm-owner@vger.kernel.org>
Received: from mail-ob0-f172.google.com ([209.85.214.172]:55899 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752964Ab3AULx1 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-pm@vger.kernel.org>); Mon, 21 Jan 2013 06:53:27 -0500
Received: by mail-ob0-f172.google.com with SMTP id ta17so702751obb.17
        for <linux-pm@vger.kernel.org>; Mon, 21 Jan 2013 03:53:26 -0800 (PST)
In-Reply-To: <CAGZ6kuM3t1P1PweJrjXk3eWWkhx1qX8rCkgsyHbPBsXqO7LvcQ@mail.gmail.com>
Sender: linux-pm-owner@vger.kernel.org
List-Id: linux-pm@vger.kernel.org
To: jonghwan Choi <jhbird.choi@gmail.com>
Cc: linux-pm@vger.kernel.org, cpufreq@vger.kernel.org, jhbird.choi@samsung.com, rjw@sisk.pl, patches@linaro.org

Hi,
On 21 January 2013 17:15, jonghwan Choi <jhbird.choi@gmail.com> wrote:
> Hi.
> I already send a patch to fix it.
> But i set the 0 as a initial value.
> Because i thought that
> =A1=B0
> if (frequeny_locked)
>      goto out; =A1=B0
> is not a error case.
> How about your opinion?

I thought it was an error condition and hence assigned -EINVAL.
If it is not then 0 should be good enough as it represents success for
that function.

>
> 2013. 1. 21. =BF=C0=C8=C4 7:38=BF=A1 "Sachin Kamat" <sachin.kamat@lin=
aro.org>=B4=D4=C0=CC =C0=DB=BC=BA:
>>
>> 'ret' is undefined when the function returns from the first
>> error condition. Without this patch we get the following warning:
>>
>> drivers/cpufreq/exynos-cpufreq.c: In function =A1=AEexynos_target=A1=
=AF:
>> drivers/cpufreq/exynos-cpufreq.c:182:2: warning:
>> =A1=AEret=A1=AF may be used uninitialized in this function [-Wuninit=
ialized]
>>
>> Signed-off-by: Sachin Kamat <sachin.kamat@linaro.org>
>> Cc: Jonghwan Choi <jhbird.choi@samsung.com>
>> ---
>>  drivers/cpufreq/exynos-cpufreq.c |    6 ++----
>>  1 files changed, 2 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/cpufreq/exynos-cpufreq.c
>> b/drivers/cpufreq/exynos-cpufreq.c
>> index 218b3ce..38c6158 100644
>> --- a/drivers/cpufreq/exynos-cpufreq.c
>> +++ b/drivers/cpufreq/exynos-cpufreq.c
>> @@ -159,7 +159,7 @@ static int exynos_target(struct cpufreq_policy
>> *policy,
>>  {
>>         struct cpufreq_frequency_table *freq_table =3D
>> exynos_info->freq_table;
>>         unsigned int index;
>> -       int ret;
>> +       int ret =3D -EINVAL;
>>
>>         mutex_lock(&cpufreq_lock);
>>
>> @@ -167,10 +167,8 @@ static int exynos_target(struct cpufreq_policy
>> *policy,
>>                 goto out;
>>
>>         if (cpufreq_frequency_table_target(policy, freq_table,
>> -                                          target_freq, relation, &i=
ndex))
>> {
>> -               ret =3D -EINVAL;
>> +                                          target_freq, relation, &i=
ndex))
>>                 goto out;
>> -       }
>>
>>         freqs.new =3D freq_table[index].frequency;
>>
>> --
>> 1.7.4.1
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe cpufreq" i=
n
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html



--=20
With warm regards,
Sachin
