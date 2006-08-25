From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Sat, 26 Aug 2006 00:03:20 +0200
Message-ID: <20060825220320.GH9568@elf.ucw.cz>
References: <20060825212712.GG9568@elf.ucw.cz>
	<Pine.LNX.4.44L0.0608251742220.9240-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0608251742220.9240-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > Are there some patches to test? I'd like to power down USB bus, even
> > when it has device connected (I do not user fingerprint scanner that
> > much).
> =

> There are some old patches.  I could update them to the current -mm kerne=
l =

> and post them next week.

Yes, that would be great.

> The idea of the patches is that they will autosuspend a USB hub when it
> has no active (i.e., unsuspended) children, and autosuspending a root hub
> stops the USB controller from doing DMA.  However, non-hub devices are not
> yet automatically suspended, so you will have to suspend the fingerprint
> scanner by hand.

That is okay, I can do that. It saves 2 hours of battery life on my
machine...
									Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
