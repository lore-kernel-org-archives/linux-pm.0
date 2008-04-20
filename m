From: Andi Kleen <andi@firstfloor.org>
Subject: Re: Higer latency with dynamic tick (need for an
	io-ondemand govenor?)
Date: Sun, 20 Apr 2008 16:26:33 +0200
Message-ID: <480B5299.9090904__18656.2541210607$1208701753$gmane$org@firstfloor.org>
References: <3B6D69C3A9EBCA4BA5DA60D913027429010253CD@dlee13.ent.ti.com><1179396659.3764.40.camel@chaos><3B6D69C3A9EBCA4BA5DA60D913027429010258E8@dlee13.ent.ti.com><1179434296.12981.14.camel@chaos><3B6D69C3A9EBCA4BA5DA60D913027429010259ED@dlee13.ent.ti.com><1179474567.12981.53.camel@chaos><3B6D69C3A9EBCA4BA5DA60D91302742904131BED@dlee13.ent.ti.com>
	<87ej90aece.fsf@basil.nowhere.org>
	<3B6D69C3A9EBCA4BA5DA60D9130274290413207D@dlee13.ent.ti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <3B6D69C3A9EBCA4BA5DA60D9130274290413207D@dlee13.ent.ti.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: "Woodruff, Richard" <r-woodruff2@ti.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-pm@lists.linux-foundation.org, Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Woodruff, Richard wrote:
> "Andi Kleen" <andi@firstfloor.org> writes:
>> Are you talking about x86?
> 
> ARM (TI-OMAP)

Sorry I was confused because you used the term "C-state" which is normally ACPI (x86/ia64) 
specific. If someone says C states I assume ACPI and usually x86 by default
due to lack of deeper sleep states on most ia64s.

> Not sure about the underlying X86 hardware implementation.

On x86 the trend is for the hardware/firmware/SMM doing more and more of this on its own,
as in deciding by itself how deep it wants to sleep.

-Andi
