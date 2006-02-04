From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Re: [RFC][PATCH -mm][Experimental] swsusp: freeze
	userspace processes first
Date: Sat, 4 Feb 2006 22:47:19 +0100
Message-ID: <200602042247.20143.rjw@sisk.pl>
References: <200602010141.53974.rjw@sisk.pl> <200602021932.21629.rjw@sisk.pl>
	<20060204212643.GJ3909@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060204212643.GJ3909@elf.ucw.cz>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@suse.cz>
Cc: Nigel Cunningham <nigel@suspend2.net>, Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

Hi,

On Saturday 04 February 2006 22:26, Pavel Machek wrote:
> > > > That requires a timeout in case we have a user mode helper in the D state.
> > > > The corrected patch is appended.
> > > > 
> > > > BTW, it contains a change that may help solve the unfreezeable gcc problem
> > > > that has appeared in your tests.  Could you please try it or tell me what I
> > > > should do to reproduce the problem?
> > > 
> > > I'm away from real macine just now... I could reproduce it with
> > > Nigel's "stress ..." command, then trying to build kernel.
> > 
> > OK, I did the following:
> > 1) run "swapoff -a"
> > 2) run kernel make on one vt,
> > 3) run "stress -d 5 --hdd-bytes 100M -i 5 -c 5" on another vt,
> > 4) run "for f in 1 2 3 4 5 6 7 8 9 10; do echo disk > /sys/power/state ; sleep 5; done" on the 3rd vt.
> > 
> > Appended is the version of the patch that has freezed processes in 10 attempts
> > out of 10 (please note the "if (!freezing(p))" in freeze_process() ;-)).
> > 
> > Still freezing the userspace processes may take more that 15 secs under such
> > a load on my box, so the timeout is set to 20 sec (probably overkill for any
> > sane real-life situation).
> 
> You have my ACK on freezer parts, but please reserve usermode helper
> parts for separate patch.

OK, I'll remove the usermodehelper-related part for now.  If we have a test
case, I'll think of it again.

> Is there simple way to demonstrate usermode helper problem?

Not that I know of.  Probably I am overly paranoid wrt that.

Greetings,
Rafael
