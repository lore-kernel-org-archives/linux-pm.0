From: Jay Cliburn <jacliburn@bellsouth.net>
Subject: Re: Suspend, followed by immediate resume
Date: Fri, 2 May 2008 13:10:03 -0500
Message-ID: <20080502131003.15f45b82@osprey.hogchain.net>
References: <20080501214437.0ae618c5@osprey.hogchain.net>
	<200805021859.57457.rjw@sisk.pl>
	<20080502122910.429312a7@osprey.hogchain.net>
	<200805021941.08003.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200805021941.08003.rjw@sisk.pl>
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
Cc: linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

On Fri, 2 May 2008 19:41:07 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:


> Does it suspend if you don't activate the WOL?

Yes, it suspends even if WOL is disabled.

I poked around in BIOS and changed the behavior somewhat.  There's a
BIOS setting called "Suspend Mode" with three options:

	S1 (POS) only
	S3 only
	Auto

When set to "S3 only" or "Auto," the machine spontaneously resumes
following a suspend.  When set to "S1 (POS) only" the machine stays
asleep.

What is "POS" an acronym for?  Does it make sense to leave the thing
set to "S1 only?"

Thanks for helping.
