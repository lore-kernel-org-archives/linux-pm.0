From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: A reference implementation of PCI suspend/resume?
Date: Wed, 18 May 2005 14:32:35 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0505181429420.13427-100000@iolanthe.rowland.org>
References: <200505181940.09407.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============25905373156135303=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200505181940.09407.rjw@sisk.pl>
List-Unsubscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <http://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============25905373156135303==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 18 May 2005, Rafael J. Wysocki wrote:

> AFAICS, the EHCI and OHCI drivers do, but the snd_intel8x0 driver does not.
> Anyway this does not seem to be relevant, as the box hangs when the
> drivers' resume routines are called (ie on resume-during-resume).
> 
> All of the drivers that cause the problem are compiled as modules, so their
> suspend routines are not called during swsusp resume.

This looks more like a IRQ-routing kind of problem and less like something
specifically to do with resume.  Here's a bug report that superficially
resembles what you've got, although this one comes up during boot:

http://bugme.osdl.org/show_bug.cgi?id=4276

Alan Stern


--===============25905373156135303==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============25905373156135303==--
