From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 0/9] PM: Update global suspend and
	hibernation operations framework
Date: Sun, 1 Jul 2007 12:01:31 +0200
Message-ID: <200707011201.33111.rjw__18867.0338051908$1183284062$gmane$org@sisk.pl>
References: <200706302257.17556.rjw@sisk.pl>
	<20070630232222.GA8100@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070630232222.GA8100@flint.arm.linux.org.uk>
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
To: Russell King <rmk@arm.linux.org.uk>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

On Sunday, 1 July 2007 01:22, Russell King wrote:
> On Sat, Jun 30, 2007 at 10:57:16PM +0200, Rafael J. Wysocki wrote:
> > Hi,
> > 
> > This series of patches implements changes that are possible/necessary/desirable
> > (IMO) after the introduction of the .set_target() method in 'struct pm_ops'
> > (the patch that introduces it is in -mm,
> > http://marc.info/?l=linux-mm-commits&m=118306698814722&w=2).
> 
> I suggest you have a look in:
> 
>  http://ftp.arm.linux.org.uk/pub/linux/arm/kernel/git-cur/arm:pxa2.diff
> 
> since there's some duplication and clashes between your patch set and mine.
> I'm intending submitting the pxa2 branch when the next merge window opens.

Okay, I'll rediff the patch series so that it applies on top of your changes.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
