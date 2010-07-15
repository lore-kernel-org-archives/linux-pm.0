From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [Bugme-new] [Bug 16396] New: [bisected] resume from suspend freezes system
Date: Thu, 15 Jul 2010 10:45:47 +0200
Message-ID: <201007151045.47302.rjw@sisk.pl>
References: <bug-16396-10286@https.bugzilla.kernel.org/> <20100714194555.2b23d803.akpm@linux-foundation.org>
Mime-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-acpi-owner@vger.kernel.org>
In-Reply-To: <20100714194555.2b23d803.akpm@linux-foundation.org>
Sender: linux-acpi-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, Matthew Garrett <mjg@redhat.com>, Len Brown <lenb@kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thursday, July 15, 2010, Andrew Morton wrote:
> On Thu, 15 Jul 2010 02:32:43 GMT bugzilla-daemon@bugzilla.kernel.org wrote:
> 
> > https://bugzilla.kernel.org/show_bug.cgi?id=16396
> 
> post-2.6.34 regression, bisected to an ACPi commit from Matthew.

Well, that's something I was afraid of.

So, the theory that we'll be fine if we do what Windows does really doesn't
match reality.

Matthew, Len, any ideas?

Rafael
