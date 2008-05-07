From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 1/4] ACPI Hibernation: Use ACPI hardware
	signature
Date: Wed, 7 May 2008 23:04:38 +0200
Message-ID: <20080507210438.GD18516__37271.6747377583$1210194620$gmane$org@elf.ucw.cz>
References: <200805062331.39454.rjw@sisk.pl> <200805062333.17558.rjw@sisk.pl>
	<20080507092055.GA13858@elf.ucw.cz>
	<200805071428.02613.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200805071428.02613.rjw@sisk.pl>
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
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> > > +static int __init acpi_s4_nosigcheck(char *str)
> > > +{
> > > +	nosigcheck = true;
> > > +	return 1;
> > > +}
> > > +__setup("acpi_s4_nosigcheck", acpi_s4_nosigcheck);
> > > +
> > 
> > Needs a patch to Documentation/ , too.
> 
> Yes, thanks.
> 
> > > +	/* Check the hardware signature */
> > > +	if (facs && s4_hardware_signature != facs->hardware_signature)
> > 
> > do you need && !nosigcheck here ?
> 
> No, facs is NULL if !nosigcheck.

Aha, ook. You can add my ACK when you add the Documentation/.

									Pavel

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
