From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: [RFC] Driver States
Date: Tue, 5 Apr 2005 11:24:23 +0200
Message-ID: <20050405092423.GA7254@elf.ucw.cz>
References: <1111963367.3503.152.camel@localhost.localdomain>
	<Pine.LNX.4.50.0503292155120.26543-100000@monsoon.he.net>
	<1112222717.3503.213.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============82423570005070412=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1112222717.3503.213.camel@localhost.localdomain>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Adam Belay <abelay@novell.com>
Cc: linux-pm@lists.osdl.org, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============82423570005070412==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > You have a few things here that can easily conflict, and that will be
> > developed at different paces. I like the direction that it's going, but
> > how do you intend to do it gradually. I.e. what to do first?
> 
> I think the first step would be for us to all agree on a design, whether
> it be this one or another, so we can began planning for long term
> changes.
> 
> My arguments for these changes are as follows:

0. I do not see how to gradually roll this in.

>      4. Having responsibilities at each driver level encourages a
>         layered and object based design, reducing code duplication and
>         complexity.

Unfortunately, you'll be retrofiting this to existing drivers. AFAICS,
trying to force existing driver to "layered and object based design"
can only result in mess.
								Pavel
-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!

--===============82423570005070412==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============82423570005070412==--
