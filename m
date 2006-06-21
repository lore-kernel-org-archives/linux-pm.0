From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 21 Jun 2006 14:21:20 -0700
Message-ID: <200606211421.20402.david-b@pacbell.net>
References: <20060614103404.GC28536@elf.ucw.cz>
	<1150862396.12507.103.camel@localhost.localdomain>
	<Pine.LNX.4.64.0606202109410.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606202109410.5498@g5.osdl.org>
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
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Tuesday 20 June 2006 9:22 pm, Linus Torvalds wrote:
> =

> =

> Let's cut right to the chase:
>  - I think "image save" is snapshotting
>  - I think snapshotting is well-defined (and possibly useful) without any =

>    suspend activity what-so-ever.
>  - I think that anybody who confuses and mixes the two is (a) missing the =

>    real potential of snapshotting, but even more importantly (b) making i=
t =

>    much more complex by having the wrong mental model.

Preaching to the choir here.  Snapshotting gets interest on the low end
as a way to accelerate system startup, and on the high end as a way to
enable checkpoint+failover as a high-availability tool.  (Don't restart
that month-long simulation run the day before completion; just restore
the last checkpoint before the backhoe powered down that part of the city.)

So a snapshot mechanism that decouples from swsusp would be a Good Thing.

- Dave


> Mental models are supremely important. Often you can say that they don't =

> actually matter, because the end result should be the same, but the fact =

> is, they have a huge impact on _how_ people think, and on how you get to =

> the end result. =
