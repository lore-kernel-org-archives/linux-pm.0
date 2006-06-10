From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Remote wake up not working
Date: Sat, 10 Jun 2006 13:28:32 +0000
Message-ID: <20060610132832.GB4547@ucw.cz>
References: <380D9721A8E2114485644D71E87C6AB201FD8476@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <380D9721A8E2114485644D71E87C6AB201FD8476@PNE-HJN-MBX01.wipro.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rasmit.ranjan@wipro.com
Cc: linux-kernel-digest@lists.us.dell.com, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

Hi!

>     I am using ACER Aspire 3003LC laptop. Linux version: 2.6.15.4. I my
> Host Controller supports Power Management.I tried selective
> suspend/resume and it worked properly.Also my Host Controller supports
> remote wake up. So i tried testing remote wake up.But it did not
> work.Then i tried the same with the standard ( OHCI controller of my
> laptop ).It did not work as wel. =

> Then i changed my laptop and tried testing remote wakeup and it worked
> properly with the OHCI controller and also with my Host Controller. =

>  =

> So does this mean that there is something wrong with the ACER Aspire
> 3003LC laptop ? =

> Or is there something on which remote wake up depends on besides the
> Host Controller and the device ( supporting remote wake up ) ?

I do not think we support remote wakeup these days. Code may be there,
but as noone ever uses it... perhaps it needs some fixing.

-- =

Thanks for all the (sleeping) penguins.
