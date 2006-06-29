From: Greg KH <greg@kroah.com>
Subject: Re: [PATCH 2/2] Fix console handling during
	suspend/resume
Date: Wed, 28 Jun 2006 20:09:23 -0700
Message-ID: <20060629030923.GA18968@kroah.com>
References: <Pine.LNX.4.64.0606221210350.5498@g5.osdl.org>
	<200606231106.46863.david-b@pacbell.net>
	<Pine.LNX.4.64.0606231216290.6483@g5.osdl.org>
	<20060623233244.GB4264@neo.rr.com>
	<Pine.LNX.4.64.0606231622580.6483@g5.osdl.org>
	<20060624024230.GB3438@neo.rr.com>
	<Pine.LNX.4.64.0606231953560.6483@g5.osdl.org>
	<Pine.LNX.4.64.0606232029200.6483@g5.osdl.org>
	<20060629003736.GA6001@kroah.com>
	<Pine.LNX.4.64.0606281743420.12404@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606281743420.12404@g5.osdl.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Linus Torvalds <torvalds@osdl.org>
Cc: David Brownell <david-b@pacbell.net>, linux-pm@lists.osdl.org, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

On Wed, Jun 28, 2006 at 05:48:36PM -0700, Linus Torvalds wrote:
> =

> I still want the individual drivers be able to split up their high-level =

> functions ("device discovery/recovery behind this bus device") from their =

> low-level functions ("power on the bus device"), exactly so that we can =

> suspend/resume the actual motherboard devices as a totally separate pass =

> of suspending/resuming the "rest of the system".
> =

> That's what the dpm_active <-> dpm_off <-> dpm_off_irq transitions give =

> us in my patch - clearly separate stages for what happens "early", and =

> what happens "late". =


Yes, I agree, I still like your changes to the core to allow these
different callbacks for different times during the shutdown and resume
proceedure.  With my patch I was trying to show that we can handle
subsystems properly now too, with no special cases needed.

Any thoughts as to applying your patch to the tree or not?  No objection
from me if you want to.

thanks,

greg k-h
