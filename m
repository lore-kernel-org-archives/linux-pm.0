From: Pavel Machek <pavel@suse.cz>
Subject: Re: [RFD] Automatic suspend
Date: Tue, 17 Feb 2009 00:22:59 +0100
Message-ID: <20090216232259.GK1370__28123.9163982265$1234826851$gmane$org@ucw.cz>
References: <200902160010.16955.rjw@sisk.pl> <20090216225831.GH1370@ucw.cz>
	<20090216231324.GA15435@srcf.ucam.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090216231324.GA15435@srcf.ucam.org>
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
Cc: Nigel Cunningham <nigel@nigel.suspend2.net>, Uli Luckas <u.luckas@road.de>, LKML <linux-kernel@vger.kernel.org>, Brian Swetland <swetland@google.com>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Mon 2009-02-16 23:13:24, Matthew Garrett wrote:
> On Mon, Feb 16, 2009 at 11:58:31PM +0100, Pavel Machek wrote:
> 
> > If no devices are being used, and next wakeup is far enough in the
> > future, just put system to sleep. Long enough == so far away that
> > suspend/wakeup is short compared to that... like 20 seconds on PC.
> 
> This is intrinsically difficult with PCs, since we have such a poorly 
> defined set of wakeup events. We can't wakeup on generic network 
> traffic, just WoL. 

At least e1000 in thinkpad can wakeup on generic network traffic. If
particular network card can't, you just can't sleep when network is up.

> Many machines won't wake up on keyboard events. 

Too bad. You'll have to close the lid for autosuspend to work on such
hw. (Or maybe you can do some hack telling the kernel to suspend
anyway if just keyboard prevents it.)

> Meanwhile, on embedded it's becoming a less interesting problem because 
> idle and suspended are often now equivalent states. 

Android people tell us otherwise.
								Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
