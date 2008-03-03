From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Mon, 3 Mar 2008 13:14:28 -0800
Message-ID: <924EFEDD5F540B4284297C4DC59F3DEEA2E81B__33128.2823266976$1204579262$gmane$org@orsmsx423.amr.corp.intel.com>
References: <20080229193812.31f45b0c@mjolnir.drzeus.cx>
	<20080303211842.6f492782@mjolnir.drzeus.cx>
	<20080303204603.GA19775@elf.ucw.cz>
	<20080303220310.0cab7213@mjolnir.drzeus.cx>
	<20080303210839.GJ13869@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080303210839.GJ13869@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>, Pierre Ossman <drzeus-list@drzeus.cx>
Cc: Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, linux-pm@lists.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

 

>-----Original Message-----
>From: Pavel Machek [mailto:pavel@ucw.cz] 
>Sent: Monday, March 03, 2008 1:09 PM
>To: Pierre Ossman
>Cc: Pallipadi, Venkatesh; Adam Belay; 
>linux-pm@lists.linux-foundation.org; LKML; Andi Kleen; Lee Revell
>Subject: Re: [PATCH] cpuidle: avoid singing capacitors
>
>On Mon 2008-03-03 22:03:10, Pierre Ossman wrote:
>> On Mon, 3 Mar 2008 21:46:03 +0100
>> Pavel Machek <pavel@ucw.cz> wrote:
>> 
>> > >  
>> > > +static unsigned int min_deep_sleep = 2000;
>> > > +
>> > 
>> > Well, why not, but I believe we should default to old 
>behaviour... not
>> > all machines are cheaply-build.
>> 
>> One would hope. ;)
>> 
>> But the problem is that most people will not be able to find this
>> option (or even know such an option exists). I'd guess the 
>distros will
>> just end up having this on by default anyway. And since I could not
>> measure any extra power drain, I believe it's hard to 
>justify having it
>> off by default (more than by pure principle).
>
>So just leave it off by default, and let distros break their own
>kernels ;-).
>								

I prefer leaving it off my default and enabling it on faulty hardware by
some blacklist.

Thanks,
Venki
