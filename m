From: =?UTF-8?B?w4Frb3MgTWFyw7N5?= <akos@maroy.hu>
Subject: Re: pm-suspend working, but pm-hibernate fails
Date: Sat, 27 Feb 2010 15:13:35 +0100
Message-ID: <4B89288F.8070302@maroy.hu>
References: <4B86F96A.1010306@maroy.hu>
	<201002252357.04056.rjw@sisk.pl>	<4B88D6B9.2050200@maroy.hu>
	<201002271300.56741.rjw@sisk.pl>	<4B891E0C.4030402@maroy.hu>
	<20100227135144.GA18662@qp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100227135144.GA18662@qp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Matthias-Christian Ott <ott@mirix.org>
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Matthias,

> Did you try it without framebuffer and X.org? It seems to me that the
> system wakes up correctly, but the graphics card is this issue. I had
> this with my old laptop too.

instead of guessword, I'd be very happy to look at a log of what's
happening. a long time ago I remember, with tuxonice, this was possible,
just to immitate hibernation.

OTOH, suspend actually works - I wonder if there's an inherent different
in the process, other than the machine state being saved to disk or not..


Akos
