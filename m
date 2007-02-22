From: David Brownell <david-b@pacbell.net>
Subject: Re: [patch/rfc 0/6] rtc framework: remove class_device,
	use class suspend()/resume()
Date: Thu, 22 Feb 2007 12:44:31 -0800
Message-ID: <200702221244.32442.david-b@pacbell.net>
References: <200702211945.15003.david-b@pacbell.net>
	<20070222180941.GA15289@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <20070222180941.GA15289@kroah.com>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Greg KH <greg@kroah.com>
Cc: Alessandro Zummo <alessandro.zummo@towertech.it>, rtc-linux@googlegroups.com, john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.osdl.org, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thursday 22 February 2007 10:09 am, Greg KH wrote:
> On Wed, Feb 21, 2007 at 07:45:14PM -0800, David Brownell wrote:
> > =

> > The main point of this series of patches is that last one, which I'll
> > circulate just a bit more widely.  (Although I think the first four are
> > also nice cleanups!)   It might be the first example of a framework that
> > uses the "new" class level suspend()/resume() calls to offload drivers.
> > =

> > ..
> =

> All of these looks good to me, feel free to add an:
> 	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> to them if you want.

Thanks ...

 =

> thanks for doing the class_device removal work, I appreciate it.

Actually the class_device removal work was because that was the
only way to clean the RTC suspend()/remove() patch out of my
queue, where it's been sitting since not log after those class
suspend/resume methods started to circulate, early last summer.

It'll be good to have that finally gone!

- Dave
