From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: Re: Async suspend-resume patch w/ completions (was: Re:
	Async	suspend-resume patch w/ rwsems)
Date: Sat, 19 Dec 2009 18:45:04 -0800
Message-ID: <20091220024503.GD4073__34934.0307097465$1261277169$gmane$org@core.coreip.homeip.net>
References: <Pine.LNX.4.44L0.0912091729530.2672-100000@iolanthe.rowland.org>
	<200912200040.18944.rjw@sisk.pl>
	<alpine.LFD.2.00.0912191542570.3712@localhost.localdomain>
	<200912200053.45988.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200912200053.45988.rjw@sisk.pl>
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
Cc: LKML <linux-kernel@vger.kernel.org>, ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linus Torvalds <torvalds@linux-foundation.org>, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Sun, Dec 20, 2009 at 12:53:45AM +0100, Rafael J. Wysocki wrote:
> On Sunday 20 December 2009, Linus Torvalds wrote:
> > 
> > If it isn't, don't do that then. But we actually have no real 
> > reason to believe that it would be problematic, at least on a PC where the 
> > actual logic is on the SB (presumably behind the LPC controller).
> > 
> > Why would it be?
> 
> The embedded controller may depend on it.
>

No, not really depend but rather wierd things may happen if you
accessing both. Witness regressions where touching embedded controller
makes us lose data from touchpad, I think you are CCed on that bug.

-- 
Dmitry
