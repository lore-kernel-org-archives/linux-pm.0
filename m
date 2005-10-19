From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: 2.6.14-rc4-mm1: USB suspend regression
Date: Wed, 19 Oct 2005 12:03:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0510191156520.5049-100000@iolanthe.rowland.org>
References: <43565DCF.5020404@rtr.ca>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============80672986297218374=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <43565DCF.5020404@rtr.ca>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Mark Lord <lkml@rtr.ca>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============80672986297218374==
Content-Type: TEXT/PLAIN; charset=US-ASCII

[Trimmed the CC: list]

On Wed, 19 Oct 2005, Mark Lord wrote:

> None of the recent kernels can resume-from-ram reliably for me
> if I use CONFIG_USB_SUSPEND (set).   But with that option UNset,
> suspend/resume to/from RAM works very well.

Try applying this patch:

http://marc.theaimsgroup.com/?l=linux-kernel&m=112966405019175&w=2

It may very well help the CONFIG_USB_SUSPEND problem.  If it doesn't, 
please turn on CONFIG_USB_DEBUG and post the dmesg log for the suspend and 
resume.

> BUT.. new in 2.6.14-rc*, is that the ehci_hcd USB hispeed driver
> no longer survives resume from ram.  I have to unload/reload the
> module to get hispeed USB after resume.

Well, on my machine it works with resume from Standby.  (Resume from RAM 
doesn't work at all -- pushing the power button to start the resume causes 
a clean shutdown instead!)

Your dmesg log might provide some useful information here as well.  But if
it's a serious problem you'll have to get Dave Brownell to help.

Alan Stern


--===============80672986297218374==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============80672986297218374==--
