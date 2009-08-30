From: Mario <rety@poczta.onet.pl>
Subject: Re: Is acpi_ec_ecdt_probe() broken? (was: Re: ACPI locks
	hardware devices when it doesn't detect vista)
Date: Sun, 30 Aug 2009 08:59:29 +0200
Message-ID: <200908300859.29494.rety__17654.9024567523$1251615728$gmane$org@poczta.onet.pl>
References: <1250945310.14167.150.camel@maxim-laptop>
	<200908300037.45412.rjw@sisk.pl>
	<1251588634.15582.0.camel@maxim-laptop>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1251588634.15582.0.camel@maxim-laptop>
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
To: Maxim Levitsky <maximlevitsky@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm <linux-pm@lists.linux-foundation.org>, Alexey Starikovskiy <astarikovskiy@suse.de>
List-Id: linux-pm@vger.kernel.org

Maxim, 

I did the test regarding last coment from Alexey Starikovskiy on the bugzilla.

>What happens if acpi_ec_ecdt_probe() is not called at all? Do you have same
>hang as with changed order?

That did it. System starts and MIR works ok without setpci solution.

Regards
Mario

Sunday 30 of August 2009 01:30:34 Maxim Levitsky wrote:
> On Sun, 2009-08-30 at 00:37 +0200, Rafael J. Wysocki wrote:
> > On Saturday 29 August 2009, Mario wrote:
> > > Exact model is Compal JFL92.
> > > I've attached a dmidecode output.
> >
> > OK
> >
> > Maxim, Mario, can you create a bug entry in the kernel Bugzilla for this
> > issue and put my address into the CC list in there?
>
> Done,
>
> http://bugzilla.kernel.org/show_bug.cgi?id=14086
>
>
> Best regards,
> 	Maxim Levitsky
