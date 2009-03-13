From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [update,
	rev. 6] Re: [PATCH 1/10] PM: Rework handling of interrupts during
	suspend-resume (rev. 5)
Date: Fri, 13 Mar 2009 17:53:37 +0100
Message-ID: <200903131753.39076.rjw__39409.4915980988$1236963535$gmane$org@sisk.pl>
References: <200902221837.49396.rjw@sisk.pl> <200903122243.27452.rjw@sisk.pl>
	<d6200be20903130015w4a25806bmbf9d4dda12e6825c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <d6200be20903130015w4a25806bmbf9d4dda12e6825c@mail.gmail.com>
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
To: Arve =?iso-8859-1?q?Hj=F8nnev=E5g?= <arve@android.com>
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Frans Pop <elendil@planet.nl>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Friday 13 March 2009, Arve Hj=F8nnev=E5g wrote:
> On Thu, Mar 12, 2009 at 1:43 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> >
> > +void __disable_irq(struct irq_desc *desc, unsigned int irq, bool suspe=
nd)
> > +{
> > +       if (suspend) {
> > +               if (desc->action && (desc->action->flags & IRQF_TIMER))
> > +                       return;
> =

> Don't you want "(!desc->action || ..." here to avoid enabling unused
> interrupts on resume?

Hmm, good idea, thanks.

Best,
Rafael
