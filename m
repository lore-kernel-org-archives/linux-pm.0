From: Pavel Machek <pavel@suse.cz>
Subject: Re: Userspace interface breakage in power/state
Date: Mon, 16 Jan 2006 21:24:55 +0100
Message-ID: <20060116202455.GS1666@elf.ucw.cz>
References: <20060116002516.GB4648@srcf.ucam.org>
	<20060116192550.GA23850@srcf.ucam.org>
	<20060116200521.GO1666@elf.ucw.cz> <200601162122.10684.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============61139215152321214=="
Return-path: <linux-pm-bounces@lists.osdl.org>
In-Reply-To: <200601162122.10684.rjw@sisk.pl>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/linux-pm>
List-Post: <mailto:linux-pm@lists.osdl.org>
List-Help: <mailto:linux-pm-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/linux-pm>,
	<mailto:linux-pm-request@lists.osdl.org?subject=subscribe>
Sender: linux-pm-bounces@lists.osdl.org
Errors-To: linux-pm-bounces@lists.osdl.org
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Matthew Garrett <mjg59@srcf.ucam.org>, linux-pm@lists.osdl.org, linux-kernel@linux.kernel.org
List-Id: linux-pm@vger.kernel.org

--===============61139215152321214==
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Po 16-01-06 21:22:10, Rafael J. Wysocki wrote:
> Hi,
> 
> On Monday, 16 January 2006 21:05, Pavel Machek wrote:
> > On Po 16-01-06 19:25:50, Matthew Garrett wrote:
> > > On Mon, Jan 16, 2006 at 08:20:36PM +0100, Pavel Machek wrote:
> > > 
> > > > I had patch to fix this breakage, but it was rejected. What depends on
> > > > that code?
> > > 
> > > Ubuntu's wireless disable script.
> > 
> > Can you search linux-pm archives? Search for "3" (that's '"', '3',
> > '"'). It should be somewhere. I no longer have a copy. (Probably could
> > get it from my working tree git...)
> 
> I think the appended message contains the latest version.

Thanks, thats it. Matthew, you probably want to replace "2" with "3"
below.

								Pavel

> Ok, so lets at least add value-checking to .../power file, and prevent
> userspace see changes to PM_EVENT_SUSPEND value. 2 and 0 are now
> "arbitrary cookies". I'd like to use "on" and "off", but pcmcia
> apparently depends on "2" and "0", so...
> 
> Any objections?
> 
> Signed-off-by: Pavel Machek <pavel@suse.cz>
> 								Pavel
> 
> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> --- a/drivers/base/power/sysfs.c
> +++ b/drivers/base/power/sysfs.c
> @@ -27,22 +27,25 @@
>  
>  static ssize_t state_show(struct device * dev, struct device_attribute *attr, char * buf)
>  {
> -	return sprintf(buf, "%u\n", dev->power.power_state.event);
> +	if (dev->power.power_state.event)
> +		return sprintf(buf, "2\n");
> +	else
> +		return sprintf(buf, "0\n");
>  }
>  
>  static ssize_t state_store(struct device * dev, struct device_attribute *attr, const char * buf, size_t n)
>  {
>  	pm_message_t state;
> -	char * rest;
> -	int error = 0;
> +	int error = -EINVAL;
>  
> -	state.event = simple_strtoul(buf, &rest, 10);
> -	if (*rest)
> -		return -EINVAL;
> -	if (state.event)
> -		error = dpm_runtime_suspend(dev, state);
> -	else
> +	state.event = PM_EVENT_SUSPEND;
> +	if ((n == 1) && !strncmp(buf, "2", 1)) {
>  		dpm_runtime_resume(dev);
> +		error = 0;
> +	}
> +	if ((n == 1) && !strncmp(buf, "0", 1))
> +		error = dpm_runtime_suspend(dev, state);
> +
>  	return error ? error : n;
>  }
>  

-- 
Thanks, Sharp!

--===============61139215152321214==
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


--===============61139215152321214==--
