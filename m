From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 1/3] PCI: Rework default handling of suspend
 and resume
Date: Sun, 7 Dec 2008 09:18:41 -0800
Message-ID: <20081207091841.1d460c1a__14583.4336792634$1228670387$gmane$org@infradead.org>
References: <Pine.LNX.4.44L0.0812061324260.13426-100000@netrider.rowland.org>
	<alpine.LFD.2.00.0812062157590.3425@nehalem.linux-foundation.org>
	<alpine.LFD.2.00.0812062201230.3425@nehalem.linux-foundation.org>
	<200812071439.27712.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200812071439.27712.rjw@sisk.pl>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sun, 7 Dec 2008 14:39:27 +0100
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Sunday, 7 of December 2008, Linus Torvalds wrote:
> > 
> > On Sat, 6 Dec 2008, Linus Torvalds wrote:
> > > 
> > > And btw, I'm talking suspend, not hibernate. 
> 
> Even as far as hibernation is concerned, I wouldn't _expect_ any BIOS
> to do anything like this as long as we use the ACPI facility to enter
> S4.

there are funky scenarios where the BIOS ends up .. not knowing.
Like

you boot your laptop
you then hot-dock your laptop
then you suspend (say S4)

..
during resume, the bios sees a very different system than it saw before.
I can totally imagine not all of them getting it right, esp if other
OSes would just re-register interrupts
