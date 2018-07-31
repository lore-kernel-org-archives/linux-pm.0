From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: [PATCH v2 2/4] power: bq25890_charger.c: Remove unused table
Date: Tue, 31 Jul 2018 08:40:16 +0200
Message-ID: <CAJKOXPcp229Kj4d+5m8JbX8k7ghgDmowiZ8j6KdWJGhAh0ONnQ@mail.gmail.com>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180725194630.10414-1-angus@akkea.ca> <20180725194630.10414-3-angus@akkea.ca>
 <CAJKOXPeowiD7bXwRrG5horJOcxfEavB6XEmF8sz1unGDoykwoA@mail.gmail.com> <98004c185428f0ff3ba7e21be29f9377@www.akkea.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <98004c185428f0ff3ba7e21be29f9377@www.akkea.ca>
Sender: linux-kernel-owner@vger.kernel.org
To: Angus Ainslie <angus@akkea.ca>
Cc: angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 27 July 2018 at 17:26, Angus Ainslie <angus@akkea.ca> wrote:
> Hi Krzysztof,
>
> On 2018-07-26 00:51, Krzysztof Kozlowski wrote:
>>
>> On 25 July 2018 at 21:46, Angus Ainslie (Purism) <angus@akkea.ca> wrote:
>>>
>>> The BATCMP table isn't used so drop it
>>
>>
>> TBL_VCLAMP also looks unused. TBL_IPRECHG does not have table entry.
>>
>
> I as looking to drop the tables that would be problematic to the new part.
> Would you like me to resolve these 2 as well ?

Yes. Since you are removing some entry then let's remove all unneeded entries.

Krzysztof
