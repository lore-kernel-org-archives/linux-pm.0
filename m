From: Greg KH <greg@kroah.com>
Subject: Re: /sys/devices/.../power/state broken?
Date: Fri, 15 Dec 2006 11:01:50 -0800
Message-ID: <20061215190150.GA18185@kroah.com>
References: <Pine.LNX.4.44L0.0612121038210.2834-100000@iolanthe.rowland.org>
	<200612121015.41365.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
Content-Disposition: inline
In-Reply-To: <200612121015.41365.david-b@pacbell.net>
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
Cc: linux-pm@lists.osdl.org, Greg KH <gregkh@suse.de>, Brice Goglin <brice@myri.com>
List-Id: linux-pm@vger.kernel.org

On Tue, Dec 12, 2006 at 10:15:39AM -0800, David Brownell wrote:
> =

> Speaking of those new PM methods ... Greg, I tried refreshing my
> patch that uses class suspend() and resume() methods with RTCs to
> adjust the system clock properly on resume.  But neither method
> is getting called any more.  Did that break with the class device
> changes?

It shouldn't have, but to be honest, I haven't paid attention to it.

thanks,

greg k-h
