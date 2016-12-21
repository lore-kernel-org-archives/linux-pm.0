From: Chris Lapa <chris@lapa.com.au>
Subject: Re: BQ27xxx registers
Date: Wed, 21 Dec 2016 13:49:10 +1100
Message-ID: <a354018a-a2e5-f70e-85b1-477a8d349a04@lapa.com.au>
References: <6da60215-4b73-8924-d5ca-48f99c70e7fb@lapa.com.au>
 <201612201234.19759@pali>
Reply-To: chris@lapa.com.au
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <201612201234.19759@pali>
Sender: linux-kernel-owner@vger.kernel.org
To: =?UTF-8?Q?Pali_Roh=c3=a1r?= <pali.rohar@gmail.com>
Cc: afd@ti.com, Sebastian Reichel <sre@kernel.org>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 20/12/16 10:34 pm, Pali Rohár wrote:
> On Tuesday 20 December 2016 07:00:41 Chris Lapa wrote:
>> I can generate a patch to fix this issue, however the bigger problem
>> exists as to which revision fuel gauge the bq27xxx_battery.c driver
>> is intended to support for each family.
>
> Hi! I think driver should support all revisions. There can be (and
> probably really is) hardware which uses old revision and such hardware
> should be still supported...
>

I agree. However due to the register address changes across the spectrum 
of revisions, each revision will have to be specified individually. For 
example, we will need to implement a BQ27510G1, BQ27510G2, BQ27510G3, 
BQ27520G1, BQ27520G2, BQ27520G3, BQ27520G4 definitions and prospective 
device tree additions ti,bq27510g1, ti,bq27510g2 etc.

The other option is to aim for bottom of the barrel support for all the 
devices under the BQ27500 definition but my feeling is it would get 
messier fast and be less maintainable.

My preference is to go with the first option if you agree?

Thanks,
Chris
