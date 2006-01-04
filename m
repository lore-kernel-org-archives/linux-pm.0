From: Pavel Machek <pavel@ucw.cz>
Subject: Re: Re: Hotplug events during sleep transition
Date: Thu, 5 Jan 2006 00:31:58 +0100
Message-ID: <20060104233158.GA1796@elf.ucw.cz>
References: <200512281159.14645.rjw@sisk.pl>
	<Pine.LNX.4.44L0.0512282113550.3218-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============95687647366140505=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512282113550.3218-100000@netrider.rowland.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Alan Stern <stern@rowland.harvard.edu>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============95687647366140505==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On St 28-12-05 21:18:38, Alan Stern wrote:
> On Wed, 28 Dec 2005, Rafael J. Wysocki wrote:
> 
> > I think for a (suspended) device that can be removed, unplugged, undocked,
> > etc. (call it "removable") the most natural place in which we can detect
> > that the device is no longer accessible is the device driver's .resume()
> > routine, at least as far as swsusp is concerned.
> 
> No.  The most natural place in which we can detect that a device is no 
> longer accessible is the place where we already do these detections.  Not 
> in the resume routine.

...for reasonable buses, like usb. For something like ps/2, .resume is
the place to check, I'm afraid.

								Pavel


-- 
Thanks, Sharp!

--===============95687647366140505==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============95687647366140505==--
