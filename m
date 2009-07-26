From: Celejar <celejar@gmail.com>
Subject: Re: suspend to disk now broken
Date: Sun, 26 Jul 2009 01:24:03 -0400
Message-ID: <20090726012403.2c4c332a.celejar__13450.7097573534$1248586000$gmane$org@gmail.com>
References: <20090712151947.25446ceb.celejar@gmail.com>
	<200907260018.03705.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200907260018.03705.rjw@sisk.pl>
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
Cc: pm list <linux-pm@lists.linux-foundation.org>, lkml <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Sun, 26 Jul 2009 00:18:03 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Sunday 12 July 2009, Celejar wrote:
> > Hi,
> > 
> > A recent change to the kernel has apparently broken suspend to disk on
> > my machine.  It still works fine in 2.6.30.1, but hangs during the
> > 'devices' phase of suspension with 2.6.31-rc2.  [I originally saw the

...

> Well, I guess it's still a problem with 2.6.31-rc4?

As we discussed earlier, the problem seems to have been resolved with
-rc3. I have just tested with -rc4, and that works fine, too.

Celejar
--
mailmin.sourceforge.net - remote access via secure (OpenPGP) email
ssuds.sourceforge.net - A Simple Sudoku Solver and Generator
