From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Subject: Re: [PATCH] cpuidle: avoid singing capacitors
Date: Tue, 4 Mar 2008 11:01:28 -0800
Message-ID: <924EFEDD5F540B4284297C4DC59F3DEEA77031__45505.8973668658$1204658040$gmane$org@orsmsx423.amr.corp.intel.com>
References: <924EFEDD5F540B4284297C4DC59F3DEEA2E8B2@orsmsx423.amr.corp.intel.com><Pine.LNX.4.44L0.0803031804330.8280-100000@iolanthe.rowland.org><20080303231033.GB15255@one.firstfloor.org><20080304040048.GA31562@codemonkey.org.uk><20080304071423.0e6b71c1@mjolnir.drzeus.cx>
	<20080304181924.70aaf8c1@mjolnir.drzeus.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-class: urn:content-classes:message
In-Reply-To: <20080304181924.70aaf8c1@mjolnir.drzeus.cx>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pierre Ossman <drzeus-list@drzeus.cx>
Cc: LKML <linux-kernel@vger.kernel.org>, Adam Belay <abelay@novell.com>, Andi Kleen <andi@firstfloor.org>, Lee Revell <rlrevell@joe-job.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

 

>-----Original Message-----
>From: Pierre Ossman [mailto:drzeus-list@drzeus.cx] 
>Sent: Tuesday, March 04, 2008 9:19 AM
>To: Pallipadi, Venkatesh
>Cc: Dave Jones; Andi Kleen; Alan Stern; LKML; Adam Belay; Lee 
>Revell; linux-pm@lists.linux-foundation.org; Pavel Machek
>Subject: Re: [linux-pm] [PATCH] cpuidle: avoid singing capacitors
>
>On Tue, 4 Mar 2008 07:14:23 +0100
>Pierre Ossman <drzeus-list@drzeus.cx> wrote:
>
>> 
>> Many devices today are of a less than stellar quality, and singing
>> capacitors are a common problem. A high-pitch noise is 
>created, caused
>> by power fluctuations as the processor enters and leaves 
>deep sleep at
>> a high frequency.
>> 
>> Instead of just disabling the deep sleep (which wastes power), this
>> patch allows you to reduces the number of times it is entered so that
>> the frequency can be kept inaudible.
>> 
>> Signed-off-by: Pierre Ossman <drzeus@drzeus.cx>
>> --
>
>Hold off on this. It turns out it still has major problems. 
>The menu algorithm now and then gets really bad at predicting 
>sleep times, completely killing this avoidance scheme.
>
>(On that subject, does anyone except Adam understand that 
>algorithm? Some comments wouldn't hurt...)

Prediction is based on cumulative time till "non expected wakeup". So,
prediction will come into play only when there are very short wakeups
due to "unexpected wakeups".

>So for now, I'm back to thinking that measuring the interval 
>between deep sleeps is the better approach. I could use some 
>ideas for a good clock source though. I haven't dug much 
>deeper than jiffies when it comes to kernel timekeeping.

I think best solution is to use get_last_residency that is already
there. If the last residency or expected_us is very low, you can avoid
deep idle states. That way you don't have to depend on jiffies being
updated at the time you are checking it.

Thanks,
Venki
