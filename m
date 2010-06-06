From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: suspend blockers & Android integration
Date: Sun, 6 Jun 2010 18:31:46 +0100
Message-ID: <20100606173146.GA13432__32408.2792307765$1275845590$gmane$org@srcf.ucam.org>
References: <AANLkTil1NCX91bWhpXHtC88Opr29mNjdhXD9RXQ6DI0y@mail.gmail.com>
	<AANLkTin1Za3GvfIKbcZdx6TzjIHzCvsg5uaY_Vk4nJIh@mail.gmail.com>
	<AANLkTilQ1k78dDCYadOa1Wiyjm2nsBcRpxwdpGvYcf8z@mail.gmail.com>
	<AANLkTin7oM3gVwHbIHWqYV8yeC6bbQ4q2jDDxAgz3DwQ@mail.gmail.com>
	<20100606133130.GA8513@srcf.ucam.org>
	<AANLkTimXTgZS_fZQa8hjIptJrCn756gF_xakT1IQiLWa@mail.gmail.com>
	<20100606152946.GA11351@srcf.ucam.org>
	<AANLkTilOq_5yUW1AIMH1qSE699gyRUTlzGPUVc4CrReY@mail.gmail.com>
	<20100606164326.GA12570@srcf.ucam.org>
	<AANLkTim0JD4V0RTc6CRIADypqYhQo3JYp3dJs0l7g7Ps@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTim0JD4V0RTc6CRIADypqYhQo3JYp3dJs0l7g7Ps@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Vitaly Wool <vitalywool@gmail.com>
Cc: Neil Brown <neilb@suse.de>, tytso@mit.edu, Peter Zijlstra <peterz@infradead.org>, Brian Swetland <swetland@google.com>, Felipe Balbi <felipe.balbi@nokia.com>, LKML <linux-kernel@vger.kernel.org>, Florian Mickler <florian@mickler.org>, James Bottomley <James.Bottomley@suse.de>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Jun 06, 2010 at 07:21:49PM +0200, Vitaly Wool wrote:
> 2010/6/6 Matthew Garrett <mjg59@srcf.ucam.org>:
> 
> > Suspend blocks prevent system suspend, not any per-device suspend.
> 
> Can you suspend a device which is holding a wake lock?

Yes. Suspend blocks are orthogonal to runtime PM.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
