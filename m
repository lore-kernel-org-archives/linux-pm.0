From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Toward runtime power management in Linux
Date: Fri, 26 Aug 2005 07:42:34 +1000
Message-ID: <1125006155.12538.21.camel@gaston>
References: <Pine.LNX.4.44L0.0508251107280.4918-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============8507343110035972=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <Pine.LNX.4.44L0.0508251107280.4918-100000@iolanthe.rowland.org>
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

--===============8507343110035972==
Content-Type: text/plain
Content-Transfer-Encoding: 7bit

On Thu, 2005-08-25 at 11:27 -0400, Alan Stern wrote:

> But it complicates the structure of drivers by forcing them to use a
> state-machine approach with a bunch of tedious intermediate states ("link
> change request issued, waiting for notification").  

Not necessarily. The driver could do synchronous blocking wait if it's
not running inside the context of the iterator thread which won't be the
case most of the time.

> It also introduces
> complications from the possible arrival of several change requests or
> notifications at once, since there's no locking to guarantee mutual
> exclusion among them.

Who else but the driver is allowed to request a link state change on the
device ? That specific race can be dealt with or considered as a
programming error.

> 	Device removal racing with power state changes.  During device
> 	removal the PM lock should be held; this will prevent the two
> 	operations from overlapping.  You might end up trying to carry
> 	out a power-state change on an already-removed device; that's
> 	not a problem -- it will simply fail.

Those locks are a wonderful deadlock scenario as soon as the driver end
up triggering add/remove events while they are held and that does
happen. I'm really not fan of those global and/or cascaded locks, I find
the approach very deadlock prone.



--===============8507343110035972==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============8507343110035972==--
