From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH] x86: make sure wakeup code is below 1M -v2
Date: Wed, 11 Nov 2009 10:56:24 +0100
Message-ID: <200911111056.24227.rjw__45057.7053278268$1257933378$gmane$org@sisk.pl>
References: <4AF7D820.5040503@kernel.org> <4AFA210B.3020207@kernel.org>
	<20091111074830.GA10310@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20091111074830.GA10310@elte.hu>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Ingo Molnar <mingo@elte.hu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yinghai@kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 11 November 2009, Ingo Molnar wrote:
> 
> * Yinghai Lu <yinghai@kernel.org> wrote:
> 
> > 
> > try to find_e820_area/reserve_early, and call acpi_reserve_memory early
> > 
> > to get area is below 1M
> > 
> > -v2: change function name to acpi_reserve_wakeup_memory according to Rafael
> > 
> > Signed-off-by: Yinghai Lu <yinghai@kernel.org>
> > 
> > ---
> >  arch/x86/include/asm/acpi.h  |    2 +-
> >  arch/x86/kernel/acpi/sleep.c |   15 +++++++++------
> >  arch/x86/kernel/setup.c      |   13 +++++++------
> >  3 files changed, 17 insertions(+), 13 deletions(-)
> 
> Looks good. Rafael, Peter, does it look good to you too?

Yes, it does.

Acked-by: Rafael J. Wysocki <rjw@sisk.pl>
