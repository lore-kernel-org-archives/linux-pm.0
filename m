From: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [RFC/RFT][PATCH -mm] swsusp: userland interface
Date: Fri, 13 Jan 2006 21:49:38 +0100
Message-ID: <200601132149.39159.rjw@sisk.pl>
References: <200601122241.07363.rjw@sisk.pl> <200601130031.34624.rjw@sisk.pl>
	<200601132053.43085.ioe-lkml@rameria.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============88416459411243009=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200601132053.43085.ioe-lkml@rameria.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Ingo Oeser <ioe-lkml@rameria.de>
Cc: Linux PM <linux-pm@osdl.org>, linux-kernel@vger.kernel.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============88416459411243009==
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

On Friday, 13 January 2006 20:53, Ingo Oeser wrote:
> On Friday 13 January 2006 00:31, Rafael J. Wysocki wrote:
> > On Thursday, 12 January 2006 23:09, Pavel Machek wrote:
> > > > +SNAPSHOT_IOCAVAIL_SWAP - check the amount of available swap (the last argument
> > > > +	should be a pointer to an unsigned int variable that will contain
> > > > +	the result if the call is successful)
> > > 
> > > Is this good idea? It will overflow on 32-bit systems. Ammount of
> > > available swap can be >4GB. [Or maybe it is in something else than
> > > bytes, then you need to specify it.]
> > 
> > It returns the number of pages.  Well, it should be written explicitly,
> > so I'll fix that.
> 
> Please always talk to the kernel in bytes. Pagesize is only a kernel
> internal unit. Sth. like off64_t is fine.

These are values returned by the kernel, actually.  Of course I can convert them
to bytes before sending to the user space, if that's preferrable.

Pavel, what do you think?

Rafael

--===============88416459411243009==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============88416459411243009==--
