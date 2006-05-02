From: Patrick Mochel <mochel@linux.intel.com>
Subject: Re: [patch/rft 2.6.17-rc2] swsusp resume must not
	device_suspend()
Date: Tue, 2 May 2006 09:12:08 -0700
Message-ID: <20060502161208.GC9337@linux.intel.com>
References: <200604241429.52022.david-b@pacbell.net>
	<20060427012231.GB26351@linux.intel.com>
	<200604271241.28944.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============44117548104830462=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200604271241.28944.david-b@pacbell.net>
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

--===============44117548104830462==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 27, 2006 at 12:41:28PM -0700, David Brownell wrote:

> There does seem to be agreement that the current FREEE invocation is not
> sufficient.  I'm looking at a slightly different solution now ... one which
> unfortunately involves changing drivers, but can indeed allow swsusp resume
> paths to do the right thing (instead of what it does now).

It's Ok if it involves a drive change, so long as its an optional change, which
means that it shouldn't affect the interface very much (i.e. the calling 
convention). That's why it'd be good to augment and/or modify pm_message_t
to implement the changes, so we wouldn't have to change every single driver
again.. 


	Patrick

--===============44117548104830462==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============44117548104830462==--
