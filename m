From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] x86 APM: delete Linux kernel APM support
Date: Fri, 08 Apr 2011 13:55:12 -0700
Message-ID: <4D9F7630.1090503__3549.02041513032$1302296202$gmane$org@zytor.com>
References: <alpine.LFD.2.02.1103232321070.3848@x980>
	<alpine.LFD.2.02.1103241929450.16085@x980>
	<20110325113048.GC29521@elte.hu>
	<201103252333.23880.rjw@sisk.pl> <20110408062506.GB1596@ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110408062506.GB1596@ucw.cz>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 04/07/2011 11:25 PM, Pavel Machek wrote:
>>
>> Well, it kind of does but not really. :-)
>>
>> The main problem with APM is that nobody really works on it and I'm not sure
>> if there are any active users.  At least no one reports any problems with it,
>> which is kind of surprising, given the number of chages we've made in the PM
>> core for the last couple of years.  So quite likely it's just become
>> non-functional over time anyway, but we have no confirmation.
> 
> It was working ok last time I tried -- cca 6/2010.
> 								Pavel

What aspects of it did you test, and on what platform?

	-hpa
