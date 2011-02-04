From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Resume hangs [was: mmotm 2010-12-02-16-34 uploaded]
Date: Fri, 04 Feb 2011 20:38:31 +0100
Message-ID: <4D4C55B7.4010005__33859.355786308$1296848467$gmane$org@gmail.com>
References: <Pine.LNX.4.44L0.1102041426380.1877-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1102041426380.1877-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: "Rafael J. Wysocki" <rjw@suse.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 02/04/2011 08:33 PM, Alan Stern wrote:
> On Fri, 4 Feb 2011, Jiri Slaby wrote:
> 
>>>> It seems to suffice... No hangs still. Should I enable pm_async back
>>>> again to confirm the issue is still present?
>>>
>>> Yes, please, it would be good to know for sure.
>>
>> Ok, confirmed right now :).
>>
>> I disabled pm_async for USB again. What do you suggest next?
> 
> What happens if you leave pm_async enabled but unplug all the USB 
> devices before suspending?

Then I cannot suspend at all (ENOINPUTDEVICE)... And this would be
painful as the bug occurs once a week or so.

> If there are any USB devices you can't 
> unplug, you can get an equivalent result by unconfiguring the root 
> hubs:
> 
> 	for a in /sys/bus/usb/devices/usb* ; do
> 		echo 0 >$a/bConfigurationValue
> 	done

Well, I can put this into suspend/resume scripts. What's the opposite
operation? 1 > $a/bConfigurationValue?

thanks,
-- 
js
