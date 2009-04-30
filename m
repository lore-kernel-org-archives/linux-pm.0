From: Michael Trimarchi <trimarchi@gandalf.sssup.it>
Subject: Re: [RFC Add no_suspend attribute V2] Let the driver
 know if it's in use
Date: Fri, 01 May 2009 01:42:04 +0200
Message-ID: <49FA374C.8000501@gandalf.sssup.it>
References: <Pine.LNX.4.44L0.0904251432250.20179-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0904251432250.20179-100000@netrider.rowland.org>
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
Cc: Greg KH <greg@kroah.com>, linux-pm@lists.linux-foundation.org, len.brown@intel.com
List-Id: linux-pm@vger.kernel.org

Hi,
Alan Stern wrote:
> On Sat, 25 Apr 2009, Michael Trimarchi wrote:
>
>   
>> Ok, I understand, so how to know the devices dependences? There is a way 
>> to express
>> this relation? Because if it is not possible a single flag can be used
>>     
>
> Nobody knows all the device dependencies.  That's why we're afraid that 
> if you change the list, something will break.
>
>   
But this happen for broken device? The list is a sufficient condition 
for correct
suspend phase but is not necesarry, because all the dependence are not 
registerd.
But just to understand: What are the typical situation, because I 
suppose that
we are not talking about broken device.
>>> This will set the dont_suspend flag for all devices in the subtree 
>>> starting at topdev.
>>>   
>>>       
>> Yes this is possible, but you walk all list twice.
>>     
>
> So what?  Walking the list is very quick, and you're not on a 
> time-critical path.
>
>   
Yes, you are right, I will submit a new patch with all the necessary fixes
> Alan Stern
>
>
>   
Thanks
