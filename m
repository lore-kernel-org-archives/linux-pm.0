From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: Re: Hotplug events during sleep transition
Date: Mon, 2 Jan 2006 15:49:59 -0800 (PST)
Message-ID: <Pine.LNX.4.50.0601021546150.5643-100000@monsoon.he.net>
References: <Pine.LNX.4.44L0.0512301412220.32015-100000@netrider.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============68256236188940123=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0512301412220.32015-100000@netrider.rowland.org>
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
Cc: Linux-pm mailing list <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

--===============68256236188940123==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Fri, 30 Dec 2005, Alan Stern wrote:

> Khubd does not exactly scan device lists on resume.  What happens is that
> we set a bit in the device's parent hub's private data structure,
> indicating that there was a connect-change on the device's port, and we
> put the data structure on a list of hubs needing attention.  Khubd
> continually scans this hub-event list whenever it isn't asleep, so it sees
> that the device has been disconnected as soon as it gets unfrozen.

Getting back to the original topic about unbinding and rebinding...

IMO, it would be best to not unbind and rebind devices, but rather do the
steps necessary to quiesce the driver and/or the device.

But, in the event that that can't happen (or in the interim), could a
similar mechanism be used for unbind events that are used for removals -
i.e. setting a bit in the device's (or related) data structure indicating
that the driver has been unbound -- and that work needs to be done -- and
then having khubd process it (and generate the appropriate events) on
resume?

Thanks,


	Patrick


--===============68256236188940123==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============68256236188940123==--
