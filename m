From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Re: freeze_processes questions
Date: Wed, 6 Apr 2005 17:03:03 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0504061702260.1634-100000@ida.rowland.org>
References: <200504062252.34867.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============15170372596673865=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200504062252.34867.rjw@sisk.pl>
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
Cc: Nigel Cunningham <ncunningham@cyclades.com>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============15170372596673865==
Content-Type: TEXT/PLAIN; charset=US-ASCII

On Wed, 6 Apr 2005, Rafael J. Wysocki wrote:

> > What happens if a process owns a lock needed to suspend a device and it is 
> > waiting in TASK_UNINTERRUPTIBLE?
> 
> Well, we're in trouble. :-)
> 
> However, if any process that we have frozen owns such a lock, we're in trouble
> too.  Thus it won't help if we forcibly freeze the uninterruptible process.
> Worse yet, there won't be any way to wake it up afterwards.  OTOH, if we leave
> it in TASK_UNINTERRUPTIBLE, it may (potentially) be woken up by an interrupt
> handler (as you pointed out previously :-)) and release the lock.
> 
> Frankly, I can't see any probable scenario leading to this kind of trouble.
> Seemingly, it would require someone to take a lock and (knowingly) do
> something that could end up in uninterruptible sleep, which IMHO is not
> a good idea.

It happens all the time in the USB core, when dealing with a 
newly-connected device.

Alan Stern


--===============15170372596673865==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============15170372596673865==--
