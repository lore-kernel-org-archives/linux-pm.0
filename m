From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC][PATCH] PM: Avoid losing wakeup events during
	suspend
Date: Mon, 21 Jun 2010 15:01:32 +0100
Message-ID: <20100621150132.24edb934@lxorguk.ukuu.org.uk>
References: <201006202350.27143.rjw@sisk.pl>
	<Pine.LNX.4.44L0.1006202154260.29532-100000@netrider.rowland.org>
	<20100621061345.GF9735@gvim.org> <20100621121058.GF6199@thunk.org>
	<20100621132234.5eb880b0@lxorguk.ukuu.org.uk>
	<20100621134249.GG6199@thunk.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100621134249.GG6199@thunk.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: tytso@mit.edu
Cc: mark gross <640e9920@gmail.com>, markgross@thegnar.org, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon, 21 Jun 2010 09:42:49 -0400
tytso@mit.edu wrote:

> On Mon, Jun 21, 2010 at 01:22:34PM +0100, Alan Cox wrote:
> > 
> > You seem desperate to just throw it at Linus - you have been all along
> > before the discussion, during it and now: but I don't understand why ?
> 
> Why are you so afraid to let Linus make the call?  He's the benevolent
> dictator, isn't he?

I don't mind him laughing at it. I'm just curious why you've tried to
short circuit the more general discussion repeatedly - even right at the
start.

> It doesn't look like progress is being made here.

On suspend blockers no - on some of the real problems yes.
