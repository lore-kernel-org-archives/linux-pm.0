From: "Jeff Chua" <jeff.chua.linux@gmail.com>
Subject: Re: [PATCH v2] Add suspend/resume for HPET
Date: Sun, 1 Apr 2007 00:01:48 +0800
Message-ID: <b6a2187b0703310901t42fe4752s55eb20d198788b22@mail.gmail.com>
References: <Pine.LNX.4.64.0703160925270.26106@woody.linux-foundation.org>
	<460BBD1B.4040308@ru.mvista.com>
	<200703291531.18253.maximlevitsky@gmail.com>
	<200703291546.48996.maximlevitsky@gmail.com>
	<1175356272.28263.27.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1175356272.28263.27.camel@localhost.localdomain>
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
To: tglx@linutronix.de
Cc: Maxim Levitsky <maximlevitsky@gmail.com>, linux-ide@vger.kernel.org, Sergei Shtylyov <sshtylyov@ru.mvista.com>, jgarzik@pobox.com, gregkh@suse.de, linux-pm@lists.osdl.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Adrian Bunk <bunk@stusta.de>, linux-acpi@vger.kernel.org, linux-pci@atrey.karlin.mff.cuni.cz, "Eric W. Biederman" <ebiederm@xmission.com>, Jens Axboe <jens.axboe@oracle.com>, "Michael S. Tsirkin" <mst@mellanox.co.il>, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On 3/31/07, Thomas Gleixner <tglx@linutronix.de> wrote:

> Jeff still seems to have problems with CONFIG_NO_HZ=3Dn and it might be
> caused by time keeping / tick management resume happening before the
> HPET resume.


me>Confirmed that suspend/resume disk/ram works on X60s with
me>CONFIG_HPET_TIMER=3Dy and CONFIG_NO_HZ unset.
me> But suspend to disk still hang with CONFIG_NO_HZ unset.


Oops, sorry. Typo (as a result copy/paste using mouse)
    ... I actually meant CONFIG_NO_HZ "set".

Just to be clear, suspend to disk still hang with CONFIG_NO_HZ=3Dy. It
hang just before you see the percent saving %.


Jeff.
