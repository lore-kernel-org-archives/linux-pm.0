From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Mon, 2 Apr 2007 10:09:09 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.0704021007440.6730@woody.linux-foundation.org>
References: <Pine.LNX.4.44L0.0704021000450.1743-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.0704021000450.1743-100000@netrider.rowland.org>
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
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, Ingo Molnar <mingo@elte.hu>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Thomas Gleixner <tglx@linutronix.de>, Kernel development list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org



On Mon, 2 Apr 2007, Alan Stern wrote:
> =

> Would you mind retracting this patch?  It will interfere with some work
> I've been doing in USB, work that relies on exactly the sort of multiple =

> power dependency you mention.

I agree. We should just make the damn timers be added at the right point. =

We can for example *add* the devices early, even if we then actually start =

using them at some later date.

			Linus
