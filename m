From: Greg KH <greg@kroah.com>
Subject: Re: swsusp3: system suspend/resume from userspace
Date: Wed, 21 Sep 2005 05:53:22 -0700
Message-ID: <20050921125322.GA13371@kroah.com>
References: <F7DC2337C7631D4386A2DF6E8FB22B30047B8E51@hdsmsx401.amr.corp.intel.com>
	<20050901201714.GA2027@openzaurus.ucw.cz>
	<1127259699.4386.82.camel@gaston>
	<20050921101811.GC25297@atrey.karlin.mff.cuni.cz>
	<1127298751.4386.114.camel@gaston>
	<20050921124523.GB2013@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============86906464125382965=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20050921124523.GB2013@elf.ucw.cz>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, Nigel Cunningham <ncunningham@linuxmail.org>
List-Id: linux-pm@vger.kernel.org

--===============86906464125382965==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Sep 21, 2005 at 02:45:23PM +0200, Pavel Machek wrote:
> 
> swsusp3 is likely easier way to go than transforming suspend2 into
> something mergeable. [Ouch and BTW it works now :-)]

I agree.  One of the main things that people really like with suspend2
is all of the "pretty" things.  With the logic moving to userspace, we
can now implement them if we want to.  Otherwise, if we keep everything
in the kernel, there is no way we will ever get them.

And besides, it's such a cool hack!

(I saw Pavel demo it yesterday, so I can vouch for the fact that it does
work.)

thanks,

greg k-h

--===============86906464125382965==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============86906464125382965==--
