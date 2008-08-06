From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: Software Suspend status in latest GIT?
Date: Wed, 6 Aug 2008 14:35:54 +0200
Message-ID: <200808061435.55421.rjw@sisk.pl>
References: <Pine.LNX.4.64.0808051552401.4955@hp9800.localdomain>
	<200808060114.31881.rjw@sisk.pl>
	<Pine.LNX.4.64.0808051653440.7367@hp9800.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0808051653440.7367@hp9800.localdomain>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Kenneth Crudup <kenny@panix.com>
Cc: pavel@suse.cz, pm list <linux-pm@lists.linux-foundation.org>
List-Id: linux-pm@vger.kernel.org

On Wednesday, 6 of August 2008, Kenneth Crudup wrote:
> 
> On Wed, 6 Aug 2008, Rafael J. Wysocki wrote:
> 
> > They all are 64-bit.  Except from this, they are quite different.
> > http://www.sisk.pl/kernel/debug/mainline/2.6.27-rc1-git6-dirty/M3A32-MVP-config
> 
> Thanks for that.
> 
> I'd made the only obvious change I could see differently (I'd specified a
> resume-to swap partition explicitly) but that had no effect.
> 
> Essentially what happens is I begin the suspend (very generically, by
> writing "disk" to /sys/power/state), and it appears to start, but hangs
> up. I have my syslog also redirected to tty12, and if I switch over to
> that, I see:
> 
> ----
> Aug  5 16:35:49 hp9800 kernel: [   71.049504] PM: Marking nosave pages: 000000000009f000 - 0000000000100000
> Aug  5 16:35:49 hp9800 kernel: [   71.049508] PM: Marking nosave pages: 00000000bfed0000 - 0000000100000000
> Aug  5 16:35:49 hp9800 kernel: [   71.054734] PM: Basic memory bitmaps created
> ---
> 
> ... then it just hangs, no apparent disk activity. All of a sudden
> (~20 sec(?) later), a series of errors spit out from syslog, mostly related
> to trying to write to the disk, then I get a large number when it tries
> to remount/access my root (XFS) which fails due to I/O errors.
> Unfortunately these can't be saved and scrolling up the screen won't
> work (there's too much output anyway).
> 
> One guess is that the suspend is stopping my hard drive (/dev/sda, SATA
> on the AHCI driver) and therefore nothing can continue. I wish I had
> more, but I'd have to find another box and see if that "serial console
> on USB" stuff actually works.
> 
> So, based on *that* nearly-as-useless bug report, anything else I could
> try? This config works mostly w/o molestation on 2.6.26 generic (and with
> the TuxOnIce version, as well). I've attached both .config files, just
> in case.

Can you try with the patch from
http://bugzilla.kernel.org/show_bug.cgi?id=11178#c10
please?

Rafael
