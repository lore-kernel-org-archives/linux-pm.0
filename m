From: Pavel Machek <pavel@suse.cz>
Subject: Re: [rft]autosuspend for btusb
Date: Tue, 26 Aug 2008 12:05:19 +0200
Message-ID: <20080826100519.GA1599__26806.3731877648$1219745461$gmane$org@elf.ucw.cz>
References: <200808221520.19791.oliver@neukum.org>
	<200808221551.57225.oliver@neukum.org>
	<1219415470.7591.472.camel@violet.holtmann.net>
	<200808251243.47569.oliver@neukum.org>
	<20080826095647.GA30913@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20080826095647.GA30913@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>, linux-usb@vger.kernel.org, Stefan Seyfried <seife@suse.de>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue 2008-08-26 11:56:47, Pavel Machek wrote:
> On Mon 2008-08-25 12:43:46, Oliver Neukum wrote:
> > Am Freitag 22 August 2008 16:31:10 schrieb Marcel Holtmann:
> > > > > Please explain the tx_in_flight stuff to me. It looks unneeded since we
> > > > > anchor all TX URBs anyway.
> > > > 
> > > > The completion of an URB may happen after the autosuspend timeout passed.
> > > > But we cannot use the pm counters as they are not accessible in interrupt.
> > > > Hence we must maintain a counter ourselves.
> > > 
> > > Can we not just check the number of URBs in the anchor? I am against
> > > just duplicating a counter, but then lets call it it what it is to make
> > > it gets not misused. It is a purely a PM counter.
> > > 
> > 
> > An excellent suggestion allowing major simplifications. This version works
> > for me. It required an extension of the anchor API, so it obsoletes
> > the split-up you've done. Therefore the whole thing comes as a big patch
> > against rc4, easy to test.
> 
> I could not get it to apply over -rc4-git, usb seems to be changing
> under us :-(. After manual fixup (conflict was in comment), I still
> get
> 
>   LD      .tmp_vmlinux1
> drivers/built-in.o: In function `btusb_suspend':
> btusb.c:(.text+0x20a578): undefined reference to `usb_anchor_empty'
> drivers/built-in.o: In function `btusb_resume':
> btusb.c:(.text+0x20ade6): undefined reference to `usb_get_from_anchor'
> btusb.c:(.text+0x20ae01): undefined reference to
> `usb_scuttle_anchored_urbs'
> make: *** [.tmp_vmlinux1] Error 1
> 40.09user 7.55system 47.97 (0m47.971s) elapsed 99.34%CPU
> pavel@amd:/data/l/linux-good$
> 
> ...probably the "already applied" patch it complained about was not so
> applied after all.
> 
> ...ok, I got it to apply, compile, resulting patch is attached.


And it worked for me, but suspend died. I'll verify if that's a
problem in vanilla -rc4-git, too.
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
