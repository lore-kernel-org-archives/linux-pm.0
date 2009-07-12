From: Celejar <celejar@gmail.com>
Subject: Re: suspend to disk now broken
Date: Sun, 12 Jul 2009 16:26:35 -0400
Message-ID: <20090712162635.0e451001.celejar__13648.0764057071$1247499089$gmane$org@gmail.com>
References: <20090712151947.25446ceb.celejar@gmail.com>
	<200907122219.53116.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200907122219.53116.rjw@sisk.pl>
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

On Sun, 12 Jul 2009 22:19:52 +0200
"Rafael J. Wysocki" <rjw@sisk.pl> wrote:

> On Sunday 12 July 2009, Celejar wrote:
> > Hi,
> > 
> > A recent change to the kernel has apparently broken suspend to disk on
> > my machine.  It still works fine in 2.6.30.1, but hangs during the
> > 'devices' phase of suspension with 2.6.31-rc2.  [I originally saw the

...

> Do you use s2disk or 'echo disk > /sys/power/state'?

First 'hibernate', then 's2disk', and finally 'echo ...' :)  None work.

Celejar
--
mailmin.sourceforge.net - remote access via secure (OpenPGP) email
ssuds.sourceforge.net - A Simple Sudoku Solver and Generator
