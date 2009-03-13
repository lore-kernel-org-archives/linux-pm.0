From: =?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?= <arve@android.com>
Subject: Re: [update,
	rev. 6] Re: [PATCH 1/10] PM: Rework handling of interrupts during
	suspend-resume (rev. 5)
Date: Thu, 12 Mar 2009 23:15:22 -0800
Message-ID: <d6200be20903130015w4a25806bmbf9d4dda12e6825c@mail.gmail.com>
References: <200902221837.49396.rjw@sisk.pl>
	<alpine.LFD.2.00.0903112342440.29264@localhost.localdomain>
	<200903121436.21504.rjw@sisk.pl> <200903122243.27452.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200903122243.27452.rjw@sisk.pl>
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
Cc: Jeremy Fitzhardinge <jeremy@goop.org>, Frans Pop <elendil@planet.nl>, LKML <linux-kernel@vger.kernel.org>, Jesse Barnes <jbarnes@virtuousgeek.org>, "Eric W. Biederman" <ebiederm@xmission.com>, pm list <linux-pm@lists.linux-foundation.org>, Thomas Gleixner <tglx@linutronix.de>, Linus Torvalds <torvalds@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>
List-Id: linux-pm@vger.kernel.org

On Thu, Mar 12, 2009 at 1:43 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
> +void __disable_irq(struct irq_desc *desc, unsigned int irq, bool suspend)
> +{
> + =A0 =A0 =A0 if (suspend) {
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (desc->action && (desc->action->flags & =
IRQF_TIMER))
> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 return;

Don't you want "(!desc->action || ..." here to avoid enabling unused
interrupts on resume?

-- =

Arve Hj=F8nnev=E5g
