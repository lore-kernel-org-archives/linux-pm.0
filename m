From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH] apm: orphan the driver
Date: Mon, 28 Mar 2011 10:57:31 -0700
Message-ID: <4D90CC0B.8070105__19078.7860462025$1301336339$gmane$org@zytor.com>
References: <20110326172204.05e52c10.sfr@canb.auug.org.au>
	<alpine.LRH.2.00.1103281443240.8162@twin.jikos.cz>
	<20110329004438.d9e755ef.sfr@canb.auug.org.au>
	<alpine.LNX.2.00.1103281604040.26754@pobox.suse.cz>
	<20110328174542.GW21838@one.firstfloor.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20110328174542.GW21838@one.firstfloor.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andi Kleen <andi@firstfloor.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Ingo Molnar <mingo@elte.hu>, Jiri Kosina <jkosina@suse.cz>, x86@kernel.org, LKML <linux-kernel@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Henrique de Moraes Holschuh <hmh@hmh.eng.br>, Ondrej Zary <linux@rainbow-software.org>, Andrew Morton <akpm@linux-foundation.org>, Linus <torvalds@linux-foundation.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On 03/28/2011 10:45 AM, Andi Kleen wrote:
> On Mon, Mar 28, 2011 at 04:05:14PM +0200, Jiri Kosina wrote:
>> On Tue, 29 Mar 2011, Stephen Rothwell wrote:
>>
>>>> I still have some hardware that uses APM and put a new 2.6 on it time 
>>>> to time, so I can take this driver over if you want to. According to 
>>>> git log it's really low effort anyway :)
>>>
>>> If you want it, its yours :-)
>>
>> Not really fighting for maintaining it actively, but can certainly give it 
>> some care when necessary.
> 
> FWIW
> Since Len plans some larger changes to the idle code 
> (moving everything to cpuidle) active care may be needed soon.
> 
> Effectively it would need a APM cpuidle driver.
> 
> Just that you know what you're signing up for...
> 

Or we phase out the APM effort by only supporting it for poweroff, for
example.

	-hpa
