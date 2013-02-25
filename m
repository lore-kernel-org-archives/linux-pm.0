From: =?ISO-8859-1?Q?Emilio_L=F3pez?= <emilio@elopez.com.ar>
Subject: Re: [PATCH] cpufreq: highbank: do not initialize array with a loop
Date: Mon, 25 Feb 2013 07:58:33 -0300
Message-ID: <BLU0-SMTP837DD4DF438223EBC6536A8AF30@phx.gbl>
References: <1361725277-5125-1-git-send-email-emilio@elopez.com.ar>
 <CAOh2x=nDZpBaqjzO22k66Bb30mVEhAdy02EFDP9RDibA50Sx7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org>
In-Reply-To: <CAOh2x=nDZpBaqjzO22k66Bb30mVEhAdy02EFDP9RDibA50Sx7A@mail.gmail.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>,
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Sender: linux-arm-kernel-bounces@lists.infradead.org
Errors-To: linux-arm-kernel-bounces+linux-arm-kernel=m.gmane.org@lists.infradead.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: mark.langsdorf@calxeda.com, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, cpufreq@vger.kernel.org, rjw@sisk.pl, shawn.guo@linaro.org, linux-arm-kernel@lists.infradead.org
List-Id: linux-pm@vger.kernel.org

Hello,

El 25/02/13 00:41, Viresh Kumar escribi=F3:
> On Sun, Feb 24, 2013 at 10:31 PM, Emilio L=F3pez <emilio@elopez.com.ar> w=
rote:
>> As uninitialized array members will be initialized to zero, we can
>> avoid using a for loop by setting a value to it.
>>
>> Signed-off-by: Emilio L=F3pez <emilio@elopez.com.ar>
>> ---
>> Note that I don't own any device using this driver, it has only been com=
pile
>> tested, but it shouldn't cause any issues.
>>
>>  drivers/cpufreq/highbank-cpufreq.c | 6 +-----
>>  1 file changed, 1 insertion(+), 5 deletions(-)
>>
>> diff --git a/drivers/cpufreq/highbank-cpufreq.c b/drivers/cpufreq/highba=
nk-cpufreq.c
>> index 66e3a71..30d4ae1 100644
>> --- a/drivers/cpufreq/highbank-cpufreq.c
>> +++ b/drivers/cpufreq/highbank-cpufreq.c
>> @@ -28,13 +28,9 @@
>>
>>  static int hb_voltage_change(unsigned int freq)
>>  {
>> -       int i;
>> -       u32 msg[HB_CPUFREQ_IPC_LEN];
>> +       u32 msg[HB_CPUFREQ_IPC_LEN] =3D {HB_CPUFREQ_CHANGE_NOTE};
>>
>> -       msg[0] =3D HB_CPUFREQ_CHANGE_NOTE;
>>         msg[1] =3D freq / 1000000;
> =

> I think this can also be part of the definition of array, isn't it?
> =

> So it would be something like:
> =

> u32 msg[HB_CPUFREQ_IPC_LEN] =3D {HB_CPUFREQ_CHANGE_NOTE, freq / 1000000};
> =


I incorrectly assumed that sparse would complain, but after testing I
see it doesn't. Thanks for pointing it out, I'll send a v2 in a minute.

Emilio
