From: mark gross <640e9920@gmail.com>
Subject: Re: [RFC][PATCH] PM: Avoid losing wakeup events during
	suspend
Date: Tue, 22 Jun 2010 16:22:38 -0700
Message-ID: <20100622232238.GA15442__40395.1201042675$1277249083$gmane$org@gvim.org>
References: <20100621055522.GE9735@gvim.org>
	<Pine.LNX.4.44L0.1006211125470.1687-100000@iolanthe.rowland.org>
	<20100622015837.GC12795@gvim.org>
	<20100622081803.4d472542@schatten.dmk.lab>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100622081803.4d472542@schatten.dmk.lab>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Florian Mickler <florian@mickler.org>
Cc: 640e9920@gmail.com, markgross@thegnar.org, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Jun 22, 2010 at 08:18:03AM +0200, Florian Mickler wrote:
> On Mon, 21 Jun 2010 18:58:37 -0700
> mark gross <640e9920@gmail.com> wrote:
> 
> 
> > wrong.  They are about 1) adding opportunistic suspend, and 2) adding
> > critical sections to block suspend.  
> > 
> > No race issues where ever talked about until alternative solutions
> > where put up.
> 
> The whole and only reason to even define the term "critical sections" is
> when you need to define "a race". Or vice versa. A race is prevented by
> defining critical sections and protecting these against concurrent
> access.
> 
> [..snip..]
> 
> [some rant that alan is not familiar with android userspace..]
> 
> Are you suggesting that only android developers are supposed to talk
> about this? 

of course not.  I'm just getting frustrated with having android-isms
tossed in my face as we try to discuss the merits of the ideas, only to
find that the are getting tossed around by someone not familiar with
Android.

Sorry about that.  I was having a bad day.

--mgross




> 
> This is a pretty basic thing. It has only to do with system suspend.
> (And using system suspend aggressively)
> 
> > 
> > --mgross
> > 
> 
> Cheers,
> Flo
