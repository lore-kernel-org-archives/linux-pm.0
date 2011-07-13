From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] x86 intel power: Initialize
	MSR_IA32_ENERGY_PERF_BIAS
Date: Wed, 13 Jul 2011 13:49:06 -0700
Message-ID: <CA+55aFxBkgwBbnqwO7DuizsWiVcULYtPzqr-mYrT6aHmXV0zZw@mail.gmail.com>
References: <alpine.LFD.2.02.1103301819250.31342@x980>
	<20110414090854.GB9248@elte.hu>
	<alpine.LFD.2.02.1104150202310.29365@x980>
	<20110415101712.GB28007@elte.hu>
	<alpine.LFD.2.02.1107131640280.9546@x980>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LFD.2.02.1107131640280.9546@x980>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Len Brown <lenb@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org, Alan Cox <alan@lxorguk.ukuu.org.uk>, Arjan van de Ven <arjan@infradead.org>
List-Id: linux-pm@vger.kernel.org

Ack. Let's just do this. Ingo?

            Linus

On Wed, Jul 13, 2011 at 1:44 PM, Len Brown <lenb@kernel.org> wrote:
>
>> So how about informing users, how about making it non-silent? An informa=
tive
>> printk that also mentions the power configuration tool, etc. This solves=
 the
>> concerns i mentioned.
>
> Something like this?
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0rdmsrl(MSR_IA32_ENERGY_PERF_BIAS, epb);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0if ((epb & 0xF) =3D=3D 0) {
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0printk_once(KERN_WARN, "x8=
6: updated energy_perf_bias"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" to 'norm=
al' from 'performance'\n"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0"You can v=
iew and update epb via utility,"
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0" such as =
x86_energy_perf_policy(8)\n");
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0epb =3D (epb & ~0xF) | ENE=
RGY_PERF_BIAS_NORMAL;
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0wrmsrl(MSR_IA32_ENERGY_PER=
F_BIAS, epb);
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0}
>
>
