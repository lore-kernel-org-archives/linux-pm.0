From: Manuel Lauss <manuel.lauss@googlemail.com>
Subject: Re: [PATCH] MIPS:i8259.c remove resume and shutdown to
	syscore_ops
Date: Tue, 24 May 2011 21:09:58 +0200
Message-ID: <BANLkTimYuJiiCbqO9QxgaAKHAZWe04vhgA__34842.7961268046$1306264250$gmane$org@mail.gmail.com>
References: <1306247112.2066.8.camel@Tux>
	<201105242059.59770.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201105242059.59770.rjw@sisk.pl>
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
Cc: linux-mips@linux-mips.org, linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>, wanlong.gao@gmail.com, Thomas Gleixner <tglx@linutronix.de>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Pengfei Zhang <zoppof.zhang@gmail.com>
List-Id: linux-pm@vger.kernel.org

On Tue, May 24, 2011 at 8:59 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
> On Tuesday, May 24, 2011, Wanlong Gao wrote:
>>
>> > On Tue, May 24, 2011 at 08:19:18PM +0800, Pengfei Zhang wrote:
>> >
>> > > Remove the resume and shutdown of i8259A from the sysdev_class
>> > > to the syscore_ops since these members had removed from the
>> > > structure sysdev_class.
>> >
>> > I don't see why one would want to want to first call
>> > register_syscore_ops
>> > then sysdev_class_register and sysdev_register?
>> >
>> Hi Ralf:
>> If these not moved to syscore_ops, building will get error.
>>
>> Hi Thomas:
>> Does you mean that we can just remove the sysfs entry now ?
>
> I had the appended patch in my tree before the merge window started,
> but it conflicted with analogous changes in the MIPS tree, so I had
> dropped it. =A0Was it a mistake?
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
> Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> Acked-and-tested-by: Lars-Peter Clausen <lars@metafoo.de>
> ---
> =A0arch/mips/alchemy/common/dbdma.c | =A0 92 +++++++++++-----------------=
-----------
> =A0arch/mips/alchemy/common/irq.c =A0 | =A0 62 +++++++++-----------------

I took care of these two, they were the reason for the conflict in -next.

Manuel
