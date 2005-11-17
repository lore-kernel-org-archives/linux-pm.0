From: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [RFC] userland swsusp
Date: Thu, 17 Nov 2005 08:14:22 +0100
Message-ID: <1132211663.2840.3.camel@laptopd505.fenrus.org>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	<20051116164429.GA5630@kroah.com> <1132172445.25230.73.camel@localhost>
	<20051116221047.GA12830@kroah.com>
	<1132176329.25230.125.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============77703551688527961=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1132176329.25230.125.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: ncunningham@cyclades.com
Cc: Pavel Machek <pavel@ucw.cz>, Dave Jones <DaveJ@redhat.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============77703551688527961==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-11-17 at 08:25 +1100, Nigel Cunningham wrote:
> Hi.
> 
> On Thu, 2005-11-17 at 09:10, Greg KH wrote:
> > On Thu, Nov 17, 2005 at 07:20:45AM +1100, Nigel Cunningham wrote:
> > > 
> > > I've also split the one patch that most people see into what is
> > > currently about 225 smaller patches, each adding only one small part, am
> > > writing descriptions for them all and am preparing to build a git tree
> > > from it.
> > 
> > That's great, I didn't know you were doing this.
> > 
> > I'd recommend using quilt instead of git for something like this,
> > because the odds that you will need to change something in patch number
> > 132 out of 225 is pretty good :)
> 
> Yeah. :) I actually wrote my own 'makepatch' script long before I ever
> heard of quilt, and am still using that. It lets me do the same sort of
> thing. Unfortunately I tend to accumulate further changes at the end of
> the series and then have to shift them back into the right place. It
> would be nice to be able to automate that :)

patch-utils have a 'movepatch' option... which flips 2 patches in order,
even when they overlap.



--===============77703551688527961==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============77703551688527961==--
