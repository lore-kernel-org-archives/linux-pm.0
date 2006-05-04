From: <rasmit.ranjan@wipro.com>
Subject: RE: __releases and __acquires macros in compiler.h
Date: Thu, 4 May 2006 11:29:23 +0530
Message-ID: <380D9721A8E2114485644D71E87C6AB201CCBC5A@PNE-HJN-MBX01.wipro.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============51265873953463337=="
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-class: urn:content-classes:message
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: rdunlap@xenotime.net
Cc: linux-kernel-digest@lists.us.dell.com, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============51265873953463337==
Content-class: urn:content-classes:message
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8bit

Thanks Randy. Can you please explain it elaboraly.
What I mean, is why this sparse static checker is used and is there any
toll to use it ?

Thanks and regards,
Rasmit.
	 

> -----Original Message-----
> From: Randy.Dunlap [mailto:rdunlap@xenotime.net] 
> Sent: Thursday, May 04, 2006 11:23 AM
> To: Rasmit Ranjan (WT01 - Semiconductors & Consumer Electronics)
> Cc: linux-kernel-digest@lists.us.dell.com; 
> linux-pm@lists.osdl.org; linux-usb-devel@lists.sourceforge.net
> Subject: Re: [linux-pm] __releases and __acquires macros in compiler.h
> 
> On Thu, 4 May 2006 11:13:20 +0530 rasmit.ranjan@wipro.com wrote:
> 
> > Hi all,
> >     I came across two macros __releases and __acquires defined in 
> > compiler.h.
> > Can anyone please tell me the exact use of these two macros.
> 
> They are for the sparse static checker to count locks 
> released and acquired, to make sure that they are balanced.
> 
> ---
> ~Randy
> 


--===============51265873953463337==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============51265873953463337==--
