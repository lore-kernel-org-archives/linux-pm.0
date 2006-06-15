From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 14 Jun 2006 18:46:55 -0700
Message-ID: <200606141846.55839.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<Pine.LNX.4.64.0606141557100.5498@g5.osdl.org>
	<20060614235713.GA24859@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060614235713.GA24859@elf.ucw.cz>
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
To: linux-pm@lists.osdl.org
Cc: Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wednesday 14 June 2006 4:57 pm, Pavel Machek wrote:

> My point is that you really want the console enabled in writing phase
> of suspend-to-disk. =


Notice how nicely this generalizes a point that's been made before:
Linux should have the ability to exclude certain devices (and their
parents) from that first "prepare to suspend" phase.  Originally the
canonical example was the swap device (and its disk, controller, bus
tree, etc).  Now we recognize consoles (and their parents, network
controllers, etc) have the same issue ...

Of course using such a mechanism would call for a bit of rework in
swsusp and str code, as well as implementing that exclusion mechanism.

- Dave
