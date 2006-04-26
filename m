From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Wed, 26 Apr 2006 10:24:00 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0604261020320.5283-100000@iolanthe.rowland.org>
References: <200604260628.41003.nigel@suspend2.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============25038127208095795=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604260628.41003.nigel@suspend2.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Nigel Cunningham <nigel@suspend2.net>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============25038127208095795==
Content-Type: TEXT/PLAIN; charset=US-ASCII

A little behind the current head of the thread, but better late than
never...

On Wed, 26 Apr 2006, Nigel Cunningham wrote:

> > (7) (without your change) swsusp calls .suspend() for all device drivers
> > that are present at that time, but our driver is not there, so its
> > .suspend() _won't_ be called.  [Of course with your change .suspend() won't
> > be called for any driver.]
> 
> We also make a list that is safely available after the atomic restore of 
> drivers that have had .suspend methods called.
> 
> > (8) swsusp restores the image.
> 
> (9) suspend to disk calls .resume() for each device that is found in the list 
> generated above, thereby excluding our problem driver. Drivers which are 
> present but not in the list above (such as the problem driver) have a 
> different routine called, perhaps the normal initialisation one?

First, is this a list of drivers or a list of devices?  Under (7) you said 
drivers, and under (9) you said devices.

Second, how do you tell whether a device or driver in the resuming kernel 
is in the list or not?  Do you store the driver's name in the list and 
compare names?

Third, suppose a driver was present in the original swsusp kernel (and 
hence also in the resuming kernel) but not in the boot kernel.  Then it 
won't be in the list.  Apparently that means it doesn't get resumed during 
(9).  So when does it get resumed?

Alan Stern


--===============25038127208095795==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============25038127208095795==--
