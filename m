From: Pavel Machek <pavel@suse.cz>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 10:41:53 +0200
Message-ID: <20060615084153.GC9423@elf.ucw.cz>
References: <20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606141557100.5498@g5.osdl.org>
	<20060614235713.GA24859@elf.ucw.cz>
	<200606141846.55839.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200606141846.55839.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On St 14-06-06 18:46:55, David Brownell wrote:
> On Wednesday 14 June 2006 4:57 pm, Pavel Machek wrote:
> =

> > My point is that you really want the console enabled in writing phase
> > of suspend-to-disk. =

> =

> Notice how nicely this generalizes a point that's been made before:
> Linux should have the ability to exclude certain devices (and their
> parents) from that first "prepare to suspend" phase.  Originally the

No, it does not. If your console needs DMA, you _need_ to stop it. If
it can work without, you want to keep it enabled.

This has less to do with device types and trees and more to do with
DMA or not.
								Pavel
-- =

(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blo=
g.html
