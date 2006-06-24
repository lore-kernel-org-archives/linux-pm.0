From: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Fri, 23 Jun 2006 20:28:22 -0700
Message-ID: <200606232028.22618.david-b@pacbell.net>
References: <Pine.LNX.4.44L0.0606211219170.6700-100000@iolanthe.rowland.org>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<1151106818.16946.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1151106818.16946.19.camel@localhost.localdomain>
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
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-pm@lists.osdl.org, Linus Torvalds <torvalds@osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Friday 23 June 2006 4:53 pm, Benjamin Herrenschmidt wrote:
> =

> I've very rarely seen drivers trying to do _anything_ to work around STD
> specific issues. I think Pavel and David are right there... suspend() is
> mostly written for STR and that way happens to work with STD...

I don't think I've used those words ... :)

The PRETHAW patches (which I'll forward for MM after I retest against
the latest GIT tree) are proof that the suspend-to-disk resume paths
actually **DON'T** just happen to work in all cases.  Which does pretty
much show that the STD stuff (FREEZE etc) was an afterthought.

- Dave
