From: Alan Jenkins <alan-jenkins@tuffmail.co.uk>
Subject: Re: Regression: First hibernation attempt fails
Date: Fri, 10 Apr 2009 12:35:02 +0100
Message-ID: <49DF2EE6.20203__2146.88564087755$1239363554$gmane$org@tuffmail.co.uk>
References: <49DDD83F.507@tuffmail.co.uk> <20090410092318.GB30093@elf.ucw.cz>
	<49DF289D.5070604@tuffmail.co.uk>
	<20090410112115.GA2513@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090410112115.GA2513@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.linux-foundation.org, Kernel Testers List <kernel-testers@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

Pavel Machek wrote:
> On Fri 2009-04-10 12:08:13, Alan Jenkins wrote:
>   
>> Pavel Machek wrote:
>>     
>>> On Thu 2009-04-09 12:13:03, Alan Jenkins wrote:
>>>   
>>>       
>>>> Yet another issue in 2.6.30-rc1 which was not present in 2.6.29 :-).  I
>>>> wonder if it rings any bells?
>>>>
>>>> On my laptop (EEE 4G), the first attempt at hibernation fails. 
>>>> Subsequent attempts succeed.
>>>>
>>>> If I use s2disk as normal, I see "snapshotting system", then before it
>>>> gets to write out the image, it aborts and switches back to X.   I can't
>>>> see any error message, even if I check the log with "dmesg".
>>>>
>>>> If I use "echo disk > /sys/power/state", echo reports the error "Cannot
>>>> allocate memory".
>>>>
>>>> This only happens if I've logged in to X first.  In fact, I narrowed it
>>>> down to gnome-power-manager.  If I kill gnome-power-manager beforehand,
>>>> then it doesn't happen.
>>>>         
>>> Anything interesting in dmesg?
>>>       
>> Nothing obvious. I've attached my latest at
>> <http://bugzilla.kernel.org/show_bug.cgi?id=13058>.
>>     
>
> Ok, next theory was that some module stuff is responsible (IIRC, from
> the lists). Can you try with everything-built-in (no modules) kernel?
> 									Pavel
>   

It's still present in v2.6.30-rc1-136-g62b8e68, which includes "module:
try_then_request_module must wait".

I don't think it's due to a missing module, because it doesn't happen if
I run "s2disk" from a console without logging in to KDE. I've put some
more details in Bugzilla about how it is reproduced (and what makes it
go away), it's a bit confusing.

But so long as I get the conditions right, it reproduces 100%. I'm going
to just try bisecting it - unless anyone has any more suggestions.

Thanks
Alan
