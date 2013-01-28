From: Lan Tianyu <lantianyu1986@gmail.com>
Subject: Re: [PATCH 1/2] ACPI/Sleep: Add init_nvs_nosave_s3() function
Date: Mon, 28 Jan 2013 21:05:32 +0800
Message-ID: <5106779C.6010305@gmail.com>
References: <1359359225-28223-1-git-send-email-tianyu.lan@intel.com> <1473081.Cm0g80OnKE@vostro.rjw.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <1473081.Cm0g80OnKE@vostro.rjw.lan>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Lan Tianyu <tianyu.lan@intel.com>, stern@rowland.harvard.edu, swilmet@gnome.org, linux-pm@vger.kernel.org, linux-acpi@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

=E4=BA=8E 2013/1/28 20:21, Rafael J. Wysocki =E5=86=99=E9=81=93:
> On Monday, January 28, 2013 03:47:04 PM Lan Tianyu wrote:
>> commit 1bad2f19f7f7 introduces nvs_nosave_s3 flag to just ban
>> saving nvs in ths s3 rather than both of s3 and s4. This patch
>> is to add init_nvs_nosave_s3() to set nvs_nosave_s3 to true for
>> those machines in the nonvs blacklist which only don't need to
>> saving nvs during s3 rather than both s3 and s4.
>>
>> Signed-off-by: Lan Tianyu <tianyu.lan@intel.com>
>
> Please fold [2/2] into [1/2] and resend.
>
Ok. I get it and will update.
> Thanks,
> Rafael
>
>
>> ---
>>   drivers/acpi/sleep.c |    6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/drivers/acpi/sleep.c b/drivers/acpi/sleep.c
>> index 2fcc67d..405b962 100644
>> --- a/drivers/acpi/sleep.c
>> +++ b/drivers/acpi/sleep.c
>> @@ -141,6 +141,12 @@ static int __init init_nvs_nosave(const struct =
dmi_system_id *d)
>>   	return 0;
>>   }
>>
>> +static int __init init_nvs_nosave_s3(const struct dmi_system_id *d)
>> +{
>> +	acpi_nvs_nosave_s3();
>> +	return 0;
>> +}
>> +
>>   static struct dmi_system_id __initdata acpisleep_dmi_table[] =3D {
>>   	{
>>   	.callback =3D init_old_suspend_ordering,
>>

--=20
Best regards
Tianyu Lan
--
To unsubscribe from this list: send the line "unsubscribe linux-acpi" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
