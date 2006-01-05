From: Greg KH <greg@kroah.com>
Subject: Re: [RFC/RFT][PATCH -mm 2/5] swsusp: userland interface
	(rev. 2)
Date: Thu, 5 Jan 2006 15:45:28 -0800
Message-ID: <20060105234528.GA28365@kroah.com>
References: <200601042340.42118.rjw@sisk.pl> <20060105001837.GA1751@elf.ucw.cz>
	<20060105002619.GA16714@kroah.com> <200601060034.53707.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============73925325538060749=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200601060034.53707.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============73925325538060749==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jan 06, 2006 at 12:34:52AM +0100, Rafael J. Wysocki wrote:
> > Ok, then I'd recommend using the misc device, dynamic for now, and
> > reserve one when you get a bit closer to merging into mainline.
> 
> Do you mean something like in the appended patch?

Yes, that looks good to me.

thanks,

greg k-h

--===============73925325538060749==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============73925325538060749==--
