From: Stratos Karafotis <stratosk@semaphore.gr>
Subject: Re: [PATCH] cpufreq: powernow-k8: Fix checkpatch warnings
Date: Wed, 23 Apr 2014 16:51:58 +0300
Message-ID: <5357C57E.9070007@semaphore.gr>
References: <5356DB92.1060600@semaphore.gr> <CAKohpo=6wTYHGvLcNUb4+MFdKeHobNA0A1W2Ta5yJqBCAceMhA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAKohpo=6wTYHGvLcNUb4+MFdKeHobNA0A1W2Ta5yJqBCAceMhA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Viresh Kumar <viresh.kumar@linaro.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>, "cpufreq@vger.kernel.org" <cpufreq@vger.kernel.org>, "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On 23/04/2014 07:46 =CF=80=CE=BC, Viresh Kumar wrote:
> On 23 April 2014 02:43, Stratos Karafotis <stratosk@semaphore.gr> wro=
te:
>> @@ -342,7 +333,7 @@ static int core_voltage_pre_transition(struct po=
wernow_k8_data *data,
>>                 return 1;
>>
>>         if (savefid !=3D data->currfid) {
>> -               printk(KERN_ERR PFX "ph1 err, currfid changed 0x%x\n=
",
>> +               pr_err("ph1 err, currfid changed 0x%x\n",
>>                                 data->currfid);
>=20
> This will come in single line?
>=20
>> @@ -529,43 +510,39 @@ static int check_pst_table(struct powernow_k8_=
data *data, struct pst_s *pst,
>>
>>         for (j =3D 0; j < data->numps; j++) {
>>                 if (pst[j].vid > LEAST_VID) {
>> -                       printk(KERN_ERR FW_BUG PFX "vid %d invalid :=
 0x%x\n",
>> -                              j, pst[j].vid);
>> +                       pr_err(FW_BUG "vid %d invalid : 0x%x\n", j,
>> +                              pst[j].vid);
>=20
> Same here.
>=20
>>  static const char missing_pss_msg[] =3D
>>         KERN_ERR
>=20
> remove this and use pr_err_once instead of printk_once()
>=20
>> -       FW_BUG PFX "No compatible ACPI _PSS objects found.\n"
>> -       FW_BUG PFX "First, make sure Cool'N'Quiet is enabled in the =
BIOS.\n"
>> -       FW_BUG PFX "If that doesn't help, try upgrading your BIOS.\n=
";
>> +       FW_BUG KBUILD_MODNAME
>> +       "No compatible ACPI _PSS objects found.\n"
>=20
> Don't break these, even if they cross 80 columns.
>=20

Thanks for your review!

Stratos
