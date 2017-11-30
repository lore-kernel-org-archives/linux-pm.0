From: Phil Reid <preid@electromag.com.au>
Subject: Re: [RFC v2 2/3] i2c: Kconfig: rename variable I2C_SMBUS to
 I2C_SMBUS_ALERT
Date: Thu, 30 Nov 2017 18:31:13 +0800
Message-ID: <0f316ec8-a9c1-3348-0d0b-cb1c567c9646@electromag.com.au>
References: <1511840309-37964-1-git-send-email-preid@electromag.com.au>
 <1511840309-37964-3-git-send-email-preid@electromag.com.au>
 <20171128230855.20bb64be@endymion>
 <21647bb9-0818-8823-0935-87b270a80f26@electromag.com.au>
 <20171129134849.140ca3ad@endymion>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-i2c-owner@vger.kernel.org>
In-Reply-To: <20171129134849.140ca3ad@endymion>
Content-Language: en-AU
Sender: linux-i2c-owner@vger.kernel.org
To: Jean Delvare <jdelvare@suse.de>
Cc: realmz6@gmail.com, wsa@the-dreams.de, sre@kernel.org, adi-buildroot-devel@lists.sourceforge.net, linux-i2c@vger.kernel.org, linux-pm@vger.kernel.org, benjamin.tissoires@redhat.com
List-Id: linux-pm@vger.kernel.org

On 29/11/2017 20:48, Jean Delvare wrote:
> On Wed, 29 Nov 2017 09:58:44 +0800, Phil Reid wrote:
>> G'day Jean,
>>
>> Thanks for looking at this.
>>
>> On 29/11/2017 06:08, Jean Delvare wrote:
>>> Hi Phil,
>>>
>>> On Tue, 28 Nov 2017 11:38:28 +0800, Phil Reid wrote:
>>>> i2c-smbus now only contains code related to the smbus_alert driver.
>>>> Other smbus protocols have been moved from this into the i2c-core-smbus.
>>>> Change the Kconfig variable name to reflect this.
>>>
>>> Not really. i2c-core-smbus.c contains essentially SMBus transaction
>>> helpers, which have never been in i2c-smbus.c. They aren't really SMBus
>>> protocols, more like a subset of I2C transactions suitable for general
>>> purpose. The only really SMBus protocol specific portion is relative to
>>> SMBus Alert, and that's only a small part of it. The other supported
>>> SMBus-specific protocol, Host Notify, is in i2c-core-base.c.
>>>
>>> My original intent was to have all the SMBus protocols specific code in
>>> one file, controlled by one Kconfig option, which could be built as a
>>> separate module. I wasn't certain it would be viable, it was a bet
>>> which I lost, as it turns out there are too many dependencies.
>>>
>>> If the code can no longer build as a separate module, there is no
>>> benefit in having it in a separate file. Let's just merge it into
>>> i2c-code-smbus.c, where the rest of the SMBus alert code already is.
>>> That would make things more simple.
>> I had to put of_i2c_setup_smbus_alert in there to deal with dependencies.
>> This was seen as a little messy at the time. It was accepted provided
>> that I clean things up somehow.
>>
>> The question is how. This series is just one proposal for that to stir some
>> discussion. Your approach is certainly the simpler one.
> 
> OK, can you please give it a try and wee how it compares with your own
> approach?

Should be able to get to it next week.

> 
>>> I also don't think renaming this configuration option and moving code
>>> to a separate file (as your patch 3/3 does) makes sense. Having a
>>> separate option for each SMBus-specific protocol seems overkill to me,
>>> having one for all of them was and still is more reasonable. I wonder
>>> why the SMBus Notify code does NOT depend on CONFIG_I2C_SMBUS, and why
>>> it is in i2c-core-base.c instead of i2c-core-smbus.c. Wolfram?
>>>
>>> And more generally, renaming a Kconfig option has a non-trivial cost
>>> for distribution kernel maintainers, so it shall not be done lightly.
>>> So you need a clear and strong rationale.
>>
>> My only rational is that it didn't encompass all the SMBUS specific protocols.
>> It currently seems a little ambiguous to me. Especially with regard the current
>> Kconfig help description is not accurate with regard the Host Notify protocol.
> 
> I agree, the I2C_SMBUS Kconfig help text no longer reflects the reality
> since over a year now. But I think the text is how things should be and
> the code is what should be fixed (that is, all the SMBus Host Notify
> code should be left out when I2C_SMBUS isn't set, and it should live in
> i2c-core-smbus.c.) But I did not look at the details, maybe this isn't
> possible for some reason. Maybe you can look into it after you are done
> with moving the SMBus Alert code into the i2c core? If you don't, I
> will.
> 
> Thanks,
> 


-- 
Regards
Phil Reid
