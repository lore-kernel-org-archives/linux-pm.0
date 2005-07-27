From: Patrick Mochel <mochel@digitalimplant.org>
Subject: Re: sysdev suspend/resume
Date: Wed, 27 Jul 2005 10:43:24 -0700 (PDT)
Message-ID: <Pine.LNX.4.50.0507271035590.17623-100000@monsoon.he.net>
References: <1122356554.5479.4.camel@linux-hp.sh.intel.com>
	<20050726101409.GA1950@openzaurus.ucw.cz>
	<1122454220.7414.3.camel@linux-hp.sh.intel.com>
	<20050727090748.GB4270@elf.ucw.cz>
	<1122456610.3000.5.camel@linux-hp.sh.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============69656116441796034=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <1122456610.3000.5.camel@linux-hp.sh.intel.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: Shaohua Li <shaohua.li@intel.com>
Cc: linux-pm <linux-pm@lists.osdl.org>, Pavel Machek <pavel@ucw.cz>
List-Id: linux-pm@vger.kernel.org

--===============69656116441796034==
Content-Type: TEXT/PLAIN; charset=US-ASCII


On Wed, 27 Jul 2005, Shaohua Li wrote:

The patch looks Ok, except for this function.

> diff -puN drivers/base/sys.c~sysdev drivers/base/sys.c
> --- linux-2.6.13-rc3/drivers/base/sys.c~sysdev	2005-07-27 10:49:52.831538832 +0800
> +++ linux-2.6.13-rc3-root/drivers/base/sys.c	2005-07-27 17:22:57.447132280 +0800
> @@ -288,6 +288,25 @@ void sysdev_shutdown(void)
>  	up(&sysdev_drivers_lock);
>  }
>
> +static void inline do_sysdev_resume(struct sysdev_class *cls,
> +	struct sys_device *dev, struct sysdev_driver *drv)
> +{


* It does not need to be inlined.

* Internal helpers are prefix'd with "__" instead of "do_", so this would
  be '__sysdev_resume()'.

* drv is a temporary variable

* cls can be ascertained from the sys_device


So, the first few lines should be

static void __sysdev_resume(struct sys_device * dev)
{
	struct sysdev_class * cls = dev->cls;
	struct sysdev_driver * dev;
	...


Thanks,


	Pat

--===============69656116441796034==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============69656116441796034==--
