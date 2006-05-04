From: "Randy.Dunlap" <rdunlap@xenotime.net>
Subject: Re: __releases and __acquires macros in compiler.h
Date: Wed, 3 May 2006 23:09:50 -0700
Message-ID: <20060503230950.470befb6.rdunlap@xenotime.net>
References: <380D9721A8E2114485644D71E87C6AB201CCBC5A@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8853810179695496=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <380D9721A8E2114485644D71E87C6AB201CCBC5A@PNE-HJN-MBX01.wipro.com>
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

--===============8853810179695496==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu, 4 May 2006 11:29:23 +0530 rasmit.ranjan@wipro.com wrote:

> 
> Thanks Randy. Can you please explain it elaboraly.
> What I mean, is why this sparse static checker is used and is there any
> toll to use it ?

The tool to use it is called 'sparse'.  You can get it from its
git repository (you can view it here:
http://www.kernel.org/git/?p=linux/kernel/git/torvalds/sparse.git;a=summary ).
Or you can download daily tarball snapshots of it from:
http://www.codemonkey.org.uk/projects/git-snapshots/sparse/

As far as explaining and using it, you'll just need to look at
kernel source code and this email from Linus:
http://marc.theaimsgroup.com/?l=linux-sparse&m=109865107109043&w=2


> Thanks and regards,
> Rasmit.
> 	
> 
> > -----Original Message-----
> > From: Randy.Dunlap [mailto:rdunlap@xenotime.net]
> > Sent: Thursday, May 04, 2006 11:23 AM
> > To: Rasmit Ranjan (WT01 - Semiconductors & Consumer Electronics)
> > Cc: linux-kernel-digest@lists.us.dell.com;
> > linux-pm@lists.osdl.org; linux-usb-devel@lists.sourceforge.net
> > Subject: Re: [linux-pm] __releases and __acquires macros in compiler.h
> >
> > On Thu, 4 May 2006 11:13:20 +0530 rasmit.ranjan@wipro.com wrote:
> >
> > > Hi all,
> > >     I came across two macros __releases and __acquires defined in
> > > compiler.h.
> > > Can anyone please tell me the exact use of these two macros.
> >
> > They are for the sparse static checker to count locks
> > released and acquired, to make sure that they are balanced.
> >
> > ---
> > ~Randy
> >
> 
> 
> The information contained in this electronic message and any attachments to this message are intended for the exclusive use of the addressee(s) and may contain proprietary, confidential or privileged information. If you are not the intended recipient, you should not disseminate, distribute or copy this e-mail. Please notify the sender immediately and destroy all copies of this message and any attachments.
> 
> WARNING: Computer viruses can be transmitted via email. The recipient should check this email and any attachments for the presence of viruses. The company accepts no liability for any damage caused by any virus transmitted by this email.
> 
> www.wipro.com
> 


---
~Randy

--===============8853810179695496==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============8853810179695496==--
