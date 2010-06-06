From: david@lang.hm
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 01:23:57 -0700 (PDT)
Message-ID: <alpine.DEB.2.01.1006060121180.17462__37036.0038163655$1275812712$gmane$org@asgard.lang.hm>
References: <20100603193045.GA7188@elte.hu> <20100603231153.GA11302@elte.hu>
	<20100603232302.GA16184@elte.hu>
	<alpine.LFD.2.00.1006031630300.8175@i5.linux-foundation.org>
	<20100603234634.GA21831@elte.hu>
	<alpine.LFD.2.00.1006031856420.8175@i5.linux-foundation.org>
	<alpine.LFD.2.00.1006031917500.8175@i5.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.1006031917500.8175@i5.linux-foundation.org>
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
Cc: tytso@mit.edu, Peter Zijlstra <a.p.zijlstra@chello.nl>, Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, "H. Peter Anvin" <hpa@zytor.com>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 3 Jun 2010, Linus Torvalds wrote:

> On Thu, 3 Jun 2010, Linus Torvalds wrote:
>>
>> so I'd like to see the opportunistc suspend thing think about CPU
>> offlining
>
> Side note: one reason for me being somewhat interested in the CPU
> offlining is that I think the Android kind of opportunistic suspend is
> _not_ likely something I'd like to see on a desktop. But an the
> "opportunistic CPU offliner"? That might _well_ be useful even outside of
> any other suspend activity.

When the OLPC was first released there was talk that the hardware was well 
designed for sleeping (including the ability for the display to keep going 
even if the system itself shut down), with the idealistic talk of the 
system possibly sleeping between keystrokes.

things didn't end up working (a couple pieces of hardware ended up not 
playing well with others), but the concept is still something that could 
end up impacting users outside of the mobile phone market, even if not on 
your traditional desktop.

David Lang
