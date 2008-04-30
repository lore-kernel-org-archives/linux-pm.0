From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch] acpi: fix drivers/acpi/glue.c build error
Date: Wed, 30 Apr 2008 15:17:55 -0700
Message-ID: <200804301517.56249.david-b__35997.9264358573$1209594105$gmane$org@pacbell.net>
References: <200804301420.11696.lenb@kernel.org>
	<20080430205615.GA23694@elte.hu> <20080430210026.GA24121@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20080430210026.GA24121@elte.hu>
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
To: linux-pm@lists.linux-foundation.org
Cc: linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org, Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@linux-foundation.org>, Andrew Morton <akpm@linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday 30 April 2008, Ingo Molnar wrote:
> Subject: acpi: fix drivers/acpi/glue.c build error
> From: Ingo Molnar <mingo@elte.hu>
> Date: Wed Apr 30 22:56:57 CEST 2008
> =

> x86.git testing found the following build bug:
> =

> =A0 drivers/built-in.o: In function `acpi_rtc_init':
> =A0 glue.c:(.init.text+0x16c3): undefined reference to `pnp_bus_type'
> =

> this tries to use PNP bus infrastructure even in the !PNP case.

Broken config, yes?  ACPI selects PNP ...
