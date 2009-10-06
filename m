From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: 2.6.32-rc1: various BUGs on resume from hibernation
Date: Tue, 06 Oct 2009 09:58:48 +0100
Message-ID: <4ACB06C8.9030209@tuffmail.co.uk>
References: <4AC8B4A8.3050601@tuffmail.co.uk> <4ACA50DD.9050801@tuffmail.co.uk>
	<4ACA5E3D.1020108@tuffmail.co.uk> <200910060048.41615.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200910060048.41615.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, Kernel Testers List <kernel-testers@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, Stefan Seyfried <stefan.seyfried@googlemail.com>
List-Id: linux-pm@vger.kernel.org

Rafael J. Wysocki wrote:
> On Monday 05 October 2009, Alan Jenkins wrote:
>   
>> Alan Jenkins wrote:
>>     
>>> Stefan Seyfried wrote:
>>>       
>>>> On Sun, 4 Oct 2009 22:47:43 +0200
>>>> "Rafael J. Wysocki" <rjw@sisk.pl> wrote:
>>>>         
>>>>> On Sunday 04 October 2009, Alan Jenkins wrote:
>>>>>           
>>>>>> Alan Jenkins wrote:
>>>>>>             
>>>>>>> I'm seeing a variety of BUGs on my EeePC 701 after hibernation. 
>>>>>>> Sometimes they cause a hang during resume; sometimes they happen
>>>>>>> just after resume. It doesn't happen all the time either - I've
>>>>>>> just hibernated three times in a row with no problems. It's most
>>>>>>> perplexing.
>>>>>>>               
>>>>> As I already asked in the Bugzilla, can you verify that this is
>>>>> reproducible without KMS?
>>>>>           
>>> No. I couldn't reproduce it without KMS. Then I re-enabled KMS, 
>>> hibernated a couple of times, and had another resume hang (different 
>>> again - this time in the freezer).
>>>
>>>       
>> Perhaps this GEM backtrace is more relevant than the others, or perhaps 
>> not. I closed the lid during resume from hibernation; the screen stayed 
>> black when I re-opened it, but syslogd recorded the following. (Again, 
>> I've done the exact thing before and often nothing unusual happens) -
>>     
>
> OK, let's assume it's related to KMS, then.
>
> 1. Do we already have a Bugzilla entry for it?
> 2. Did it work with 2.6.31 (and with KMS)?
>   

I thought so, but my recollection is hazy.  I didn't test it for very
long if I did.  I've tried it now and 2.6.31 behaves pretty similarly. 
Sorry for ringing the regression bell.

Firstly the _hibernation_ process hung (after a couple of suspend-to-ram
cycles).

No text on the console (despite using s2disk).  It echoed keypresses and
responds to SysRq keys.  No messages from lockdep or the hung task
detector (after waiting 5 minutes).  SysRq-P said we're in the idle
loop; SysRq-T said both events/0 and hald-addon-input were runnable.

Then suspend-to-ram hung (following a hibernation cycle).  This time it
showed the contents of vt1, but didn't appear to respond to anything
short of SysRq+B.


> 3. Are you aware of http://marc.info/?l=linux-kernel&m=125452324520623&w=4 ?
>
> Thanks,
> Rafael
>   

I guess there's no connection.  That issue seems to be about generally
flickery screens.  I've seen a few rare flickers that might be related. 
But in general nothing bad happens until I try to suspend, and the
badness is in the form of random crashes or hangs.

Also that bug is confirmed to be a regression, and my issue isn't :-).

Many thanks
Alan
