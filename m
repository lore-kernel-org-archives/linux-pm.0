From: Alessandro Zummo <alessandro.zummo@towertech.it>
Subject: Re: [patch/rfc 0/6] rtc framework: remove class_device,
 use class suspend()/resume()
Date: Thu, 22 Feb 2007 22:37:58 +0100
Message-ID: <20070222223758.55fce4b3@inspiron>
References: <200702211945.15003.david-b@pacbell.net>
	<20070222180941.GA15289@kroah.com>
	<200702221244.32442.david-b@pacbell.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200702221244.32442.david-b@pacbell.net>
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
Cc: rtc-linux@googlegroups.com, john stultz <johnstul@us.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, linux-pm@lists.osdl.org, Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: linux-pm@vger.kernel.org

On Thu, 22 Feb 2007 12:44:31 -0800
David Brownell <david-b@pacbell.net> wrote:

> > All of these looks good to me, feel free to add an:
> > 	Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> > to them if you want.
> =

> Thanks ...
> =

>  =

> > thanks for doing the class_device removal work, I appreciate it.
> =

> Actually the class_device removal work was because that was the
> only way to clean the RTC suspend()/remove() patch out of my
> queue, where it's been sitting since not log after those class
> suspend/resume methods started to circulate, early last summer.
> =

> It'll be good to have that finally gone!


 Hi David,

  thanks for your work. The interface system was originally
 in place because it seemed the right-thing-to-do. if it isn't,
 better to remove it ;)

-- =


 Best regards,

 Alessandro Zummo,
  Tower Technologies - Torino, Italy

  http://www.towertech.it
