From: Paul Mackerras <paulus@samba.org>
Subject: Re: Re: [PATCH] Remove process freezer from suspend to RAM
	pathway
Date: Tue, 3 Jul 2007 21:23:32 +1000
Message-ID: <18058.12724.163599.707035__7037.39448586038$1183462118$gmane$org@cargo.ozlabs.ibm.com>
References: <20070703042916.GA17240@srcf.ucam.org>
	<200707031608.06348.nigel@nigel.suspend2.net>
	<1183447184.10386.102.camel@localhost.localdomain>
	<200707030944.18702.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707030944.18702.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

Oliver Neukum writes:

> At the risk of repeating myself. Character device drivers are written
> with the assumption that normal io and suspend/resume do not race
> with each other due to the freezer.
> What do you intend to do about that?

Going back to the old powerbook sleep code, we had a two-phase
suspend: drivers got notified once when userspace is still running,
with interrupts enabled, in process context; and then a second time
with interrupts disabled and with only one CPU up, so the process
that is initiating the suspend is the only process running (since
interrupts are disabled and nothing it does can sleep, no other
process can get to run).

I still believe that is the right way to go, although we currently
only have a single-phase suspend.

Most drivers suspended their hardware in the second call.  If they are
in the middle of a conversation with their device that *has* to be
completed, they can do that by polling.  If it's a character device, a
better approach would be to set a flag or whatever in the first
suspend call to make sure that no new conversations get started with
the device, sleeping if necessary.

I'm actually having a hard time thinking of how to test your assertion
since there are so few things on a typical computer that are plain
character devices driving real hardware.  A serial port would be about
the only one; keyboards and mice (and serial ports :) are USB these
days, or ADB on older powerbooks.

Or did you mean to include drivers for pseudo-devices (e.g. ptys)?  I
don't see why they would have a suspend method at all.

Paul.
