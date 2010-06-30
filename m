From: Florian Mickler <florian@mickler.org>
Subject: Re: [update] Re: [PATCH] PM: Make it possible to avoid
 wakeup events from being lost
Date: Wed, 30 Jun 2010 09:10:38 +0200
Message-ID: <20100630091038.6af2a53b__23462.5699733899$1277881951$gmane$org@schatten.dmk.lab>
References: <Pine.LNX.4.44L0.1006281006360.1977-100000@iolanthe.rowland.org>
	<201006282101.54041.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <201006282101.54041.rjw@sisk.pl>
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
Cc: mark gross <640e9920@gmail.com>, Neil Brown <neilb@suse.de>, linux-pci@vger.kernel.org, Dmitry Torokhov <dmitry.torokhov@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Arve@smtp1.linux-foundation.org, Jesse Barnes <jbarnes@virtuousgeek.org>, linux-pm@lists.linux-foundation.org
List-Id: linux-pm@vger.kernel.org

Hi Rafael!

On Mon, 28 Jun 2010 21:01:53 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Monday, June 28, 2010, Alan Stern wrote:
> > On Mon, 28 Jun 2010, Rafael J. Wysocki wrote:

> From: Rafael J. Wysocki <rjw@sisk.pl>
> Subject: PM: Make it possible to avoid wakeup events from being lost

I have nothing substantial to add, but just wanted to let you know that
this approach seems like a good alternative to me. As far as I can see
the userspace suspend-blocker interface could be expressed in terms of
this kernel facility which brings android closer to mainline.

The only thing I haven't thought through yet is the 'maintain a discrete
set of constraints' vs 'just increment a number' thing. Especially if
what we loose in information through that (in comparison to 'the other
approach') is made up for by easier in-kernel-API.  I _think_ if there
is any need for in-kernel-accounting (i don't know that) it could be
retro-fitted by using the trace event infrastructure?

Cheers,
Flo
