From: david@lang.hm
Subject: Re: Hibernation considerations
Date: Tue, 17 Jul 2007 10:49:52 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0707171042300.2467@asgard.lang.hm>
References: <200707151433.34625.rjw@sisk.pl> <20070715125855.GA1737@gallifrey>
	<200707160038.12943.rjw@sisk.pl>
	<Pine.LNX.4.64.0707151526080.25614@asgard.lang.hm>
	<20070717174044.GA11212@gallifrey>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070717174044.GA11212@gallifrey>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Dr. David Alan Gilbert" <linux@treblig.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Tue, 17 Jul 2007, Dr. David Alan Gilbert wrote:

> * david@lang.hm (david@lang.hm) wrote:
>> On Mon, 16 Jul 2007, Rafael J. Wysocki wrote:
>
>>> Encryption is possible with both the userland hibernation (aka uswsusp) and
>>> TuxOnIce (formerly known as suspend2).  Still, I don't consider it as a
>>> "must
>>> have" feature for a framework to be generally useful (many users don't use
>>> it
>>> anyway).
>>
>> he's talking about the main system useing an encrypted device/partition,
>> not the hibernate image being stored encrypted.
>>
>> This would require the main system 'forget' the keys when it does the
>> hinbernate and prompt for it again during the wake-up phase.
>
> Indeed - although as I say I really don't know what you would do with
> apps using the mounts at that point.   Still it seems like a
> sensible requrest from the security side.

along the same lines, it would probably be a good idea to have the ability 
for a system to re-ask for the pass phrase periodicly while the system is 
running.

I see two possible approaches to these issues.

1. implement the periodic re-request capability, and when going into 
hibernate time-out any known pass phrases.

this is a lot of work overall, but the suspend portion is trivial so there 
would not be any suspend surprises.

2. flush the keyring on hibernate and have the resume process re-populate 
it (either by pokeing directly into the memory, or by providing a table 
that the resuming kernel reads from during wake-up to re-populate it)

this is less work, but it's all suspend related so it will get less 
testing.

David Lang
