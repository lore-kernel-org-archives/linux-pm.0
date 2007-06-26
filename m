From: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm 6/8] PM: Rework struct
	platform_suspend_operations
Date: Tue, 26 Jun 2007 10:52:22 +0200
Message-ID: <20070626085222.GB4594__23842.3780807809$1182896769$gmane$org@elf.ucw.cz>
References: <200706242239.05678.rjw@sisk.pl> <200706260039.17530.rjw@sisk.pl>
	<200706260049.40457.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200706260049.40457.rjw@sisk.pl>
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
Cc: Len Brown <len.brown@intel.com>, linux acpi <linux-acpi@vger.kernel.org>, pm list <linux-pm@lists.linux-foundation.org>, Johannes Berg <johannes@sipsolutions.net>
List-Id: linux-pm@vger.kernel.org

Hi!

> There is no reason why the .prepare() and .finish() methods in 'struct
> platform_suspend_operations' should take any arguments, since architectures
> don't use these methods' argument in any practically meaningful way (ie. either
> the target system sleep state is conveyed to the platform by .set_target(), or
> there is only one suspend state supported and it is indicated to the PM core by
> .valid(), or .prepare() and .finish() aren't defined at all).  There also is
> no reason why .finish() should return any result.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

ACK. (Maybe you should not in changelog that this changes absolutely
no behaviour; it is not immediately obvious).

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
