From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: suspend blockers & Android integration
Date: Mon, 7 Jun 2010 17:57:19 -0700
Message-ID: <AANLkTimf_nVcOZGi0x6nDtaO-FMVSLPrxDtOzQwKTB5P__21887.8908934586$1275958775$gmane$org@mail.gmail.com>
References: <20100606152946.GA11351@srcf.ucam.org>
	<Pine.LNX.4.44L0.1006061956510.4894-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1006061956510.4894-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: tytso@mit.edu, Neil Brown <neilb@suse.de>, Brian Swetland <swetland@google.com>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Ingo Molnar <mingo@elte.hu>, "H. Peter Anvin" <hpa@zytor.com>, Florian Mickler <florian@mickler.org>, Felipe Balbi <felipe.balbi@nokia.com>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Jun 6, 2010 at 5:01 PM, Alan Stern <stern@rowland.harvard.edu> wrot=
e:
> On Sun, 6 Jun 2010, Matthew Garrett wrote:
>
>> The difference between idle-based suspend and opportunistic suspend is
>> that the former will continue to wake up for timers and will never be
>> entered if something is using CPU, whereas the latter will be entered
>> whenever no suspend blocks are held. The problem with opportunistic
>> suspend is that you might make the decision to suspend simultaneusly
>> with a wakeup event being received. Suspend blocks facilitate
>> synchronisation between the kernel and userspace to ensure that all such
>> events have been consumed and handld appropriately.
>
> Remember that suspend takes place in several phases, the first of which
> is to freeze tasks. =A0The phases can be controlled individually by the
> process carrying out a suspend, and there's nothing to prevent you from
> stopping after the freezer phase. =A0Devices won't get powered down, but
> Android uses aggressive runtime power management for its devices
> anyway.
>
> If you do this then the synchronization can be carried out entirely
> from userspace, with no need for kernel modifications such as suspend
> blockers. And since Android can reach essentially the same low-power
> state from idle as from suspend, it appears that they really don't need
> any kernel changes at all.
>

I don't think this is true. If you stop after the freezer phase you
still need all the suspend blockers that are held until user-space
consumes an event, otherwise it never gets consumed since user-space
is frozen.

-- =

Arve Hj=F8nnev=E5g
