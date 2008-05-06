From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 1/2] ACPI PM: Add suspend sequence workaround
Date: Wed, 7 May 2008 00:09:52 +0200
Message-ID: <200805070009.53120.rjw__38438.6232741692$1210112012$gmane$org@sisk.pl>
References: <200805062342.42789.rjw@sisk.pl> <200805062344.31117.rjw@sisk.pl>
	<200805062257.55554.carlos@strangeworlds.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805062257.55554.carlos@strangeworlds.co.uk>
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
To: Carlos Corbacho <carlos@strangeworlds.co.uk>
Cc: Jesse Barnes <jbarnes@virtuousgeek.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, 6 of May 2008, Carlos Corbacho wrote:
> On Tuesday 06 May 2008 22:44:30 Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rjw@sisk.pl>
> >
> > There are some systems out there that don't work correctly with
> > our current suspend/hibernation code ordering.  Provide a workaround
> > for these systems allowing them to pass the
> > 'acpi_old_suspend_ordering' command line parameter to the kernel that
> > will make it use the pre-ACPI 2.0 suspend code ordering.
> 
> Can we tack on a set of DMI matches to this somewhere to automatically apply 
> this to the systems we know so far that need the old ordering?

Yes, that will be the next step.

I think the command line argument may be useful anyway for checking if given
system is affected.

Thanks,
Rafael
