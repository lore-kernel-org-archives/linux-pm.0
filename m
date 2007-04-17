From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Tue, 17 Apr 2007 14:58:29 +1000
Message-ID: <17956.21493.680585.335419@cargo.ozlabs.ibm.com>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176499086.7052.124.camel@johannes.berg>
	<20070413213349.GL28264@elf.ucw.cz>
	<200704140009.33298.rjw@sisk.pl>
	<1176503122.5764.109.camel@localhost.localdomain>
	<20070413223922.GS28264@elf.ucw.cz>
	<1176506383.5764.129.camel@localhost.localdomain>
	<20070416073249.GA2057@elf.ucw.cz>
	<1176712634.7052.175.camel@johannes.berg>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1176712634.7052.175.camel@johannes.berg>
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

Johannes Berg writes:

> No, it's two, for enabling as well.

I'm not sure we actually need a special enable hook.  I assume we have
a sysdev for the timekeeping stuff, whose resume function gets called
before interrupts are enabled.  That can set the decrementer to a
suitable value.  If we get an extra decrementer interrupt when
interrupts are enabled with local_irq_enable, it doesn't matter.

Paul.
