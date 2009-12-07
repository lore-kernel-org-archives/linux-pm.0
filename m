From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 6 Dec 2009 18:27:56 -0800
Message-ID: <20091207022756.GB20770__32716.5557806895$1260152940$gmane$org@core.coreip.homeip.net>
References: <200912052216.19540.rjw@sisk.pl> <200912060055.36130.rjw@sisk.pl>
	<alpine.LFD.2.00.0912051635330.3560@localhost.localdomain>
	<200912060254.10081.rjw@sisk.pl>
	<alpine.LFD.2.00.0912051758190.3560@localhost.localdomain>
	<20091206113555.5a646713@infradead.org>
	<alpine.LFD.2.00.0912061144100.3560@localhost.localdomain>
	<20091206121803.70385c33@infradead.org>
	<7AB497C7-8495-4535-9E83-81307E008BF4@gmail.com>
	<20091206165551.2529075f@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091206165551.2529075f@infradead.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Arjan van de Ven <arjan@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 06, 2009 at 04:55:51PM -0800, Arjan van de Ven wrote:
> On Sun, 6 Dec 2009 14:54:48 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > > isn't serio the PS/2 stuff?
> > 
> > Yes, that's your PS/2 mouse (rather touchpad) and the delay comes
> > from device reset (needed by some keyboard controllers - I remember
> > HP -or it and keyboard will be dead at resume).
> 
> and I have a HP laptop... so this makes perfect sense.
> Thanks for the explenation!
> 

Well, we do it for everyone, it's just a particular series of HPs forced
us to add it.

> Now, the good news is that serio is near invisible on resume...
> 

Resume is fully offloaded to kseriod.

-- 
Dmitry
