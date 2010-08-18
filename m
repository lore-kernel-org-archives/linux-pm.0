From: Florian Mickler <florian@mickler.org>
Subject: Re: Wakeup-events implementation
Date: Wed, 18 Aug 2010 09:04:04 +0200
Message-ID: <20100818090404.12bc7d1d@schatten.dmk.lab>
References: <AANLkTikqWLShBVVB9-wCngO2ajrrgt-Nkmt_Bmys7b7w@mail.gmail.com>
	<Pine.LNX.4.44L0.1008171109030.1656-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.44L0.1008171109030.1656-100000@iolanthe.rowland.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: list <linux-pm@lists.linux-foundation.org>, Linux-pm@smtp1.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, 17 Aug 2010 11:53:53 -0400 (EDT)
Alan Stern <stern@rowland.harvard.edu> wrote:

> Also, I frankly have to wonder why you demand such a large amount of
> detailed debugging about the kernel's wakeup/wakelock subsystem (as
> opposed to userspace wakelocks).  Yes, it's clear that if something
> goes wrong then you will drain your phone's battery in a few hours
> rather than a few days.  But what if something goes wrong with the VM
> subsystem, or the RF subsystem, or the keypad driver?  The device would
> crash immediately or at best become almost totally unusable.  These are
> much worse scenarios than losing some battery life -- have you added
> comparable quantities of debugging to those other parts of the kernel?
> =

> In addition, you retain all these debugging facilities in your
> production builds, not just in the debug kernels.  Doesn't this seem
> excessive?
> =


There is a theory about risk analysis and follow-up costs... i don't have
anything concrete at hand but the main idea is that if you develop for
example some monitoring for a production line of a pharmaceutical
product, you have to take into consideration all possible
failure-modes, the associated risk (likelihood * impact)
 and the likelihood of detecting these failures before shipping.

A failure mode that is fatal (->high risk), and is not detectable
before shipping is bad and a sign that you probably shouldn't produce
at all.

A failure mode that is fatal (->high risk) but is detectable in all
cases before shipping=A0is not such a big problem. =


With battery powered devices, you have failure-modes (run-time not
optimal) that is not easily detectable before shipping. This is the
worst kind of failure-mode because you don't know if it will happen or
not. =


The risk of this failure mode (non-optimal runtime) is bad also, because
for mobile devices the runtime is critical and the fact that we talk
about millions of devices will turn this up with a non-negligible =

probability.
 =

So I totally understand that the android people want all the debugging
they can get to make non-optimal runtime as visible as a broken vm or a
not functioning keypad. After all, runtime is critical for mobile
devices.

Cheers,
Flo
