From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Sun, 15 Apr 2007 10:19:42 +1000
Message-ID: <1176596382.10629.1.camel@localhost.localdomain>
References: <1175810054.3489.34.camel@johannes.berg>
	<20070413223922.GS28264@elf.ucw.cz>
	<1176506383.5764.129.camel@localhost.localdomain>
	<200704141114.56545.rjw@sisk.pl>
	<1176542370.7052.159.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176542370.7052.159.camel@johannes.berg>
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
Cc: linux-pm@lists.linux-foundation.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org


> On the other hand, if doing an arch hook here and something like
> CONFIG_ARCH_HAS_SUSPEND_IRQ_HOOKS would actually allow us to end this
> pointless discussion, then why not.

The preferred approach for that sort of thing nowadays is to have
the generic code contain

#ifndef arch_foo_bar()
#define arch_foo_bar()	do { } while(0)
#endif

And have the arch code do

void arch_foo_bar(void)
{
	xxx
}
#define arch_foo_bar arch_foo_bar

Ben.
