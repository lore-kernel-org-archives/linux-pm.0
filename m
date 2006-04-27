From: Patrick Mochel <mochel@linux.intel.com>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Wed, 26 Apr 2006 18:22:31 -0700
Message-ID: <20060427012231.GB26351@linux.intel.com>
References: <200604241429.52022.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============21348197298921257=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604241429.52022.david-b@pacbell.net>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: David Brownell <david-b@pacbell.net>
Cc: Andrew Morton <akpm@osdl.org>, linux-pm@lists.osdl.org, linux-usb-devel@lists.sourceforge.net
List-Id: linux-pm@vger.kernel.org

--===============21348197298921257==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Apr 24, 2006 at 02:29:51PM -0700, David Brownell wrote:

> I recently observed this myself and tracked down one problem.  The solution
> involves what kexec() does in much the same situation:  before starting a
> new kernel, most hardware needs to be reset.  Today, swsusp will suspend it
> instead, which is the root cause of the problem.

I'm not sure that is a good thing to do for a lot of video chipsets on x86 
platforms. For many, we do not have a way to reinitialize them from scratch,
so if we do a reset on them then we shoot ourselves in the foot. 

Now, maybe some/most/all video chipsets wouldn't do anything when it gets
the reset call. But, if you have one driver that does reset the hardware
(e.g. because the hardware is buggy and needs it before system reset), then
this patch will prevent that one chipset from working, so you'll have to 
work around that, possibly by passing a flag to the reset method. 

At that point, you have something very similar to just calling suspend with
a different flag than FREEZE (or an additional flag). 


I don't disagree with the intent or justification of the patch, but ultimately
it is up to the drivers to decide what to do for a particular piece of 
hardware in a particular context. Maybe the driver does the same thing for
all hardware in all situations, like reset the device. Or, maybe all
drivers do the same thing in a particular context. 

It's very difficult to know what every single device needs, so we should just
be honest with the drivers - tell them exactly what we're about to do - and
let them handle it as appropriate..


	Pat

--===============21348197298921257==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============21348197298921257==--
