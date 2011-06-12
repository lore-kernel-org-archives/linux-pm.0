From: "Justin P. Mattock" <justinmattock@gmail.com>
Subject: Re: [PATCH]drivers:base:power:trace.c Add "UTC"
 Coordinated Universal Time to the printk.
Date: Sun, 12 Jun 2011 12:34:20 -0700
Message-ID: <4DF514BC.9030808__44180.1490997479$1307907372$gmane$org@gmail.com>
References: <1307599301-2524-1-git-send-email-justinmattock@gmail.com>
	<201106121412.09903.rjw@sisk.pl> <4DF4E0CB.4090900@gmail.com>
	<201106122035.26600.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201106122035.26600.rjw@sisk.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On 06/12/2011 11:35 AM, Rafael J. Wysocki wrote:
> On Sunday, June 12, 2011, Justin P. Mattock wrote:
>> On 06/12/2011 05:12 AM, Rafael J. Wysocki wrote:
>>> Hi,
>>>
>>> On Thursday, June 09, 2011, Justin P. Mattock wrote:
>>>> From: "Justin P. Mattock"<justinmattock@gmail.com>
>>>>
>>>> sounds stupid, but taking a glance at the time, and seeing the wrong time, or what seemed
>>>> wrong in dmesg, caused me to go into total check the time clock panic mode.. So the patch below adds:
>>>> "UTC" Coordinated Universal Time abreviation to the printk so people like me dont flip out over the time!
>>>>
>>>> before:
>>>> [    0.114915] Time:  1:47:03  Date: 06/09/11
>>>>
>>>> after:
>>>> [    0.114728] Time:  5:46:02 UTC Date: 06/09/11
>>>>
>>>> Signed-off-by: Justin P. Mattock<justinmattock@gmail.com>
>>>
>>> I suspect the goal is to mark messages printed by the PM trace code so that
>>> they can be easily distinguished from messages from other sources to avoid
>>> confusion.  Why do you think it's a good idea to use the "UTC" string for
>>> this purpose?  The time printed in those messages need not be UTC.
>>>
>>> It would be better to simply print "RTC time: ..., date: ..." IMO.
>>>
>>> Thanks,
>>> Rafael
>>>
>>
>> well.. if thats better, then thats better.. over here(people that dont
>> know what RTC time is) would not get so confused with a simple UTC or
>> PDT or whatever the time zone is but if RTC is bettr, then its better.
>
> My point is we don't know this time is always UTC, so we rather shouldn't
> label it as UTC unconditionally, should we?
>
> Rafael
>

sounds good to me!!
