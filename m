From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Thu, 5 Jan 2006 11:07:52 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0601051102180.5520-100000@iolanthe.rowland.org>
References: <20060104233158.GA1796@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============66924424799136473=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20060104233158.GA1796@elf.ucw.cz>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Pavel Machek <pavel@ucw.cz>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============66924424799136473==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Thu, 5 Jan 2006, Pavel Machek wrote:

> On St 28-12-05 21:18:38, Alan Stern wrote:
> > On Wed, 28 Dec 2005, Rafael J. Wysocki wrote:
> > 
> > > I think for a (suspended) device that can be removed, unplugged, undocked,
> > > etc. (call it "removable") the most natural place in which we can detect
> > > that the device is no longer accessible is the device driver's .resume()
> > > routine, at least as far as swsusp is concerned.
> > 
> > No.  The most natural place in which we can detect that a device is no 
> > longer accessible is the place where we already do these detections.  Not 
> > in the resume routine.
> 
> ...for reasonable buses, like usb. For something like ps/2, .resume is
> the place to check, I'm afraid.

It's _a_ place to check.  On the other hand, since there's no checking 
anywhere else, why does there need to be a check in .resume?

If people insist on detecting device removal during resume, then the
driver and PM cores will have to be able to cope with it.  Dumping
everything into keventd's lap is one approach.  Or we could define a list
of devices awaiting unregistration; the list could be scanned every time a
system resume or runtime resume procedure completes.

Alan Stern


--===============66924424799136473==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============66924424799136473==--
