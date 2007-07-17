From: Matthew Garrett <mjg59@srcf.ucam.org>
Subject: Re: Hibernation considerations
Date: Tue, 17 Jul 2007 11:42:33 +0100
Message-ID: <20070717104231.GA32486__370.932676787739$1184669078$gmane$org@srcf.ucam.org>
References: <200707151433.34625.rjw@sisk.pl> <200707161406.28539.rjw@sisk.pl>
	<20070716123849.GC14212@grifter.jdc.home>
	<200707161729.16440.rjw@sisk.pl>
	<Pine.LNX.4.64.0707162119500.19248@asgard.lang.hm>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0707162119500.19248@asgard.lang.hm>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: david@lang.hm
Cc: Jim Crilly <jim@why.dont.jablowme.net>, LKML <linux-kernel@vger.kernel.org>, Kyle Moffett <mrmacman_g4@mac.com>, Al Boldi <a1426z@gawab.com>, "Eric W. Biederman" <ebiederm@xmission.com>, Pavel Machek <pavel@ucw.cz>, "Huang, Ying" <ying.huang@intel.com>, Andrew Morton <akpm@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>, Jeremy Maitin-Shepard <jbms@cmu.edu>
List-Id: linux-pm@vger.kernel.org

On Mon, Jul 16, 2007 at 09:28:13PM -0700, david@lang.hm wrote:

> why would the type of hibernate that I'm talking about (power off, not S4 
> mode) not work on a box that has ACPI?

Powering off rather than using S4 means you lose most wakeup device 
support. That would be a functional regression compared to the current 
code.

-- 
Matthew Garrett | mjg59@srcf.ucam.org
