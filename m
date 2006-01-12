From: Greg KH <greg@kroah.com>
Subject: Re: Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Date: Thu, 12 Jan 2006 14:47:34 -0800
Message-ID: <20060112224734.GA18244@kroah.com>
References: <200601122241.07363.rjw@sisk.pl>
	<20060112220940.GA10088@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============98341907649106131=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060112220940.GA10088@elf.ucw.cz>
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
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

--===============98341907649106131==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jan 12, 2006 at 11:09:40PM +0100, Pavel Machek wrote:
> > +commands defined in kernel/power/power.h.  The major and minor
> > +numbers of the device are, respectively, 10 and 231, and they can
> > +be read from /sys/class/misc/snapshot/dev.
> 
> Is this still true?

Yes, the driver core adds that "automagically" for you so tools like
udev know how to create the proper device node.

thanks,

greg k-h

--===============98341907649106131==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============98341907649106131==--
