From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH 7/9] PM / Runtime: Add generic
	clock	manipulation rountines for runtime PM
Date: Tue, 19 Apr 2011 11:58:38 +0100
Message-ID: <20110419105836.GG9462__28574.9191920788$1303210944$gmane$org@sirena.org.uk>
References: <201104130205.26988.rjw@sisk.pl> <201104170135.19388.rjw@sisk.pl>
	<201104170142.10723.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <201104170142.10723.rjw@sisk.pl>
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
Cc: Grant Likely <grant.likely@secretlab.ca>, Linux PM mailing list <linux-pm@lists.linux-foundation.org>, Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>, linux-sh@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Sun, Apr 17, 2011 at 01:42:10AM +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Many different platforms and subsystems may want to disable device
> clocks during suspend and enable them during resume which is going to
> be done in a very similar way in all those cases.  For this reason,
> provide generic routines for the manipulation of device clocks during
> suspend and resume.

> Convert the ARM shmobile platform to using the new routines.

I've had similar thoughts with respect to the regulator API - I'd been
thinking of dealing with this by adding a notifier which subsystems
could build upon, in much the same way as already exists for the system
ssuspend and resume events.
