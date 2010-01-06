From: Anders Eriksson <aeriksson@fastmail.fm>
Subject: Re:
	=?utf-8?q?=5Bsuspend/resume=5D_Re=3A_userspace_notific?=
	=?utf-8?q?ation_from_module?=
Date: Wed, 06 Jan 2010 15:35:34 +0100
Message-ID: <20100106143534.A7EEA33C5F5__48600.040752399$1262788630$gmane$org@tippex.mynet.homeunix.org>
References: <686edb2c.6263643a.4b3f4a3b.b60b3@o2.pl>
	<201001052223.21964.rjw@sisk.pl>
	<16a1b165.2fdc37c6.4b43b943.c6733@o2.pl>
	<201001060003.23419.rjw@sisk.pl>
	<1ab86ec9.7bc73105.4b43cd45.c2747@o2.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-reply-to: <1ab86ec9.7bc73105.4b43cd45.c2747@o2.pl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: =?UTF-8?Q?Bart=C5=82omiej_Zimo=C5=84?= <uzi18@o2.pl>
Cc: awalls@radix.net, linux-pm@lists.linux-foundation.org, =?UTF-8?Q?Anders_Eriksson?= <aeriksson@fastmail.fm>, linux-kernel@vger.kernel.org, danborkmann@googlemail.com
List-Id: linux-pm@vger.kernel.org


uzi18@o2.pl said:
>  Ummm sorry, it's IM App, to be realible for such app it's needed to close
> conn before suspend, because after resume tcp connections will wait
> (especialy on linux) quiet a lot of time to broke and reconnect.

I don't know the details here, but shouldn't the kernel fix this internally?

If sufficient time have elapsed so the kernel _should_ have sent keep alives 
etc on an othervise idle connection, they shold be sent immediately on resume. 
If the other end has disappeared by then, the resulting port unreachable 
should trigger a local closure of the tcp state which the app will notice 
(EBADF, or similar). Or?

Seems to me the kernel should sit on enough info to handle this nicely. 
