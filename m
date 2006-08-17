From: Pavel Machek <pavel@ucw.cz>
Subject: Re: So, what's the status on the recent patches here?
Date: Thu, 17 Aug 2006 21:40:32 +0000
Message-ID: <20060817214031.GE6450@ucw.cz>
References: <20060814200735.GC14099@kroah.com>
	<c948ef9077556626e85291ad716b7ddb@nomadgs.com>
	<20060814224623.GH30814@redhat.com>
	<221e3d51950d20642b3655617527dc52@nomadgs.com>
	<20060814234801.GK30814@redhat.com>
	<20060815010020.GA14251@kroah.com>
	<1155638115.6736.135.camel@localhost>
	<20060815190439.GI7612@redhat.com>
	<1155806337.30834.17.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <1155806337.30834.17.camel@localhost>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Amit Kucheria <amit.kucheria@nokia.com>
Cc: linux-pm@lists.osdl.org
List-Id: linux-pm@vger.kernel.org

Hi!

> > Userspace cares about "save power" or "go fast".
> > Historically, I wish we had never exposed frequencies, but instead
> > a performance percentage, so that the various userspace tools
> > didn't have to care about things like 'what frequencies are
> > available'.
> > Adding the same mistake for voltages doesn't strike me as a fantastic
> > idea. =

> =

> The userspace interface in Eungeny's patches is for other userspace
> programs (policy managers) to activate/deactivate valid operating points
> in the system dynamically and if necessary, introduce new ones into the
> system. It will also allow the operating points to be referenced by name
> instead of the tuple.
> =

> Then, we will be able to use names like 'video', 'mp3', 'fast',
> 'powersave', 'usb' to switch to the relevant operating point based on
> configuration of the policy manager.

This seems to be too specific to embedded machine.

If userspace wants to work with usb and play mp3s at the same time,
what does it do?
							Pavel
-- =

Thanks for all the (sleeping) penguins.
