From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH 1/5] ACPI / PM: Move references to pm_flags
	into sleep.c
Date: Tue, 8 Feb 2011 17:04:31 -0800
Message-ID: <AANLkTinZrhOdxZ-F+V1KLbR__PMNj-Qfc_O-xk7rJb_Y__19088.8399411508$1297213606$gmane$org@mail.gmail.com>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<201102082220.25240.rjw@sisk.pl>
	<AANLkTinAZphXC=7FParFnxDPQvpB1ic=FwTe7u4Txy5o@mail.gmail.com>
	<201102090137.52697.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201102090137.52697.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>, linux-embedded@vger.kernel.org, Mark Brown <broonie@opensource.wolfsonmicro.com>, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Tue, Feb 8, 2011 at 4:37 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
>
>> but maybe it would be about APM being enabled. Which is what the caller
>> actually seems to care about and talks about for the failure case. Maybe
>> you need separate functions for the "is APM enabled" case for the naming
>> to make sense. Hmm?
>
> That sounds like a good idea. =A0What about the following patch?

This patch I have no problems with.

                    Linus
