From: Maxim Levitsky <maximlevitsky@gmail.com>
Subject: Re: [Bugme-new] [Bug 16396] New: [bisected] resume from suspend
 freezes system
Date: Mon, 19 Jul 2010 03:25:41 +0300
Message-ID: <1279499141.17672.10.camel@localhost.localdomain>
References: <bug-16396-10286@https.bugzilla.kernel.org/>
	 <20100714194555.2b23d803.akpm@linux-foundation.org>
	 <201007151045.47302.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <201007151045.47302.rjw@sisk.pl>
Sender: linux-acpi-owner@vger.kernel.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thu, 2010-07-15 at 10:45 +0200, Rafael J. Wysocki wrote:
> On Thursday, July 15, 2010, Andrew Morton wrote:
> > On Thu, 15 Jul 2010 02:32:43 GMT bugzilla-daemon@bugzilla.kernel.org wrote:
> > 
> > > https://bugzilla.kernel.org/show_bug.cgi?id=16396
> > 
> > post-2.6.34 regression, bisected to an ACPi commit from Matthew.
> 
> Well, that's something I was afraid of.
> 
> So, the theory that we'll be fine if we do what Windows does really doesn't
> match reality.
> 
> Matthew, Len, any ideas?

One idea would be to see when exactly windows saves the NVS.
Maybe it does that earlier (that it relative to _PTS, device suspend,
etc...)

Maybe this system run Win7, and MS fixed that bug?

Best regards,
	Maxim Levitsky

