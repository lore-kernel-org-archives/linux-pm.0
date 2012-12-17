From: Len Brown <lenb@kernel.org>
Subject: Re: turbostat tool update for Linux-3.8
Date: Mon, 17 Dec 2012 13:34:30 -0500
Message-ID: <50CF65B6.2080308@kernel.org>
References: <1352925804-6746-1-git-send-email-lenb@kernel.org> <1353011874.3055.22.camel@ejdallLaptop>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <1353011874.3055.22.camel@ejdallLaptop>
Sender: linux-kernel-owner@vger.kernel.org
To: Betty Dall <betty.dall@hp.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 11/15/2012 03:37 PM, Betty Dall wrote:
> On Wed, 2012-11-14 at 15:43 -0500, Len Brown wrote:
>> Here are some turbostat patches I have staged.
>> The 1st two I've requested be pulled into 3.7,
>> the rest are for 3.8
>>
>> The final patch allows turbostat to print Watts
>> as measured by hardware RAPL counters -- something
>> that people have been asking for.
>>
>> Please let me know if you see troubles with any of these patches.
> 
> Hi Len,
> 
> I tested out these patches on an IvyBridge system and see the new Watts
> fields. They look like reasonable numbers to me. I ran with the system
> idle and then with lookbusy -c 50 and saw the Watts increase. Is there
> anything else to do to validate the numbers? In one case I saw that the
> Pkg_W for the system was off by .01, e.g. socket 0 was 28.33 and socket
> 1 was 29.74 and the system total was 58.08 instead of 58.07. That is
> probably fine and just rounding up.

This is likely a result of printf truncation.
note that these numbers are added internally w/o that truncation,
and then their sum is printed.

If the total system power is what you're looking for, note that
you need to calibrate these numbers vs an external A/C watt meter.
eg. add a base Watts to idle -- which covers things like fans
and fixed power supply loss, then use a coefficient on the counter
to handle factors such as power conversion loss, which tend to be
somewhat linear with load.

With constant temperature, I've found this trivial curve fitting
to be remarkably accurate.

eg. on a dual SNB Xeon box I have...

45 Watts + 1.25 * RAPL-Watt-Meter = System A/C watts
within a couple %.

cheers,
-Len
