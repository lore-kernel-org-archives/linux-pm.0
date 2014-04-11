From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [RFC PATCH] cpufreq: Introduce macros for cpufreq_frequency_table
 iteration
Date: Fri, 11 Apr 2014 19:31:39 +0300
Message-ID: <534818EB.3080406@semaphore.gr>
References: <534714D0.2010803@semaphore.gr> <CAKohpo=u9hHtp94A_KLKupi9de+eZYCWQfEdUV-NS+iryH-gHw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=u9hHtp94A_KLKupi9de+eZYCWQfEdUV-NS+iryH-gHw@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org >> LKML" <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 11/04/2014 07:24 =CF=80=CE=BC, Viresh Kumar wrote:
> On 11 April 2014 03:31, Stratos Karafotis <stratosk@semaphore.gr> wro=
te:
>> This patch intoduces 2 macros which can be used for iteration
>> over cpufreq_frequency_table:
>>
>> - cpufreq_for_each_entry: iterate over each entry of the table
>> - cpufreq_for_each_valid_entry: iterate over each entry of the
>> table that contains a valid frequency.
>>
>> It should have no functional changes.
>>
>> Signed-off-by: Stratos Karafotis <stratosk@semaphore.gr>
>> ---
>>
>> I found about 20 occurrences in various drivers that these macros
>> can be used. I will proceed with the necessary changes if you
>> approve something like this.
>>
>> Thanks in advance for your time,
>=20
> Thanks for your time and I find it useful enough. So its a yes from
> me :)
>=20
> But, have you tested this yet?
>=20
>> Stratos Karafotis.
>> ---
>>
>>  drivers/cpufreq/freq_table.c | 54 ++++++++++++++++++++-------------=
-----------
>>  include/linux/cpufreq.h      | 29 ++++++++++++++++++++++++
>>  2 files changed, 53 insertions(+), 30 deletions(-)
>>
>> diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_tab=
le.c
>> index 08e7bbc..19bf0c4 100644
>> --- a/drivers/cpufreq/freq_table.c
>> +++ b/drivers/cpufreq/freq_table.c
>> @@ -21,22 +21,18 @@
>>  int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
>>                                     struct cpufreq_frequency_table *=
table)
>>  {
>> +       struct cpufreq_frequency_table *pos;
>>         unsigned int min_freq =3D ~0;
>>         unsigned int max_freq =3D 0;
>> -       unsigned int i;
>>
>> -       for (i =3D 0; (table[i].frequency !=3D CPUFREQ_TABLE_END); i=
++) {
>> -               unsigned int freq =3D table[i].frequency;
>> -               if (freq =3D=3D CPUFREQ_ENTRY_INVALID) {
>> -                       pr_debug("table entry %u is invalid, skippin=
g\n", i);
>> +       cpufreq_for_each_valid_entry(pos, table) {
>> +               unsigned int freq =3D pos->frequency;
>=20
> move the definition part to the top of this routine, we don't need
> to create freq for every iteration here. It was bad earlier as well :=
)
>=20
>>
>> -                       continue;
>> -               }
>>                 if (!cpufreq_boost_enabled()
>> -                   && (table[i].flags & CPUFREQ_BOOST_FREQ))
>> +                   && (pos->flags & CPUFREQ_BOOST_FREQ))
>>                         continue;
>>
>> -               pr_debug("table entry %u: %u kHz\n", i, freq);
>> +               pr_debug("table entry %lu: %u kHz\n", pos - table, f=
req);
>>                 if (freq < min_freq)
>>                         min_freq =3D freq;
>>                 if (freq > max_freq)
>> @@ -57,7 +53,8 @@ EXPORT_SYMBOL_GPL(cpufreq_frequency_table_cpuinfo)=
;
>>  int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
>>                                    struct cpufreq_frequency_table *t=
able)
>>  {
>> -       unsigned int next_larger =3D ~0, freq, i =3D 0;
>> +       struct cpufreq_frequency_table *pos;
>> +       unsigned int next_larger =3D ~0, freq;
>>         bool found =3D false;
>>
>>         pr_debug("request for verification of policy (%u - %u kHz) f=
or cpu %u\n",
>> @@ -65,9 +62,9 @@ int cpufreq_frequency_table_verify(struct cpufreq_=
policy *policy,
>>
>>         cpufreq_verify_within_cpu_limits(policy);
>>
>> -       for (; freq =3D table[i].frequency, freq !=3D CPUFREQ_TABLE_=
END; i++) {
>> -               if (freq =3D=3D CPUFREQ_ENTRY_INVALID)
>> -                       continue;
>> +       cpufreq_for_each_valid_entry(pos, table) {
>> +               freq =3D pos->frequency;
>> +
>>                 if ((freq >=3D policy->min) && (freq <=3D policy->ma=
x)) {
>>                         found =3D true;
>>                         break;
>> @@ -118,7 +115,8 @@ int cpufreq_frequency_table_target(struct cpufre=
q_policy *policy,
>>                 .driver_data =3D ~0,
>>                 .frequency =3D 0,
>>         };
>> -       unsigned int i;
>> +       struct cpufreq_frequency_table *pos;
>> +       unsigned int i =3D 0;
>>
>>         pr_debug("request for target %u kHz (relation: %u) for cpu %=
u\n",
>>                                         target_freq, relation, polic=
y->cpu);
>> @@ -132,10 +130,10 @@ int cpufreq_frequency_table_target(struct cpuf=
req_policy *policy,
>>                 break;
>>         }
>>
>> -       for (i =3D 0; (table[i].frequency !=3D CPUFREQ_TABLE_END); i=
++) {
>> -               unsigned int freq =3D table[i].frequency;
>> -               if (freq =3D=3D CPUFREQ_ENTRY_INVALID)
>> -                       continue;
>> +       cpufreq_for_each_valid_entry(pos, table) {
>> +               unsigned int freq =3D pos->frequency;
>=20
> same here.
>=20
>> +
>> +               i =3D pos - table;
>>                 if ((freq < policy->min) || (freq > policy->max))
>>                         continue;
>>                 switch (relation) {
>> @@ -184,8 +182,7 @@ EXPORT_SYMBOL_GPL(cpufreq_frequency_table_target=
);
>>  int cpufreq_frequency_table_get_index(struct cpufreq_policy *policy=
,
>>                 unsigned int freq)
>>  {
>> -       struct cpufreq_frequency_table *table;
>> -       int i;
>> +       struct cpufreq_frequency_table *pos, *table;
>>
>>         table =3D cpufreq_frequency_get_table(policy->cpu);
>>         if (unlikely(!table)) {
>> @@ -193,9 +190,9 @@ int cpufreq_frequency_table_get_index(struct cpu=
freq_policy *policy,
>>                 return -ENOENT;
>>         }
>>
>> -       for (i =3D 0; table[i].frequency !=3D CPUFREQ_TABLE_END; i++=
) {
>> -               if (table[i].frequency =3D=3D freq)
>> -                       return i;
>> +       cpufreq_for_each_entry(pos, table) {
>=20
> use cpufreq_for_each_valid_entry() here as well.
>=20
>> +               if (pos->frequency =3D=3D freq)
>> +                       return pos - table;
>>         }
>>
>>         return -EINVAL;
>> @@ -208,16 +205,13 @@ EXPORT_SYMBOL_GPL(cpufreq_frequency_table_get_=
index);
>>  static ssize_t show_available_freqs(struct cpufreq_policy *policy, =
char *buf,
>>                                     bool show_boost)
>>  {
>> -       unsigned int i =3D 0;
>>         ssize_t count =3D 0;
>> -       struct cpufreq_frequency_table *table =3D policy->freq_table=
;
>> +       struct cpufreq_frequency_table *pos, *table =3D policy->freq=
_table;
>>
>>         if (!table)
>>                 return -ENODEV;
>>
>> -       for (i =3D 0; (table[i].frequency !=3D CPUFREQ_TABLE_END); i=
++) {
>> -               if (table[i].frequency =3D=3D CPUFREQ_ENTRY_INVALID)
>> -                       continue;
>> +       cpufreq_for_each_valid_entry(pos, table) {
>>                 /*
>>                  * show_boost =3D true and driver_data =3D BOOST fre=
q
>>                  * display BOOST freqs
>> @@ -229,10 +223,10 @@ static ssize_t show_available_freqs(struct cpu=
freq_policy *policy, char *buf,
>>                  * show_boost =3D false and driver_data !=3D BOOST f=
req
>>                  * display NON BOOST freqs
>>                  */
>> -               if (show_boost ^ (table[i].flags & CPUFREQ_BOOST_FRE=
Q))
>> +               if (show_boost ^ (pos->flags & CPUFREQ_BOOST_FREQ))
>>                         continue;
>>
>> -               count +=3D sprintf(&buf[count], "%d ", table[i].freq=
uency);
>> +               count +=3D sprintf(&buf[count], "%d ", pos->frequenc=
y);
>>         }
>>         count +=3D sprintf(&buf[count], "\n");
>>
>> diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
>> index 5ae5100..1c221c8 100644
>> --- a/include/linux/cpufreq.h
>> +++ b/include/linux/cpufreq.h
>> @@ -468,6 +468,35 @@ struct cpufreq_frequency_table {
>>                                     * order */
>>  };
>>
>> +static inline bool validate_entry(struct cpufreq_frequency_table *p=
os)
>> +{
>> +       while (pos->frequency !=3D CPUFREQ_TABLE_END)
>> +               if (pos->frequency =3D=3D CPUFREQ_ENTRY_INVALID)
>> +                       pos++;
>=20
> This is why I asked you if you have tested it or not.
> pos is a local variable here and so pos++ wouldn't reflect in the par=
ent
> function. But your code will still work as we will check again for th=
e next
> INVALID frequency.

Of course, you are right!
Yes, I partially tested it. But my frequency table didn't contain an
invalid entry. I will fix it.

> Another important thing: This routine is going to be used from a Macr=
o
> and so making it inline is very *inefficient*. We are going to use it=
 from
> Atleast 20-25 places (as you mentioned) and we definitely aren't look=
ing
> to have so many copies of this one :)
>=20
> So, you should move this to cpufreq.c

OK, I will do it. I was thinking about performance but as you mentioned
20 copies are too much. :)

>> +               else
>> +                       return true;
>> +       return false;
>> +}
>> +
>> +/*
>> + * cpufreq_for_each_entry -    iterate over a cpufreq_frequency_tab=
le
>> + * @pos:       the cpufreq_frequency_table * to use as a loop curso=
r.
>> + * @table:     the cpufreq_frequency_table * to iterate over.
>> + */
>> +
>> +#define cpufreq_for_each_entry(pos, table)     \
>> +       for (pos =3D table; pos->frequency !=3D CPUFREQ_TABLE_END; p=
os++)
>> +
>> +/*
>> + * cpufreq_for_each_valid_entry -     iterate over a cpufreq_freque=
ncy_table
>> + *     exluding CPUFREQ_ENTRY_INVALID frequencies.
>> + * @pos:        the cpufreq_frequency_table * to use as a loop curs=
or.
>> + * @table:      the cpufreq_frequency_table * to iterate over.
>> + */
>> +
>> +#define cpufreq_for_each_valid_entry(pos, table)       \
>> +       for (pos =3D table; validate_entry(pos); pos++)
>> +
>>  int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
>>                                     struct cpufreq_frequency_table *=
table);
>=20
> Otherwise looks fine. Please update all drivers as well :)
>=20

I will prepare the patches with your suggestions.
Thank you very much for your review!


Stratos
