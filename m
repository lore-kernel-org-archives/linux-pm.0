From: Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [RFC] dynamic device power management proposal
Date: Wed, 21 Mar 2007 10:44:39 -0400 (EDT)
Message-ID: <Pine.LNX.4.44L0.0703211042400.3249-100000@iolanthe.rowland.org>
References: <1174441439.29722.18.camel@sli10-conroe.sh.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.linux-foundation.org>
In-Reply-To: <1174441439.29722.18.camel@sli10-conroe.sh.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.linux-foundation.org>
List-Help: <mailto:linux-pm-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.linux-foundation.org?subject=subscribe>
Sender: linux-pm-bounces@lists.linux-foundation.org
Errors-To: linux-pm-bounces@lists.linux-foundation.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm <linux-pm@lists.osdl.org>
List-Id: linux-pm@vger.kernel.org

On Wed, 21 Mar 2007, Shaohua Li wrote:

> > I agree; nothing I said
> > before was meant to rule out such things.  In fact, USB already
> > contains
> > several instances where non-driver code decides to suspend a device.
> > For
> > example, when a device's file in the usbfs filesystem is closed, the
> > filesystem code attempts to suspend the device.
> This is another question. Should we make decision in kernel layer?

Why not?  If the only reason the device is in use is because the kernel =

layer has opened its device file, then when the kernel layer closes the =

file the device will be idle and so it should be suspended.

Alan Stern
