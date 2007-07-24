From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: Towards eliminating the freezer
Date: Tue, 24 Jul 2007 10:27:24 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0707241025020.3568-100000__31554.8562597998$1185287290$gmane$org@iolanthe.rowland.org>
References: <200707241021.35573.oliver@neukum.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <200707241021.35573.oliver@neukum.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Oliver Neukum <oliver@neukum.org>
Cc: linux-pm <linux-pm@lists.linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Tue, 24 Jul 2007, Oliver Neukum wrote:

> Am Montag 23 Juli 2007 schrieb Alan Stern:
> > Now here's an idea which might work. =A0Can we require every caller o=
f
> > device_add() to hold some existing device's semaphore? =A0Normally it
> > would be the semaphore of the new device's parent, but it could be a
> > higher ancestor. =A0There even could be a single "root" semaphore for
> > drivers registering a top-level device with no parent.
>=20
> What prevents us from having a device addition semaphore?
> Adding device is not critical to performance, is it?

It would create a locking order violation.  Many drivers hold a device
semaphore while registering a child device, so they would acquire your
new semaphore while holding a device sem.  But the PM core needs to
prevent registration while calling suspend() methods, so it would need
to acquire the device sems while holding your new semaphore.

Alan Stern
