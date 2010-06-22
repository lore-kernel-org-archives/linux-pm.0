From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH] PM: Avoid losing wakeup events during
	suspend
Date: Tue, 22 Jun 2010 11:29:42 +0200
Message-ID: <201006221129.43216.rjw@sisk.pl>
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
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tuesday, June 22, 2010, mark gross wrote:
> On Mon, Jun 21, 2010 at 11:57:21AM -0400, Alan Stern wrote:
> > On Sun, 20 Jun 2010, mark gross wrote:
... 
> > I don't know -- I have never looked at the Android userspace.  No doubt 
> > Arve can provide some examples.
> who are you?  You don't know about the Android stack, and you keep
> blowing about how suspend blockers solve all the PM problems?  I'm
> starting to think your just trolling. 

And that's just an excellent way of convincing people that you're right.  Guess
how it worked on me.

For your information, Alan is one of the people most actively engaged in
power management development at the kernel level and his ideas have heavily
influenced the design of the I/O runtime PM framework, among other things.

I certainly appeciate Alan's opinions very much, because he usually is
technically right.

Thanks,
Rafael
