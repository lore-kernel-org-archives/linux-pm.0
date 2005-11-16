From: Greg KH <greg@kroah.com>
Subject: Re: [RFC] userland swsusp
Date: Wed, 16 Nov 2005 14:10:47 -0800
Message-ID: <20051116221047.GA12830@kroah.com>
References: <F760B14C9561B941B89469F59BA3A8470BDD12EB@orsmsx401.amr.corp.intel.com>
	<20051116164429.GA5630@kroah.com>
	<1132172445.25230.73.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============17398150228656917=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1132172445.25230.73.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <ncunningham@cyclades.com>
Cc: Pavel Machek <pavel@ucw.cz>, Dave Jones <DaveJ@redhat.com>, Linux-pm mailing list <linux-pm@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============17398150228656917==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Nov 17, 2005 at 07:20:45AM +1100, Nigel Cunningham wrote:
> 
> I've also split the one patch that most people see into what is
> currently about 225 smaller patches, each adding only one small part, am
> writing descriptions for them all and am preparing to build a git tree
> from it.

That's great, I didn't know you were doing this.

I'd recommend using quilt instead of git for something like this,
because the odds that you will need to change something in patch number
132 out of 225 is pretty good :)

thanks,

greg k-h

--===============17398150228656917==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============17398150228656917==--
