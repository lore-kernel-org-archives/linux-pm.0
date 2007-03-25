From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH] implement pm_ops.valid for everybody
Date: Sat, 24 Mar 2007 18:02:29 -0700
Message-ID: <200703241802.29739.david-b@pacbell.net>
References: <200703221344.l2MDi2Q9007989@olwen.urbana.css.mot.com>
	<200703241349.19964.david-b@pacbell.net>
	<1174770101.9161.20.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174770101.9161.20.camel@johannes.berg>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Johannes Berg <johannes@sipsolutions.net>
Cc: alexey.y.starikovskiy@intel.com, dirk.behme@de.bosch.com, pavel@ucw.cz, linux-pm@lists.linux-foundation.org, nico@cam.org, ben@simtec.co.uk, g.liakhovetski@gmx.de
List-Id: linux-pm@vger.kernel.org

On Saturday 24 March 2007 2:01 pm, Johannes Berg wrote:
> On Sat, 2007-03-24 at 13:49 -0700, David Brownell wrote:
> =

> > You seem to have overlooked the clk_must_disable() patches I
> > recently re-sent.  In conjunction with the driver model wakeup
> > flags, that can solve the problem on every SOC platform I've
> > had a reason to look at ... see how it works for AT91 USB.
> =

> In fact, I looked at those, and it's actually useful on powermac laptops
> (powerbooks/ibooks) as well, there are some sound clocks that could be
> managed with it.

Interesting.  I've sort of assumed <linux/clk.h> didn't get much
use outside the embedded arch code (ARM, AVR32, SH pending, ...)
so far ... there's no good technical reason for that of course!


> > No, let's not complexify that pm_message_t mistake any further.
> =

> I second that. Drivers can't really know what the precise semantics of
> any state are across platforms, especially drivers that are shared
> between different platforms but where the hw could be wired up
> differently.

Even within one platform there can be board-specific diferences,
and different chip revisions may work differently.

- Dave
