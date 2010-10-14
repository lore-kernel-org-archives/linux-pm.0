From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] input: syfs switches for SKE keypad
Date: Thu, 14 Oct 2010 09:50:07 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.1010140946030.1645-100000__24543.079318437$1287064275$gmane$org@iolanthe.rowland.org>
References: <201010132226.02933.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201010132226.02933.rjw@sisk.pl>
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
Cc: "samu.p.onkalo@nokia.com" <samu.p.onkalo@nokia.com>, Mark Brown <broonie@opensource.wolfsonmicro.com>, Linus WALLEIJ <linus.walleij@stericsson.com>, Naveen Kumar GADDIPATI <naveen.gaddipati@stericsson.com>, Dmitry Torokhov <dmitry.torokhov@gmail.com>, "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>, linux-pm@lists.linux-foundation.org, Jayeeta BANDYOPADHYAY <jayeeta.banerjee@stericsson.com>, Sundar R IYER <sundar.iyer@stericsson.com>
List-Id: linux-pm@vger.kernel.org

On Wed, 13 Oct 2010, Rafael J. Wysocki wrote:

> On Wednesday, October 13, 2010, Sundar wrote:
> > On Wed, Oct 13, 2010 at 11:12 PM, Sundar <sunder.svit@gmail.com> wrote:
> > > On Wed, Oct 13, 2010 at 11:07 PM, Alan Stern <stern@rowland.harvard.edu> wrote:
> > >>
> > >> Sorry, I don't quite understand your question.  I think it would be
> > >> okay to add an interface for userspace to cut short a runtime-suspend
> > >> delay, but I don't think anything more is needed.
> 
> I'm not 100% sure how that interface is supposed to work.  Can you elaborate
> a bit, please?

There could be a new attribute file, or we could use a blank line
written to autosuspend_delay_ms for this purpose.  Either way, the
result would be to call pm_runtime_suspend.  If the device is idle,
merely awaiting the timer expiration for a scheduled suspend or
autosuspend, this would cause it to suspend immediately.

Alan Stern
