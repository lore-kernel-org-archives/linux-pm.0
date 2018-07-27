From: Angus Ainslie <angus@akkea.ca>
Subject: Re: [PATCH v2 2/4] power: bq25890_charger.c: Remove unused table
Date: Fri, 27 Jul 2018 09:26:46 -0600
Message-ID: <98004c185428f0ff3ba7e21be29f9377@www.akkea.ca>
References: <CAJKOXPczJWdNugbHiLRQv1krUFhZH=muix3M9R2LUT5=4zypYA@mail.gmail.com>
 <20180725194630.10414-1-angus@akkea.ca>
 <20180725194630.10414-3-angus@akkea.ca>
 <CAJKOXPeowiD7bXwRrG5horJOcxfEavB6XEmF8sz1unGDoykwoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <CAJKOXPeowiD7bXwRrG5horJOcxfEavB6XEmF8sz1unGDoykwoA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: angus.ainslie@puri.sm, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Hi Krzysztof,

On 2018-07-26 00:51, Krzysztof Kozlowski wrote:
> On 25 July 2018 at 21:46, Angus Ainslie (Purism) <angus@akkea.ca> 
> wrote:
>> The BATCMP table isn't used so drop it
> 
> TBL_VCLAMP also looks unused. TBL_IPRECHG does not have table entry.
> 

I as looking to drop the tables that would be problematic to the new 
part. Would you like me to resolve these 2 as well ?

Regards,
Angus

> Best regards,
> Krzysztof
