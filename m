From: Florian Mickler <florian@mickler.org>
Subject: Re: [PATCH 0/8] Suspend block api (version 8)
Date: Sat, 5 Jun 2010 21:56:04 +0200
Message-ID: <20100605215604.68efc4e5__32586.0428544276$1275767931$gmane$org@schatten.dmk.lab>
References: <Pine.LNX.4.44L0.1005271253240.3239-100000@iolanthe.rowland.org>
	<201005302202.39511.rjw@sisk.pl>
	<AANLkTilUQ2AG76nbK6LwI8_7zw0_yMSoAOr9pmuz7xrt@mail.gmail.com>
	<201005312347.24251.rjw@sisk.pl>
	<AANLkTilvOgSFTDFtXbjJobMZWxgfvsC97TqC7_a_NHBX@mail.gmail.com>
	<alpine.LFD.2.00.1006011411200.2933@localhost.localdomain>
	<AANLkTikZHmF6baP7dEXEGFE8YsbEteRjlhb5wqZX8ll1@mail.gmail.com>
	<alpine.LFD.2.00.1006020905410.2933@localhost.localdomain>
	<AANLkTinDm3FIrbS1jqEzW15THmr1hdd7ox0Mllm1VLjZ@mail.gmail.com>
	<1275471561.27810.30865.camel@twins>
	<AANLkTilLmAb2c9fQwuguzWtjcHfuTZvPUTbUx7vuwFI6@mail.gmail.com>
	<1275474088.27810.31000.camel@twins>
	<20100602221309.6da754e7@schatten.dmk.lab>
	<1275550802.27810.34863.camel@twins>
	<20100603161205.73a2b56d@schatten.dmk.lab>
	<1275578881.27810.35995.camel@twins>
	<AANLkTinBg9W7zeomPbpGEDWkIsfxO9OfFUC0Kq7wafFb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTinBg9W7zeomPbpGEDWkIsfxO9OfFUC0Kq7wafFb@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Felipe Contreras <felipe.contreras@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Paul@smtp1.linux-foundation.org, LKML <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Linux PM <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linux OMAP Mailing List <linux-omap@vger.kernel.org>, felipe.balbi@nokia.com, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: linux-pm@vger.kernel.org

On Sat, 5 Jun 2010 20:30:40 +0300
Felipe Contreras <felipe.contreras@gmail.com> wrote:

> On Thu, Jun 3, 2010 at 6:28 PM, Peter Zijlstra <peterz@infradead.org> wrote:
> > On Thu, 2010-06-03 at 16:12 +0200, Florian Mickler wrote:
> >> On Thu, 03 Jun 2010 09:40:02 +0200
> >> Peter Zijlstra <peterz@infradead.org> wrote:
> >>
> >> > Fix the friggin apps, don't kludge with freezing.
> >>
> >> Of course programs should be as smart as possible. But that is an
> >> orthogonal problem.
> >>
> >> Suppose firefox were fixed. It still needs to fetch my rss feeds every
> >> minute, because I'm sad if it doesn't. It just can't be fixed at the
> >> application level.
> >
> > Sure it can, why would it need to fetch RSS feeds when the screen is off
> > and nobody could possible see the result? So you can stop the timer when
> > you know the window isn't visible or alternatively when the screensaver
> > is active, I think most desktops have notification of that as well.
> 
> Exactly, and that's what applications in the N900 do. For this to work
> reliably, you need these notifications (network disconnected, screen
> off) to be easily accessible, and even transparent to the application
> writer.
> 
> I don't think the suspend blockers solve much. A bad application will
> behave bad on any system. Suppose somebody decides to port Firefox to
> Android, and forgets to listen to the screen off event (bad on Android
> or Maemo), however, notices the application behaves very badly, so by
> googling finds these suspend blockers, and enables them all the time
> the application runs.
> 
> When the user install the application, will be greeted by a warning
> "This application might break PM, do you want to enable suspend
> blockers?" (or whatever), as any typical user would do, will press Yes
> (whatever).
> 
> We end up in exactly the same situation.
> 
No. The application will show up in the suspend blocker stats and the
user will remember: "Oh, yes. There was a warning about that. Well I
think I'm going to file a bug there."

The only difference is, that with suspend blockers, he can than
dismiss the applications permission to block suspend and will not miss
his job interview the next day because his phones battery run
out. And also he can use the application to a certain extent.

Cheers,
Flo
