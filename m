From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [suspend/resume] Re: userspace notification
	from	module
Date: Fri, 15 Jan 2010 21:02:41 +0100
Message-ID: <20100115200241.GF1345__33488.3534153507$1263585846$gmane$org@ucw.cz>
References: <686edb2c.6263643a.4b3f4a3b.b60b3@o2.pl>
	<201001052223.21964.rjw@sisk.pl>
	<16a1b165.2fdc37c6.4b43b943.c6733@o2.pl>
	<201001060003.23419.rjw@sisk.pl>
	<1ab86ec9.7bc73105.4b43cd45.c2747@o2.pl>
	<20100106143534.A7EEA33C5F5@tippex.mynet.homeunix.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20100106143534.A7EEA33C5F5@tippex.mynet.homeunix.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Anders Eriksson <aeriksson@fastmail.fm>
Cc: Bart?omiej Zimo? <uzi18@o2.pl>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org, danborkmann@googlemail.com, awalls@radix.net
List-Id: linux-pm@vger.kernel.org

On Wed 2010-01-06 15:35:34, Anders Eriksson wrote:
> 
> uzi18@o2.pl said:
> >  Ummm sorry, it's IM App, to be realible for such app it's needed to close
> > conn before suspend, because after resume tcp connections will wait
> > (especialy on linux) quiet a lot of time to broke and reconnect.
> 
> I don't know the details here, but shouldn't the kernel fix this internally?
> 
> If sufficient time have elapsed so the kernel _should_ have sent keep alives 
> etc on an othervise idle connection, they shold be sent immediately on resume. 
> If the other end has disappeared by then, the resulting port unreachable 
> should trigger a local closure of the tcp state which the app will notice 
> (EBADF, or similar). Or?

Patches welcome.
									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
