From: Daniel Lezcano <daniel.lezcano@linaro.org>
Subject: Re: [PATCH V2 4/5] cpuidle: menu: Fix the get_typical_interval
Date: Wed, 29 Oct 2014 19:15:34 +0100
Message-ID: <54512EC6.4010901@linaro.org>
References: <1414054881-17713-1-git-send-email-daniel.lezcano@linaro.org>	<1414054881-17713-4-git-send-email-daniel.lezcano@linaro.org> <CAJvTdKk=uQmon81Y8+jVmYggxg-K2sWC4vEFM+bycKCEAt0fFg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJvTdKk=uQmon81Y8+jVmYggxg-K2sWC4vEFM+bycKCEAt0fFg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Nicolas Pitre <nicolas.pitre@linaro.org>, Linux PM list <linux-pm@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, linaro-kernel@lists.linaro.org, Patch Tracking <patches@linaro.org>
List-Id: linux-pm@vger.kernel.org

On 10/28/2014 03:48 AM, Len Brown wrote:
> On Thu, Oct 23, 2014 at 5:01 AM, Daniel Lezcano
> <daniel.lezcano@linaro.org> wrote:
>> The first time the 'get_typical_function' is called, it computes an =
average
>> of zero as no data is filled yet. That leads the 'data->predicted_us=
' variable
>> to be set to zero too.
>>
>> The caller, 'menu_select' will then do:
>>
>>          interactivity_req =3D data->predicted_us /
>>                          performance_multiplier(nr_iowaiters, cpu_lo=
ad);
>>
>> That sets the interactivity_req to zero (0/performance...).
>>
>> and then
>>
>>          if (latency_req > interactivity_req)
>>                  latency_req =3D interactivity_req;
>>
>> ... setting 'latency_req' to zero too.
>>
>> No idle state will fulfill this constraint and we will go the C1 sta=
te as
>> default and leading to an update. So the next calls will compute an =
average
>> different from zero.
>>
>> Even if that works with the current code but with a broken semantic,=
 it will
>> just break with the next patches where we are stricter with the late=
ncies
>> check: the first check will fail (latency_req is zero), then no upda=
te will
>> occur leading to always falling to choose an idle state.
>>
>> As there are no previous values and it is pointless to compute a sta=
ndard
>> deviation for these unexisting values. Just return without setting t=
he
>> 'data->predicted_us' to zero.
>>
>> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
>> ---
>>   drivers/cpuidle/governors/menu.c | 9 +++++++++
>>   1 file changed, 9 insertions(+)
>>
>> diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/gove=
rnors/menu.c
>> index 3907301..6ae8390 100644
>> --- a/drivers/cpuidle/governors/menu.c
>> +++ b/drivers/cpuidle/governors/menu.c
>> @@ -226,6 +226,15 @@ again:
>>          else
>>                  do_div(avg, divisor);
>>
>> +       /*
>> +        * We are at the very beginning and no data have been filled
>> +        * yet. Let's skip the standard deviation computation
>> +        * otherwise the data->predicted_us will be zero and that wi=
ll
>> +        * lead to a zero latency req in the select function
>> +        */
>> +       if (!avg)
>> +               return;
>> +
>
> Unfortunately, you've touched ugly code,
> and your (correct) patch makes it ever-so slightly more ugly,
> instead of more clear.
>
> I think the code would read more clearly, and your patch would
> less obscure, if the code read something like this sow that it is
> clear at the menu_select level when and where we monkey
> with predicted_us:
>
> menu_select()...
> ...
> data->predicted_us =3D div_round64(bla bla bla
>
> interactivity_overrride_us =3D get_typical_interval(data);
>
> if (interactivity_override_us)
>    if (interactivity_predicted_us < data->predicted_us)
>          data->predicted_us =3D interactivity_override_us;
>
> And, of course, down inside get_typical_interval()
> ...
> if (!avg)
>          return 0;
> ...
> if (likely(stddev <=3D ULONG_MAX)) {
> ...
>          return avg;


Ok, thanks for the suggestion. I will look at reworking this patch.

   -- Daniel


--=20
  <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software fo=
r ARM SoCs

=46ollow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
