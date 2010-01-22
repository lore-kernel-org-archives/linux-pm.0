From: Nigel Cunningham <ncunningham@crca.org.au>
Subject: Re: syncing the disks when entering sleep
Date: Sat, 23 Jan 2010 09:06:50 +1100
Message-ID: <4B5A217A.4090107@crca.org.au>
References: <76FA3B279DD9DA48896E2B404944957204E0B241@USA7061MS02.na.xerox.net>
	<4B5A1942.2050003@crca.org.au>
	<76FA3B279DD9DA48896E2B404944957204E0B68C@USA7061MS02.na.xerox.net>
	<201001222238.13926.rjw@sisk.pl>
	<76FA3B279DD9DA48896E2B404944957204E0B6AE@USA7061MS02.na.xerox.net>
	<4B5A1EE1.5040005@crca.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <4B5A1EE1.5040005@crca.org.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Leisner, Martin" <Martin.Leisner@xerox.com>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi again.

Nigel Cunningham wrote:
> Hi.
> 
> Leisner, Martin wrote:
>>>   -----Original Message-----
>>>   From: Rafael J. Wysocki [mailto:rjw@sisk.pl]
>>>   Sent: Friday, January 22, 2010 4:38 PM
>>>   To: Leisner, Martin
>>>   Cc: Nigel Cunningham; linux-pm@lists.linux-foundation.org
>>>   Subject: Re: [linux-pm] syncing the disks when entering sleep
>>>   
>>>   On Friday 22 January 2010, Leisner, Martin wrote:
>>>   > To clarify what I proposed:
>>>   >
>>>   > if(user sets knobs)
>>>   >     if(disk is spun up)
>>>   >          sync
>>>   >
>>>   > currently the algorithm is
>>>   >
>>>   >     sync
>>>   
>>>   Yes, but Nigel said it should be
>>>   
>>>   if(user knob is unset)
>>>             sync
>>>   
>>>   which I agree with.
>>>   
>>>   [BTW, please don't top-post in future.]
>>>   
>>>   Rafael
>> if(knob is set) {
>>     if(disk is spun up)
>>        sync
>> } else sync
>>
>> The spinup of the disk can have a very noticeable amount of time...if the user doesn't care about syncing, then the top is preferred...

Sorry to reply to myself but...

> That sounds much better; thanks.

I shouldn't have said that - as Rafael said

if (knob is unset)
  sync

provides much more predictable behaviour. I know you want the code to
look at whether the disk is spun up, but that makes things more
unpredictable. Imagine a situation where you get some error in which
whether we synced or not is important - reproducing, diagnosing and
fixing the issue gets more complicated if we go your way.

The other issue would be detecting whether disks (there might be more
than one!) are spun up. That, in itself, would probably require a lot of
extra code to get the info from the drivers.

An explicit and unconditional disabling of syncing is simpler.

Regards,

Nigel
