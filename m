From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [2.6.30-rc1-git2 regressions] Hibernation broken and
 (minor but annoying) audio problem
Date: Fri, 10 Apr 2009 18:53:59 -0700
Message-ID: <49DFF837.9080009__41054.1826663122$1239415051$gmane$org@linux.intel.com>
References: <200904100057.43827.rjw@sisk.pl>
	<alpine.LFD.2.00.0904091605080.4583@localhost.localdomain>
	<200904101439.43480.rjw@sisk.pl> <200904102058.36018.rjw@sisk.pl>
	<alpine.LFD.2.00.0904101204350.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0904101204350.4583@localhost.localdomain>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Linus Torvalds wrote:
> 
> On Fri, 10 Apr 2009, Rafael J. Wysocki wrote:
>> I've just verified that the resume-after-hibernation issue goes away after
>> reverting commit 9710794383ee5008d67f1a6613a4717bf6de47bc
>> (async: remove the temporary (2.6.29) "async is off by default" code) , so it
>> is async-related.
> 
> Arjan? Clearly all the necessary fixes weren't found..
> 
> There _is_ a module loading problem wrt initmem - I think you found that 
> and we added a hack for it for the ACPI battery driver. I wonder if we're 
> hitting a similar issue now with module discovery: modules that use 
> "async_schedule()" to do their discovery asynchronously are now not 
> necessarily fully "done" when the module is loaded. 

this is both a "yes and no" kind of thing. It already happened for many cases
(USB, SCSI (and thus libata) etc) but now it can happen for more new cases.


> And so, anything that expected the devices to be available after module 
> load (like they used to) would be screwed.
> 
> IOW, maybe something like the totally untested patch appended here (that 
> should also allow us to make the ACPI battery code to go back to using 
> __init).
> 

this will work. It's a tad unfortunate that we basically end up synchronizing
at load time; maybe some time in the future we can make this opt-in/out ;-(
