From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: swsusp status report
Date: Wed, 26 Jul 2006 11:40:37 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0607261137410.6573-100000@iolanthe.rowland.org>
References: <200607251325.14747.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200607251325.14747.rjw@sisk.pl>
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
Cc: Linux PM <linux-pm@osdl.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 25 Jul 2006, Rafael J. Wysocki wrote:

> VIII. Saving and loading the suspend image
> =

> The suspend image is saved to a swap partition in step (7) of the
> suspend-resume cycle and loaded from it in step (9) with the help of stan=
dard
> block IO callbacks and/or functions designed for accessing swap devices a=
nd/or
> swap files.  This code has not changed for a long time, but recently Andr=
ew
> Morton has made it use asynchronous IO (the patches are waiting in the -mm
> tree now).
> =

> There are almost no problems with this part of swsusp.  There have been o=
nly
> a couple of minor bugs found in it, and fixed, for the last 6 months.  Ye=
t,
> it has one major limitation which is that it can only use swap partitions
> for saving the suspend image and only one swap partition can be used at a
> time.  To overcome this limitation I am considering the addition of suppo=
rt
> for swap files to this part of swsusp.

The disk I/O while reading or writing the image is very slow.  In fact, it =

sounds like it's going one sector at a time.  Can it be sped up?  Do the =

AIO changes accomplish that?

Alan Stern
