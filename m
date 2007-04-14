From: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH v4] pm_ops: add system quiesce/activate hooks
Date: Sun, 15 Apr 2007 02:55:13 +1000
Message-ID: <17953.1905.510261.169936@cargo.ozlabs.ibm.com>
References: <1175810054.3489.34.camel@johannes.berg>
	<1176499086.7052.124.camel@johannes.berg>
	<20070413213349.GL28264@elf.ucw.cz>
	<200704140009.33298.rjw@sisk.pl>
	<1176502406.7052.134.camel@johannes.berg>
	<20070413221652.GR28264@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070413221652.GR28264@elf.ucw.cz>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Pavel Machek <pavel@ucw.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Pavel Machek writes:

> I see ppc as being really special here.

It is, I guess.  The salient point is that once the decrementer has an
interrupt pending, the only way to clear it is to take the interrupt.
There is no explicit access to the interrupt pending bit and no
separate enable bit for its interrupt, only the global interrupt
enable for the whole CPU.  We have to turn on the global interrupt
enable when finally putting the system into the suspend state (for
suspend to RAM), otherwise on some machines we'll never wake up again.

Effectively, when dealing with the decrementer during preparation for
suspend-to-RAM, we may need to have interrupts enabled briefly in
order to clear a pending decrementer interrupt.

Paul.
