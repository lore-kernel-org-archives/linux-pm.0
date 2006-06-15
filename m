From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Thu, 15 Jun 2006 09:57:41 -0700
Message-ID: <200606150957.42449.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606141846.55839.david-b@pacbell.net>
	<20060615084153.GC9423@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060615084153.GC9423@elf.ucw.cz>
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
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thursday 15 June 2006 1:41 am, Pavel Machek wrote:
> On St 14-06-06 18:46:55, David Brownell wrote:
> > On Wednesday 14 June 2006 4:57 pm, Pavel Machek wrote:
> > =

> > > My point is that you really want the console enabled in writing phase
> > > of suspend-to-disk. =

> > =

> > Notice how nicely this generalizes a point that's been made before:
> > Linux should have the ability to exclude certain devices (and their
> > parents) from that first "prepare to suspend" phase.  Originally the
> =

> No, it does not. If your console needs DMA, you _need_ to stop it. If
> it can work without, you want to keep it enabled.
> =

> This has less to do with device types and trees and more to do with
> DMA or not.

Certainly there are details that need to be worked out, that's the
whole point of fixing some of these console+suspend problems.  And
DMA is one of them.

In this case, DMA only would need to be prevented during the actual
construction of the snapshot -- which is AFTER that "prepare to
suspend" phase, notice! -- so your straw-man doesn't apply.

- Dave
