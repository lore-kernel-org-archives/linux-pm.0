From: Arjan van de Ven <arjan@linux.intel.com>
Subject: Re: [2.6.30-rc1-git2 regressions] Hibernation broken and
 (minor but annoying) audio problem
Date: Fri, 10 Apr 2009 18:45:53 -0700
Message-ID: <49DFF651.5080909__12891.9928022244$1239414570$gmane$org@linux.intel.com>
References: <200904100057.43827.rjw@sisk.pl> <200904102058.36018.rjw@sisk.pl>
	<alpine.LFD.2.00.0904101204350.4583@localhost.localdomain>
	<200904110206.33525.rjw@suse.com>
	<alpine.LFD.2.00.0904101817100.4583@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0904101817100.4583@localhost.localdomain>
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
Cc: "Rafael J. Wysocki" <rjw@suse.com>, Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

Linus Torvalds wrote:
> 
> Hmm.
> 
> I'm not 100% sure that patch is good.
> 
> The reason? I think it's going to deadlock if an async caller ends up 
> wanting to load a module, because then the nestecd 
> "async_synchronize_full()" will basically want to wait for itself.
> 
> So it's a good test-patch, and maybe no async caller ever loads a module, 
> but it makes me a bit nervous.
> 
> But the fact that it fixes things for you at least means that the _reason_ 
> for the problem is know, and maybe there are alternative solutions. Arjan?

I just got back from the LF summit and am catching up on mail; I'll take a look
at the history.
