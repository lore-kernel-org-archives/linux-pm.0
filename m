From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Suspend hangs since 2.6.34
Date: Wed, 23 Jun 2010 23:22:57 +0200
Message-ID: <201006232322.57834.rjw__47967.5617105842$1277328549$gmane$org@sisk.pl>
References: <20100621213224.GA5723@mac.home>
	<Pine.LNX.4.44L0.1006211828090.1687-100000@iolanthe.rowland.org>
	<20100623203234.GA20913@mac.home>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <20100623203234.GA20913@mac.home>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Tino Keitel <tino.keitel@tikei.de>
Cc: Linux-pm mailing list <linux-pm@lists.linux-foundation.org>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

On Wednesday, June 23, 2010, Tino Keitel wrote:
> On Mon, Jun 21, 2010 at 18:31:57 -0400, Alan Stern wrote:
> 
> [...]
> 
> > Why does this look like a USB problem?  As far as I can tell, the bug 
> > is that the system delays somewhere during the suspend procedure.  But 
> > there's no reason to think the delay is connected with USB.
> 
> Breaking news: I just got the same hang when switching from X to the
> console, so I gues that this bug has nothing to to with suspend, but
> was just triggered by the switch to the console before suspend. I guess
> I have to ask the intel-gfx folks.

Or the tty folks.

Rafael
