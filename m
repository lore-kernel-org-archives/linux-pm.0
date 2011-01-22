From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: Occasional (too common) suspend problem
Date: Fri, 21 Jan 2011 17:14:25 -0800
Message-ID: <AANLkTikv55eQfNaCGLm-2pA3Ndyi9ZEzb4xn64D3u0ww__37293.0778809406$1295659025$gmane$org@mail.gmail.com>
References: <AANLkTikBRf00H_6YcS9nsnJG68WguDzL_AvNTRyDWRY=@mail.gmail.com>
	<201101212342.01646.rjw@sisk.pl>
	<AANLkTi=_-bMsp1K-thY+4wUMC5wDMVT+8m=fmVEx_wqE@mail.gmail.com>
	<201101220016.46227.rjw@sisk.pl>
	<AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <AANLkTi=Tkf9MYmSmCX6CZ9Ymgqo8S1HmRkBn+Uvr2KUb@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, Jeff Chua <jeff.chua.linux@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Fri, Jan 21, 2011 at 4:23 PM, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Or - and perhaps more likely - it's connected to the lid event, and
> how that interacts with user space and then eventually triggers the
> sleep event (which is quite likely - as mentioned, I think I've only
> ever seen the problem when I'm physically at the machine).

.. but with the 'test' suspend (echo core ..), the lid event is all
good too. And going back to non-testing (echo none ..), it works too.

Which really does seem to get me back to the whole "if it fails, it
seems to fail on the first suspend" thing. Don't ask me why. I have no
idea. But I just suspended that machine 100+ times using the test
thing (60 times at the gdm prompt, 60 times while logged in and with
glxgears running to verify dri/thermal interfaces), and then a couple
of times with the lid, and it all worked.

But I bet that if I rebooted the machine a few times, it would
eventually fail on the first suspend.

Some initialization issue, perhaps?

                      Linus
