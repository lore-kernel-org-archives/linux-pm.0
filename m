From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: Hotplug events during sleep transition
Date: Wed, 28 Dec 2005 21:18:38 -0500 (EST)
Message-ID: <Pine.LNX.4.44L0.0512282113550.3218-100000@netrider.rowland.org>
References: <200512281159.14645.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============76246191780021588=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200512281159.14645.rjw@sisk.pl>
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
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

--===============76246191780021588==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 28 Dec 2005, Rafael J. Wysocki wrote:

> I think for a (suspended) device that can be removed, unplugged, undocked,
> etc. (call it "removable") the most natural place in which we can detect
> that the device is no longer accessible is the device driver's .resume()
> routine, at least as far as swsusp is concerned.

No.  The most natural place in which we can detect that a device is no 
longer accessible is the place where we already do these detections.  Not 
in the resume routine.

> IMO .resume() should check if the device is still there and if not, it should
> put the device on a list of "no-longer-present devices" and just return.
> After the .resume() routines of all devices have completed, the list can
> be processed by something (a kernel thread?) that will do the changes
> on whatever level is necessary.

Often the device-specific resume routine doesn't have the information
needed for checking whether the device is still there.  Such checks are 
done by generic bus-oriented routines.

Yes, the bus's resume handler can do such a check.  Why should it bother,
when other parts of the bus code will detect the device removal in the
normal course of events?  Or alternatively, why shouldn't the bus's resume
handler simply invoke those other parts of the bus code when it determines
that a device has been removed?

Alan Stern


--===============76246191780021588==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============76246191780021588==--
