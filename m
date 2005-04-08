From: Pavel Machek <pavel@suse.cz>
Subject: Re: Re: [RFC] Driver States
Date: Fri, 8 Apr 2005 12:31:42 +0200
Message-ID: <20050408103142.GC1392@elf.ucw.cz>
References: <1111963367.3503.152.camel@localhost.localdomain>
	<Pine.LNX.4.50.0503292155120.26543-100000@monsoon.he.net>
	<1112222717.3503.213.camel@localhost.localdomain>
	<20050405092423.GA7254@elf.ucw.cz>
	<1112817072.8517.15.camel@linux.site>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============59739751662385343=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1112817072.8517.15.camel@linux.site>
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
Cc: linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>, linux-kernel@vger.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============59739751662385343==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi!

> > > > You have a few things here that can easily conflict, and that will be
> > > > developed at different paces. I like the direction that it's going, but
> > > > how do you intend to do it gradually. I.e. what to do first?
> > > 
> > > I think the first step would be for us to all agree on a design, whether
> > > it be this one or another, so we can began planning for long term
> > > changes.
> > > 
> > > My arguments for these changes are as follows:
> > 
> > 0. I do not see how to gradually roll this in.
> > 
> > >      4. Having responsibilities at each driver level encourages a
> > >         layered and object based design, reducing code duplication and
> > >         complexity.
> > 
> > Unfortunately, you'll be retrofiting this to existing drivers. AFAICS,
> > trying to force existing driver to "layered and object based design"
> > can only result in mess.
> > 								Pavel
> 
> Fair enough.  How does this sound?  I'd like to add "*attach" and
> "*detach" to "struct device_driver".  These functions would act as one
> time initializers and decontructors.  Then we could rename "*probe" to
> "*start", and "*remove" to "*stop", which should be rather trivial to

I do not think you'll find rename across all the drivers easy. You
could get away with "I create start, and if it does not exist, probe
is called instead", but you need pretty good justification for that, too.

								Pavel
-- 
Boycott Kodak -- for their patent abuse against Java.

--===============59739751662385343==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============59739751662385343==--
