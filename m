From: Magnus Damm <magnus.damm@gmail.com>
Subject: Re: [PATCH] ARM / shmobile: Make A3RV be a subdomain of
	A4LC on SH7372
Date: Wed, 13 Jul 2011 10:39:41 +0900
Message-ID: <CANqRtoSW9jQwQLU4kMP1UOpPp0i-KunZKnNaegriFT74LEovhQ__37601.3559791774$1310521244$gmane$org@mail.gmail.com>
References: <201107130040.02752.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201107130040.02752.rjw@sisk.pl>
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
Cc: Linux PM mailing list <linux-pm@lists.linux-foundation.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wed, Jul 13, 2011 at 7:40 AM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
>
> Instead of coding the undocumented dependencies between power domains
> A3RV and A4LC on SH7372 directly into the low-level power up/down
> routines, make A3RV be a subdomain of A4LC, which will cause the
> same dependecies to hold.
>
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> ---

Thanks for your effort of cleaning up the code!

You are correct that putting A3RV as a subdomain of A4LC will help
with one side of the problem. The not so visible problem at this point
is the connection between A4R and A3RV. A4R is a power domain which
contains some I/O devices and the two power domains A3RV and A3RI.

Because of the hardware dependency between A4R and A3RV we would need
to force A4R to be powered on whenever A3RV is being used. So A4R is
the "real" parent pm domain from the data sheet point of view.

To simplify the software side one option could be to make A4LC the
parent of A3RV and A4R the parent of A4LC. This is not however a very
good fit either - the hardware allows us to have A4LC powered on
without A4R or A3RV. This case is quite common and happens when any
LCD panel is enabled but the rest of the system is idle.

For the case when no A4R support is in place your suggestion is fine.
But to support A4R we need to deal with something similar to what my
patch does anyway. It is worth nothing that A4R contains an interrupt
controller and needs special care that way too. Also the I/O devices
in A4R require QoS software to be in place before we can start
powering down A4R for real.

So the reason behind my somewhat ugly existing A3RV and A4LC power
domain code is to make sure the framework code can do whatever we need
to do for A4R support. Or perhaps it can be done in a better way? Any
ideas?

Thanks,

/ magnus
