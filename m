From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [GIT PULL] PM updates for 2.6.33
Date: Mon, 7 Dec 2009 16:17:51 +0100
Message-ID: <200912071617.51262.rjw__41850.2402179458$1260199208$gmane$org@sisk.pl>
References: <alpine.LFD.2.00.0912051758190.3560@localhost.localdomain>
	<20091206223112.77433d13@infradead.org>
	<20091207063236.GF21451@core.coreip.homeip.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091207063236.GF21451@core.coreip.homeip.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Monday 07 December 2009, Dmitry Torokhov wrote:
> On Sun, Dec 06, 2009 at 10:31:12PM -0800, Arjan van de Ven wrote:
> > On Sun, 6 Dec 2009 22:15:49 -0800
> > Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:
> > 
> > > And the bad thing is that violates multiple layers in the kernel.
> > > Atkbd driver does not have to be using i8042; neither does psmouse.
> > > Althtough they do in 99% of the cases there are other controllers
> > > providing the i8042-style ports. Just grep for SERIO_8042 in
> > > drivers/input/serio.
> > > 
> > > I do not want to hard-code the i8042-psmouse-atkbd dependency.
> > 
> > it's not a specific dependency.
> > 
> > it's a "I know I'm critical, so everything before me needs to be done".
> > 
> > that doesn't encode an actual relationship, it encodes a potential
> > relationship... with a worst case behavior of ... what we do right
> > now ;_)
> 
> This is the case with every parent device, isn't it? It is important for
> its children. And wasn't Rafael patchset trying to address exactkly
> this?

Yes, it was.

Thanks,
Rafael
