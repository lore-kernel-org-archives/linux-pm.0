From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [PATCH 1/3] PCI: Rework default handling of suspend
 and resume
Date: Sat, 6 Dec 2008 15:25:45 -0800
Message-ID: <20081206152545.326c8b67__49711.3237659962$1228606151$gmane$org@infradead.org>
References: <Pine.LNX.4.44L0.0812061324260.13426-100000@netrider.rowland.org>
	<200812062236.44111.rjw@sisk.pl>
	<alpine.LFD.2.00.0812061420190.3425@nehalem.linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.00.0812061420190.3425@nehalem.linux-foundation.org>
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
Cc: Andrew Morton <akpm@linux-foundation.org>, Takashi Iwai <tiwai@suse.de>, Greg KH <greg@kroah.com>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, pm list <linux-pm@lists.linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Sat, 6 Dec 2008 14:24:55 -0800 (PST)
Linus Torvalds <torvalds@linux-foundation.org> wrote:

> 
> 
> On Sat, 6 Dec 2008, Rafael J. Wysocki wrote:
> > 
> > However, I'm not quite sure about the freeing and requesting IRQs
> > during suspend and resume.  Many drivers do that, many others
> > don't.  Still, apparently some drivers don't work correctly after
> > resume if this is not done. So, if that should generally be done, I
> > also think that moving it to the core might be a good idea.
> 
> I'd suggest against it.
> 
> A lot of drivers that want to disable (or unregister) interrupts
> almost certainly want to do it simply because they are not ready and
> willing to handle any interrupts after having run their "suspend()"
> function. 

the problem is that the system bios can have reassigned interrupts
after resume, and afaik we need to re-evaluate the ACPI methods to
get the new mapping.
So we need to unregister + re-register to make that happen
