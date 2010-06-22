From: Florian Mickler <florian@mickler.org>
Subject: Re: [RFC][PATCH] PM: Avoid losing wakeup events during
	suspend
Date: Tue, 22 Jun 2010 08:18:03 +0200
Message-ID: <20100622081803.4d472542__13006.0775009499$1277187674$gmane$org@schatten.dmk.lab>
References: <20100621055522.GE9735@gvim.org>
	<Pine.LNX.4.44L0.1006211125470.1687-100000@iolanthe.rowland.org>
	<20100622015837.GC12795@gvim.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100622015837.GC12795@gvim.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: markgross@thegnar.org
Cc: 640e9920@gmail.com, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Matthew@smtp1.linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Mon, 21 Jun 2010 18:58:37 -0700
mark gross <640e9920@gmail.com> wrote:


> wrong.  They are about 1) adding opportunistic suspend, and 2) adding
> critical sections to block suspend.  
> 
> No race issues where ever talked about until alternative solutions
> where put up.

The whole and only reason to even define the term "critical sections" is
when you need to define "a race". Or vice versa. A race is prevented by
defining critical sections and protecting these against concurrent
access.

[..snip..]

[some rant that alan is not familiar with android userspace..]

Are you suggesting that only android developers are supposed to talk
about this? 

This is a pretty basic thing. It has only to do with system suspend.
(And using system suspend aggressively)

> 
> --mgross
> 

Cheers,
Flo
