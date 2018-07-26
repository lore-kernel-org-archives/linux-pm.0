From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH] bq25890_charger.c : add the BQ25896 part
Date: Thu, 26 Jul 2018 08:37:02 +0200
Message-ID: <CAJKOXPd1NZtyDmBnLnsQafH2AKufAsB-p78JM0s6kBXK3APhuA@mail.gmail.com>
References: <20180723135117.2090-1-angus@akkea.ca> <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <cdfed37dd6a24a4afffc0d880601e2c7@www.akkea.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <cdfed37dd6a24a4afffc0d880601e2c7@www.akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Angus Ainslie <angus@akkea.ca>
Cc: Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, Angus Ainslie <angus.ainslie@puri.sm>
List-Id: linux-pm@vger.kernel.org

On 25 July 2018 at 14:17, Angus Ainslie <angus@akkea.ca> wrote:
> Hi Krzysztof,
>
> On 2018-07-25 03:58, Krzysztof Kozlowski wrote:
>>
>> On 23 July 2018 at 15:51, Angus Ainslie <angus@akkea.ca> wrote:
>>>
>>> Add some debugging to be able to check the proper initialization
>>> of the BQ25896 part.
>>
>>
>> Hi,
>>
>> This should be split into separate patchset. Do not mix two features
>> in one commit.
>>
>
> Ok, I'll take it apart
>
>>> Enable the BQ25896 part.
>>>
>>> Add 2 new parameters "voltage_now" and "model_name".
>>>
>>> Signed-off-by: Angus Ainslie <angus.ainslie@puri.sm>
>>
>>
>> Your signed-off-by does not match From address.
>>
>
> That was intentional as I wanted Purism to get credit for it. I'm guessing
> that's not the correct way of doing it.

The author of patch (appearing as "From") should match Signed-off-by.
You might however easily create commit and signed it with your Purism
email. If you send such email, you will notice that "From" field is
visible in the mail message and it differs from Sender.

Best regards,
Krzysztof
