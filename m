From: Greg KH <greg@kroah.com>
Subject: Re: [RFC] userland swsusp
Date: Fri, 18 Nov 2005 13:20:32 -0800
Message-ID: <20051118212032.GA23950@kroah.com>
References: <20051115212942.GA9828@elf.ucw.cz>
	<20051115222549.GF17023@redhat.com>
	<1132342590.25914.86.camel@localhost.localdomain>
	<20051118211847.GA3881@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============16825505755326997=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051118211847.GA3881@redhat.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Dave Jones <davej@redhat.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>, Pavel Machek <pavel@ucw.cz>, kernel list <linux-kernel@vger.kernel.org>, "Rafael J. Wysocki" <rjw@sisk.pl>, Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============16825505755326997==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Nov 18, 2005 at 04:18:47PM -0500, Dave Jones wrote:
> Even if that was capable however, it still doesn't solve the problem.
> Pavel's implementation wants to write to arbitary address spaces, which is
> what we're trying to prevent. The two are at odds with each other.

I agree, he needs to find a different way to get that information into
and out of the kernel than that device node for it to be accepted into
mainline.  But for now, it's a nice way to mock up the fuctionality
needed.

thanks,

greg k-h

--===============16825505755326997==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============16825505755326997==--
