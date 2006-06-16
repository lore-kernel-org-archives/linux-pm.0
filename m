From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 16 Jun 2006 07:04:33 -0700
Message-ID: <200606160704.34093.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<200606150957.42449.david-b@pacbell.net>
	<20060615180350.GG23859@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060615180350.GG23859@elf.ucw.cz>
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
To: Pavel Machek <pavel@ucw.cz>
Cc: Linus Torvalds <torvalds@osdl.org>, linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

On Thursday 15 June 2006 11:03 am, Pavel Machek wrote:

> > =

> > In this case, DMA only would need to be prevented during the actual
> > construction of the snapshot -- which is AFTER that "prepare to
> > suspend" phase, notice! -- so your straw-man doesn't apply.
> =

> Okay, you _can_ do =

> =

> suspend whole tree but disk and video
> freeze disk and video
> create snapshot
> unfreeze disk and video
> write snapshot
> powerdown
> =

> Question is: looks to me like quite a lot of complexity for very
> little gain, but...

It's not so different from what Linus has been sketching, except
for the actual turn-off-DMA step.  (Needed because you want to get
an atomic snapshot.)  In terms of $SUBJECT the gain is that you
actually get a debuggable suspend sequence.
