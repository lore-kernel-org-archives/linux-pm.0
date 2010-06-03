From: mark gross <640e9920@gmail.com>
Subject: Re: [PATCH] - race-free suspend. Was: Re: [PATCH 0/8]
 Suspend block api (version 8)
Date: Thu, 3 Jun 2010 06:36:46 -0700
Message-ID: <20100603133646.GF15595__3102.99280467934$1275572248$gmane$org@gvim.org>
References: <20100601113309.609349fd@notabene.brown>
	<alpine.LFD.2.00.1006010340160.2933@localhost.localdomain>
	<20100601122012.1edeaf48@notabene.brown>
	<alpine.LFD.2.00.1006011243350.2933@localhost.localdomain>
	<20100602153235.340a7852@notabene.brown>
	<AANLkTikVjAf5nHdMx2bcHRAUSkq99s-b5YZCECXIJJLy@mail.gmail.com>
	<20100602180614.729246ea@notabene.brown>
	<AANLkTikXy__71nBNW0EFbyL_qNf0nQ68pW9KymWlTk7L@mail.gmail.com>
	<20100603060444.GF11311@gvim.org>
	<AANLkTilml9GM2GmJhlB39oqDk6oPnLSSfiQAinpCpAbt@mail.gmail.com>
Reply-To: markgross@thegnar.org
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <AANLkTilml9GM2GmJhlB39oqDk6oPnLSSfiQAinpCpAbt@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Brian Swetland <swetland@google.com>
Cc: Florian Mickler <florian@mickler.org>, Neil Brown <neilb@suse.de>, markgross@thegnar.org, "Paul@smtp1.linux-foundation.org" <Paul@smtp1.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, James Bottomley <James.Bottomley@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Linux PM <linux-pm@lists.linux-foundation.org>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, Thomas Gleixner <tglx@linutronix.de>, Felipe Balbi <felipe.balbi@nokia.com>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 02, 2010 at 11:12:39PM -0700, Brian Swetland wrote:
> On Wed, Jun 2, 2010 at 11:04 PM, mark gross <640e9920@gmail.com> wrote:
> >>
> >> There are many wakeup events possible in a typical system --
> >> keypresses or other input events, network traffic, telephony events,
> >> media events (fill audio buffer, fill video decoder buffer, etc), and
> >> I think requiring that all wakeup event processing bottleneck through
> >> a single userspace process is non-optimal here.
> >
> > Um doesn't the android framework bottleneck the user mode lock
> > processing through the powermanager and any wake up event processing
> > eventually has to grab a lock through this bottleneck anyway?
> 
> For "high level" framework/application level wakelocks, yes, but lower
> level components beneath the java api layer use the kernel interface
> directly.
>
Oh.  I thought everything went through
hardware/libhardware_legacy/power/power.c 
who else is hitting /sys/power/* in the android user mode then? 

I'll have to go hunting for them I guess.

--mgross
 
