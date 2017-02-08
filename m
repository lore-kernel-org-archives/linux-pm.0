From: Eduardo Valentin <edubezval-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: [PATCH V9] thermal: bcm2835: add thermal driver for bcm2835 soc
Date: Tue, 7 Feb 2017 20:31:09 -0800
Message-ID: <20170208043107.GA7097@localhost.localdomain>
References: <1483808145-6206-1-git-send-email-kernel@martin.sperl.org>
 <20170120041400.GA24617@localhost.localdomain>
 <060918B6-A773-46A5-8D10-C9F6BBA6D3F1@martin.sperl.org>
 <20170124093127.GB3651@localhost.localdomain>
 <0452720A-5914-469B-9EF7-0581CF1B5478@martin.sperl.org>
 <20170202042930.GA6377@localhost.localdomain>
 <E0A4388D-788A-40B4-9193-36FD75284654@martin.sperl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Content-Disposition: inline
In-Reply-To: <E0A4388D-788A-40B4-9193-36FD75284654-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-rpi-kernel/>
List-Post: <mailto:linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
List-Help: <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-rpi-kernel>,
 <mailto:linux-rpi-kernel-request-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org?subject=subscribe>
Sender: "linux-rpi-kernel" <linux-rpi-kernel-bounces-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>
Errors-To: linux-rpi-kernel-bounces+glkr-linux-rpi-kernel=m.gmane.org-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
To: kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org
Cc: linux-pm-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, Lee Jones <lee-DgEjT+Ai2ygdnm+yROfE0A@public.gmane.org>, linux-rpi-kernel <linux-rpi-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org>, Zhang Rui <rui.zhang-ral2JQCrhuEAvxtiuMwx3w@public.gmane.org>, linux-arm-kernel-IAPFreCvJWM7uuMidbF8XUB+6BGkLq7r@public.gmane.org
List-Id: linux-pm@vger.kernel.org

On Sat, Feb 04, 2017 at 09:35:47AM +0100, kernel-TqfNSX0MhmxHKSADF0wUEw@public.gmane.org wrote:
> 

> So how does this change/impact the driver code itself?
> 
> Defining a thermal zone in the dts is just an additional feature
> that only impacts the device tree.
> The DT as is works fine and at least allows to read the current temperature.

Well, your driver is still half finished. It is a DT only driver, which
does not follow the DT spec on thermal. The impact on your code is that
it wont need to carry your hardware data in the source code.

Also, having the data described in DT allows you porting your driver
without patching it, in  case you need, or any other system engineer,
to have different thermal data, trips values, number or trips, offset
and slope per sensor, on different boards, or even on different chip
version.

Not to say that having the data described in DT also allows system
engineers to deploy different thermal zones, based on your
driver/sensor, to extrapolate different hotspots.

> Martin
> 
BR,

Eduardo Valentin
