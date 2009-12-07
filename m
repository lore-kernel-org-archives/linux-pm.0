From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Sun, 6 Dec 2009 22:32:37 -0800
Message-ID: <20091207063236.GF21451__15168.2879812599$1260167620$gmane$org@core.coreip.homeip.net>
References: <alpine.LFD.2.00.0912051758190.3560@localhost.localdomain>
	<20091206113555.5a646713@infradead.org>
	<alpine.LFD.2.00.0912061144100.3560@localhost.localdomain>
	<20091206121803.70385c33@infradead.org>
	<7AB497C7-8495-4535-9E83-81307E008BF4@gmail.com>
	<20091206171856.394ce6d8@infradead.org>
	<20091207022706.GA20770@core.coreip.homeip.net>
	<20091206213112.568c602b@infradead.org>
	<20091207061548.GB21451@core.coreip.homeip.net>
	<20091206223112.77433d13@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091206223112.77433d13@infradead.org>
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

On Sun, Dec 06, 2009 at 10:31:12PM -0800, Arjan van de Ven wrote:
> On Sun, 6 Dec 2009 22:15:49 -0800
> Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> 
> > And the bad thing is that violates multiple layers in the kernel.
> > Atkbd driver does not have to be using i8042; neither does psmouse.
> > Althtough they do in 99% of the cases there are other controllers
> > providing the i8042-style ports. Just grep for SERIO_8042 in
> > drivers/input/serio.
> > 
> > I do not want to hard-code the i8042-psmouse-atkbd dependency.
> 
> it's not a specific dependency.
> 
> it's a "I know I'm critical, so everything before me needs to be done".
> 
> that doesn't encode an actual relationship, it encodes a potential
> relationship... with a worst case behavior of ... what we do right
> now ;_)

This is the case with every parent device, isn't it? It is important for
its children. And wasn't Rafael patchset trying to address exactkly
this?

-- 
Dmitry
