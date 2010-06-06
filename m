From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 21:01:52 +0200
Message-ID: <201006062101.52752.rjw__16073.1980730363$1275850977$gmane$org@sisk.pl>
References: <AANLkTil1NCX91bWhpXHtC88Opr29mNjdhXD9RXQ6DI0y@mail.gmail.com>
	<AANLkTim0JD4V0RTc6CRIADypqYhQo3JYp3dJs0l7g7Ps@mail.gmail.com>
	<20100606173146.GA13432@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100606173146.GA13432@srcf.ucam.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthew Garrett <mjg59@srcf.ucam.org>
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sunday 06 June 2010, Matthew Garrett wrote:
> On Sun, Jun 06, 2010 at 07:21:49PM +0200, Vitaly Wool wrote:
> > 2010/6/6 Matthew Garrett <mjg59@srcf.ucam.org>:
> > 
> > > Suspend blocks prevent system suspend, not any per-device suspend.
> > 
> > Can you suspend a device which is holding a wake lock?
> 
> Yes. Suspend blocks are orthogonal to runtime PM.

Yes, they are.

The idea that they would somehow interfere with runtime PM has always been pure
nonsense.  They wouldn't and there's no way in which they could.

Whether or not they are really necessary to address the Android requirements is
a different question, though, and I don't really think so right now.  At least
not in the form submitted by Arve.

Also, there's some overlap between suspend blockers and the PM QoS framework,
so it seems to be a good idea to extend PM QoS (which already is in the kernel)
to express some requirements that suspend blockers are supposed to express.

Rafael
