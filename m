From: Jeremy Maitin-Shepard <jbms@cmu.edu>
Subject: Re: hibernation/snapshot design
Date: Mon, 09 Jul 2007 11:23:12 -0400
Message-ID: <873azxwqhr.fsf__19442.1622356915$1183994731$gmane$org@jbms.ath.cx>
References: <Pine.LNX.4.44L0.0707072224270.10912-100000@netrider.rowland.org>
	<200707082115.27363.rjw@sisk.pl>
	<1183928612.3388.289.camel@localhost.localdomain>
	<200707082345.27859.rjw@sisk.pl>
	<1183931688.3388.316.camel@localhost.localdomain>
	<20070708221315.GF5401@elf.ucw.cz>
	<Pine.LNX.4.64.0707081519210.25614@asgard.lang.hm>
	<20070708230042.GH5401@elf.ucw.cz>
	<Pine.LNX.4.64.0707081614211.25614@asgard.lang.hm>
	<20070708232819.GJ5401@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20070708232819.GJ5401@elf.ucw.cz> (Pavel Machek's message of
	"Mon\, 9 Jul 2007 01\:28\:19 +0200")
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
Cc: david@lang.hm, Matthew Garrett <mjg59@srcf.ucam.org>, linux-kernel@vger.kernel.org, Kyle Moffett <mrmacman_g4@mac.com>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Pavel Machek <pavel@ucw.cz> writes:

[snip]

>> why do you say that neither would work for the "lets hibernate my 
>> notebook" case?

> Both would work. One would eat 8-64MB of your RAM, permanently;

As I have stated in other messages, the kdump approach would not waste
any RAM permanently.  The reason that kdump must reserve memory at boot
is that on panic, it cannot attempt to nicely stop drivers, and
consequently there might be ongoing DMAs that could clobber anything but
the reserved area; this reason does not apply to hibernate, though.
I'll quote a previous message in which I stated a solution that can be
used:

Immediately before jumping to the new kernel, the first X bytes (where X
is the amount of memory the new kernel will get, typically 16MB or 64MB)
of physical memory are backed up into the arbitrary discontiguous pages
that are made available.  This will not take very long, because copying
even 64MB of memory is extremely fast.  Then the new kernel is free to
use the first X bytes of contiguous physical memory.  Problem solved.

-- 
Jeremy Maitin-Shepard
