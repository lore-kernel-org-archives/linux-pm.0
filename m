From: Greg KH <greg@kroah.com>
Subject: Re: [RFC] userland swsusp
Date: Tue, 15 Nov 2005 13:32:29 -0800
Message-ID: <20051115213229.GB11776@kroah.com>
References: <20051115212942.GA9828@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============094566189762796071=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20051115212942.GA9828@elf.ucw.cz>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>, kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============094566189762796071==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 15, 2005 at 10:29:42PM +0100, Pavel Machek wrote:
> Hi!
> 
> This is prototype of userland swsusp. I'd like kernel parts to go in,
> probably for 2.6.16. Now, I'm not sure about the interface, ioctls are
> slightly ugly, OTOH it would be probably overkill to introduce
> syscalls just for this. (I'll need to add an ioctl for freeing memory
> in future).

What's wrong with 4 new syscalls?  It seems the cleanest way.

thanks,

greg k-h

--===============094566189762796071==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============094566189762796071==--
