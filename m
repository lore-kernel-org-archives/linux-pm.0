From: Vitaly Wool <vitalywool@gmail.com>
Subject: Re: [PATCH] PM: suspend_device_irqs(): don't disable
	wakeup IRQs
Date: Tue, 5 May 2009 18:11:31 +0400
Message-ID: <acd2a5930905050711j57cbf81du2fe4dbb4e408e877__4242.83610559559$1241532941$gmane$org@mail.gmail.com>
References: <1241483224-7113-1-git-send-email-khilman@deeprootsystems.com>
	<20090504235405.647772ed.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20090504235405.647772ed.akpm@linux-foundation.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Tue, May 5, 2009 at 10:54 AM, Andrew Morton
<akpm@linux-foundation.org> wrote:
> On Mon, =A04 May 2009 17:27:04 -0700 Kevin Hilman <khilman@deeprootsystem=
s.com> wrote:
>
>> Interrupts that are flagged as wakeup sources via set_irq_wake()
>> should not be disabled for suspend.
>>
>
> Why not?

Sounds like an interesting problem. If a wakeup depends on the
interrupt line, then no they definitely should not be disabled, as no
wakeup would happen otherwise. OTOH, this is not necessarily the case;
some SoCs configure wakeup sources as GPIOs (i.MXs do AFAIR) so it's
not clear if we should change generic source code in this case.

Vitaly
