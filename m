From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: xHCI and suspend/resume
Date: Tue, 17 May 2011 23:54:22 +0200
Message-ID: <201105172354.22675.rjw__19935.5198223659$1305669427$gmane$org@sisk.pl>
References: <Pine.LNX.4.44L0.1105121733370.1917-100000@iolanthe.rowland.org>
	<201105172343.19074.rjw@sisk.pl>
	<BANLkTikqyX8vS+xsQfM8d=oqvCqF82Wj=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <BANLkTikqyX8vS+xsQfM8d=oqvCqF82Wj=A@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Dwight Schauer <dschauer@gmail.com>
Cc: Sarah Sharp <sarah.a.sharp@linux.intel.com>, dschauer@ti.com, linux-pm@lists.linux-foundation.org, USB list <linux-usb@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tuesday, May 17, 2011, Dwight Schauer wrote:
> On Tue, May 17, 2011 at 4:43 PM, Rafael J. Wysocki <rjw@sisk.pl> wrote:
...
> >
> > OK, one more test, please.
> >
> > Try to do
> >
> > # echo core > /sys/power/pm_test
> > # echo mem > /sys/power/state
> >
> > (that should simulate suspend, but without going into the BIOS, and it
> > should return do the command prompt after 5-10 sec.) and check if the
> > USB3 controllers work after that ("echo none > /sys/power/pm_test" resets
> > to the normal suspend behavior).
> >
> > Thanks,
> > Rafael
> 
> No problem.
> 
> The simulated suspend works fine.

Good.

> Also, waking up from S3 via a PS/2 keyboard works fine.

Hmm.  Do you mean that the USB3 controllers work after the resume if
the box has been woken up via the keyboard and they don't work when it
has been woken up via a power button?

Rafael
