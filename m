From: Jiri Slaby <jirislaby@gmail.com>
Subject: Re: Resume hangs [was: mmotm 2010-12-02-16-34 uploaded]
Date: Tue, 08 Mar 2011 23:18:32 +0100
Message-ID: <4D76AB38.2070906__38630.8336783715$1299623261$gmane$org@gmail.com>
References: <Pine.LNX.4.44L0.1102221029100.1968-100000@iolanthe.rowland.org>
	<201103082312.26675.rjw@sisk.pl> <4D76AA2C.2010805@gmail.com>
	<201103082316.59901.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201103082316.59901.rjw@sisk.pl>
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
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 03/08/2011 11:16 PM, Rafael J. Wysocki wrote:
> On Tuesday, March 08, 2011, Jiri Slaby wrote:
>> On 03/08/2011 11:12 PM, Rafael J. Wysocki wrote:
>>> On Tuesday, March 08, 2011, Jiri Slaby wrote:
>>>> On 03/08/2011 08:25 PM, Rafael J. Wysocki wrote:
>>>>> On Tuesday, March 08, 2011, Jiri Slaby wrote:
>>>>>> On 02/22/2011 04:36 PM, Alan Stern wrote:
>>>>>>> By the way, are you booting with no_console_suspend?  And do you do 
>>>>>>> "echo 8 >/proc/sys/kernel/printk" (or equivalently, Alt-SysRq-8) before 
>>>>>>> suspending?
>>>>>>
>>>>>> Unfortunately there are no messages at all.
>>>>>>
>>>>>> Rafael, this is a Factory with intel gfx (modesetting). Do pm-utils
>>>>>> switch a console in such case? And if yes, to which one?
>>>>>
>>>>> pm-utils don't, but s2ram does, I'm not sure from the top of my head to
>>>>> which one, though.
>>>>>
>>>>> If you use a KMS driver (I get you do), please just "chmod a-x /usr/sbin/s2ram".
>>>>
>>>> Yeah, I meant kernel modesetting, of course. Sorry for the confusion.
>>>>
>>>> I don't have /usr/sbin/s2ram.
>>>
>>> Ah.  So it's gone from Factory?  Interesting.
>>
>> I don't know, maybe it's in suspend package which I don't have installed.
> 
> Hm.  So you use the in-kernel hibernate code?
> 
> The one in the suspend package is generally faster.

I don't use hibernation at all. This is a desktop -- suspending to S3.

-- 
js
