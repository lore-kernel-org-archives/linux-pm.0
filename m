From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC][PATCH -mm 0/9] PM: Update global suspend and
	hibernation operations framework
Date: Wed, 11 Jul 2007 13:16:07 +0200
Message-ID: <200707111316.08388.rjw__4499.34525318003$1184152166$gmane$org@sisk.pl>
References: <200706302257.17556.rjw@sisk.pl> <20070711105334.GH7091@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070711105334.GH7091@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, Russell King <rmk@arm.linux.org.uk>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Hi,

On Wednesday, 11 July 2007 12:53, Pavel Machek wrote:
> Hi!
> 
> 
> > This series of patches implements changes that are possible/necessary/desirable
> > (IMO) after the introduction of the .set_target() method in 'struct pm_ops'
> > (the patch that introduces it is in -mm,
> > http://marc.info/?l=linux-mm-commits&m=118306698814722&w=2).
> 
> (I think this series is already in -mm, right?)

No, it is not, because I'm waiting for the inclusion of the ARM update.

Greetings,
Rafael


-- 
"Premature optimization is the root of all evil." - Donald Knuth
